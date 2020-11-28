@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]
define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
    %0 = alloca i32
    %_3 = add i32 0, 1
    %_4 = icmp slt i32 %_2, %_3
    br i1 %_4, label %1, label %2
1:
    %_5 = add i32 0, 1
    store i32 %_5 i32* %0
    br label 3
2:
    %_6 = add i32 0, 1
    %_7 = sub i32 %_5 %_6
    %_9 = mul i32 %_5 %_8
    store i32 %_9 i32* %0
    br label 3
3:
    %_10 = load i32, i32* %0 
}
