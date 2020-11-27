@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]
define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
sym 0 = alloca i32
reg 3 = add i32 0, 1
reg 4 = icmp slt i32 reg 2, reg 3
br i1 reg 4, label sym 0, label sym 1
0:
reg 5 = add i32 0, 1
store i32 reg 5 i32* sym 0
br label 2
1:
reg 6 = add i32 0, 1
reg 7 = sub i32 reg 5 reg 6
reg 9 = mul i32 reg 5 reg 8
store i32 reg 9 i32* sym 0
br label 2
2:
reg 10 = load i32 i32* sym 0 
}
