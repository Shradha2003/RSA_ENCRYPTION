module isPrime (
    input wire [255:0] E,
    output reg is_prime
);

    reg [255:0] i;
    wire [255:0] sqrt_E;

    // Calculate square root of E
   
    
    

    // Check if E is prime
    always @* begin
        if (E <= 1) begin
            is_prime = 0;
        end else if (E == 2 || E == 3) begin
            is_prime = 1;
        end else if (E % 2 == 0 || E % 3 == 0) begin
            is_prime = 0;
        end else begin
            is_prime = 1;
            for (i = 4; i < E && is_prime!=0; i = i + 1) begin
                if (E % i == 0) begin
                    is_prime = 0;
                end
            end
        end
    end

endmodule
