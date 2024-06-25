module mod_operationrsa(
    input clk,
    input reset,
    input sign,
    input op_rdy,
    input [255:0] in1,
    input [255:0] in2,
    output reg [255:0] out,
    output reg out_rdy
);
    reg [255:0] tmp1;
    reg [255:0] tmp2;
    reg start;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            out <= 256'd0;
            out_rdy <= 1'b0;
            tmp1 <= 256'd0;
            tmp2 <= 256'd0;
            start <= 1'b0;
        end else if (op_rdy && ~start) begin
            tmp1 <= in1;
            tmp2 <= in2;
            start <= 1'b1;
            out_rdy <= 1'b0;
        end else if (start) begin
            if (tmp1 >= tmp2) begin
                tmp1 <= tmp1 - tmp2;
            end else begin
                out <= tmp1;
                out_rdy <= 1'b1;
                start <= 1'b0; // Stop the operation
            end
        end
    end
endmodule
