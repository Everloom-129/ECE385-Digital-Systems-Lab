#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define WIDTH 20
#define HEIGHT 30 
#define TRUE 1
#define FALSE 0

char screen[HEIGHT][WIDTH] = {0};
int score = 0;
char GameOn = TRUE;
suseconds_t timer = 4000000; // decrease this to make it faster
int decrease = 1000;

typedef struct {
    char **array;
    int width, row, col;
} Shape;

Shape current;

const Shape ShapesArray[7]= {
	{(char *[]){(char []){0,1,1},(char []){1,1,0}, (char []){0,0,0}}, 3},                           //S shape     
	{(char *[]){(char []){1,1,0},(char []){0,1,1}, (char []){0,0,0}}, 3},                           //Z shape     
	{(char *[]){(char []){0,1,0},(char []){1,1,1}, (char []){0,0,0}}, 3},                           //T shape     
	{(char *[]){(char []){0,0,1},(char []){1,1,1}, (char []){0,0,0}}, 3},                           //L shape     
	{(char *[]){(char []){1,0,0},(char []){1,1,1}, (char []){0,0,0}}, 3},                           //flipped L shape    
	{(char *[]){(char []){1,1},(char []){1,1}}, 2},                                                 //square shape
	{(char *[]){(char []){0,0,0,0}, (char []){1,1,1,1}, (char []){0,0,0,0}, (char []){0,0,0,0}}, 4} //long bar shape
	// you can add any shape like it's done above. Don't be naughty.
};

Shape CopyShape(Shape shape) {
    Shape new_shape = shape;
    char **copyshape = shape.array;
    new_shape.array = (char **)malloc(new_shape.width * sizeof(char *));
    int i, j;
    for (i = 0; i < new_shape.width; i++) {
        new_shape.array[i] = (char *)malloc(new_shape.width * sizeof(char));
        for (j = 0; j < new_shape.width; j++) {
            new_shape.array[i][j] = copyshape[i][j];
        }
    }
    return new_shape;
}

void DeleteShape(Shape shape) {
    int i;
    for (i = 0; i < shape.width; i++) {
        free(shape.array[i]);
    }
    free(shape.array);
}

int CheckPosition(Shape shape) {
    char **array = shape.array;
    int i, j;
    for (i = 0; i < shape.width; i++) {
        for (j = 0; j < shape.width; j++) {
            if ((shape.col + j < 0 || shape.col + j >= WIDTH || shape.row + i >= HEIGHT)) {
                if (array[i][j])
                    return FALSE;
            } else if (screen[shape.row + i][shape.col + j] && array[i][j])
                return FALSE;
        }
    }
    return TRUE;
}

void SetNewRandomShape() {
    Shape new_shape = CopyShape(ShapesArray[rand() % 7]);
    new_shape.col = rand() % (WIDTH - new_shape.width + 1);
    new_shape.row = 0;
    DeleteShape(current);
    current = new_shape;
    if (!CheckPosition(current)) {
        GameOn = FALSE;
    }
}

void RotateShape(Shape shape) {
    Shape temp = CopyShape(shape);
    int i, j, k, width;
    width = shape.width;
    for (i = 0; i < width; i++) {
        for (j = 0, k = width - 1; j < width; j++, k--) {
            shape.array[i][j] = temp.array[k][i];
        }
    }
    DeleteShape(temp);
}

void WriteToTable() {
    int i, j;
    for (i = 0; i < current.width; i++) {
        for (j = 0; j < current.width; j++) {
            if (current.array[i][j])
                screen[current.row + i][current.col + j] = current.array[i][j];
        }
    }
}

void RemoveFullRowsAndUpdateScore() {
    int i, j, sum, count = 0;
    for (i = 0; i < HEIGHT; i++) {
        sum = 0;
        for (j = 0; j < WIDTH; j++) {
            sum += screen[i][j];
        }
        if (sum == WIDTH) {
            count++;
            int l, k;
            for (k = i; k >= 1; k--) {
                for (l = 0; l < WIDTH; l++)
                    screen[k][l] = screen[k - 1][l];
            }
            for (l = 0; l < WIDTH; l++)
                screen[k][l] = 0;
            timer -= decrease--;
        }
    }
    score += 100 * count;
}

void printScreen() {
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            printf("%d ", screen[i][j]);
        }
        printf("\n");
    }
    printf("============\n\n");
}

void ManipulateCurrent(int action) {
    Shape temp = CopyShape(current);
    switch (action) {
        case 's':
            temp.row++;
            if (CheckPosition(temp))
                current.row++;
            else {
                WriteToTable();
                RemoveFullRowsAndUpdateScore();
                SetNewRandomShape();
            }
            break;
        case 'd':
            temp.col++;
            if (CheckPosition(temp))
                current.col++;
            break;
        case 'a':
            temp.col--;
            if (CheckPosition(temp))
                current.col--;
            break;
        case 'w':
            RotateShape(temp);
            if (CheckPosition(temp))
                RotateShape(current);
            break;
    }
    DeleteShape(temp);
    printScreen();
}

int main() {
    srand(time(0));
    int c;
    SetNewRandomShape();
    printScreen();

    while (GameOn) {
        usleep(5000000);
        ManipulateCurrent('s');
    }

    DeleteShape(current);
    printf("Game over!\n");
    printf("Score: %d\n", score);
    return 0;
}
