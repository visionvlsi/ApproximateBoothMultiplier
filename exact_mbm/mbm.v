module mbm(multiplier,multiplicand, product);
input signed [15:0]multiplier, multiplicand;
output signed [31:0]product;
wire [7:0]neg;
wire [7:0]two;
wire [7:0]zero;

//Multiplier left shift by 1-bit
wire  signed [16:0]left_shift_by_1bit_multiplicand;

assign {neg[0],two[0],zero[0]}=({multiplier[1:0],1'b0}==3'b000)? 3'b001: ({multiplier[1:0],1'b0}==3'b001)? 
                               3'b000: ({multiplier[1:0],1'b0}==3'b010)? 3'b000: ({multiplier[1:0],1'b0}==3'b011)? 
										 3'b010: ({multiplier[1:0],1'b0}==3'b100)? 3'b110: ({multiplier[1:0],1'b0}==3'b101)? 
										 3'b100: ({multiplier[1:0],1'b0}==3'b110)? 3'b100: 3'b001;

assign {neg[1],two[1],zero[1]}=(multiplier[3:1]==3'b000)? 3'b001: (multiplier[3:1]==3'b001)? 3'b000:
                                (multiplier[3:1]==3'b010)? 3'b000: (multiplier[3:1]==3'b011)? 3'b010:
										  (multiplier[3:1]==3'b100)?3'b110:(multiplier[3:1]==3'b101)? 3'b100:(multiplier[3:1]==3'b110)? 
										  3'b100: 3'b001;//multiplier[3:1];

assign {neg[2],two[2],zero[2]}=(multiplier[5:3]==3'b000)? 3'b001: (multiplier[5:3]==3'b001)? 3'b000:
                                (multiplier[5:3]==3'b010)? 3'b000: (multiplier[5:3]==3'b011)? 3'b010:(multiplier[5:3]==3'b100)?
										  3'b110: (multiplier[5:3]==3'b101)? 3'b100: (multiplier[5:3]==3'b110)? 3'b100: 3'b001;//multiplier[5:3];

assign {neg[3],two[3],zero[3]}=(multiplier[7:5]==3'b000)? 3'b001: (multiplier[7:5]==3'b001)? 3'b000:(multiplier[7:5]==3'b010)?
                               3'b000:(multiplier[7:5]==3'b011)?3'b010:(multiplier[7:5]==3'b100)?3'b110:(multiplier[7:5]==3'b101)?
										 3'b100:(multiplier[7:5]==3'b110)? 3'b100: 3'b001;//multiplier[7:5];
     
assign {neg[4],two[4],zero[4]}=(multiplier[9:7]==3'b000)? 3'b001:(multiplier[9:7]==3'b001)? 3'b000:(multiplier[9:7]==3'b010)?3'b000:
                                (multiplier[9:7]==3'b011)?3'b010:(multiplier[9:7]==3'b100)?3'b110:(multiplier[9:7]==3'b101)?3'b100:
										  (multiplier[9:7]==3'b110)? 3'b100: 3'b001;//multiplier[9:7];
    
assign {neg[5],two[5],zero[5]}=(multiplier[11:9]==3'b000)? 3'b001:(multiplier[11:9]==3'b001)? 3'b000:(multiplier[11:9]==3'b010)?
                                3'b000:(multiplier[11:9]==3'b011)?3'b010:(multiplier[11:9]==3'b100)? 3'b110:
										  (multiplier[11:9]==3'b101)? 3'b100:(multiplier[11:9]==3'b110)?3'b100: 3'b001;//multiplier[11:9];
   
assign {neg[6],two[6],zero[6]}=(multiplier[13:11]==3'b000)? 3'b001: (multiplier[13:11]==3'b001)? 3'b000:
                               (multiplier[13:11]==3'b010)?3'b000:(multiplier[13:11]==3'b011)?3'b010:(multiplier[13:11]==3'b100)?
										 3'b110:(multiplier[13:11]==3'b101)?3'b100:(multiplier[13:11]==3'b110)?3'b100: 3'b001;//multiplier[13:11]; 

assign {neg[7],two[7],zero[7]}=(multiplier[15:13]==3'b000)? 3'b001: (multiplier[15:13]==3'b001)? 3'b000:(multiplier[15:13]==3'b010)?
                               3'b000:(multiplier[15:13]==3'b011)?3'b010:(multiplier[15:13]==3'b100)?3'b110:
										 (multiplier[15:13]==3'b101)?3'b100:(multiplier[15:13]==3'b110)?3'b100: 3'b001;//multiplier[15:13]; 

assign left_shift_by_1bit_multiplicand={multiplicand, 1'b0};

wire signed   [16:0]m[0:7];
wire signed   [16:0]xor_gate_output[0:7];
wire signed   [16:0]and_gate_output[0:7];

genvar j;
generate for(j=0;j<=7;j=j+1) begin: two_neg_zero

assign m[j]= (two[j])? left_shift_by_1bit_multiplicand:{multiplicand[15],multiplicand};
       
assign xor_gate_output[j]=m[j] ^  {17{neg[j]}};

assign and_gate_output[j]=xor_gate_output[j] & ({17{~zero[j]}});
end

endgenerate


wire  signed [16:0]pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;

wire signed [31:0]pp11;//[20:0]pp11;
wire signed [31:0]pp22;//[21:0]pp22;
wire signed [31:0]pp33;//[23:0]pp33;
wire signed [31:0]pp44;//[25:0]pp44;
wire signed [31:0]pp55;//[27:0]pp55;
wire signed [31:0]pp66;//[29:0]pp66;
wire signed [31:0]pp77;//[31:0]pp77;
wire signed [31:0]pp88;//[33:0]pp88;

assign pp1={and_gate_output[0]};  // 3-sign bits+ 17 bits=20 bits

assign pp2={and_gate_output[1]};  // 2-sign bits+ 17 bits=19 bits

assign pp3={and_gate_output[2]};  // 2-sign bits+ 17 bits=19 bits
assign pp4={and_gate_output[3]};  // 2-sign bits+ 17 bits=19 bits

assign pp5={and_gate_output[4]};  // 2-sign bits+ 17 bits=19 bits
assign pp6={and_gate_output[5]};  // 2-sign bits+ 17 bits=19 bits

assign pp7={and_gate_output[6]};  // 2-sign bits+ 17 bits=19 bits
assign pp8={and_gate_output[7]};  // 2-sign bits+ 17 bits=19 bits

assign pp11= (pp1!=0)  ? ({{17{pp1[16]}},pp1}) + multiplier[1] : 0;
assign pp22= (pp2 !=0) ? ({{17{pp2[16]}},pp2,2'b00}) + {multiplier[3],2'b00} :0;
assign pp33= (pp3 !=0) ? ({{17{pp3[16]}},pp3,4'b0000}) + {multiplier[5],4'b0000}:0;
assign pp44= (pp4 !=0) ? ({{17{pp4[16]}},pp4,6'b000000})+ {multiplier[7],6'b000_000} :0;
assign pp55= (pp5 !=0) ? ({{17{pp5[16]}},pp5,8'b00000000})+ {multiplier[9],8'b0000_0000} :0;
assign pp66= (pp6 !=0) ? ({{17{pp6[16]}},pp6,10'b0000000000}) + {multiplier[11],10'b00000_00000} :0;
assign pp77= (pp7 !=0) ? ({{17{pp7[16]}},pp7,12'b000000000000})+ {multiplier[13],12'b0000_0000_0000} :0;
assign pp88= (pp8 !=0) ? ({{17{pp8[16]}},pp8,14'b00000000000000}) + {multiplier[15],14'b0000_0000_0000_00} :0;

assign product= pp11 + pp22 + pp33 + pp44 + pp55 + pp66 + pp77 + pp88;
endmodule
