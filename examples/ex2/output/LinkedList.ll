@.Element_vtable = global [6 x i8*] [
   i8* bitcast (i1 (i8*, i32, i32, i1)* @Element.Init to i8*), 
   i8* bitcast (i32 (i8*)* @Element.GetAge to i8*), 
   i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*), 
   i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*), 
   i8* bitcast (i1 (i8*, i8*)* @Element.Equal to i8*), 
   i8* bitcast (i1 (i8*, i32, i32)* @Element.Compare to i8*)]

@.List_vtable = global [10 x i8*] [
   i8* bitcast (i1 (i8*)* @List.Init to i8*), 
   i8* bitcast (i1 (i8*, i8*, i8*, i1)* @List.InitNew to i8*), 
   i8* bitcast (i8* (i8*, i8*)* @List.Insert to i8*), 
   i8* bitcast (i1 (i8*, i8*)* @List.SetNext to i8*), 
   i8* bitcast (i8* (i8*, i8*)* @List.Delete to i8*), 
   i8* bitcast (i32 (i8*, i8*)* @List.Search to i8*), 
   i8* bitcast (i1 (i8*)* @List.GetEnd to i8*), 
   i8* bitcast (i8* (i8*)* @List.GetElem to i8*), 
   i8* bitcast (i8* (i8*)* @List.GetNext to i8*), 
   i8* bitcast (i1 (i8*)* @List.Print to i8*)]

@.LL_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*)* @LL.Start to i8*)]

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
    %_1 = add i32 0, 8
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    %_6 = bitcast i8* %_5 to i8***
    %_7 = load i8**, i8*** %_6
    %_8 = add i32 0, 0
    %_9 = getelementptr i8*, i8** %_7, i32 %_8 
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*)*
    %_12 = call i32 %_11(i8* %_5)

    call void (i32) @print_int(i32 %_12) 
	ret i32 0
}

define i32 @Element.GetSalary(i8* %_0) {
    %_1 = add i32 0, 12
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    ret i32 %_4
}
define i1 @Element.Init(i8* %_0, i32 %.1, i32 %.2, i1 %.3) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    store i32 %.2, i32* %2 
    %3 = alloca i1
    store i1 %.3, i1* %3 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 8
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = load i32, i32* %2 
    %_6 = add i32 0, 12
    %_7 = getelementptr i8, i8* %_0, i32 %_6 
    %_8 = bitcast i8* %_7 to i32*
    store i32 %_5, i32* %_8
    %_9 = load i1, i1* %3 
    %_10 = add i32 0, 16
    %_11 = getelementptr i8, i8* %_0, i32 %_10 
    %_12 = bitcast i8* %_11 to i1*
    store i1 %_9, i1* %_12
    %_13 = add i1 0, 1 
    ret i1 %_13
}
define i32 @Element.GetAge(i8* %_0) {
    %_1 = add i32 0, 8
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    ret i32 %_4
}
define i1 @Element.Equal(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i1
    %3 = alloca i32
    %4 = alloca i32
    %5 = alloca i32
    %_1 = add i1 0, 1 
    store i1 %_1, i1* %2
    %_2 = load i8*, i8** %1 
    %_3 = bitcast i8* %_2 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = add i32 0, 1
    %_6 = getelementptr i8*, i8** %_4, i32 %_5 
    %_7 = load i8*, i8** %_6
    %_8 = bitcast i8* %_7 to i32 (i8*)*
    %_9 = call i32 %_8(i8* %_2)

    store i32 %_9, i32* %3
    %_10 = bitcast i8* %_0 to i8*
    %_11 = bitcast i8* %_10 to i8***
    %_12 = load i8**, i8*** %_11
    %_13 = add i32 0, 5
    %_14 = getelementptr i8*, i8** %_12, i32 %_13 
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i1 (i8*, i32, i32)*
    %_17 = load i32, i32* %3 
    %_18 = add i32 0, 8
    %_19 = getelementptr i8, i8* %_0, i32 %_18 
    %_20 = bitcast i8* %_19 to i32*
    %_21 = load i32, i32* %_20
    %_22 = call i1 %_16(i8* %_10, i32 %_17, i32 %_21)

    %_23 = xor i1 %_22, 1
    br i1 %_23, label %l0, label %l1
l0:
    %_24 = add i1 0, 0 
    store i1 %_24, i1* %2
    br label %l2
l1:
    %_25 = load i8*, i8** %1 
    %_26 = bitcast i8* %_25 to i8***
    %_27 = load i8**, i8*** %_26
    %_28 = add i32 0, 2
    %_29 = getelementptr i8*, i8** %_27, i32 %_28 
    %_30 = load i8*, i8** %_29
    %_31 = bitcast i8* %_30 to i32 (i8*)*
    %_32 = call i32 %_31(i8* %_25)

    store i32 %_32, i32* %4
    %_33 = bitcast i8* %_0 to i8*
    %_34 = bitcast i8* %_33 to i8***
    %_35 = load i8**, i8*** %_34
    %_36 = add i32 0, 5
    %_37 = getelementptr i8*, i8** %_35, i32 %_36 
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i1 (i8*, i32, i32)*
    %_40 = load i32, i32* %4 
    %_41 = add i32 0, 12
    %_42 = getelementptr i8, i8* %_0, i32 %_41 
    %_43 = bitcast i8* %_42 to i32*
    %_44 = load i32, i32* %_43
    %_45 = call i1 %_39(i8* %_33, i32 %_40, i32 %_44)

    %_46 = xor i1 %_45, 1
    br i1 %_46, label %l3, label %l4
l3:
    %_47 = add i1 0, 0 
    store i1 %_47, i1* %2
    br label %l5
l4:
    %_48 = add i32 0, 16
    %_49 = getelementptr i8, i8* %_0, i32 %_48 
    %_50 = bitcast i8* %_49 to i1*
    %_51 = load i1, i1* %_50
    br i1 %_51, label %l6, label %l7
l6:
    %_52 = load i8*, i8** %1 
    %_53 = bitcast i8* %_52 to i8***
    %_54 = load i8**, i8*** %_53
    %_55 = add i32 0, 3
    %_56 = getelementptr i8*, i8** %_54, i32 %_55 
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i1 (i8*)*
    %_59 = call i1 %_58(i8* %_52)

    %_60 = xor i1 %_59, 1
    br i1 %_60, label %l9, label %l10
l9:
    %_61 = add i1 0, 0 
    store i1 %_61, i1* %2
    br label %l11
l10:
    %_62 = add i32 0, 0
    store i32 %_62, i32* %5
    br label %l11
l11:
    br label %l8
l7:
    %_63 = load i8*, i8** %1 
    %_64 = bitcast i8* %_63 to i8***
    %_65 = load i8**, i8*** %_64
    %_66 = add i32 0, 3
    %_67 = getelementptr i8*, i8** %_65, i32 %_66 
    %_68 = load i8*, i8** %_67
    %_69 = bitcast i8* %_68 to i1 (i8*)*
    %_70 = call i1 %_69(i8* %_63)

    br i1 %_70, label %l12, label %l13
l12:
    %_71 = add i1 0, 0 
    store i1 %_71, i1* %2
    br label %l14
l13:
    %_72 = add i32 0, 0
    store i32 %_72, i32* %5
    br label %l14
l14:
    br label %l8
l8:
    br label %l5
l5:
    br label %l2
l2:
    %_73 = load i1, i1* %2 
    ret i1 %_73
}
define i1 @Element.GetMarried(i8* %_0) {
    %_1 = add i32 0, 16
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i1*
    %_4 = load i1, i1* %_3
    ret i1 %_4
}
define i1 @Element.Compare(i8* %_0, i32 %.1, i32 %.2) {
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
    br i1 %_7, label %l15, label %l16
l15:
    %_8 = add i1 0, 0 
    store i1 %_8, i1* %3
    br label %l17
l16:
    %_9 = load i32, i32* %1 
    %_10 = load i32, i32* %4 
    %_11 = icmp slt i32 %_9, %_10
    %_12 = xor i1 %_11, 1
    br i1 %_12, label %l18, label %l19
l18:
    %_13 = add i1 0, 0 
    store i1 %_13, i1* %3
    br label %l20
l19:
    %_14 = add i1 0, 1 
    store i1 %_14, i1* %3
    br label %l20
l20:
    br label %l17
l17:
    %_15 = load i1, i1* %3 
    ret i1 %_15
}
define i8* @List.Delete(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i8*
    %3 = alloca i1
    %4 = alloca i1
    %5 = alloca i8*
    %6 = alloca i8*
    %7 = alloca i1
    %8 = alloca i8*
    %9 = alloca i32
    %10 = alloca i32
    %_1 = bitcast i8* %_0 to i8*
    store i8* %_1, i8** %2
    %_2 = add i1 0, 0 
    store i1 %_2, i1* %3
    %_3 = add i32 0, 0
    %_4 = add i32 0, 1
    %_5 = sub i32 %_3, %_4
    store i32 %_5, i32* %9
    %_6 = bitcast i8* %_0 to i8*
    store i8* %_6, i8** %5
    %_7 = bitcast i8* %_0 to i8*
    store i8* %_7, i8** %6
    %_8 = add i32 0, 24
    %_9 = getelementptr i8, i8* %_0, i32 %_8 
    %_10 = bitcast i8* %_9 to i1*
    %_11 = load i1, i1* %_10
    store i1 %_11, i1* %7
    %_12 = add i32 0, 8
    %_13 = getelementptr i8, i8* %_0, i32 %_12 
    %_14 = bitcast i8* %_13 to i8**
    %_15 = load i8*, i8** %_14
    store i8* %_15, i8** %8
    br label %l21
l21:
    %_16 = load i1, i1* %7 
    %_17 = xor i1 %_16, 1
    br label %l24
l24:
    br i1 %_17, label %l25, label %l27
l25:
    %_18 = load i1, i1* %3 
    %_19 = xor i1 %_18, 1
    br label %l26
l26:
    br label %l27
l27:
    %_20 = phi i1 [0, %l24], [%_19, %l26]
    br i1 %_20, label %l22, label %l23
l22:
    %_21 = load i8*, i8** %1 
    %_22 = bitcast i8* %_21 to i8***
    %_23 = load i8**, i8*** %_22
    %_24 = add i32 0, 4
    %_25 = getelementptr i8*, i8** %_23, i32 %_24 
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i1 (i8*, i8*)*
    %_28 = load i8*, i8** %8 
    %_29 = call i1 %_27(i8* %_21, i8* %_28)

    br i1 %_29, label %l28, label %l29
l28:
    %_30 = add i1 0, 1 
    store i1 %_30, i1* %3
    %_31 = load i32, i32* %9 
    %_32 = add i32 0, 0
    %_33 = icmp slt i32 %_31, %_32
    br i1 %_33, label %l31, label %l32
l31:
    %_34 = load i8*, i8** %5 
    %_35 = bitcast i8* %_34 to i8***
    %_36 = load i8**, i8*** %_35
    %_37 = add i32 0, 8
    %_38 = getelementptr i8*, i8** %_36, i32 %_37 
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i8* (i8*)*
    %_41 = call i8* %_40(i8* %_34)

    store i8* %_41, i8** %2
    br label %l33
l32:
    %_42 = add i32 0, 0
    %_43 = add i32 0, 555
    %_44 = sub i32 %_42, %_43
    call void (i32) @print_int(i32 %_44) 
    %_45 = load i8*, i8** %6 
    %_46 = bitcast i8* %_45 to i8***
    %_47 = load i8**, i8*** %_46
    %_48 = add i32 0, 3
    %_49 = getelementptr i8*, i8** %_47, i32 %_48 
    %_50 = load i8*, i8** %_49
    %_51 = bitcast i8* %_50 to i1 (i8*, i8*)*
    %_52 = load i8*, i8** %5 
    %_53 = bitcast i8* %_52 to i8***
    %_54 = load i8**, i8*** %_53
    %_55 = add i32 0, 8
    %_56 = getelementptr i8*, i8** %_54, i32 %_55 
    %_57 = load i8*, i8** %_56
    %_58 = bitcast i8* %_57 to i8* (i8*)*
    %_59 = call i8* %_58(i8* %_52)

    %_60 = call i1 %_51(i8* %_45, i8* %_59)

    store i1 %_60, i1* %4
    %_61 = add i32 0, 0
    %_62 = add i32 0, 555
    %_63 = sub i32 %_61, %_62
    call void (i32) @print_int(i32 %_63) 
    br label %l33
l33:
    br label %l30
l29:
    %_64 = add i32 0, 0
    store i32 %_64, i32* %10
    br label %l30
l30:
    %_65 = load i1, i1* %3 
    %_66 = xor i1 %_65, 1
    br i1 %_66, label %l34, label %l35
l34:
    %_67 = load i8*, i8** %5 
    store i8* %_67, i8** %6
    %_68 = load i8*, i8** %5 
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = add i32 0, 8
    %_72 = getelementptr i8*, i8** %_70, i32 %_71 
    %_73 = load i8*, i8** %_72
    %_74 = bitcast i8* %_73 to i8* (i8*)*
    %_75 = call i8* %_74(i8* %_68)

    store i8* %_75, i8** %5
    %_76 = load i8*, i8** %5 
    %_77 = bitcast i8* %_76 to i8***
    %_78 = load i8**, i8*** %_77
    %_79 = add i32 0, 6
    %_80 = getelementptr i8*, i8** %_78, i32 %_79 
    %_81 = load i8*, i8** %_80
    %_82 = bitcast i8* %_81 to i1 (i8*)*
    %_83 = call i1 %_82(i8* %_76)

    store i1 %_83, i1* %7
    %_84 = load i8*, i8** %5 
    %_85 = bitcast i8* %_84 to i8***
    %_86 = load i8**, i8*** %_85
    %_87 = add i32 0, 7
    %_88 = getelementptr i8*, i8** %_86, i32 %_87 
    %_89 = load i8*, i8** %_88
    %_90 = bitcast i8* %_89 to i8* (i8*)*
    %_91 = call i8* %_90(i8* %_84)

    store i8* %_91, i8** %8
    %_92 = add i32 0, 1
    store i32 %_92, i32* %9
    br label %l36
l35:
    %_93 = add i32 0, 0
    store i32 %_93, i32* %10
    br label %l36
l36:
    br label %l21
l23:
    %_94 = load i8*, i8** %2 
    ret i8* %_94
}
define i1 @List.Print(i8* %_0) {
    %1 = alloca i8*
    %2 = alloca i1
    %3 = alloca i8*
    %_1 = bitcast i8* %_0 to i8*
    store i8* %_1, i8** %1
    %_2 = add i32 0, 24
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i1*
    %_5 = load i1, i1* %_4
    store i1 %_5, i1* %2
    %_6 = add i32 0, 8
    %_7 = getelementptr i8, i8* %_0, i32 %_6 
    %_8 = bitcast i8* %_7 to i8**
    %_9 = load i8*, i8** %_8
    store i8* %_9, i8** %3
    br label %l43
l43:
    %_10 = load i1, i1* %2 
    %_11 = xor i1 %_10, 1
    br i1 %_11, label %l44, label %l45
l44:
    %_12 = load i8*, i8** %3 
    %_13 = bitcast i8* %_12 to i8***
    %_14 = load i8**, i8*** %_13
    %_15 = add i32 0, 1
    %_16 = getelementptr i8*, i8** %_14, i32 %_15 
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i32 (i8*)*
    %_19 = call i32 %_18(i8* %_12)

    call void (i32) @print_int(i32 %_19) 
    %_20 = load i8*, i8** %1 
    %_21 = bitcast i8* %_20 to i8***
    %_22 = load i8**, i8*** %_21
    %_23 = add i32 0, 8
    %_24 = getelementptr i8*, i8** %_22, i32 %_23 
    %_25 = load i8*, i8** %_24
    %_26 = bitcast i8* %_25 to i8* (i8*)*
    %_27 = call i8* %_26(i8* %_20)

    store i8* %_27, i8** %1
    %_28 = load i8*, i8** %1 
    %_29 = bitcast i8* %_28 to i8***
    %_30 = load i8**, i8*** %_29
    %_31 = add i32 0, 6
    %_32 = getelementptr i8*, i8** %_30, i32 %_31 
    %_33 = load i8*, i8** %_32
    %_34 = bitcast i8* %_33 to i1 (i8*)*
    %_35 = call i1 %_34(i8* %_28)

    store i1 %_35, i1* %2
    %_36 = load i8*, i8** %1 
    %_37 = bitcast i8* %_36 to i8***
    %_38 = load i8**, i8*** %_37
    %_39 = add i32 0, 7
    %_40 = getelementptr i8*, i8** %_38, i32 %_39 
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i8* (i8*)*
    %_43 = call i8* %_42(i8* %_36)

    store i8* %_43, i8** %3
    br label %l43
l45:
    %_44 = add i1 0, 1 
    ret i1 %_44
}
define i1 @List.Init(i8* %_0) {
    %_1 = add i1 0, 1 
    %_2 = add i32 0, 24
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i1*
    store i1 %_1, i1* %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i8* @List.GetElem(i8* %_0) {
    %_1 = add i32 0, 8
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    ret i8* %_4
}
define i8* @List.GetNext(i8* %_0) {
    %_1 = add i32 0, 16
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    ret i8* %_4
}
define i1 @List.SetNext(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %_1 = load i8*, i8** %1 
    %_2 = add i32 0, 16
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i8**
    store i8* %_1, i8** %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i32 @List.Search(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i32
    %3 = alloca i8*
    %4 = alloca i8*
    %5 = alloca i1
    %6 = alloca i32
    %_1 = add i32 0, 0
    store i32 %_1, i32* %2
    %_2 = bitcast i8* %_0 to i8*
    store i8* %_2, i8** %3
    %_3 = add i32 0, 24
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i1*
    %_6 = load i1, i1* %_5
    store i1 %_6, i1* %5
    %_7 = add i32 0, 8
    %_8 = getelementptr i8, i8* %_0, i32 %_7 
    %_9 = bitcast i8* %_8 to i8**
    %_10 = load i8*, i8** %_9
    store i8* %_10, i8** %4
    br label %l37
l37:
    %_11 = load i1, i1* %5 
    %_12 = xor i1 %_11, 1
    br i1 %_12, label %l38, label %l39
l38:
    %_13 = load i8*, i8** %1 
    %_14 = bitcast i8* %_13 to i8***
    %_15 = load i8**, i8*** %_14
    %_16 = add i32 0, 4
    %_17 = getelementptr i8*, i8** %_15, i32 %_16 
    %_18 = load i8*, i8** %_17
    %_19 = bitcast i8* %_18 to i1 (i8*, i8*)*
    %_20 = load i8*, i8** %4 
    %_21 = call i1 %_19(i8* %_13, i8* %_20)

    br i1 %_21, label %l40, label %l41
l40:
    %_22 = add i32 0, 1
    store i32 %_22, i32* %2
    br label %l42
l41:
    %_23 = add i32 0, 0
    store i32 %_23, i32* %6
    br label %l42
l42:
    %_24 = load i8*, i8** %3 
    %_25 = bitcast i8* %_24 to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = add i32 0, 8
    %_28 = getelementptr i8*, i8** %_26, i32 %_27 
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i8* (i8*)*
    %_31 = call i8* %_30(i8* %_24)

    store i8* %_31, i8** %3
    %_32 = load i8*, i8** %3 
    %_33 = bitcast i8* %_32 to i8***
    %_34 = load i8**, i8*** %_33
    %_35 = add i32 0, 6
    %_36 = getelementptr i8*, i8** %_34, i32 %_35 
    %_37 = load i8*, i8** %_36
    %_38 = bitcast i8* %_37 to i1 (i8*)*
    %_39 = call i1 %_38(i8* %_32)

    store i1 %_39, i1* %5
    %_40 = load i8*, i8** %3 
    %_41 = bitcast i8* %_40 to i8***
    %_42 = load i8**, i8*** %_41
    %_43 = add i32 0, 7
    %_44 = getelementptr i8*, i8** %_42, i32 %_43 
    %_45 = load i8*, i8** %_44
    %_46 = bitcast i8* %_45 to i8* (i8*)*
    %_47 = call i8* %_46(i8* %_40)

    store i8* %_47, i8** %4
    br label %l37
l39:
    %_48 = load i32, i32* %2 
    ret i32 %_48
}
define i1 @List.GetEnd(i8* %_0) {
    %_1 = add i32 0, 24
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i1*
    %_4 = load i1, i1* %_3
    ret i1 %_4
}
define i1 @List.InitNew(i8* %_0, i8* %.1, i8* %.2, i1 %.3) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i8*
    store i8* %.2, i8** %2 
    %3 = alloca i1
    store i1 %.3, i1* %3 
    %_1 = load i1, i1* %3 
    %_2 = add i32 0, 24
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i1*
    store i1 %_1, i1* %_4
    %_5 = load i8*, i8** %1 
    %_6 = add i32 0, 8
    %_7 = getelementptr i8, i8* %_0, i32 %_6 
    %_8 = bitcast i8* %_7 to i8**
    store i8* %_5, i8** %_8
    %_9 = load i8*, i8** %2 
    %_10 = add i32 0, 16
    %_11 = getelementptr i8, i8* %_0, i32 %_10 
    %_12 = bitcast i8* %_11 to i8**
    store i8* %_9, i8** %_12
    %_13 = add i1 0, 1 
    ret i1 %_13
}
define i8* @List.Insert(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i1
    %3 = alloca i8*
    %4 = alloca i8*
    %_1 = bitcast i8* %_0 to i8*
    store i8* %_1, i8** %3

    %_2 = add i32 0, 25
    %_3 = add i32 0, 1
    %_6 = call i8* @calloc(i32 %_3, i32 %_2)
    %_4 = bitcast i8* %_6 to i8***
    %_5 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
    store i8** %_5, i8*** %_4 

    store i8* %_6, i8** %4
    %_7 = load i8*, i8** %4 
    %_8 = bitcast i8* %_7 to i8***
    %_9 = load i8**, i8*** %_8
    %_10 = add i32 0, 1
    %_11 = getelementptr i8*, i8** %_9, i32 %_10 
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i1 (i8*, i8*, i8*, i1)*
    %_14 = load i8*, i8** %1 
    %_15 = load i8*, i8** %3 
    %_16 = add i1 0, 0 
    %_17 = call i1 %_13(i8* %_7, i8* %_14, i8* %_15, i1 %_16)

    store i1 %_17, i1* %2
    %_18 = load i8*, i8** %4 
    ret i8* %_18
}
define i32 @LL.Start(i8* %_0) {
    %1 = alloca i8*
    %2 = alloca i8*
    %3 = alloca i1
    %4 = alloca i8*
    %5 = alloca i8*
    %6 = alloca i8*

    %_1 = add i32 0, 25
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    store i8* %_5, i8** %2
    %_6 = load i8*, i8** %2 
    %_7 = bitcast i8* %_6 to i8***
    %_8 = load i8**, i8*** %_7
    %_9 = add i32 0, 0
    %_10 = getelementptr i8*, i8** %_8, i32 %_9 
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i1 (i8*)*
    %_13 = call i1 %_12(i8* %_6)

    store i1 %_13, i1* %3
    %_14 = load i8*, i8** %2 
    store i8* %_14, i8** %1
    %_15 = load i8*, i8** %1 
    %_16 = bitcast i8* %_15 to i8***
    %_17 = load i8**, i8*** %_16
    %_18 = add i32 0, 0
    %_19 = getelementptr i8*, i8** %_17, i32 %_18 
    %_20 = load i8*, i8** %_19
    %_21 = bitcast i8* %_20 to i1 (i8*)*
    %_22 = call i1 %_21(i8* %_15)

    store i1 %_22, i1* %3
    %_23 = load i8*, i8** %1 
    %_24 = bitcast i8* %_23 to i8***
    %_25 = load i8**, i8*** %_24
    %_26 = add i32 0, 9
    %_27 = getelementptr i8*, i8** %_25, i32 %_26 
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i1 (i8*)*
    %_30 = call i1 %_29(i8* %_23)

    store i1 %_30, i1* %3

    %_31 = add i32 0, 17
    %_32 = add i32 0, 1
    %_35 = call i8* @calloc(i32 %_32, i32 %_31)
    %_33 = bitcast i8* %_35 to i8***
    %_34 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
    store i8** %_34, i8*** %_33 

    store i8* %_35, i8** %4
    %_36 = load i8*, i8** %4 
    %_37 = bitcast i8* %_36 to i8***
    %_38 = load i8**, i8*** %_37
    %_39 = add i32 0, 0
    %_40 = getelementptr i8*, i8** %_38, i32 %_39 
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i1 (i8*, i32, i32, i1)*
    %_43 = add i32 0, 25
    %_44 = add i32 0, 37000
    %_45 = add i1 0, 0 
    %_46 = call i1 %_42(i8* %_36, i32 %_43, i32 %_44, i1 %_45)

    store i1 %_46, i1* %3
    %_47 = load i8*, i8** %1 
    %_48 = bitcast i8* %_47 to i8***
    %_49 = load i8**, i8*** %_48
    %_50 = add i32 0, 2
    %_51 = getelementptr i8*, i8** %_49, i32 %_50 
    %_52 = load i8*, i8** %_51
    %_53 = bitcast i8* %_52 to i8* (i8*, i8*)*
    %_54 = load i8*, i8** %4 
    %_55 = call i8* %_53(i8* %_47, i8* %_54)

    store i8* %_55, i8** %1
    %_56 = load i8*, i8** %1 
    %_57 = bitcast i8* %_56 to i8***
    %_58 = load i8**, i8*** %_57
    %_59 = add i32 0, 9
    %_60 = getelementptr i8*, i8** %_58, i32 %_59 
    %_61 = load i8*, i8** %_60
    %_62 = bitcast i8* %_61 to i1 (i8*)*
    %_63 = call i1 %_62(i8* %_56)

    store i1 %_63, i1* %3
    %_64 = add i32 0, 10000000
    call void (i32) @print_int(i32 %_64) 

    %_65 = add i32 0, 17
    %_66 = add i32 0, 1
    %_69 = call i8* @calloc(i32 %_66, i32 %_65)
    %_67 = bitcast i8* %_69 to i8***
    %_68 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
    store i8** %_68, i8*** %_67 

    store i8* %_69, i8** %4
    %_70 = load i8*, i8** %4 
    %_71 = bitcast i8* %_70 to i8***
    %_72 = load i8**, i8*** %_71
    %_73 = add i32 0, 0
    %_74 = getelementptr i8*, i8** %_72, i32 %_73 
    %_75 = load i8*, i8** %_74
    %_76 = bitcast i8* %_75 to i1 (i8*, i32, i32, i1)*
    %_77 = add i32 0, 39
    %_78 = add i32 0, 42000
    %_79 = add i1 0, 1 
    %_80 = call i1 %_76(i8* %_70, i32 %_77, i32 %_78, i1 %_79)

    store i1 %_80, i1* %3
    %_81 = load i8*, i8** %4 
    store i8* %_81, i8** %5
    %_82 = load i8*, i8** %1 
    %_83 = bitcast i8* %_82 to i8***
    %_84 = load i8**, i8*** %_83
    %_85 = add i32 0, 2
    %_86 = getelementptr i8*, i8** %_84, i32 %_85 
    %_87 = load i8*, i8** %_86
    %_88 = bitcast i8* %_87 to i8* (i8*, i8*)*
    %_89 = load i8*, i8** %4 
    %_90 = call i8* %_88(i8* %_82, i8* %_89)

    store i8* %_90, i8** %1
    %_91 = load i8*, i8** %1 
    %_92 = bitcast i8* %_91 to i8***
    %_93 = load i8**, i8*** %_92
    %_94 = add i32 0, 9
    %_95 = getelementptr i8*, i8** %_93, i32 %_94 
    %_96 = load i8*, i8** %_95
    %_97 = bitcast i8* %_96 to i1 (i8*)*
    %_98 = call i1 %_97(i8* %_91)

    store i1 %_98, i1* %3
    %_99 = add i32 0, 10000000
    call void (i32) @print_int(i32 %_99) 

    %_100 = add i32 0, 17
    %_101 = add i32 0, 1
    %_104 = call i8* @calloc(i32 %_101, i32 %_100)
    %_102 = bitcast i8* %_104 to i8***
    %_103 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
    store i8** %_103, i8*** %_102 

    store i8* %_104, i8** %4
    %_105 = load i8*, i8** %4 
    %_106 = bitcast i8* %_105 to i8***
    %_107 = load i8**, i8*** %_106
    %_108 = add i32 0, 0
    %_109 = getelementptr i8*, i8** %_107, i32 %_108 
    %_110 = load i8*, i8** %_109
    %_111 = bitcast i8* %_110 to i1 (i8*, i32, i32, i1)*
    %_112 = add i32 0, 22
    %_113 = add i32 0, 34000
    %_114 = add i1 0, 0 
    %_115 = call i1 %_111(i8* %_105, i32 %_112, i32 %_113, i1 %_114)

    store i1 %_115, i1* %3
    %_116 = load i8*, i8** %1 
    %_117 = bitcast i8* %_116 to i8***
    %_118 = load i8**, i8*** %_117
    %_119 = add i32 0, 2
    %_120 = getelementptr i8*, i8** %_118, i32 %_119 
    %_121 = load i8*, i8** %_120
    %_122 = bitcast i8* %_121 to i8* (i8*, i8*)*
    %_123 = load i8*, i8** %4 
    %_124 = call i8* %_122(i8* %_116, i8* %_123)

    store i8* %_124, i8** %1
    %_125 = load i8*, i8** %1 
    %_126 = bitcast i8* %_125 to i8***
    %_127 = load i8**, i8*** %_126
    %_128 = add i32 0, 9
    %_129 = getelementptr i8*, i8** %_127, i32 %_128 
    %_130 = load i8*, i8** %_129
    %_131 = bitcast i8* %_130 to i1 (i8*)*
    %_132 = call i1 %_131(i8* %_125)

    store i1 %_132, i1* %3

    %_133 = add i32 0, 17
    %_134 = add i32 0, 1
    %_137 = call i8* @calloc(i32 %_134, i32 %_133)
    %_135 = bitcast i8* %_137 to i8***
    %_136 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
    store i8** %_136, i8*** %_135 

    store i8* %_137, i8** %6
    %_138 = load i8*, i8** %6 
    %_139 = bitcast i8* %_138 to i8***
    %_140 = load i8**, i8*** %_139
    %_141 = add i32 0, 0
    %_142 = getelementptr i8*, i8** %_140, i32 %_141 
    %_143 = load i8*, i8** %_142
    %_144 = bitcast i8* %_143 to i1 (i8*, i32, i32, i1)*
    %_145 = add i32 0, 27
    %_146 = add i32 0, 34000
    %_147 = add i1 0, 0 
    %_148 = call i1 %_144(i8* %_138, i32 %_145, i32 %_146, i1 %_147)

    store i1 %_148, i1* %3
    %_149 = load i8*, i8** %1 
    %_150 = bitcast i8* %_149 to i8***
    %_151 = load i8**, i8*** %_150
    %_152 = add i32 0, 5
    %_153 = getelementptr i8*, i8** %_151, i32 %_152 
    %_154 = load i8*, i8** %_153
    %_155 = bitcast i8* %_154 to i32 (i8*, i8*)*
    %_156 = load i8*, i8** %5 
    %_157 = call i32 %_155(i8* %_149, i8* %_156)

    call void (i32) @print_int(i32 %_157) 
    %_158 = load i8*, i8** %1 
    %_159 = bitcast i8* %_158 to i8***
    %_160 = load i8**, i8*** %_159
    %_161 = add i32 0, 5
    %_162 = getelementptr i8*, i8** %_160, i32 %_161 
    %_163 = load i8*, i8** %_162
    %_164 = bitcast i8* %_163 to i32 (i8*, i8*)*
    %_165 = load i8*, i8** %6 
    %_166 = call i32 %_164(i8* %_158, i8* %_165)

    call void (i32) @print_int(i32 %_166) 
    %_167 = add i32 0, 10000000
    call void (i32) @print_int(i32 %_167) 

    %_168 = add i32 0, 17
    %_169 = add i32 0, 1
    %_172 = call i8* @calloc(i32 %_169, i32 %_168)
    %_170 = bitcast i8* %_172 to i8***
    %_171 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0 
    store i8** %_171, i8*** %_170 

    store i8* %_172, i8** %4
    %_173 = load i8*, i8** %4 
    %_174 = bitcast i8* %_173 to i8***
    %_175 = load i8**, i8*** %_174
    %_176 = add i32 0, 0
    %_177 = getelementptr i8*, i8** %_175, i32 %_176 
    %_178 = load i8*, i8** %_177
    %_179 = bitcast i8* %_178 to i1 (i8*, i32, i32, i1)*
    %_180 = add i32 0, 28
    %_181 = add i32 0, 35000
    %_182 = add i1 0, 0 
    %_183 = call i1 %_179(i8* %_173, i32 %_180, i32 %_181, i1 %_182)

    store i1 %_183, i1* %3
    %_184 = load i8*, i8** %1 
    %_185 = bitcast i8* %_184 to i8***
    %_186 = load i8**, i8*** %_185
    %_187 = add i32 0, 2
    %_188 = getelementptr i8*, i8** %_186, i32 %_187 
    %_189 = load i8*, i8** %_188
    %_190 = bitcast i8* %_189 to i8* (i8*, i8*)*
    %_191 = load i8*, i8** %4 
    %_192 = call i8* %_190(i8* %_184, i8* %_191)

    store i8* %_192, i8** %1
    %_193 = load i8*, i8** %1 
    %_194 = bitcast i8* %_193 to i8***
    %_195 = load i8**, i8*** %_194
    %_196 = add i32 0, 9
    %_197 = getelementptr i8*, i8** %_195, i32 %_196 
    %_198 = load i8*, i8** %_197
    %_199 = bitcast i8* %_198 to i1 (i8*)*
    %_200 = call i1 %_199(i8* %_193)

    store i1 %_200, i1* %3
    %_201 = add i32 0, 2220000
    call void (i32) @print_int(i32 %_201) 
    %_202 = load i8*, i8** %1 
    %_203 = bitcast i8* %_202 to i8***
    %_204 = load i8**, i8*** %_203
    %_205 = add i32 0, 4
    %_206 = getelementptr i8*, i8** %_204, i32 %_205 
    %_207 = load i8*, i8** %_206
    %_208 = bitcast i8* %_207 to i8* (i8*, i8*)*
    %_209 = load i8*, i8** %5 
    %_210 = call i8* %_208(i8* %_202, i8* %_209)

    store i8* %_210, i8** %1
    %_211 = load i8*, i8** %1 
    %_212 = bitcast i8* %_211 to i8***
    %_213 = load i8**, i8*** %_212
    %_214 = add i32 0, 9
    %_215 = getelementptr i8*, i8** %_213, i32 %_214 
    %_216 = load i8*, i8** %_215
    %_217 = bitcast i8* %_216 to i1 (i8*)*
    %_218 = call i1 %_217(i8* %_211)

    store i1 %_218, i1* %3
    %_219 = add i32 0, 33300000
    call void (i32) @print_int(i32 %_219) 
    %_220 = load i8*, i8** %1 
    %_221 = bitcast i8* %_220 to i8***
    %_222 = load i8**, i8*** %_221
    %_223 = add i32 0, 4
    %_224 = getelementptr i8*, i8** %_222, i32 %_223 
    %_225 = load i8*, i8** %_224
    %_226 = bitcast i8* %_225 to i8* (i8*, i8*)*
    %_227 = load i8*, i8** %4 
    %_228 = call i8* %_226(i8* %_220, i8* %_227)

    store i8* %_228, i8** %1
    %_229 = load i8*, i8** %1 
    %_230 = bitcast i8* %_229 to i8***
    %_231 = load i8**, i8*** %_230
    %_232 = add i32 0, 9
    %_233 = getelementptr i8*, i8** %_231, i32 %_232 
    %_234 = load i8*, i8** %_233
    %_235 = bitcast i8* %_234 to i1 (i8*)*
    %_236 = call i1 %_235(i8* %_229)

    store i1 %_236, i1* %3
    %_237 = add i32 0, 44440000
    call void (i32) @print_int(i32 %_237) 
    %_238 = add i32 0, 0
    ret i32 %_238
}
