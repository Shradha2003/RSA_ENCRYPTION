module power_process(
    input clk,
    input reset,
    input in_rdy,
    input [255:0] data1,
    input [255:0] data2,
    output reg [255:0] out,
    output reg out_rdy
);
    reg [255:0] temp;
    reg [255:0] temp1;
    reg [255:0] temp2;
    reg st1;
    reg st2;
    reg [255:0] count;

    always @(posedge clk) begin
        if(~reset) begin
            temp <= 256'd1;
            st1 <= 1'b0;
            st2 <= 1'b0;
            count <= 256'd0;
            out_rdy <= 1'b0;
            out <= 256'd0;
        end else if(in_rdy && ~st1 && ~st2) begin
            temp1 <= data1;
            temp2 <= data2;
            st1 <= 1'b1;
            st2 <= 1'b0;
            count <= 256'd0;
            temp <= 256'd1; // Initialize temp to 1 for multiplication
        end else if(st1 && ~st2) begin
            if(count < temp2) begin
                temp <= temp * temp1;
                count <= count + 1;
            end else begin
                out <= temp;
                out_rdy <= 1'b1;
                st1 <= 1'b0;
                st2 <= 1'b1;
            end
        end else begin
            temp <= 256'd1;
            count <= 256'd0;
            st1 <= 1'b0;
            st2 <= 1'b0;
        end
    end
endmodule
