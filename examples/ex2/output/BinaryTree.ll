@.BT_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*)* @BT.Start to i8*)]

@.Tree_vtable = global [20 x i8*] [
   i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*), 
   i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*), 
   i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*), 
   i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), 
   i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), 
   i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), 
   i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*), 
   i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), 
   i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), 
   i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*), 
   i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*), 
   i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*), 
   i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*), 
   i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*), 
   i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*), 
   i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*), 
   i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*), 
   i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*), 
   i8* bitcast (i1 (i8*)* @Tree.Print to i8*), 
   i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*)]

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
    %_4 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0 
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

define i32 @BT.Start(i8* %_0) {
    %1 = alloca i8*
    %2 = alloca i1
    %3 = alloca i32

    %_1 = add i32 0, 38
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    store i8* %_5, i8** %1
    %_6 = load i8*, i8** %1 
    %_7 = bitcast i8* %_6 to i8***
    %_8 = load i8**, i8*** %_7
    %_9 = add i32 0, 0
    %_10 = getelementptr i8*, i8** %_8, i32 %_9 
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i1 (i8*, i32)*
    %_13 = add i32 0, 16
    %_14 = call i1 %_12(i8* %_6, i32 %_13)

    store i1 %_14, i1* %2
    %_15 = load i8*, i8** %1 
    %_16 = bitcast i8* %_15 to i8***
    %_17 = load i8**, i8*** %_16
    %_18 = add i32 0, 18
    %_19 = getelementptr i8*, i8** %_17, i32 %_18 
    %_20 = load i8*, i8** %_19
    %_21 = bitcast i8* %_20 to i1 (i8*)*
    %_22 = call i1 %_21(i8* %_15)

    store i1 %_22, i1* %2
    %_23 = add i32 0, 100000000
    call void (i32) @print_int(i32 %_23) 
    %_24 = load i8*, i8** %1 
    %_25 = bitcast i8* %_24 to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = add i32 0, 12
    %_28 = getelementptr i8*, i8** %_26, i32 %_27 
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i1 (i8*, i32)*
    %_31 = add i32 0, 8
    %_32 = call i1 %_30(i8* %_24, i32 %_31)

    store i1 %_32, i1* %2
    %_33 = load i8*, i8** %1 
    %_34 = bitcast i8* %_33 to i8***
    %_35 = load i8**, i8*** %_34
    %_36 = add i32 0, 18
    %_37 = getelementptr i8*, i8** %_35, i32 %_36 
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i1 (i8*)*
    %_40 = call i1 %_39(i8* %_33)

    store i1 %_40, i1* %2
    %_41 = load i8*, i8** %1 
    %_42 = bitcast i8* %_41 to i8***
    %_43 = load i8**, i8*** %_42
    %_44 = add i32 0, 12
    %_45 = getelementptr i8*, i8** %_43, i32 %_44 
    %_46 = load i8*, i8** %_45
    %_47 = bitcast i8* %_46 to i1 (i8*, i32)*
    %_48 = add i32 0, 24
    %_49 = call i1 %_47(i8* %_41, i32 %_48)

    store i1 %_49, i1* %2
    %_50 = load i8*, i8** %1 
    %_51 = bitcast i8* %_50 to i8***
    %_52 = load i8**, i8*** %_51
    %_53 = add i32 0, 12
    %_54 = getelementptr i8*, i8** %_52, i32 %_53 
    %_55 = load i8*, i8** %_54
    %_56 = bitcast i8* %_55 to i1 (i8*, i32)*
    %_57 = add i32 0, 4
    %_58 = call i1 %_56(i8* %_50, i32 %_57)

    store i1 %_58, i1* %2
    %_59 = load i8*, i8** %1 
    %_60 = bitcast i8* %_59 to i8***
    %_61 = load i8**, i8*** %_60
    %_62 = add i32 0, 12
    %_63 = getelementptr i8*, i8** %_61, i32 %_62 
    %_64 = load i8*, i8** %_63
    %_65 = bitcast i8* %_64 to i1 (i8*, i32)*
    %_66 = add i32 0, 12
    %_67 = call i1 %_65(i8* %_59, i32 %_66)

    store i1 %_67, i1* %2
    %_68 = load i8*, i8** %1 
    %_69 = bitcast i8* %_68 to i8***
    %_70 = load i8**, i8*** %_69
    %_71 = add i32 0, 12
    %_72 = getelementptr i8*, i8** %_70, i32 %_71 
    %_73 = load i8*, i8** %_72
    %_74 = bitcast i8* %_73 to i1 (i8*, i32)*
    %_75 = add i32 0, 20
    %_76 = call i1 %_74(i8* %_68, i32 %_75)

    store i1 %_76, i1* %2
    %_77 = load i8*, i8** %1 
    %_78 = bitcast i8* %_77 to i8***
    %_79 = load i8**, i8*** %_78
    %_80 = add i32 0, 12
    %_81 = getelementptr i8*, i8** %_79, i32 %_80 
    %_82 = load i8*, i8** %_81
    %_83 = bitcast i8* %_82 to i1 (i8*, i32)*
    %_84 = add i32 0, 28
    %_85 = call i1 %_83(i8* %_77, i32 %_84)

    store i1 %_85, i1* %2
    %_86 = load i8*, i8** %1 
    %_87 = bitcast i8* %_86 to i8***
    %_88 = load i8**, i8*** %_87
    %_89 = add i32 0, 12
    %_90 = getelementptr i8*, i8** %_88, i32 %_89 
    %_91 = load i8*, i8** %_90
    %_92 = bitcast i8* %_91 to i1 (i8*, i32)*
    %_93 = add i32 0, 14
    %_94 = call i1 %_92(i8* %_86, i32 %_93)

    store i1 %_94, i1* %2
    %_95 = load i8*, i8** %1 
    %_96 = bitcast i8* %_95 to i8***
    %_97 = load i8**, i8*** %_96
    %_98 = add i32 0, 18
    %_99 = getelementptr i8*, i8** %_97, i32 %_98 
    %_100 = load i8*, i8** %_99
    %_101 = bitcast i8* %_100 to i1 (i8*)*
    %_102 = call i1 %_101(i8* %_95)

    store i1 %_102, i1* %2
    %_103 = load i8*, i8** %1 
    %_104 = bitcast i8* %_103 to i8***
    %_105 = load i8**, i8*** %_104
    %_106 = add i32 0, 17
    %_107 = getelementptr i8*, i8** %_105, i32 %_106 
    %_108 = load i8*, i8** %_107
    %_109 = bitcast i8* %_108 to i32 (i8*, i32)*
    %_110 = add i32 0, 24
    %_111 = call i32 %_109(i8* %_103, i32 %_110)

    call void (i32) @print_int(i32 %_111) 
    %_112 = load i8*, i8** %1 
    %_113 = bitcast i8* %_112 to i8***
    %_114 = load i8**, i8*** %_113
    %_115 = add i32 0, 17
    %_116 = getelementptr i8*, i8** %_114, i32 %_115 
    %_117 = load i8*, i8** %_116
    %_118 = bitcast i8* %_117 to i32 (i8*, i32)*
    %_119 = add i32 0, 12
    %_120 = call i32 %_118(i8* %_112, i32 %_119)

    call void (i32) @print_int(i32 %_120) 
    %_121 = load i8*, i8** %1 
    %_122 = bitcast i8* %_121 to i8***
    %_123 = load i8**, i8*** %_122
    %_124 = add i32 0, 17
    %_125 = getelementptr i8*, i8** %_123, i32 %_124 
    %_126 = load i8*, i8** %_125
    %_127 = bitcast i8* %_126 to i32 (i8*, i32)*
    %_128 = add i32 0, 16
    %_129 = call i32 %_127(i8* %_121, i32 %_128)

    call void (i32) @print_int(i32 %_129) 
    %_130 = load i8*, i8** %1 
    %_131 = bitcast i8* %_130 to i8***
    %_132 = load i8**, i8*** %_131
    %_133 = add i32 0, 17
    %_134 = getelementptr i8*, i8** %_132, i32 %_133 
    %_135 = load i8*, i8** %_134
    %_136 = bitcast i8* %_135 to i32 (i8*, i32)*
    %_137 = add i32 0, 50
    %_138 = call i32 %_136(i8* %_130, i32 %_137)

    call void (i32) @print_int(i32 %_138) 
    %_139 = load i8*, i8** %1 
    %_140 = bitcast i8* %_139 to i8***
    %_141 = load i8**, i8*** %_140
    %_142 = add i32 0, 17
    %_143 = getelementptr i8*, i8** %_141, i32 %_142 
    %_144 = load i8*, i8** %_143
    %_145 = bitcast i8* %_144 to i32 (i8*, i32)*
    %_146 = add i32 0, 12
    %_147 = call i32 %_145(i8* %_139, i32 %_146)

    call void (i32) @print_int(i32 %_147) 
    %_148 = load i8*, i8** %1 
    %_149 = bitcast i8* %_148 to i8***
    %_150 = load i8**, i8*** %_149
    %_151 = add i32 0, 13
    %_152 = getelementptr i8*, i8** %_150, i32 %_151 
    %_153 = load i8*, i8** %_152
    %_154 = bitcast i8* %_153 to i1 (i8*, i32)*
    %_155 = add i32 0, 12
    %_156 = call i1 %_154(i8* %_148, i32 %_155)

    store i1 %_156, i1* %2
    %_157 = load i8*, i8** %1 
    %_158 = bitcast i8* %_157 to i8***
    %_159 = load i8**, i8*** %_158
    %_160 = add i32 0, 18
    %_161 = getelementptr i8*, i8** %_159, i32 %_160 
    %_162 = load i8*, i8** %_161
    %_163 = bitcast i8* %_162 to i1 (i8*)*
    %_164 = call i1 %_163(i8* %_157)

    store i1 %_164, i1* %2
    %_165 = load i8*, i8** %1 
    %_166 = bitcast i8* %_165 to i8***
    %_167 = load i8**, i8*** %_166
    %_168 = add i32 0, 17
    %_169 = getelementptr i8*, i8** %_167, i32 %_168 
    %_170 = load i8*, i8** %_169
    %_171 = bitcast i8* %_170 to i32 (i8*, i32)*
    %_172 = add i32 0, 12
    %_173 = call i32 %_171(i8* %_165, i32 %_172)

    call void (i32) @print_int(i32 %_173) 
    %_174 = add i32 0, 0
    ret i32 %_174
}
define i1 @Tree.Delete(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i8*
    %3 = alloca i8*
    %4 = alloca i1
    %5 = alloca i1
    %6 = alloca i1
    %7 = alloca i32
    %8 = alloca i1
    %_1 = %_0
    store i8* %_1, i8** %2
    %_2 = %_0
    store i8* %_2, i8** %3
    %_3 = add i1 0, 1 
    store i1 %_3, i1* %4
    %_4 = add i1 0, 0 
    store i1 %_4, i1* %5
    %_5 = add i1 0, 1 
    store i1 %_5, i1* %6
    br label %l18
l18:
    %_6 = load i1, i1* %4 
    br i1 %_6, label %l19, label %l20
l19:
    %_7 = load i8*, i8** %2 
    %_8 = bitcast i8* %_0 to i8***
    %_9 = load i8**, i8*** %_8
    %_10 = add i32 0, 5
    %_11 = getelementptr i8*, i8** %_9, i32 %_10 
    %_12 = load i8*, i8** %_11
    %_13 = bitcast i8* %_12 to i32 (i8*)*
    %_14 = call i32 %_13(i8* %_0)

    store i32 %_14, i32* %7
    %_15 = load i32, i32* %1 
    %_16 = load i32, i32* %7 
    %_17 = icmp slt i32 %_15, %_16
    br i1 %_17, label %l21, label %l22
l21:
    %_18 = load i8*, i8** %2 
    %_19 = bitcast i8* %_0 to i8***
    %_20 = load i8**, i8*** %_19
    %_21 = add i32 0, 8
    %_22 = getelementptr i8*, i8** %_20, i32 %_21 
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i1 (i8*)*
    %_25 = call i1 %_24(i8* %_0)

    br i1 %_25, label %l24, label %l25
l24:
    %_26 = load i8*, i8** %2 
    store i8* %_26, i8** %3
    %_27 = load i8*, i8** %2 
    %_28 = bitcast i8* %_0 to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = add i32 0, 4
    %_31 = getelementptr i8*, i8** %_29, i32 %_30 
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i8* (i8*)*
    %_34 = call i8* %_33(i8* %_0)

    store i8* %_34, i8** %2
    br label %l26
l25:
    %_35 = add i1 0, 0 
    store i1 %_35, i1* %4
    br label %l26
l26:
    br label %l23
l22:
    %_36 = load i32, i32* %7 
    %_37 = load i32, i32* %1 
    %_38 = icmp slt i32 %_36, %_37
    br i1 %_38, label %l27, label %l28
l27:
    %_39 = load i8*, i8** %2 
    %_40 = bitcast i8* %_0 to i8***
    %_41 = load i8**, i8*** %_40
    %_42 = add i32 0, 7
    %_43 = getelementptr i8*, i8** %_41, i32 %_42 
    %_44 = load i8*, i8** %_43
    %_45 = bitcast i8* %_44 to i1 (i8*)*
    %_46 = call i1 %_45(i8* %_0)

    br i1 %_46, label %l30, label %l31
l30:
    %_47 = load i8*, i8** %2 
    store i8* %_47, i8** %3
    %_48 = load i8*, i8** %2 
    %_49 = bitcast i8* %_0 to i8***
    %_50 = load i8**, i8*** %_49
    %_51 = add i32 0, 3
    %_52 = getelementptr i8*, i8** %_50, i32 %_51 
    %_53 = load i8*, i8** %_52
    %_54 = bitcast i8* %_53 to i8* (i8*)*
    %_55 = call i8* %_54(i8* %_0)

    store i8* %_55, i8** %2
    br label %l32
l31:
    %_56 = add i1 0, 0 
    store i1 %_56, i1* %4
    br label %l32
l32:
    br label %l29
l28:
    %_57 = load i1, i1* %6 
    br i1 %_57, label %l33, label %l34
l33:
    br label %l36
l36:
    %_58 = load i8*, i8** %2 
    %_59 = bitcast i8* %_0 to i8***
    %_60 = load i8**, i8*** %_59
    %_61 = add i32 0, 7
    %_62 = getelementptr i8*, i8** %_60, i32 %_61 
    %_63 = load i8*, i8** %_62
    %_64 = bitcast i8* %_63 to i1 (i8*)*
    %_65 = call i1 %_64(i8* %_0)

    %_66 = xor i1 %_66, 1
    br i1 %_66, label %l38, label %l37
l37:
    %_67 = load i8*, i8** %2 
    %_68 = bitcast i8* %_0 to i8***
    %_69 = load i8**, i8*** %_68
    %_70 = add i32 0, 8
    %_71 = getelementptr i8*, i8** %_69, i32 %_70 
    %_72 = load i8*, i8** %_71
    %_73 = bitcast i8* %_72 to i1 (i8*)*
    %_74 = call i1 %_73(i8* %_0)

    %_75 = xor i1 %_75, 1
    br i1 %_75, label %l38, label %l39
l38:
    br label %l39
l39:
    %_76 = phi i1 [0, %l38], [1, %l37]
    br i1 %_76, label %l40, label %l41
l40:
    %_77 = add i1 0, 1 
    store i1 %_77, i1* %8
    br label %l42
l41:
    %_78 = %_0
    %_79 = bitcast i8* %_0 to i8***
    %_80 = load i8**, i8*** %_79
    %_81 = add i32 0, 14
    %_82 = getelementptr i8*, i8** %_80, i32 %_81 
    %_83 = load i8*, i8** %_82
    %_84 = bitcast i8* %_83 to i1 (i8*, i8*, i8*)*
    %_85 = load i8*, i8** %3 
    %_86 = load i8*, i8** %2 
    %_87 = call i1 %_84(i8* %_0, i8* %_85, i8* %_86)

    store i1 %_87, i1* %8
    br label %l42
l42:
    br label %l35
l34:
    %_88 = %_0
    %_89 = bitcast i8* %_0 to i8***
    %_90 = load i8**, i8*** %_89
    %_91 = add i32 0, 14
    %_92 = getelementptr i8*, i8** %_90, i32 %_91 
    %_93 = load i8*, i8** %_92
    %_94 = bitcast i8* %_93 to i1 (i8*, i8*, i8*)*
    %_95 = load i8*, i8** %3 
    %_96 = load i8*, i8** %2 
    %_97 = call i1 %_94(i8* %_0, i8* %_95, i8* %_96)

    store i1 %_97, i1* %8
    br label %l35
l35:
    %_98 = add i1 0, 1 
    store i1 %_98, i1* %5
    %_99 = add i1 0, 0 
    store i1 %_99, i1* %4
    br label %l29
l29:
    br label %l23
l23:
    %_100 = add i1 0, 0 
    store i1 %_100, i1* %6
    br label %l18
l20:
    %_101 = load i1, i1* %5 
    ret i1 %_101
}
define i1 @Tree.SetHas_Left(i8* %_0, i1 %.1) {
    %1 = alloca i1
    store i1 %.1, i1* %1 
    %_1 = load i1, i1* %1 
    %_2 = add i32 0, 28
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i1*
    store i1 %_1, i1* %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i1 @Tree.RemoveLeft(i8* %_0, i8* %.1, i8* %.2) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i8*
    store i8* %.2, i8** %2 
    %3 = alloca i1
    %4 = alloca i8*
    br label %l55
l55:
    %_1 = load i8*, i8** %2 
    %_2 = bitcast i8* %_0 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 8
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*)*
    %_8 = call i1 %_7(i8* %_0)

    br i1 %_8, label %l56, label %l57
l56:
    %_9 = load i8*, i8** %2 
    %_10 = bitcast i8* %_0 to i8***
    %_11 = load i8**, i8*** %_10
    %_12 = add i32 0, 4
    %_13 = getelementptr i8*, i8** %_11, i32 %_12 
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i8* (i8*)*
    %_16 = call i8* %_15(i8* %_0)

    store i8* %_16, i8** %4
    %_17 = load i8*, i8** %2 
    %_18 = bitcast i8* %_0 to i8***
    %_19 = load i8**, i8*** %_18
    %_20 = add i32 0, 6
    %_21 = getelementptr i8*, i8** %_19, i32 %_20 
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i1 (i8*, i32)*
    %_24 = load i8*, i8** %4 
    %_25 = bitcast i8* %_0 to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = add i32 0, 5
    %_28 = getelementptr i8*, i8** %_26, i32 %_27 
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_0)

    %_32 = call i1 %_23(i8* %_0, i32 %_31)

    store i1 %_32, i1* %3
    %_33 = load i8*, i8** %2 
    store i8* %_33, i8** %1
    %_34 = load i8*, i8** %2 
    %_35 = bitcast i8* %_0 to i8***
    %_36 = load i8**, i8*** %_35
    %_37 = add i32 0, 4
    %_38 = getelementptr i8*, i8** %_36, i32 %_37 
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i8* (i8*)*
    %_41 = call i8* %_40(i8* %_0)

    store i8* %_41, i8** %2
    br label %l55
l57:
    %_42 = load i8*, i8** %1 
    %_43 = bitcast i8* %_0 to i8***
    %_44 = load i8**, i8*** %_43
    %_45 = add i32 0, 2
    %_46 = getelementptr i8*, i8** %_44, i32 %_45 
    %_47 = load i8*, i8** %_46
    %_48 = bitcast i8* %_47 to i1 (i8*, i8*)*
    %_49 = add i32 0, 30
    %_50 = getelementptr i8, i8* %_0, i32 %_49 
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = call i1 %_48(i8* %_0, i8* %_52)

    store i1 %_53, i1* %3
    %_54 = load i8*, i8** %1 
    %_55 = bitcast i8* %_0 to i8***
    %_56 = load i8**, i8*** %_55
    %_57 = add i32 0, 9
    %_58 = getelementptr i8*, i8** %_56, i32 %_57 
    %_59 = load i8*, i8** %_58
    %_60 = bitcast i8* %_59 to i1 (i8*, i1)*
    %_61 = add i1 0, 0 
    %_62 = call i1 %_60(i8* %_0, i1 %_61)

    store i1 %_62, i1* %3
    %_63 = add i1 0, 1 
    ret i1 %_63
}
define i32 @Tree.GetKey(i8* %_0) {
    %_1 = add i32 0, 24
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    ret i32 %_4
}
define i1 @Tree.SetRight(i8* %_0, i8* %.1) {
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
define i8* @Tree.GetLeft(i8* %_0) {
    %_1 = add i32 0, 8
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    ret i8* %_4
}
define i8* @Tree.GetRight(i8* %_0) {
    %_1 = add i32 0, 16
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i8**
    %_4 = load i8*, i8** %_3
    ret i8* %_4
}
define i1 @Tree.Remove(i8* %_0, i8* %.1, i8* %.2) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i8*
    store i8* %.2, i8** %2 
    %3 = alloca i1
    %4 = alloca i32
    %5 = alloca i32
    %6 = alloca i8*
    %_1 = load i8*, i8** %2 
    %_2 = bitcast i8* %_0 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 8
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*)*
    %_8 = call i1 %_7(i8* %_0)

    br i1 %_8, label %l43, label %l44
l43:
    %_9 = %_0
    %_10 = bitcast i8* %_0 to i8***
    %_11 = load i8**, i8*** %_10
    %_12 = add i32 0, 16
    %_13 = getelementptr i8*, i8** %_11, i32 %_12 
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i1 (i8*, i8*, i8*)*
    %_16 = load i8*, i8** %1 
    %_17 = load i8*, i8** %2 
    %_18 = call i1 %_15(i8* %_0, i8* %_16, i8* %_17)

    store i1 %_18, i1* %3
    br label %l45
l44:
    %_19 = load i8*, i8** %2 
    %_20 = bitcast i8* %_0 to i8***
    %_21 = load i8**, i8*** %_20
    %_22 = add i32 0, 7
    %_23 = getelementptr i8*, i8** %_21, i32 %_22 
    %_24 = load i8*, i8** %_23
    %_25 = bitcast i8* %_24 to i1 (i8*)*
    %_26 = call i1 %_25(i8* %_0)

    br i1 %_26, label %l46, label %l47
l46:
    %_27 = %_0
    %_28 = bitcast i8* %_0 to i8***
    %_29 = load i8**, i8*** %_28
    %_30 = add i32 0, 15
    %_31 = getelementptr i8*, i8** %_29, i32 %_30 
    %_32 = load i8*, i8** %_31
    %_33 = bitcast i8* %_32 to i1 (i8*, i8*, i8*)*
    %_34 = load i8*, i8** %1 
    %_35 = load i8*, i8** %2 
    %_36 = call i1 %_33(i8* %_0, i8* %_34, i8* %_35)

    store i1 %_36, i1* %3
    br label %l48
l47:
    %_37 = load i8*, i8** %2 
    %_38 = bitcast i8* %_0 to i8***
    %_39 = load i8**, i8*** %_38
    %_40 = add i32 0, 5
    %_41 = getelementptr i8*, i8** %_39, i32 %_40 
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i32 (i8*)*
    %_44 = call i32 %_43(i8* %_0)

    store i32 %_44, i32* %4
    %_45 = load i8*, i8** %1 
    %_46 = bitcast i8* %_0 to i8***
    %_47 = load i8**, i8*** %_46
    %_48 = add i32 0, 4
    %_49 = getelementptr i8*, i8** %_47, i32 %_48 
    %_50 = load i8*, i8** %_49
    %_51 = bitcast i8* %_50 to i8* (i8*)*
    %_52 = call i8* %_51(i8* %_0)

    store i8* %_52, i8** %6
    %_53 = load i8*, i8** %6 
    %_54 = bitcast i8* %_0 to i8***
    %_55 = load i8**, i8*** %_54
    %_56 = add i32 0, 5
    %_57 = getelementptr i8*, i8** %_55, i32 %_56 
    %_58 = load i8*, i8** %_57
    %_59 = bitcast i8* %_58 to i32 (i8*)*
    %_60 = call i32 %_59(i8* %_0)

    store i32 %_60, i32* %5
    %_61 = %_0
    %_62 = bitcast i8* %_0 to i8***
    %_63 = load i8**, i8*** %_62
    %_64 = add i32 0, 11
    %_65 = getelementptr i8*, i8** %_63, i32 %_64 
    %_66 = load i8*, i8** %_65
    %_67 = bitcast i8* %_66 to i1 (i8*, i32, i32)*
    %_68 = load i32, i32* %4 
    %_69 = load i32, i32* %5 
    %_70 = call i1 %_67(i8* %_0, i32 %_68, i32 %_69)

    br i1 %_70, label %l49, label %l50
l49:
    %_71 = load i8*, i8** %1 
    %_72 = bitcast i8* %_0 to i8***
    %_73 = load i8**, i8*** %_72
    %_74 = add i32 0, 2
    %_75 = getelementptr i8*, i8** %_73, i32 %_74 
    %_76 = load i8*, i8** %_75
    %_77 = bitcast i8* %_76 to i1 (i8*, i8*)*
    %_78 = add i32 0, 30
    %_79 = getelementptr i8, i8* %_0, i32 %_78 
    %_80 = bitcast i8* %_79 to i8**
    %_81 = load i8*, i8** %_80
    %_82 = call i1 %_77(i8* %_0, i8* %_81)

    store i1 %_82, i1* %3
    %_83 = load i8*, i8** %1 
    %_84 = bitcast i8* %_0 to i8***
    %_85 = load i8**, i8*** %_84
    %_86 = add i32 0, 9
    %_87 = getelementptr i8*, i8** %_85, i32 %_86 
    %_88 = load i8*, i8** %_87
    %_89 = bitcast i8* %_88 to i1 (i8*, i1)*
    %_90 = add i1 0, 0 
    %_91 = call i1 %_89(i8* %_0, i1 %_90)

    store i1 %_91, i1* %3
    br label %l51
l50:
    %_92 = load i8*, i8** %1 
    %_93 = bitcast i8* %_0 to i8***
    %_94 = load i8**, i8*** %_93
    %_95 = add i32 0, 1
    %_96 = getelementptr i8*, i8** %_94, i32 %_95 
    %_97 = load i8*, i8** %_96
    %_98 = bitcast i8* %_97 to i1 (i8*, i8*)*
    %_99 = add i32 0, 30
    %_100 = getelementptr i8, i8* %_0, i32 %_99 
    %_101 = bitcast i8* %_100 to i8**
    %_102 = load i8*, i8** %_101
    %_103 = call i1 %_98(i8* %_0, i8* %_102)

    store i1 %_103, i1* %3
    %_104 = load i8*, i8** %1 
    %_105 = bitcast i8* %_0 to i8***
    %_106 = load i8**, i8*** %_105
    %_107 = add i32 0, 10
    %_108 = getelementptr i8*, i8** %_106, i32 %_107 
    %_109 = load i8*, i8** %_108
    %_110 = bitcast i8* %_109 to i1 (i8*, i1)*
    %_111 = add i1 0, 0 
    %_112 = call i1 %_110(i8* %_0, i1 %_111)

    store i1 %_112, i1* %3
    br label %l51
l51:
    br label %l48
l48:
    br label %l45
l45:
    %_113 = add i1 0, 1 
    ret i1 %_113
}
define i1 @Tree.SetLeft(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %_1 = load i8*, i8** %1 
    %_2 = add i32 0, 8
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i8**
    store i8* %_1, i8** %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i1 @Tree.Insert(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i8*
    %3 = alloca i1
    %4 = alloca i1
    %5 = alloca i32
    %6 = alloca i8*

    %_1 = add i32 0, 38
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    store i8* %_5, i8** %2
    %_6 = load i8*, i8** %2 
    %_7 = bitcast i8* %_0 to i8***
    %_8 = load i8**, i8*** %_7
    %_9 = add i32 0, 0
    %_10 = getelementptr i8*, i8** %_8, i32 %_9 
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i1 (i8*, i32)*
    %_13 = load i32, i32* %1 
    %_14 = call i1 %_12(i8* %_0, i32 %_13)

    store i1 %_14, i1* %3
    %_15 = %_0
    store i8* %_15, i8** %6
    %_16 = add i1 0, 1 
    store i1 %_16, i1* %4
    br label %l6
l6:
    %_17 = load i1, i1* %4 
    br i1 %_17, label %l7, label %l8
l7:
    %_18 = load i8*, i8** %6 
    %_19 = bitcast i8* %_0 to i8***
    %_20 = load i8**, i8*** %_19
    %_21 = add i32 0, 5
    %_22 = getelementptr i8*, i8** %_20, i32 %_21 
    %_23 = load i8*, i8** %_22
    %_24 = bitcast i8* %_23 to i32 (i8*)*
    %_25 = call i32 %_24(i8* %_0)

    store i32 %_25, i32* %5
    %_26 = load i32, i32* %1 
    %_27 = load i32, i32* %5 
    %_28 = icmp slt i32 %_26, %_27
    br i1 %_28, label %l9, label %l10
l9:
    %_29 = load i8*, i8** %6 
    %_30 = bitcast i8* %_0 to i8***
    %_31 = load i8**, i8*** %_30
    %_32 = add i32 0, 8
    %_33 = getelementptr i8*, i8** %_31, i32 %_32 
    %_34 = load i8*, i8** %_33
    %_35 = bitcast i8* %_34 to i1 (i8*)*
    %_36 = call i1 %_35(i8* %_0)

    br i1 %_36, label %l12, label %l13
l12:
    %_37 = load i8*, i8** %6 
    %_38 = bitcast i8* %_0 to i8***
    %_39 = load i8**, i8*** %_38
    %_40 = add i32 0, 4
    %_41 = getelementptr i8*, i8** %_39, i32 %_40 
    %_42 = load i8*, i8** %_41
    %_43 = bitcast i8* %_42 to i8* (i8*)*
    %_44 = call i8* %_43(i8* %_0)

    store i8* %_44, i8** %6
    br label %l14
l13:
    %_45 = add i1 0, 0 
    store i1 %_45, i1* %4
    %_46 = load i8*, i8** %6 
    %_47 = bitcast i8* %_0 to i8***
    %_48 = load i8**, i8*** %_47
    %_49 = add i32 0, 9
    %_50 = getelementptr i8*, i8** %_48, i32 %_49 
    %_51 = load i8*, i8** %_50
    %_52 = bitcast i8* %_51 to i1 (i8*, i1)*
    %_53 = add i1 0, 1 
    %_54 = call i1 %_52(i8* %_0, i1 %_53)

    store i1 %_54, i1* %3
    %_55 = load i8*, i8** %6 
    %_56 = bitcast i8* %_0 to i8***
    %_57 = load i8**, i8*** %_56
    %_58 = add i32 0, 2
    %_59 = getelementptr i8*, i8** %_57, i32 %_58 
    %_60 = load i8*, i8** %_59
    %_61 = bitcast i8* %_60 to i1 (i8*, i8*)*
    %_62 = load i8*, i8** %2 
    %_63 = call i1 %_61(i8* %_0, i8* %_62)

    store i1 %_63, i1* %3
    br label %l14
l14:
    br label %l11
l10:
    %_64 = load i8*, i8** %6 
    %_65 = bitcast i8* %_0 to i8***
    %_66 = load i8**, i8*** %_65
    %_67 = add i32 0, 7
    %_68 = getelementptr i8*, i8** %_66, i32 %_67 
    %_69 = load i8*, i8** %_68
    %_70 = bitcast i8* %_69 to i1 (i8*)*
    %_71 = call i1 %_70(i8* %_0)

    br i1 %_71, label %l15, label %l16
l15:
    %_72 = load i8*, i8** %6 
    %_73 = bitcast i8* %_0 to i8***
    %_74 = load i8**, i8*** %_73
    %_75 = add i32 0, 3
    %_76 = getelementptr i8*, i8** %_74, i32 %_75 
    %_77 = load i8*, i8** %_76
    %_78 = bitcast i8* %_77 to i8* (i8*)*
    %_79 = call i8* %_78(i8* %_0)

    store i8* %_79, i8** %6
    br label %l17
l16:
    %_80 = add i1 0, 0 
    store i1 %_80, i1* %4
    %_81 = load i8*, i8** %6 
    %_82 = bitcast i8* %_0 to i8***
    %_83 = load i8**, i8*** %_82
    %_84 = add i32 0, 10
    %_85 = getelementptr i8*, i8** %_83, i32 %_84 
    %_86 = load i8*, i8** %_85
    %_87 = bitcast i8* %_86 to i1 (i8*, i1)*
    %_88 = add i1 0, 1 
    %_89 = call i1 %_87(i8* %_0, i1 %_88)

    store i1 %_89, i1* %3
    %_90 = load i8*, i8** %6 
    %_91 = bitcast i8* %_0 to i8***
    %_92 = load i8**, i8*** %_91
    %_93 = add i32 0, 1
    %_94 = getelementptr i8*, i8** %_92, i32 %_93 
    %_95 = load i8*, i8** %_94
    %_96 = bitcast i8* %_95 to i1 (i8*, i8*)*
    %_97 = load i8*, i8** %2 
    %_98 = call i1 %_96(i8* %_0, i8* %_97)

    store i1 %_98, i1* %3
    br label %l17
l17:
    br label %l11
l11:
    br label %l6
l8:
    %_99 = add i1 0, 1 
    ret i1 %_99
}
define i1 @Tree.Print(i8* %_0) {
    %1 = alloca i8*
    %2 = alloca i1
    %_1 = %_0
    store i8* %_1, i8** %1
    %_2 = %_0
    %_3 = bitcast i8* %_0 to i8***
    %_4 = load i8**, i8*** %_3
    %_5 = add i32 0, 19
    %_6 = getelementptr i8*, i8** %_4, i32 %_5 
    %_7 = load i8*, i8** %_6
    %_8 = bitcast i8* %_7 to i1 (i8*, i8*)*
    %_9 = load i8*, i8** %1 
    %_10 = call i1 %_8(i8* %_0, i8* %_9)

    store i1 %_10, i1* %2
    %_11 = add i1 0, 1 
    ret i1 %_11
}
define i1 @Tree.Init(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 24
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = add i1 0, 0 
    %_6 = add i32 0, 28
    %_7 = getelementptr i8, i8* %_0, i32 %_6 
    %_8 = bitcast i8* %_7 to i1*
    store i1 %_5, i1* %_8
    %_9 = add i1 0, 0 
    %_10 = add i32 0, 29
    %_11 = getelementptr i8, i8* %_0, i32 %_10 
    %_12 = bitcast i8* %_11 to i1*
    store i1 %_9, i1* %_12
    %_13 = add i1 0, 1 
    ret i1 %_13
}
define i1 @Tree.GetHas_Right(i8* %_0) {
    %_1 = add i32 0, 29
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i1*
    %_4 = load i1, i1* %_3
    ret i1 %_4
}
define i1 @Tree.GetHas_Left(i8* %_0) {
    %_1 = add i32 0, 28
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i1*
    %_4 = load i1, i1* %_3
    ret i1 %_4
}
define i1 @Tree.RemoveRight(i8* %_0, i8* %.1, i8* %.2) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i8*
    store i8* %.2, i8** %2 
    %3 = alloca i1
    %4 = alloca i8*
    br label %l52
l52:
    %_1 = load i8*, i8** %2 
    %_2 = bitcast i8* %_0 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 7
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*)*
    %_8 = call i1 %_7(i8* %_0)

    br i1 %_8, label %l53, label %l54
l53:
    %_9 = load i8*, i8** %2 
    %_10 = bitcast i8* %_0 to i8***
    %_11 = load i8**, i8*** %_10
    %_12 = add i32 0, 3
    %_13 = getelementptr i8*, i8** %_11, i32 %_12 
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i8* (i8*)*
    %_16 = call i8* %_15(i8* %_0)

    store i8* %_16, i8** %4
    %_17 = load i8*, i8** %2 
    %_18 = bitcast i8* %_0 to i8***
    %_19 = load i8**, i8*** %_18
    %_20 = add i32 0, 6
    %_21 = getelementptr i8*, i8** %_19, i32 %_20 
    %_22 = load i8*, i8** %_21
    %_23 = bitcast i8* %_22 to i1 (i8*, i32)*
    %_24 = load i8*, i8** %4 
    %_25 = bitcast i8* %_0 to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = add i32 0, 5
    %_28 = getelementptr i8*, i8** %_26, i32 %_27 
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i32 (i8*)*
    %_31 = call i32 %_30(i8* %_0)

    %_32 = call i1 %_23(i8* %_0, i32 %_31)

    store i1 %_32, i1* %3
    %_33 = load i8*, i8** %2 
    store i8* %_33, i8** %1
    %_34 = load i8*, i8** %2 
    %_35 = bitcast i8* %_0 to i8***
    %_36 = load i8**, i8*** %_35
    %_37 = add i32 0, 3
    %_38 = getelementptr i8*, i8** %_36, i32 %_37 
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i8* (i8*)*
    %_41 = call i8* %_40(i8* %_0)

    store i8* %_41, i8** %2
    br label %l52
l54:
    %_42 = load i8*, i8** %1 
    %_43 = bitcast i8* %_0 to i8***
    %_44 = load i8**, i8*** %_43
    %_45 = add i32 0, 1
    %_46 = getelementptr i8*, i8** %_44, i32 %_45 
    %_47 = load i8*, i8** %_46
    %_48 = bitcast i8* %_47 to i1 (i8*, i8*)*
    %_49 = add i32 0, 30
    %_50 = getelementptr i8, i8* %_0, i32 %_49 
    %_51 = bitcast i8* %_50 to i8**
    %_52 = load i8*, i8** %_51
    %_53 = call i1 %_48(i8* %_0, i8* %_52)

    store i1 %_53, i1* %3
    %_54 = load i8*, i8** %1 
    %_55 = bitcast i8* %_0 to i8***
    %_56 = load i8**, i8*** %_55
    %_57 = add i32 0, 10
    %_58 = getelementptr i8*, i8** %_56, i32 %_57 
    %_59 = load i8*, i8** %_58
    %_60 = bitcast i8* %_59 to i1 (i8*, i1)*
    %_61 = add i1 0, 0 
    %_62 = call i1 %_60(i8* %_0, i1 %_61)

    store i1 %_62, i1* %3
    %_63 = add i1 0, 1 
    ret i1 %_63
}
define i32 @Tree.Search(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i1
    %3 = alloca i32
    %4 = alloca i8*
    %5 = alloca i32
    %_1 = %_0
    store i8* %_1, i8** %4
    %_2 = add i1 0, 1 
    store i1 %_2, i1* %2
    %_3 = add i32 0, 0
    store i32 %_3, i32* %3
    br label %l58
l58:
    %_4 = load i1, i1* %2 
    br i1 %_4, label %l59, label %l60
l59:
    %_5 = load i8*, i8** %4 
    %_6 = bitcast i8* %_0 to i8***
    %_7 = load i8**, i8*** %_6
    %_8 = add i32 0, 5
    %_9 = getelementptr i8*, i8** %_7, i32 %_8 
    %_10 = load i8*, i8** %_9
    %_11 = bitcast i8* %_10 to i32 (i8*)*
    %_12 = call i32 %_11(i8* %_0)

    store i32 %_12, i32* %5
    %_13 = load i32, i32* %1 
    %_14 = load i32, i32* %5 
    %_15 = icmp slt i32 %_13, %_14
    br i1 %_15, label %l61, label %l62
l61:
    %_16 = load i8*, i8** %4 
    %_17 = bitcast i8* %_0 to i8***
    %_18 = load i8**, i8*** %_17
    %_19 = add i32 0, 8
    %_20 = getelementptr i8*, i8** %_18, i32 %_19 
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i1 (i8*)*
    %_23 = call i1 %_22(i8* %_0)

    br i1 %_23, label %l64, label %l65
l64:
    %_24 = load i8*, i8** %4 
    %_25 = bitcast i8* %_0 to i8***
    %_26 = load i8**, i8*** %_25
    %_27 = add i32 0, 4
    %_28 = getelementptr i8*, i8** %_26, i32 %_27 
    %_29 = load i8*, i8** %_28
    %_30 = bitcast i8* %_29 to i8* (i8*)*
    %_31 = call i8* %_30(i8* %_0)

    store i8* %_31, i8** %4
    br label %l66
l65:
    %_32 = add i1 0, 0 
    store i1 %_32, i1* %2
    br label %l66
l66:
    br label %l63
l62:
    %_33 = load i32, i32* %5 
    %_34 = load i32, i32* %1 
    %_35 = icmp slt i32 %_33, %_34
    br i1 %_35, label %l67, label %l68
l67:
    %_36 = load i8*, i8** %4 
    %_37 = bitcast i8* %_0 to i8***
    %_38 = load i8**, i8*** %_37
    %_39 = add i32 0, 7
    %_40 = getelementptr i8*, i8** %_38, i32 %_39 
    %_41 = load i8*, i8** %_40
    %_42 = bitcast i8* %_41 to i1 (i8*)*
    %_43 = call i1 %_42(i8* %_0)

    br i1 %_43, label %l70, label %l71
l70:
    %_44 = load i8*, i8** %4 
    %_45 = bitcast i8* %_0 to i8***
    %_46 = load i8**, i8*** %_45
    %_47 = add i32 0, 3
    %_48 = getelementptr i8*, i8** %_46, i32 %_47 
    %_49 = load i8*, i8** %_48
    %_50 = bitcast i8* %_49 to i8* (i8*)*
    %_51 = call i8* %_50(i8* %_0)

    store i8* %_51, i8** %4
    br label %l72
l71:
    %_52 = add i1 0, 0 
    store i1 %_52, i1* %2
    br label %l72
l72:
    br label %l69
l68:
    %_53 = add i32 0, 1
    store i32 %_53, i32* %3
    %_54 = add i1 0, 0 
    store i1 %_54, i1* %2
    br label %l69
l69:
    br label %l63
l63:
    br label %l58
l60:
    %_55 = load i32, i32* %3 
    ret i32 %_55
}
define i1 @Tree.SetKey(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 24
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i1 @Tree.Compare(i8* %_0, i32 %.1, i32 %.2) {
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
    br i1 %_7, label %l0, label %l1
l0:
    %_8 = add i1 0, 0 
    store i1 %_8, i1* %3
    br label %l2
l1:
    %_9 = load i32, i32* %1 
    %_10 = load i32, i32* %4 
    %_11 = icmp slt i32 %_9, %_10
    %_12 = xor i1 %_12, 1
    br i1 %_12, label %l3, label %l4
l3:
    %_13 = add i1 0, 0 
    store i1 %_13, i1* %3
    br label %l5
l4:
    %_14 = add i1 0, 1 
    store i1 %_14, i1* %3
    br label %l5
l5:
    br label %l2
l2:
    %_15 = load i1, i1* %3 
    ret i1 %_15
}
define i1 @Tree.SetHas_Right(i8* %_0, i1 %.1) {
    %1 = alloca i1
    store i1 %.1, i1* %1 
    %_1 = load i1, i1* %1 
    %_2 = add i32 0, 29
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i1*
    store i1 %_1, i1* %_4
    %_5 = add i1 0, 1 
    ret i1 %_5
}
define i1 @Tree.RecPrint(i8* %_0, i8* %.1) {
    %1 = alloca i8*
    store i8* %.1, i8** %1 
    %2 = alloca i1
    %_1 = load i8*, i8** %1 
    %_2 = bitcast i8* %_0 to i8***
    %_3 = load i8**, i8*** %_2
    %_4 = add i32 0, 8
    %_5 = getelementptr i8*, i8** %_3, i32 %_4 
    %_6 = load i8*, i8** %_5
    %_7 = bitcast i8* %_6 to i1 (i8*)*
    %_8 = call i1 %_7(i8* %_0)

    br i1 %_8, label %l73, label %l74
l73:
    %_9 = %_0
    %_10 = bitcast i8* %_0 to i8***
    %_11 = load i8**, i8*** %_10
    %_12 = add i32 0, 19
    %_13 = getelementptr i8*, i8** %_11, i32 %_12 
    %_14 = load i8*, i8** %_13
    %_15 = bitcast i8* %_14 to i1 (i8*, i8*)*
    %_16 = load i8*, i8** %1 
    %_17 = bitcast i8* %_0 to i8***
    %_18 = load i8**, i8*** %_17
    %_19 = add i32 0, 4
    %_20 = getelementptr i8*, i8** %_18, i32 %_19 
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8* (i8*)*
    %_23 = call i8* %_22(i8* %_0)

    %_24 = call i1 %_15(i8* %_0, i8* %_23)

    store i1 %_24, i1* %2
    br label %l75
l74:
    %_25 = add i1 0, 1 
    store i1 %_25, i1* %2
    br label %l75
l75:
    %_26 = load i8*, i8** %1 
    %_27 = bitcast i8* %_0 to i8***
    %_28 = load i8**, i8*** %_27
    %_29 = add i32 0, 5
    %_30 = getelementptr i8*, i8** %_28, i32 %_29 
    %_31 = load i8*, i8** %_30
    %_32 = bitcast i8* %_31 to i32 (i8*)*
    %_33 = call i32 %_32(i8* %_0)

    call void (i32) @print_int(i32 %_33) 
    %_34 = load i8*, i8** %1 
    %_35 = bitcast i8* %_0 to i8***
    %_36 = load i8**, i8*** %_35
    %_37 = add i32 0, 7
    %_38 = getelementptr i8*, i8** %_36, i32 %_37 
    %_39 = load i8*, i8** %_38
    %_40 = bitcast i8* %_39 to i1 (i8*)*
    %_41 = call i1 %_40(i8* %_0)

    br i1 %_41, label %l76, label %l77
l76:
    %_42 = %_0
    %_43 = bitcast i8* %_0 to i8***
    %_44 = load i8**, i8*** %_43
    %_45 = add i32 0, 19
    %_46 = getelementptr i8*, i8** %_44, i32 %_45 
    %_47 = load i8*, i8** %_46
    %_48 = bitcast i8* %_47 to i1 (i8*, i8*)*
    %_49 = load i8*, i8** %1 
    %_50 = bitcast i8* %_0 to i8***
    %_51 = load i8**, i8*** %_50
    %_52 = add i32 0, 3
    %_53 = getelementptr i8*, i8** %_51, i32 %_52 
    %_54 = load i8*, i8** %_53
    %_55 = bitcast i8* %_54 to i8* (i8*)*
    %_56 = call i8* %_55(i8* %_0)

    %_57 = call i1 %_48(i8* %_0, i8* %_56)

    store i1 %_57, i1* %2
    br label %l78
l77:
    %_58 = add i1 0, 1 
    store i1 %_58, i1* %2
    br label %l78
l78:
    %_59 = add i1 0, 1 
    ret i1 %_59
}
