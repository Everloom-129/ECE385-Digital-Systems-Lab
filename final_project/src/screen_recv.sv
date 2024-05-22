module screen_receiver (
    input logic clk,
    input logic reset,
    input logic [31:0] T_row,
    input logic data_valid,
    output logic [599:0] screen_data
);
    logic [4:0] row_index;
    logic [19:0] row_data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            screen_data <= 600'b0;
        end else if (data_valid) begin
            row_index <= T_row[31:27];
            row_data <= T_row[26:7];
            screen_data[row_index * 20 +: 20] <= row_data;
        end
    end
endmodule
