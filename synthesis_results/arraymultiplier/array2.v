module array2(a, b, c);
    input [1:0]a, b;
    output [3:0]c;
    wire [3:0]c, temp;
     
    assign c[0]=a[0]&b[0];
    assign temp[0]=a[1]&b[0];
    assign temp[1]=a[0]&b[1];
    assign temp[2]=a[1]&b[1];
    ha z1(temp[0],temp[1],c[1],temp[3]);
    ha z2(temp[2],temp[3],c[2],c[3]);
 
endmodule
