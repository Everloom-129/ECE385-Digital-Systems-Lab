CC = gcc
CFLAGS = -Wall -g
LIBS = -lncurses

# Targets
TARGET1 = tetris
TARGET2 = t200

# Source files
SRCS1 = main.c
SRCS2 = t200.c
OBJS1 = $(SRCS1:.c=.o)
OBJS2 = $(SRCS2:.c=.o)

# Default target: build both targets
all: $(TARGET1) $(TARGET2)

# Build the first target (tetris)
$(TARGET1): $(OBJS1)
	$(CC) $(CFLAGS) -o $(TARGET1) $(OBJS1)

# Build the second target (t200)
$(TARGET2): $(OBJS2)
	$(CC) $(CFLAGS) -o $(TARGET2) $(OBJS2) $(LIBS)

# Compile object files for the first target
$(OBJS1): %.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile object files for the second target
$(OBJS2): %.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up
clean:
	rm -f $(TARGET1) $(TARGET2) $(OBJS1) $(OBJS2)

# Run the first target
run1: $(TARGET1)
	./$(TARGET1)

# Run the second target
run2: $(TARGET2)
	./$(TARGET2)
