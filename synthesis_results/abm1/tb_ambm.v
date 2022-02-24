`timescale 1ns / 1ps

module tb_ambm;

	// Inputs
	reg [15:0] multiplier;
	reg [15:0] multiplicand;

	// Outputs
	wire [31:0] product;
	reg [31:0] product1;

	// Instantiate the Unit Under Test (UUT)
	abm1 uut (
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.product(product)
	);

	integer i;
	initial begin
		// Initialize Inputs
		for(i=0; i<=62; i=i+1)
		begin
		#5;
		multiplier = i;
		multiplicand = i+3;
		#1 product1=multiplier*multiplicand;
		if(product1==product)
		#1 $display("\nMatching :: multiplier=%0d, multiplicand=%0d, product=%0d, product1=%0d",multiplier, multiplicand, product,product1);
		else
		#1 $display("\nNot Matching :: multiplier=%0d, multiplicand=%0d, product=%0d, product1=%0d",multiplier, multiplicand, product,product1);
		#1 $display("\nThe difference between Actual product - Obtained product=%0d", $signed(product-product1));
		end
		end
endmodule
