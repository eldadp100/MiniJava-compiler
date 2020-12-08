@.LS_vtable = global [4 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), 
   i8* bitcast (i32 (i8*)* @LS.Print to i8*), 
   i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), 
   i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)]

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}

define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define i32 @main() {
    %_1 = add i32 0, 20
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    %_6 = bitcast i8* %_5 to i8***
    %_7 = load i8**, i8*** %_6
    %_8 = add i32 0, 0
    %_9 = getelementptr i8*, i8** %_7, i32 %_8 
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*, i32)*
    %_12 = add i32 0, 10
    %_13 = call i32 %_11(i8* %_5, i32 %_12)

    call void (i32) @print_int(i32 %_13) 
	ret i32 0
}

define i32 @LS.Print(i8* %_0) {
    %1 = alloca i32
    %_1 = add i32 0, 1
    store i32 %_1, i32* %1
    br label %l0
l0:
    %_2 = load i32, i32* %1 
    %_3 = add i32 0, 16
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i32*
    %_6 = load i32, i32* %_5
    %_7 = icmp slt i32 %_2, %_6
    br i1 %_7, label %l1, label %l2
l1:
    %_8 = add i32 0, 8
    %_9 = getelementptr i8, i8* %_0, i32 %_8 
    %_10 = bitcast i8* %_9 to i32**
    %_11 = load i32*, i32** %_10
    %_12 = load i32, i32* %1 
    %_13 = add i32 0, -1
    %_14 = load i32, i32* %_11
    %_15 = icmp slt i32 %_12, %_14
    %_16 = icmp slt i32 %_13, %_12
    %_17 = and i1 %_15, %_16 
    br i1 %_17, label %l4, label %l3
l3:
    call void @throw_oob() 
    br label %l4
l4:
    %_18 = add i32 %_12, 1
    %_19 = getelementptr i32, i32* %_11, i32 %_18 
    %_20 = load i32, i32* %_19
    call void (i32) @print_int(i32 %_20) 
    %_21 = load i32, i32* %1 
    %_22 = add i32 0, 1
    %_23 = add i32 %_21, %_22
    store i32 %_23, i32* %1
    br label %l0
l2:
    %_24 = add i32 0, 0
    ret i32 %_24
}
define i32 @LS.Init(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %3 = alloca i32
    %4 = alloca i32
    %5 = alloca i32
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 16
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = load i32, i32* %1 
    %_6 = add i32 0, 0
    %_10 = icmp slt i32 %_6, %_5
    br i1 %_10, label %l17, label %l16
l16:
    call void @throw_oob() 
    br label %l17
l17:
    %_9 = add i32 %_5, 1
    %_7 = add i32 0, 4
    %_8 = call i8* @calloc(i32 %_9, i32 %_7)
    %_11 = bitcast i8* %_8 to i32*
    store i32 %_5, i32* %_11 
    %_12 = add i32 0, 8
    %_13 = getelementptr i8, i8* %_0, i32 %_12 
    %_14 = bitcast i8* %_13 to i32**
    store i32* %_11, i32** %_14
    %_15 = add i32 0, 1
    store i32 %_15, i32* %2
    %_16 = add i32 0, 16
    %_17 = getelementptr i8, i8* %_0, i32 %_16 
    %_18 = bitcast i8* %_17 to i32*
    %_19 = load i32, i32* %_18
    %_20 = add i32 0, 1
    %_21 = add i32 %_19, %_20
    store i32 %_21, i32* %3
    br label %l18
l18:
    %_22 = load i32, i32* %2 
    %_23 = add i32 0, 16
    %_24 = getelementptr i8, i8* %_0, i32 %_23 
    %_25 = bitcast i8* %_24 to i32*
    %_26 = load i32, i32* %_25
    %_27 = icmp slt i32 %_22, %_26
    br i1 %_27, label %l19, label %l20
l19:
    %_28 = add i32 0, 2
    %_29 = load i32, i32* %2 
    %_30 = mul i32 %_28, %_29
    store i32 %_30, i32* %4
    %_31 = load i32, i32* %3 
    %_32 = add i32 0, 3
    %_33 = sub i32 %_31, %_32
    store i32 %_33, i32* %5
    %_34 = load i32, i32* %4 
    %_35 = load i32, i32* %5 
    %_36 = add i32 %_34, %_35
    %_37 = load i32, i32* %2 
    %_38 = add i32 0, 8
    %_39 = getelementptr i8, i8* %_0, i32 %_38 
    %_40 = bitcast i8* %_39 to i32**
    %_41 = load i32*, i32** %_40
    %_42 = add i32 0, -1
    %_43 = load i32, i32* %_41
    %_44 = icmp slt i32 %_37, %_43
    %_45 = icmp slt i32 %_42, %_37
    %_46 = and i1 %_44, %_45 
    br i1 %_46, label %l22, label %l21
l21:
    call void @throw_oob() 
    br label %l22
l22:
    %_47 = add i32 %_37, 1
    %_48 = getelementptr i32, i32* %_41, i32 %_47 
    store i32 %_36, i32* %_48 
    %_49 = load i32, i32* %2 
    %_50 = add i32 0, 1
    %_51 = add i32 %_49, %_50
    store i32 %_51, i32* %2
    %_52 = load i32, i32* %3 
    %_53 = add i32 0, 1
    %_54 = sub i32 %_52, %_53
    store i32 %_54, i32* %3
    br label %l18
l20:
    %_55 = add i32 0, 0
    ret i32 %_55
}
define i32 @LS.Start(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %3 = alloca i32
    %_1 = bitcast i8* %_0 to i8*
    %_2 = bitcast i8* %_1 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 3
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i32)*
    %_8 = load i32, i32* %1 
    %_9 = call i32 %_7(i8* %_1, i32 %_8)

    store i32 %_9, i32* %2
    %_10 = bitcast i8* %_0 to i8*
    %_11 = bitcast i8* %_10 to i8***
    %_12 = load i8**, i8*** %_11
    %_13 = add i32 0, 1
    %_14 = getelementptr i8*, i8** %_12, i32 %_13 
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i32 (i8*)*
    %_17 = call i32 %_16(i8* %_10)

    store i32 %_17, i32* %3
    %_18 = add i32 0, 9999
    call void (i32) @print_int(i32 %_18) 
    %_19 = bitcast i8* %_0 to i8*
    %_20 = bitcast i8* %_19 to i8***
    %_21 = load i8**, i8*** %_20
    %_22 = add i32 0, 2
    %_23 = getelementptr i8*, i8** %_21, i32 %_22 
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i32 (i8*, i32)*
    %_26 = add i32 0, 8
    %_27 = call i32 %_25(i8* %_19, i32 %_26)

    call void (i32) @print_int(i32 %_27) 
    %_28 = bitcast i8* %_0 to i8*
    %_29 = bitcast i8* %_28 to i8***
    %_30 = load i8**, i8*** %_29
    %_31 = add i32 0, 2
    %_32 = getelementptr i8*, i8** %_30, i32 %_31 
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i32 (i8*, i32)*
    %_35 = add i32 0, 12
    %_36 = call i32 %_34(i8* %_28, i32 %_35)

    call void (i32) @print_int(i32 %_36) 
    %_37 = bitcast i8* %_0 to i8*
    %_38 = bitcast i8* %_37 to i8***
    %_39 = load i8**, i8*** %_38
    %_40 = add i32 0, 2
    %_41 = getelementptr i8*, i8** %_39, i32 %_40 
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i32 (i8*, i32)*
    %_44 = add i32 0, 17
    %_45 = call i32 %_43(i8* %_37, i32 %_44)

    call void (i32) @print_int(i32 %_45) 
    %_46 = bitcast i8* %_0 to i8*
    %_47 = bitcast i8* %_46 to i8***
    %_48 = load i8**, i8*** %_47
    %_49 = add i32 0, 2
    %_50 = getelementptr i8*, i8** %_48, i32 %_49 
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i32 (i8*, i32)*
    %_53 = add i32 0, 50
    %_54 = call i32 %_52(i8* %_46, i32 %_53)

    call void (i32) @print_int(i32 %_54) 
    %_55 = add i32 0, 55
    ret i32 %_55
}
define i32 @LS.Search(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %3 = alloca i1
    %4 = alloca i32
    %5 = alloca i32
    %6 = alloca i32
    %7 = alloca i32
    %_1 = add i32 0, 1
    store i32 %_1, i32* %2
    %_2 = add i1 0, 0 
    store i1 %_2, i1* %3
    %_3 = add i32 0, 0
    store i32 %_3, i32* %4
    br label %l5
l5:
    %_4 = load i32, i32* %2 
    %_5 = add i32 0, 16
    %_6 = getelementptr i8, i8* %_0, i32 %_5 
    %_7 = bitcast i8* %_6 to i32*
    %_8 = load i32, i32* %_7
    %_9 = icmp slt i32 %_4, %_8
    br i1 %_9, label %l6, label %l7
l6:
    %_10 = add i32 0, 8
    %_11 = getelementptr i8, i8* %_0, i32 %_10 
    %_12 = bitcast i8* %_11 to i32**
    %_13 = load i32*, i32** %_12
    %_14 = load i32, i32* %2 
    %_15 = add i32 0, -1
    %_16 = load i32, i32* %_13
    %_17 = icmp slt i32 %_14, %_16
    %_18 = icmp slt i32 %_15, %_14
    %_19 = and i1 %_17, %_18 
    br i1 %_19, label %l9, label %l8
l8:
    call void @throw_oob() 
    br label %l9
l9:
    %_20 = add i32 %_14, 1
    %_21 = getelementptr i32, i32* %_13, i32 %_20 
    %_22 = load i32, i32* %_21
    store i32 %_22, i32* %5
    %_23 = load i32, i32* %1 
    %_24 = add i32 0, 1
    %_25 = add i32 %_23, %_24
    store i32 %_25, i32* %6
    %_26 = load i32, i32* %5 
    %_27 = load i32, i32* %1 
    %_28 = icmp slt i32 %_26, %_27
    br i1 %_28, label %l10, label %l11
l10:
    %_29 = add i32 0, 0
    store i32 %_29, i32* %7
    br label %l12
l11:
    %_30 = load i32, i32* %5 
    %_31 = load i32, i32* %6 
    %_32 = icmp slt i32 %_30, %_31
    %_33 = xor i1 %_32, 1
    br i1 %_33, label %l13, label %l14
l13:
    %_34 = add i32 0, 0
    store i32 %_34, i32* %7
    br label %l15
l14:
    %_35 = add i1 0, 1 
    store i1 %_35, i1* %3
    %_36 = add i32 0, 1
    store i32 %_36, i32* %4
    %_37 = add i32 0, 16
    %_38 = getelementptr i8, i8* %_0, i32 %_37 
    %_39 = bitcast i8* %_38 to i32*
    %_40 = load i32, i32* %_39
    store i32 %_40, i32* %2
    br label %l15
l15:
    br label %l12
l12:
    %_41 = load i32, i32* %2 
    %_42 = add i32 0, 1
    %_43 = add i32 %_41, %_42
    store i32 %_43, i32* %2
    br label %l5
l7:
    %_44 = load i32, i32* %4 
    ret i32 %_44
}
