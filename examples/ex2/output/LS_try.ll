@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)]
define i32 @LS.Start(i8* %this, i32 %.sz) {
sym 2 = alloca i32
sym 3 = alloca i32
store i32 reg 1 i32* 2
store i32 reg 1 i32* 3
reg 1 = add i32 0, 9999
reg 2 = add i32 0, 8
reg 3 = add i32 0, 12
reg 4 = add i32 0, 17
reg 5 = add i32 0, 50
reg 6 = add i32 0, 55
}
define i32 @LS.Print(i8* %this) {
sym 4 = alloca i32
reg 7 = add i32 0, 1
store i32 reg 8 i32* 4
reg 9 = icmp slt i32 reg 8, reg 8
reg 10 = add i32 0, 0
reg 12 = icmp slt i32 reg 9, reg 11
reg 13 = icmp slt i32 reg 10, reg 9
reg 14 = and reg 12, reg 13 
br i1 reg 14, label sym 1, label sym 0
0:
call void @throw_oob()1:
reg 16 = add i32 0, 1
reg 18 = add i32 reg 16 reg 17
store i32 reg 18 i32* 4
reg 18 = add i32 0, 0
}
define i32 @LS.Search(i8* %this, i32 %.num) {
sym 5 = alloca i32
sym 6 = alloca i1
sym 7 = alloca i32
sym 8 = alloca i32
sym 9 = alloca i32
sym 10 = alloca i32
reg 19 = add i32 0, 1
store i32 reg 20 i32* 5
store i1 reg 20 i1* 6
reg 20 = add i32 0, 0
store i32 reg 21 i32* 7
reg 22 = icmp slt i32 reg 21, reg 21
reg 23 = add i32 0, 0
reg 25 = icmp slt i32 reg 22, reg 24
reg 26 = icmp slt i32 reg 23, reg 22
reg 27 = and reg 25, reg 26 
br i1 reg 27, label sym 3, label sym 2
2:
call void @throw_oob()3:
store i32 reg 29 i32* 8
reg 29 = add i32 0, 1
reg 31 = add i32 reg 29 reg 30
store i32 reg 31 i32* 9
reg 32 = icmp slt i32 reg 31, reg 31
br i1 reg 32, label sym 4, label sym 5
4:
reg 32 = add i32 0, 0
store i32 reg 33 i32* 10
5:
reg 34 = icmp slt i32 reg 33, reg 33
reg 35 = not reg 35
br i1 reg 35, label sym 6, label sym 7
6:
reg 35 = add i32 0, 0
store i32 reg 36 i32* 10
7:
store i1 reg 36 i1* 6
reg 36 = add i32 0, 1
store i32 reg 37 i32* 7
store i32 reg 37 i32* 5
reg 37 = add i32 0, 1
reg 39 = add i32 reg 37 reg 38
store i32 reg 39 i32* 5
}
define i32 @LS.Init(i8* %this, i32 %.sz) {
sym 11 = alloca i32
sym 12 = alloca i32
sym 13 = alloca i32
sym 14 = alloca i32
store i32 reg 39 i32* 1
reg 42 = icmp slt i32 reg 0, reg 41
br i1 reg 42, label sym 9, label sym 8
8:
call void @throw_oob()br label sym 9
9:
reg 40 = call i8* @calloc(i32 reg 41, i32 reg 4)
reg 41 = bitcast i8* reg 40 to i32*
store i32 reg 41, i32* 41 
store i32* reg 42 i32** 0
reg 42 = add i32 0, 1
store i32 reg 43 i32* 11
reg 43 = add i32 0, 1
reg 45 = add i32 reg 43 reg 44
store i32 reg 45 i32* 12
reg 46 = icmp slt i32 reg 45, reg 45
reg 46 = add i32 0, 2
store i32 reg 47 i32* 13
reg 47 = add i32 0, 3
store i32 reg 48 i32* 14
reg 49 = add i32 reg 48 reg 48
reg 49 = add i32 0, 1
reg 51 = add i32 reg 49 reg 50
store i32 reg 51 i32* 11
reg 51 = add i32 0, 1
store i32 reg 52 i32* 12
reg 52 = add i32 0, 0
}
