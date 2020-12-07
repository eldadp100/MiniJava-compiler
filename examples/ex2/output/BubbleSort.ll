@.BBS_vtable = global [4 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @BBS.Start to i8*), 
   i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), 
   i8* bitcast (i32 (i8*)* @BBS.Print to i8*), 
   i8* bitcast (i32 (i8*, i32)* @BBS.Init to i8*)]

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
    %_4 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0 
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

define i32 @BBS.Print(i8* %_0) {
    %1 = alloca i32
    %_1 = add i32 0, 0
    store i32 %_1, i32* %1
    br label %l21
l21:
    %_2 = load i32, i32* %1 
    %_3 = add i32 0, 16
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i32*
    %_6 = load i32, i32* %_5
    %_7 = icmp slt i32 %_2, %_6
    br i1 %_7, label %l22, label %l23
l22:
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
    br i1 %_17, label %l25, label %l24
l24:
    call void @throw_oob() 
    br label %l25
l25:
    %_18 = add i32 %_12, 1
    %_19 = getelementptr i32, i32* %_11, i32 %_18 
    %_20 = load i32, i32* %_19
    call void (i32) @print_int(i32 %_20) 
    %_21 = load i32, i32* %1 
    %_22 = add i32 0, 1
    %_23 = add i32 %_21, %_22
    store i32 %_23, i32* %1
    br label %l21
l23:
    %_24 = add i32 0, 0
    ret i32 %_24
}
define i32 @BBS.Init(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 16
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = load i32, i32* %1 
    %_6 = add i32 0, 0
    %_10 = icmp slt i32 %_6, %_5
    br i1 %_10, label %l27, label %l26
l26:
    call void @throw_oob() 
    br label %l27
l27:
    %_9 = add i32 %_5, 1
    %_7 = add i32 0, 4
    %_8 = call i8* @calloc(i32 %_9, i32 %_7)
    %_11 = bitcast i8* %_8 to i32*
    store i32 %_5, i32* %_11 
    %_12 = add i32 0, 8
    %_13 = getelementptr i8, i8* %_0, i32 %_12 
    %_14 = bitcast i8* %_13 to i32**
    store i32* %_11, i32** %_14
    %_15 = add i32 0, 20
    %_16 = add i32 0, 0
    %_17 = add i32 0, 8
    %_18 = getelementptr i8, i8* %_0, i32 %_17 
    %_19 = bitcast i8* %_18 to i32**
    %_20 = load i32*, i32** %_19
    %_21 = add i32 0, -1
    %_22 = load i32, i32* %_20
    %_23 = icmp slt i32 %_16, %_22
    %_24 = icmp slt i32 %_21, %_16
    %_25 = and i1 %_23, %_24 
    br i1 %_25, label %l29, label %l28
l28:
    call void @throw_oob() 
    br label %l29
l29:
    %_26 = add i32 %_16, 1
    %_27 = getelementptr i32, i32* %_20, i32 %_26 
    store i32 %_15, i32* %_27 
    %_28 = add i32 0, 7
    %_29 = add i32 0, 1
    %_30 = add i32 0, 8
    %_31 = getelementptr i8, i8* %_0, i32 %_30 
    %_32 = bitcast i8* %_31 to i32**
    %_33 = load i32*, i32** %_32
    %_34 = add i32 0, -1
    %_35 = load i32, i32* %_33
    %_36 = icmp slt i32 %_29, %_35
    %_37 = icmp slt i32 %_34, %_29
    %_38 = and i1 %_36, %_37 
    br i1 %_38, label %l31, label %l30
l30:
    call void @throw_oob() 
    br label %l31
l31:
    %_39 = add i32 %_29, 1
    %_40 = getelementptr i32, i32* %_33, i32 %_39 
    store i32 %_28, i32* %_40 
    %_41 = add i32 0, 12
    %_42 = add i32 0, 2
    %_43 = add i32 0, 8
    %_44 = getelementptr i8, i8* %_0, i32 %_43 
    %_45 = bitcast i8* %_44 to i32**
    %_46 = load i32*, i32** %_45
    %_47 = add i32 0, -1
    %_48 = load i32, i32* %_46
    %_49 = icmp slt i32 %_42, %_48
    %_50 = icmp slt i32 %_47, %_42
    %_51 = and i1 %_49, %_50 
    br i1 %_51, label %l33, label %l32
l32:
    call void @throw_oob() 
    br label %l33
l33:
    %_52 = add i32 %_42, 1
    %_53 = getelementptr i32, i32* %_46, i32 %_52 
    store i32 %_41, i32* %_53 
    %_54 = add i32 0, 18
    %_55 = add i32 0, 3
    %_56 = add i32 0, 8
    %_57 = getelementptr i8, i8* %_0, i32 %_56 
    %_58 = bitcast i8* %_57 to i32**
    %_59 = load i32*, i32** %_58
    %_60 = add i32 0, -1
    %_61 = load i32, i32* %_59
    %_62 = icmp slt i32 %_55, %_61
    %_63 = icmp slt i32 %_60, %_55
    %_64 = and i1 %_62, %_63 
    br i1 %_64, label %l35, label %l34
l34:
    call void @throw_oob() 
    br label %l35
l35:
    %_65 = add i32 %_55, 1
    %_66 = getelementptr i32, i32* %_59, i32 %_65 
    store i32 %_54, i32* %_66 
    %_67 = add i32 0, 2
    %_68 = add i32 0, 4
    %_69 = add i32 0, 8
    %_70 = getelementptr i8, i8* %_0, i32 %_69 
    %_71 = bitcast i8* %_70 to i32**
    %_72 = load i32*, i32** %_71
    %_73 = add i32 0, -1
    %_74 = load i32, i32* %_72
    %_75 = icmp slt i32 %_68, %_74
    %_76 = icmp slt i32 %_73, %_68
    %_77 = and i1 %_75, %_76 
    br i1 %_77, label %l37, label %l36
l36:
    call void @throw_oob() 
    br label %l37
l37:
    %_78 = add i32 %_68, 1
    %_79 = getelementptr i32, i32* %_72, i32 %_78 
    store i32 %_67, i32* %_79 
    %_80 = add i32 0, 11
    %_81 = add i32 0, 5
    %_82 = add i32 0, 8
    %_83 = getelementptr i8, i8* %_0, i32 %_82 
    %_84 = bitcast i8* %_83 to i32**
    %_85 = load i32*, i32** %_84
    %_86 = add i32 0, -1
    %_87 = load i32, i32* %_85
    %_88 = icmp slt i32 %_81, %_87
    %_89 = icmp slt i32 %_86, %_81
    %_90 = and i1 %_88, %_89 
    br i1 %_90, label %l39, label %l38
l38:
    call void @throw_oob() 
    br label %l39
l39:
    %_91 = add i32 %_81, 1
    %_92 = getelementptr i32, i32* %_85, i32 %_91 
    store i32 %_80, i32* %_92 
    %_93 = add i32 0, 6
    %_94 = add i32 0, 6
    %_95 = add i32 0, 8
    %_96 = getelementptr i8, i8* %_0, i32 %_95 
    %_97 = bitcast i8* %_96 to i32**
    %_98 = load i32*, i32** %_97
    %_99 = add i32 0, -1
    %_100 = load i32, i32* %_98
    %_101 = icmp slt i32 %_94, %_100
    %_102 = icmp slt i32 %_99, %_94
    %_103 = and i1 %_101, %_102 
    br i1 %_103, label %l41, label %l40
l40:
    call void @throw_oob() 
    br label %l41
l41:
    %_104 = add i32 %_94, 1
    %_105 = getelementptr i32, i32* %_98, i32 %_104 
    store i32 %_93, i32* %_105 
    %_106 = add i32 0, 9
    %_107 = add i32 0, 7
    %_108 = add i32 0, 8
    %_109 = getelementptr i8, i8* %_0, i32 %_108 
    %_110 = bitcast i8* %_109 to i32**
    %_111 = load i32*, i32** %_110
    %_112 = add i32 0, -1
    %_113 = load i32, i32* %_111
    %_114 = icmp slt i32 %_107, %_113
    %_115 = icmp slt i32 %_112, %_107
    %_116 = and i1 %_114, %_115 
    br i1 %_116, label %l43, label %l42
l42:
    call void @throw_oob() 
    br label %l43
l43:
    %_117 = add i32 %_107, 1
    %_118 = getelementptr i32, i32* %_111, i32 %_117 
    store i32 %_106, i32* %_118 
    %_119 = add i32 0, 19
    %_120 = add i32 0, 8
    %_121 = add i32 0, 8
    %_122 = getelementptr i8, i8* %_0, i32 %_121 
    %_123 = bitcast i8* %_122 to i32**
    %_124 = load i32*, i32** %_123
    %_125 = add i32 0, -1
    %_126 = load i32, i32* %_124
    %_127 = icmp slt i32 %_120, %_126
    %_128 = icmp slt i32 %_125, %_120
    %_129 = and i1 %_127, %_128 
    br i1 %_129, label %l45, label %l44
l44:
    call void @throw_oob() 
    br label %l45
l45:
    %_130 = add i32 %_120, 1
    %_131 = getelementptr i32, i32* %_124, i32 %_130 
    store i32 %_119, i32* %_131 
    %_132 = add i32 0, 5
    %_133 = add i32 0, 9
    %_134 = add i32 0, 8
    %_135 = getelementptr i8, i8* %_0, i32 %_134 
    %_136 = bitcast i8* %_135 to i32**
    %_137 = load i32*, i32** %_136
    %_138 = add i32 0, -1
    %_139 = load i32, i32* %_137
    %_140 = icmp slt i32 %_133, %_139
    %_141 = icmp slt i32 %_138, %_133
    %_142 = and i1 %_140, %_141 
    br i1 %_142, label %l47, label %l46
l46:
    call void @throw_oob() 
    br label %l47
l47:
    %_143 = add i32 %_133, 1
    %_144 = getelementptr i32, i32* %_137, i32 %_143 
    store i32 %_132, i32* %_144 
    %_145 = add i32 0, 0
    ret i32 %_145
}
define i32 @BBS.Start(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
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
    %_13 = add i32 0, 2
    %_14 = getelementptr i8*, i8** %_12, i32 %_13 
    %_15 = load i8*, i8** %_14
    %_16 = bitcast i8* %_15 to i32 (i8*)*
    %_17 = call i32 %_16(i8* %_10)

    store i32 %_17, i32* %2
    %_18 = add i32 0, 99999
    call void (i32) @print_int(i32 %_18) 
    %_19 = bitcast i8* %_0 to i8*
    %_20 = bitcast i8* %_19 to i8***
    %_21 = load i8**, i8*** %_20
    %_22 = add i32 0, 1
    %_23 = getelementptr i8*, i8** %_21, i32 %_22 
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i32 (i8*)*
    %_26 = call i32 %_25(i8* %_19)

    store i32 %_26, i32* %2
    %_27 = bitcast i8* %_0 to i8*
    %_28 = bitcast i8* %_27 to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = add i32 0, 2
    %_31 = getelementptr i8*, i8** %_29, i32 %_30 
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i32 (i8*)*
    %_34 = call i32 %_33(i8* %_27)

    store i32 %_34, i32* %2
    %_35 = add i32 0, 0
    ret i32 %_35
}
define i32 @BBS.Sort(i8* %_0) {
    %1 = alloca i32
    %2 = alloca i32
    %3 = alloca i32
    %4 = alloca i32
    %5 = alloca i32
    %6 = alloca i32
    %7 = alloca i32
    %8 = alloca i32
    %9 = alloca i32
    %_1 = add i32 0, 16
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    %_5 = add i32 0, 1
    %_6 = sub i32 %_4, %_5
    store i32 %_6, i32* %2
    %_7 = add i32 0, 0
    %_8 = add i32 0, 1
    %_9 = sub i32 %_7, %_8
    store i32 %_9, i32* %3
    br label %l0
l0:
    %_10 = load i32, i32* %3 
    %_11 = load i32, i32* %2 
    %_12 = icmp slt i32 %_10, %_11
    br i1 %_12, label %l1, label %l2
l1:
    %_13 = add i32 0, 1
    store i32 %_13, i32* %8
    br label %l3
l3:
    %_14 = load i32, i32* %8 
    %_15 = load i32, i32* %2 
    %_16 = add i32 0, 1
    %_17 = add i32 %_15, %_16
    %_18 = icmp slt i32 %_14, %_17
    br i1 %_18, label %l4, label %l5
l4:
    %_19 = load i32, i32* %8 
    %_20 = add i32 0, 1
    %_21 = sub i32 %_19, %_20
    store i32 %_21, i32* %7
    %_22 = add i32 0, 8
    %_23 = getelementptr i8, i8* %_0, i32 %_22 
    %_24 = bitcast i8* %_23 to i32**
    %_25 = load i32*, i32** %_24
    %_26 = load i32, i32* %7 
    %_27 = add i32 0, -1
    %_28 = load i32, i32* %_25
    %_29 = icmp slt i32 %_26, %_28
    %_30 = icmp slt i32 %_27, %_26
    %_31 = and i1 %_29, %_30 
    br i1 %_31, label %l7, label %l6
l6:
    call void @throw_oob() 
    br label %l7
l7:
    %_32 = add i32 %_26, 1
    %_33 = getelementptr i32, i32* %_25, i32 %_32 
    %_34 = load i32, i32* %_33
    store i32 %_34, i32* %4
    %_35 = add i32 0, 8
    %_36 = getelementptr i8, i8* %_0, i32 %_35 
    %_37 = bitcast i8* %_36 to i32**
    %_38 = load i32*, i32** %_37
    %_39 = load i32, i32* %8 
    %_40 = add i32 0, -1
    %_41 = load i32, i32* %_38
    %_42 = icmp slt i32 %_39, %_41
    %_43 = icmp slt i32 %_40, %_39
    %_44 = and i1 %_42, %_43 
    br i1 %_44, label %l9, label %l8
l8:
    call void @throw_oob() 
    br label %l9
l9:
    %_45 = add i32 %_39, 1
    %_46 = getelementptr i32, i32* %_38, i32 %_45 
    %_47 = load i32, i32* %_46
    store i32 %_47, i32* %5
    %_48 = load i32, i32* %5 
    %_49 = load i32, i32* %4 
    %_50 = icmp slt i32 %_48, %_49
    br i1 %_50, label %l10, label %l11
l10:
    %_51 = load i32, i32* %8 
    %_52 = add i32 0, 1
    %_53 = sub i32 %_51, %_52
    store i32 %_53, i32* %6
    %_54 = add i32 0, 8
    %_55 = getelementptr i8, i8* %_0, i32 %_54 
    %_56 = bitcast i8* %_55 to i32**
    %_57 = load i32*, i32** %_56
    %_58 = load i32, i32* %6 
    %_59 = add i32 0, -1
    %_60 = load i32, i32* %_57
    %_61 = icmp slt i32 %_58, %_60
    %_62 = icmp slt i32 %_59, %_58
    %_63 = and i1 %_61, %_62 
    br i1 %_63, label %l14, label %l13
l13:
    call void @throw_oob() 
    br label %l14
l14:
    %_64 = add i32 %_58, 1
    %_65 = getelementptr i32, i32* %_57, i32 %_64 
    %_66 = load i32, i32* %_65
    store i32 %_66, i32* %9
    %_67 = add i32 0, 8
    %_68 = getelementptr i8, i8* %_0, i32 %_67 
    %_69 = bitcast i8* %_68 to i32**
    %_70 = load i32*, i32** %_69
    %_71 = load i32, i32* %8 
    %_72 = add i32 0, -1
    %_73 = load i32, i32* %_70
    %_74 = icmp slt i32 %_71, %_73
    %_75 = icmp slt i32 %_72, %_71
    %_76 = and i1 %_74, %_75 
    br i1 %_76, label %l16, label %l15
l15:
    call void @throw_oob() 
    br label %l16
l16:
    %_77 = add i32 %_71, 1
    %_78 = getelementptr i32, i32* %_70, i32 %_77 
    %_79 = load i32, i32* %_78
    %_80 = load i32, i32* %6 
    %_81 = add i32 0, 8
    %_82 = getelementptr i8, i8* %_0, i32 %_81 
    %_83 = bitcast i8* %_82 to i32**
    %_84 = load i32*, i32** %_83
    %_85 = add i32 0, -1
    %_86 = load i32, i32* %_84
    %_87 = icmp slt i32 %_80, %_86
    %_88 = icmp slt i32 %_85, %_80
    %_89 = and i1 %_87, %_88 
    br i1 %_89, label %l18, label %l17
l17:
    call void @throw_oob() 
    br label %l18
l18:
    %_90 = add i32 %_80, 1
    %_91 = getelementptr i32, i32* %_84, i32 %_90 
    store i32 %_79, i32* %_91 
    %_92 = load i32, i32* %9 
    %_93 = load i32, i32* %8 
    %_94 = add i32 0, 8
    %_95 = getelementptr i8, i8* %_0, i32 %_94 
    %_96 = bitcast i8* %_95 to i32**
    %_97 = load i32*, i32** %_96
    %_98 = add i32 0, -1
    %_99 = load i32, i32* %_97
    %_100 = icmp slt i32 %_93, %_99
    %_101 = icmp slt i32 %_98, %_93
    %_102 = and i1 %_100, %_101 
    br i1 %_102, label %l20, label %l19
l19:
    call void @throw_oob() 
    br label %l20
l20:
    %_103 = add i32 %_93, 1
    %_104 = getelementptr i32, i32* %_97, i32 %_103 
    store i32 %_92, i32* %_104 
    br label %l12
l11:
    %_105 = add i32 0, 0
    store i32 %_105, i32* %1
    br label %l12
l12:
    %_106 = load i32, i32* %8 
    %_107 = add i32 0, 1
    %_108 = add i32 %_106, %_107
    store i32 %_108, i32* %8
    br label %l3
l5:
    %_109 = load i32, i32* %2 
    %_110 = add i32 0, 1
    %_111 = sub i32 %_109, %_110
    store i32 %_111, i32* %2
    br label %l0
l2:
    %_112 = add i32 0, 0
    ret i32 %_112
}
