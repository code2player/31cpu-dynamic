module alu(
input [31:0] a,
input [31:0] b,
input [3:0] aluc,
input reset,
output reg [31:0] r,
output reg zero,
output reg carry,
output reg negative,
output reg overflow
    );
    
    reg [31:0]kkk;
    
    always @(*)
    begin
    
    if(reset==1'b1)
    begin
    r=32'b0;
    zero=0;
    carry=0;
    negative=0;
    overflow=0;
    end
    else
    begin
    
    if (aluc == 4'b0000)
    begin 
    r=a+b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r<a||r<b)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b0010)
    begin
    r=a+b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    if((a[31]==0&&b[31]==0&&r[31]==1)||(a[31]==1&&b[31]==1&&r[31]==0))
    overflow=1;
    else
    overflow=0;
    
    
    end
    else if (aluc == 4'b0001)
    begin
    r=a-b;
    
    if(r==0)
    zero=1;
    else
    zero=0;  
    if(r>a)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    

    end
    else if (aluc == 4'b0011)
    begin
    r=a-b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
   if((a[31]==0&&b[31]==1&&r[31]==1)||(a[31]==1&&b[31]==0&&r[31]==0))
    overflow=1;
    else
    overflow=0;

    end
    else if (aluc == 4'b0100)
    begin
    r=a&b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b0101)
    begin
    r=a|b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b0110)
    begin
    r=a^b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b0111)
    begin  
    r=~(a|b);
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1000||aluc == 4'b1001)
    begin
    r={b[15:0],16'b0};
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1011)
    begin
   // r=(a<b)?1:0;
   
   if(a[31]==0&&b[31]==0)
   r=(a<b)?1:0;
   else if(a[31]==0&&b[31]==1)
   r=0;
   else if(a[31]==1&&b[31]==0)
   r=1;
   else
   r=(a<b)?1:0;
   
   
    
    if(a-b==0)
    zero=1;
    else
    zero=0;
    
    kkk=a-b;
    
    if(kkk[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b1010)
    begin
    r=(a<b)?1:0;
    
    if(a-b==0)
    zero=1;
    else
    zero=0;
    if(a<b)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1100)
    begin
   // r=b>>>a;
    r=($signed(b)) >>> a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[a-1];
    else
    carry=b[31];
    //carry=
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    

    end
    else if (aluc == 4'b1110)
    begin
    r=b<<a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[32-a];
    else
    carry=0;
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1111)//原样传值，额外添加，用于mfhi,mflo操作中。
    begin
    r=a;

    end
    else if (aluc == 4'b1101)
    begin
    r=b>>a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[a-1];
    else
    carry=0;
    //carry=
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else
    begin
    
    end
    end
    end
endmodule
