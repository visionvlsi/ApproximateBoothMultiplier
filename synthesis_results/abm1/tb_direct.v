`timescale 1ns / 1ps
module tb_direct;

	// Inputs
	reg clk,rst;
	reg signed [15:0] multplr;
	reg signed [15:0] multplcnd;

	// Outputs
	wire signed [31:0] prod;
reg signed [31:0] prod1;
integer i;
	// Instantiate the Unit Under Test (UUT)
	mbm_direct uut (
	        .clk(clk),
	        .rst(rst),
		.multplr(multplr), 
		.multplcnd(multplcnd), 
		.prod(prod)
	);
	initial
	begin
	clk=0;
	rst=0;
	#5 rst=1;
	#5 rst=0;
	end
	always
	#5 clk=~clk;
	initial
	#500 $finish;
initial begin
$dumpfile("direct.vcd");
$dumpvars(1);
end
	initial 
		begin
		for(i=1;i<=10;i=i+1)
		begin
		#5 multplr=56*i; multplcnd=-i*4;
		#5 prod1=multplr*multplcnd;
		if(prod1!=prod)
		$display("simtime=%0g, multplr=%0d, multplcnd=%0d, prod=%0d, prod1=%0d, Not Matching",$time,multplr,multplcnd,prod,prod1);
		else
		$display("simtime=%0g, multplr=%0d, multplcnd=%0d, prod=%0d, prod1=%0d, Matching",$time,multplr,multplcnd,prod,prod1);
		end
		end
	  endmodule 
