module abm1(multiplier,multiplicand, product);
input signed [15:0]multiplier, multiplicand;
output signed [31:0]product;
wire [7:0]neg;
wire [7:0]two;
wire [7:0]zero;

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


wire  signed [16:0]pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;

wire signed [31:0]pp11;//[20:0]pp11;
wire signed [31:0]pp22;//[21:0]pp22;
wire signed [31:0]pp33;//[23:0]pp33;
wire signed [31:0]pp44;//[25:0]pp44;
wire signed [31:0]pp55;//[27:0]pp55;
wire signed [31:0]pp66;//[29:0]pp66;
wire signed [31:0]pp77;//[31:0]pp77;
wire signed [31:0]pp88;//[33:0]pp88;


/// Circuit schematic for approximate two-signal partial product generator PPG-2S.
wire signed [15:0]two_input_andgate[0:7];
wire signed [15:0]three_input_andgate[0:7];
wire signed [15:0]or_gate[0:7];
genvar j1;
generate for(j1=0;j1<=7;j1=j1+1) begin: neg_zero
assign two_input_andgate[j1]=(~multiplicand) & {16{neg[j1]}};
assign three_input_andgate[j1]=multiplicand & {16{~neg[j1]}} & {16{~zero[j1]}};
assign or_gate[j1]=two_input_andgate[j1] | three_input_andgate[j1];
end
endgenerate

wire signed [48:0]new_p1,new_p2,new_p3,new_p4,new_p5,new_p6,new_p7,new_p8;


assign new_p1= {{17{or_gate[0][15]}},or_gate[0][15:1],or_gate[0][0]|multiplier[1]};
assign new_p2= {{17{or_gate[1][15]}},or_gate[1][15:1],or_gate[1][0]|multiplier[3],2'b00};
assign new_p3= {{17{or_gate[2][15]}},or_gate[2][15:1],or_gate[2][0]|multiplier[5],4'b0000};
assign new_p4= {{17{or_gate[3][15]}},or_gate[3][15:1],or_gate[3][0]|multiplier[7],6'b000000};
assign new_p5= {{17{or_gate[4][15]}},or_gate[4][15:1],or_gate[4][0]|multiplier[9],8'b00000000};
assign new_p6= {{17{or_gate[5][15]}},or_gate[5][15:1],or_gate[5][0]|multiplier[11],10'b0000000000};
assign new_p7= {{17{or_gate[6][15]}},or_gate[6][15:1],or_gate[6][0]|multiplier[13],12'b000000000000}; 
assign new_p8= {{17{or_gate[7][15]}},or_gate[7][15:1],or_gate[7][0]|multiplier[15], 14'b00000000000000}; //32+15=47

assign product=new_p1+new_p2+new_p3+new_p4+new_p5+new_p6+new_p7+new_p8;
endmodule
