@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]
define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
sym 0 = alloca i32
reg 1 = add i32 0, 1
reg 3 = icmp slt i32 reg 1, reg 2
br i1 reg 3, label sym 0, label sym 1
0:
reg 3 = add i32 0, 1
store i32 reg 4 i32* 0
1:
reg 4 = add i32 0, 1
store i32 reg 5 i32* 0
}
