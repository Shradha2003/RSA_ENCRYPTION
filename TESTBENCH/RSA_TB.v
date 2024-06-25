`timescale 1ns / 1ps

module tb_RSA_ALGORITHM;

    // Inputs
    reg clk;
    reg reset;
    reg [255:0] Encryption_key;
    reg [127:0] Prime_Number1;
    reg [127:0] Prime_Number2;
    reg [255:0] MESSAGE;
    reg data_rdy;

    // Outputs
    wire [255:0] ENCRY_DATA;
    wire ENCRY_RDY;

    // Instantiate the Unit Under Test (UUT)
    RSA_ALGORITHM uut (
        .clk(clk),
        .reset(reset),
        .Encryption_key(Encryption_key),
        .Prime_Number1(Prime_Number1),
        .Prime_Number2(Prime_Number2),
        .MESSAGE(MESSAGE),
        .data_rdy(data_rdy),
        .ENCRY_DATA(ENCRY_DATA),
        .ENCRY_RDY(ENCRY_RDY)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Stimulus process
    
    
    
    initial begin
        // Initialize Inputs
        reset = 0;
        Encryption_key = 0;
        Prime_Number1 = 0;
        Prime_Number2 = 0;
        MESSAGE = 0;
        data_rdy = 0;

        // Wait for global reset
        #10;
        
        // Reset the UUT
        reset = 1;
             
        // Test vector
        Prime_Number1 = 128'h5;
        Prime_Number2 = 128'h7;
        Encryption_key = 256'h5; // Commonly used public exponent
        MESSAGE = 256'h12; // "This is a test message!"
        data_rdy = 1;
        
        // Wait for encryption to complete
        wait(ENCRY_RDY);
        
        // Display the result
        $display("Encrypted Data: %h", ENCRY_DATA);
        
        // Finish the test
        $stop;
    end

endmodule

