module RSA_ALGORITHM(
    input clk,
    input reset,
    input [255:0] Encryption_key,   
    input [127:0] Prime_Number1,  
    input [127:0] Prime_Number2,  
    input [255:0] MESSAGE, // Message to encrypt (M)
    input data_rdy,      // Indicates new message is ready
    output reg [255:0] ENCRY_DATA, // Encrypted data
    output reg ENCRY_RDY // Encryption ready signal
);

    reg [255:0] mod_num1; 
    reg [255:0] mod_num2; 
    wire [255:0] mod_out;
    wire mod_out_rdy;    
    reg [255:0] power_num1;
    reg [255:0] power_num2; 
    reg power_rdy;         
    reg mod_rdy;
    wire [255:0] power_out; 
    wire power_out_rdy;
    wire [255:0] N;
    wire [255:0] T;
    wire Encryption_key_valid;    
    reg stg1, stg2; 

   Encryption_Valid Valid(
        .clk(clk),
        .reset(reset),
        .P(Prime_Number1),
        .Q(Prime_Number2),
        .E(Encryption_key),
        .Encryption_key_valid(Encryption_key_valid),
        .N(N),
        .T(T)
    );

    power_process power_inst (
        .clk(clk),
        .reset(reset),
        .in_rdy(power_rdy),
        .data1(power_num1),
        .data2(power_num2),
        .out(power_out),
        .out_rdy(power_out_rdy)
    );

    mod_operationrsa mod_inst (
        .clk(clk),
        .reset(reset),
        .op_rdy(mod_rdy),
        .in1(mod_num1),
        .in2(mod_num2),
        .out(mod_out),
        .out_rdy(mod_out_rdy)
    );

    always @(posedge clk or posedge reset) begin
        if (~reset) begin
            ENCRY_DATA <= 256'd0;
            ENCRY_RDY <= 1'b0;
            power_rdy <= 1'b0;
            mod_rdy <= 1'b0;
            stg1 <= 1'b0;
            stg2 <= 1'b0;
           
        end else begin
            // Stage 1: Wait for new message
            if (data_rdy && ~stg1 && ~stg2 && Encryption_key_valid) begin
              
                power_num1 <= MESSAGE;
                power_num2 <= Encryption_key;
                power_rdy <= 1'b1;
                stg1 <= 1'b1;
                stg2 <= 1'b0;
            end
            // Stage 2: Modular exponentiation
            if (stg1 && power_out_rdy && ~stg2) begin
                mod_num1 <= power_out;
                mod_num2 <= N;
                mod_rdy <= 1'b1;
                stg1 <= 1'b0;
                stg2 <= 1'b1;
            end
            // Final stage: Final modulus operation
            if (stg2 && mod_out_rdy) begin
                ENCRY_DATA <= mod_out;
                ENCRY_RDY <= 1'b1;
                stg2 <= 1'b0;
            end
        end
    end
endmodule

