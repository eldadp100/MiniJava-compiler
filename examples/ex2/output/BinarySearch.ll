@.BS_vtable = global [6 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @BS.Start to i8*), 
   i8* bitcast (i1 (i8*, i32)* @BS.Search to i8*), 
   i8* bitcast (i32 (i8*, i32)* @BS.Div to i8*), 
   i8* bitcast (i1 (i8*, i32, i32)* @BS.Compare to i8*), 
   i8* bitcast (i32 (i8*)* @BS.Print to i8*), 
   i8* bitcast (i32 (i8*, i32)* @BS.Init to i8*)]

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
    %_4 = getelementptr [6 x i8*], [6 x i8*]* @.BS_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    %_6 = bitcast i8* %_5 to i8***
    %_7 = load i8**, i8*** %_6
    %_8 = add i32 0, 0
    %_9 = getelementptr i8*, i8** %_7, i32 %_8 
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*, i32)*
    %_12 = add i32 0, 20
    %_13 = call i32 %_11(i8* %_5, i32 %_12)

    call void (i32) @print_int(i32 %_13) 
	ret i32 0
}

define i32 @BS.Div(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %3 = alloca i32
    %4 = alloca i32
    %_1 = add i32 0, 0
    store i32 %_1, i32* %2
    %_2 = add i32 0, 0
    store i32 %_2, i32* %3
    %_3 = load i32, i32* %1 
    %_4 = add i32 0, 1
    %_5 = sub i32 %_3, %_4
    store i32 %_5, i32* %4
    br label %l41
l41:
    %_6 = load i32, i32* %3 
    %_7 = load i32, i32* %4 
    %_8 = icmp slt i32 %_6, %_7
    br i1 %_8, label %l42, label %l43
l42:
    %_9 = load i32, i32* %2 
    %_10 = add i32 0, 1
    %_11 = add i32 %_9, %_10
    store i32 %_11, i32* %2
    %_12 = load i32, i32* %3 
    %_13 = add i32 0, 2
    %_14 = add i32 %_12, %_13
    store i32 %_14, i32* %3
    br label %l41
l43:
    %_15 = load i32, i32* %2 
    ret i32 %_15
}
define i32 @BS.Print(i8* %_0) {
    %1 = alloca i32
    %_1 = add i32 0, 1
    store i32 %_1, i32* %1
    br label %l50
l50:
    %_2 = load i32, i32* %1 
    %_3 = add i32 0, 16
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i32*
    %_6 = load i32, i32* %_5
    %_7 = icmp slt i32 %_2, %_6
    br i1 %_7, label %l51, label %l52
l51:
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
    br i1 %_17, label %l54, label %l53
l53:
    call void @throw_oob() 
    br label %l54
l54:
    %_18 = add i32 %_12, 1
    %_19 = getelementptr i32, i32* %_11, i32 %_18 
    %_20 = load i32, i32* %_19
    call void (i32) @print_int(i32 %_20) 
    %_21 = load i32, i32* %1 
    %_22 = add i32 0, 1
    %_23 = add i32 %_21, %_22
    store i32 %_23, i32* %1
    br label %l50
l52:
    %_24 = add i32 0, 99999
    call void (i32) @print_int(i32 %_24) 
    %_25 = add i32 0, 0
    ret i32 %_25
}
define i32 @BS.Init(i8* %_0, i32 %.1) {
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
    br i1 %_10, label %l56, label %l55
l55:
    call void @throw_oob() 
    br label %l56
l56:
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
    br label %l57
l57:
    %_22 = load i32, i32* %2 
    %_23 = add i32 0, 16
    %_24 = getelementptr i8, i8* %_0, i32 %_23 
    %_25 = bitcast i8* %_24 to i32*
    %_26 = load i32, i32* %_25
    %_27 = icmp slt i32 %_22, %_26
    br i1 %_27, label %l58, label %l59
l58:
    %_28 = add i32 0, 2
    %_29 = load i32, i32* %2 
    %_30 = mul i32 %_28, %_29
    store i32 %_30, i32* %5
    %_31 = load i32, i32* %3 
    %_32 = add i32 0, 3
    %_33 = sub i32 %_31, %_32
    store i32 %_33, i32* %4
    %_34 = load i32, i32* %5 
    %_35 = load i32, i32* %4 
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
    br i1 %_46, label %l61, label %l60
l60:
    call void @throw_oob() 
    br label %l61
l61:
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
    br label %l57
l59:
    %_55 = add i32 0, 0
    ret i32 %_55
}
define i32 @BS.Start(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %3 = alloca i32
    %_1 = bitcast i8* %_0 to i8*
    %_2 = bitcast i8* %_1 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 5
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i32 (i8*, i32)*
    %_8 = load i32, i32* %1 
    %_9 = call i32 %_7(i8* %_1, i32 %_8)

    store i32 %_9, i32* %2
    %_10 = bitcast i8* %_0 to i8*
    %_11 = bitcast i8* %_10 to i8***
    %_12 = load i8**, i8*** %_11
    %_13 = add i32 0, 4
    %_14 = getelementptr i8*, i8** %_12, i32 %_13 
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i32 (i8*)*
    %_17 = call i32 %_16(i8* %_10)

    store i32 %_17, i32* %3
    %_18 = bitcast i8* %_0 to i8*
    %_19 = bitcast i8* %_18 to i8***
    %_20 = load i8**, i8*** %_19
    %_21 = add i32 0, 1
    %_22 = getelementptr i8*, i8** %_20, i32 %_21 
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i1 (i8*, i32)*
    %_25 = add i32 0, 8
    %_26 = call i1 %_24(i8* %_18, i32 %_25)

    br i1 %_26, label %l0, label %l1
l0:
    %_27 = add i32 0, 1
    call void (i32) @print_int(i32 %_27) 
    br label %l2
l1:
    %_28 = add i32 0, 0
    call void (i32) @print_int(i32 %_28) 
    br label %l2
l2:
    %_29 = bitcast i8* %_0 to i8*
    %_30 = bitcast i8* %_29 to i8***
    %_31 = load i8**, i8*** %_30
    %_32 = add i32 0, 1
    %_33 = getelementptr i8*, i8** %_31, i32 %_32 
    %_34 = load i8*, i8** %_33
    %_35 = bitcast i8* %_34 to i1 (i8*, i32)*
    %_36 = add i32 0, 19
    %_37 = call i1 %_35(i8* %_29, i32 %_36)

    br i1 %_37, label %l3, label %l4
l3:
    %_38 = add i32 0, 1
    call void (i32) @print_int(i32 %_38) 
    br label %l5
l4:
    %_39 = add i32 0, 0
    call void (i32) @print_int(i32 %_39) 
    br label %l5
l5:
    %_40 = bitcast i8* %_0 to i8*
    %_41 = bitcast i8* %_40 to i8***
    %_42 = load i8**, i8*** %_41
    %_43 = add i32 0, 1
    %_44 = getelementptr i8*, i8** %_42, i32 %_43 
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i1 (i8*, i32)*
    %_47 = add i32 0, 20
    %_48 = call i1 %_46(i8* %_40, i32 %_47)

    br i1 %_48, label %l6, label %l7
l6:
    %_49 = add i32 0, 1
    call void (i32) @print_int(i32 %_49) 
    br label %l8
l7:
    %_50 = add i32 0, 0
    call void (i32) @print_int(i32 %_50) 
    br label %l8
l8:
    %_51 = bitcast i8* %_0 to i8*
    %_52 = bitcast i8* %_51 to i8***
    %_53 = load i8**, i8*** %_52
    %_54 = add i32 0, 1
    %_55 = getelementptr i8*, i8** %_53, i32 %_54 
    %_56 = load i8*, i8** %_55
    %_57 = bitcast i8* %_56 to i1 (i8*, i32)*
    %_58 = add i32 0, 21
    %_59 = call i1 %_57(i8* %_51, i32 %_58)

    br i1 %_59, label %l9, label %l10
l9:
    %_60 = add i32 0, 1
    call void (i32) @print_int(i32 %_60) 
    br label %l11
l10:
    %_61 = add i32 0, 0
    call void (i32) @print_int(i32 %_61) 
    br label %l11
l11:
    %_62 = bitcast i8* %_0 to i8*
    %_63 = bitcast i8* %_62 to i8***
    %_64 = load i8**, i8*** %_63
    %_65 = add i32 0, 1
    %_66 = getelementptr i8*, i8** %_64, i32 %_65 
    %_67 = load i8*, i8** %_66
    %_68 = bitcast i8* %_67 to i1 (i8*, i32)*
    %_69 = add i32 0, 37
    %_70 = call i1 %_68(i8* %_62, i32 %_69)

    br i1 %_70, label %l12, label %l13
l12:
    %_71 = add i32 0, 1
    call void (i32) @print_int(i32 %_71) 
    br label %l14
l13:
    %_72 = add i32 0, 0
    call void (i32) @print_int(i32 %_72) 
    br label %l14
l14:
    %_73 = bitcast i8* %_0 to i8*
    %_74 = bitcast i8* %_73 to i8***
    %_75 = load i8**, i8*** %_74
    %_76 = add i32 0, 1
    %_77 = getelementptr i8*, i8** %_75, i32 %_76 
    %_78 = load i8*, i8** %_77
    %_79 = bitcast i8* %_78 to i1 (i8*, i32)*
    %_80 = add i32 0, 38
    %_81 = call i1 %_79(i8* %_73, i32 %_80)

    br i1 %_81, label %l15, label %l16
l15:
    %_82 = add i32 0, 1
    call void (i32) @print_int(i32 %_82) 
    br label %l17
l16:
    %_83 = add i32 0, 0
    call void (i32) @print_int(i32 %_83) 
    br label %l17
l17:
    %_84 = bitcast i8* %_0 to i8*
    %_85 = bitcast i8* %_84 to i8***
    %_86 = load i8**, i8*** %_85
    %_87 = add i32 0, 1
    %_88 = getelementptr i8*, i8** %_86, i32 %_87 
    %_89 = load i8*, i8** %_88
    %_90 = bitcast i8* %_89 to i1 (i8*, i32)*
    %_91 = add i32 0, 39
    %_92 = call i1 %_90(i8* %_84, i32 %_91)

    br i1 %_92, label %l18, label %l19
l18:
    %_93 = add i32 0, 1
    call void (i32) @print_int(i32 %_93) 
    br label %l20
l19:
    %_94 = add i32 0, 0
    call void (i32) @print_int(i32 %_94) 
    br label %l20
l20:
    %_95 = bitcast i8* %_0 to i8*
    %_96 = bitcast i8* %_95 to i8***
    %_97 = load i8**, i8*** %_96
    %_98 = add i32 0, 1
    %_99 = getelementptr i8*, i8** %_97, i32 %_98 
    %_100 = load i8*, i8** %_99
    %_101 = bitcast i8* %_100 to i1 (i8*, i32)*
    %_102 = add i32 0, 50
    %_103 = call i1 %_101(i8* %_95, i32 %_102)

    br i1 %_103, label %l21, label %l22
l21:
    %_104 = add i32 0, 1
    call void (i32) @print_int(i32 %_104) 
    br label %l23
l22:
    %_105 = add i32 0, 0
    call void (i32) @print_int(i32 %_105) 
    br label %l23
l23:
    %_106 = add i32 0, 999
    ret i32 %_106
}
define i1 @BS.Search(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i1
    %3 = alloca i32
    %4 = alloca i32
    %5 = alloca i1
    %6 = alloca i32
    %7 = alloca i32
    %8 = alloca i32
    %_1 = add i32 0, 0
    store i32 %_1, i32* %7
    %_2 = add i1 0, 0 
    store i1 %_2, i1* %2
    %_3 = add i32 0, 8
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i32**
    %_6 = load i32*, i32** %_5
    %_7 = load i32, i32* %_6
    store i32 %_7, i32* %3
    %_8 = load i32, i32* %3 
    %_9 = add i32 0, 1
    %_10 = sub i32 %_8, %_9
    store i32 %_10, i32* %3
    %_11 = add i32 0, 0
    store i32 %_11, i32* %4
    %_12 = add i1 0, 1 
    store i1 %_12, i1* %5
    br label %l24
l24:
    %_13 = load i1, i1* %5 
    br i1 %_13, label %l25, label %l26
l25:
    %_14 = load i32, i32* %4 
    %_15 = load i32, i32* %3 
    %_16 = add i32 %_14, %_15
    store i32 %_16, i32* %6
    %_17 = bitcast i8* %_0 to i8*
    %_18 = bitcast i8* %_17 to i8***
    %_19 = load i8**, i8*** %_18
    %_20 = add i32 0, 2
    %_21 = getelementptr i8*, i8** %_19, i32 %_20 
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i32 (i8*, i32)*
    %_24 = load i32, i32* %6 
    %_25 = call i32 %_23(i8* %_17, i32 %_24)

    store i32 %_25, i32* %6
    %_26 = add i32 0, 8
    %_27 = getelementptr i8, i8* %_0, i32 %_26 
    %_28 = bitcast i8* %_27 to i32**
    %_29 = load i32*, i32** %_28
    %_30 = load i32, i32* %6 
    %_31 = add i32 0, -1
    %_32 = load i32, i32* %_29
    %_33 = icmp slt i32 %_30, %_32
    %_34 = icmp slt i32 %_31, %_30
    %_35 = and i1 %_33, %_34 
    br i1 %_35, label %l28, label %l27
l27:
    call void @throw_oob() 
    br label %l28
l28:
    %_36 = add i32 %_30, 1
    %_37 = getelementptr i32, i32* %_29, i32 %_36 
    %_38 = load i32, i32* %_37
    store i32 %_38, i32* %7
    %_39 = load i32, i32* %1 
    %_40 = load i32, i32* %7 
    %_41 = icmp slt i32 %_39, %_40
    br i1 %_41, label %l29, label %l30
l29:
    %_42 = load i32, i32* %6 
    %_43 = add i32 0, 1
    %_44 = sub i32 %_42, %_43
    store i32 %_44, i32* %3
    br label %l31
l30:
    %_45 = load i32, i32* %6 
    %_46 = add i32 0, 1
    %_47 = add i32 %_45, %_46
    store i32 %_47, i32* %4
    br label %l31
l31:
    %_48 = bitcast i8* %_0 to i8*
    %_49 = bitcast i8* %_48 to i8***
    %_50 = load i8**, i8*** %_49
    %_51 = add i32 0, 3
    %_52 = getelementptr i8*, i8** %_50, i32 %_51 
    %_53 = load i8*, i8** %_52
    %_54 = bitcast i8* %_53 to i1 (i8*, i32, i32)*
    %_55 = load i32, i32* %7 
    %_56 = load i32, i32* %1 
    %_57 = call i1 %_54(i8* %_48, i32 %_55, i32 %_56)

    br i1 %_57, label %l32, label %l33
l32:
    %_58 = add i1 0, 0 
    store i1 %_58, i1* %5
    br label %l34
l33:
    %_59 = add i1 0, 1 
    store i1 %_59, i1* %5
    br label %l34
l34:
    %_60 = load i32, i32* %3 
    %_61 = load i32, i32* %4 
    %_62 = icmp slt i32 %_60, %_61
    br i1 %_62, label %l35, label %l36
l35:
    %_63 = add i1 0, 0 
    store i1 %_63, i1* %5
    br label %l37
l36:
    %_64 = add i32 0, 0
    store i32 %_64, i32* %8
    br label %l37
l37:
    br label %l24
l26:
    %_65 = bitcast i8* %_0 to i8*
    %_66 = bitcast i8* %_65 to i8***
    %_67 = load i8**, i8*** %_66
    %_68 = add i32 0, 3
    %_69 = getelementptr i8*, i8** %_67, i32 %_68 
    %_70 = load i8*, i8** %_69
    %_71 = bitcast i8* %_70 to i1 (i8*, i32, i32)*
    %_72 = load i32, i32* %7 
    %_73 = load i32, i32* %1 
    %_74 = call i1 %_71(i8* %_65, i32 %_72, i32 %_73)

    br i1 %_74, label %l38, label %l39
l38:
    %_75 = add i1 0, 1 
    store i1 %_75, i1* %2
    br label %l40
l39:
    %_76 = add i1 0, 0 
    store i1 %_76, i1* %2
    br label %l40
l40:
    %_77 = load i1, i1* %2 
    ret i1 %_77
}
define i1 @BS.Compare(i8* %_0, i32 %.1, i32 %.2) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    store i32 %.2, i32* %2 
    %3 = alloca i1
    %4 = alloca i32
    %_1 = add i1 0, 0 
    store i1 %_1, i1* %3
    %_2 = load i32, i32* %2 
    %_3 = add i32 0, 1
    %_4 = add i32 %_2, %_3
    store i32 %_4, i32* %4
    %_5 = load i32, i32* %1 
    %_6 = load i32, i32* %2 
    %_7 = icmp slt i32 %_5, %_6
    br i1 %_7, label %l44, label %l45
l44:
    %_8 = add i1 0, 0 
    store i1 %_8, i1* %3
    br label %l46
l45:
    %_9 = load i32, i32* %1 
    %_10 = load i32, i32* %4 
    %_11 = icmp slt i32 %_9, %_10
    %_12 = xor i1 %_11, 1
    br i1 %_12, label %l47, label %l48
l47:
    %_13 = add i1 0, 0 
    store i1 %_13, i1* %3
    br label %l49
l48:
    %_14 = add i1 0, 1 
    store i1 %_14, i1* %3
    br label %l49
l49:
    br label %l46
l46:
    %_15 = load i1, i1* %3 
    ret i1 %_15
}
