module Encryption_Valid (
    input clk,
    input reset,
    input [127:0] P,
    input [127:0] Q,
    input [255:0] E,
    output reg Encryption_key_valid,
    output reg [255:0] N,
    output reg [255:0] T
);
    wire is_prime;

    isPrime prime_check (.E(E), .is_prime(is_prime));

    always @(posedge clk) begin
        if (~reset) begin
            N <= 256'd0;
            T <= 256'd0;
            Encryption_key_valid <= 1'b0;
        end else begin
            N <= P * Q;
            T <= (P - 1) * (Q - 1);
            Encryption_key_valid <= (is_prime && (E < T) && (T % E != 0));
        end
    end
endmodule
