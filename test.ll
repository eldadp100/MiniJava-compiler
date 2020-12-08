@.BBS_vtable = global [4 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @BBS.Start to i8*), 
   i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), 
   i8* bitcast (i32 (i8*)* @BBS.Print to i8*), 
   i8* bitcast (i32 (i8*, i32)* @BBS.Init to i8*)]

define i32 @BBS.Print(i8* %_0) {
    %0 = alloca i32
    %_1 = add i32 0, 0
    store i32 %_1 i32* %0
21:
    %_2 = load i32, i32* %0 
    %_3 = add i32 0, 16
    %_4 = getelementptr i8, i8* %_0, i32 %_3 
    %_5 = bitcast i8* %_4 to i32*
    %_6 = load i32, i32* %_5
    %_7 = icmp slt i32 %_2, %_6
    br i1 %_7, label %22, label %23
22:
    %_8 = add i32 0, 8
    %_9 = getelementptr i8, i8* %_0, i32 %_8 
    %_10 = bitcast i8* %_9 to i32**
    %_11 = load i32*, i32** %_10
    %_12 = load i32, i32* %0 
    %_13 = add i32 0, 0
    %_14 = load i32, i32* %_11
    %_15 = icmp slt i32 %_12, %_14
    %_16 = icmp slt i32 %_13, %_12
    %_17 = and %_15, %_16 
    br i1 %_17, label %25, label %24
24:
    call void @throw_oob() 
25:
    %_18 = add i32 %_12, 1
    %_19 = getelementptr i32, i32* %_11, i32 %_18 
    %_20 = load i32, i32* %_19
    call void (i32) @print_int(i32 %_20) 
    %_21 = load i32, i32* %0 
    %_22 = add i32 0, 1
    %_23 = add i32 %_21, %_22
    store i32 %_23 i32* %0
    br label 21
23:
    %_24 = add i32 0, 0
    ret i32 %_24
}
define i32 @BBS.Init(i8* %_0, i32 %.0) {
    %0 = alloca i32
    store i32 %.0, i32* %0 
    %_1 = load i32, i32* %0 
    %_2 = add i32 0, 16
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1 i32* %_4
    %_5 = load i32, i32* %0 
    %_9 = icmp slt i32 %_0, %_5
    br i1 %_9, label %27, label %26
26:
    call void @throw_oob() 
    br label 27
27:
    %_8 = add i32 %_5, 1
    %_6 = call i8* @calloc(i32 %_8, i32 %_4)
    %_7 = bitcast i8* %_6 to i32*
    store i32 %_5, i32* %7 
    %_10 = add i32 0, 8
    %_11 = getelementptr i8, i8* %_0, i32 %_10 
    %_12 = bitcast i8* %_11 to i32**
    store i32* %_9 i32** %_12
    %_13 = add i32 0, 20
    %_14 = add i32 0, 0
    %_15 = add i32 0, 8
    %_16 = getelementptr i8, i8* %_0, i32 %_15 
    %_17 = bitcast i8* %_16 to i32**
    %_18 = add i32 0, 0
    %_19 = load i32, i32* %_17
    %_20 = icmp slt i32 %_14, %_19
    %_21 = icmp slt i32 %_18, %_14
    %_22 = and %_20, %_21 
    br i1 %_22, label %29, label %28
28:
    call void @throw_oob() 
29:
    %_23 = add i32 %_14, 1
    %_24 = getelementptr i32, i32* %_17, i32 %_23 
    store i32 %_13, i32* %_24 
    %_25 = add i32 0, 7
    %_26 = add i32 0, 1
    %_27 = add i32 0, 8
    %_28 = getelementptr i8, i8* %_0, i32 %_27 
    %_29 = bitcast i8* %_28 to i32**
    %_30 = add i32 0, 0
    %_31 = load i32, i32* %_29
    %_32 = icmp slt i32 %_26, %_31
    %_33 = icmp slt i32 %_30, %_26
    %_34 = and %_32, %_33 
    br i1 %_34, label %31, label %30
30:
    call void @throw_oob() 
31:
    %_35 = add i32 %_26, 1
    %_36 = getelementptr i32, i32* %_29, i32 %_35 
    store i32 %_25, i32* %_36 
    %_37 = add i32 0, 12
    %_38 = add i32 0, 2
    %_39 = add i32 0, 8
    %_40 = getelementptr i8, i8* %_0, i32 %_39 
    %_41 = bitcast i8* %_40 to i32**
    %_42 = add i32 0, 0
    %_43 = load i32, i32* %_41
    %_44 = icmp slt i32 %_38, %_43
    %_45 = icmp slt i32 %_42, %_38
    %_46 = and %_44, %_45 
    br i1 %_46, label %33, label %32
32:
    call void @throw_oob() 
33:
    %_47 = add i32 %_38, 1
    %_48 = getelementptr i32, i32* %_41, i32 %_47 
    store i32 %_37, i32* %_48 
    %_49 = add i32 0, 18
    %_50 = add i32 0, 3
    %_51 = add i32 0, 8
    %_52 = getelementptr i8, i8* %_0, i32 %_51 
    %_53 = bitcast i8* %_52 to i32**
    %_54 = add i32 0, 0
    %_55 = load i32, i32* %_53
    %_56 = icmp slt i32 %_50, %_55
    %_57 = icmp slt i32 %_54, %_50
    %_58 = and %_56, %_57 
    br i1 %_58, label %35, label %34
34:
    call void @throw_oob() 
35:
    %_59 = add i32 %_50, 1
    %_60 = getelementptr i32, i32* %_53, i32 %_59 
    store i32 %_49, i32* %_60 
    %_61 = add i32 0, 2
    %_62 = add i32 0, 4
    %_63 = add i32 0, 8
    %_64 = getelementptr i8, i8* %_0, i32 %_63 
    %_65 = bitcast i8* %_64 to i32**
    %_66 = add i32 0, 0
    %_67 = load i32, i32* %_65
    %_68 = icmp slt i32 %_62, %_67
    %_69 = icmp slt i32 %_66, %_62
    %_70 = and %_68, %_69 
    br i1 %_70, label %37, label %36
36:
    call void @throw_oob() 
37:
    %_71 = add i32 %_62, 1
    %_72 = getelementptr i32, i32* %_65, i32 %_71 
    store i32 %_61, i32* %_72 
    %_73 = add i32 0, 11
    %_74 = add i32 0, 5
    %_75 = add i32 0, 8
    %_76 = getelementptr i8, i8* %_0, i32 %_75 
    %_77 = bitcast i8* %_76 to i32**
    %_78 = add i32 0, 0
    %_79 = load i32, i32* %_77
    %_80 = icmp slt i32 %_74, %_79
    %_81 = icmp slt i32 %_78, %_74
    %_82 = and %_80, %_81 
    br i1 %_82, label %39, label %38
38:
    call void @throw_oob() 
39:
    %_83 = add i32 %_74, 1
    %_84 = getelementptr i32, i32* %_77, i32 %_83 
    store i32 %_73, i32* %_84 
    %_85 = add i32 0, 6
    %_86 = add i32 0, 6
    %_87 = add i32 0, 8
    %_88 = getelementptr i8, i8* %_0, i32 %_87 
    %_89 = bitcast i8* %_88 to i32**
    %_90 = add i32 0, 0
    %_91 = load i32, i32* %_89
    %_92 = icmp slt i32 %_86, %_91
    %_93 = icmp slt i32 %_90, %_86
    %_94 = and %_92, %_93 
    br i1 %_94, label %41, label %40
40:
    call void @throw_oob() 
41:
    %_95 = add i32 %_86, 1
    %_96 = getelementptr i32, i32* %_89, i32 %_95 
    store i32 %_85, i32* %_96 
    %_97 = add i32 0, 9
    %_98 = add i32 0, 7
    %_99 = add i32 0, 8
    %_100 = getelementptr i8, i8* %_0, i32 %_99 
    %_101 = bitcast i8* %_100 to i32**
    %_102 = add i32 0, 0
    %_103 = load i32, i32* %_101
    %_104 = icmp slt i32 %_98, %_103
    %_105 = icmp slt i32 %_102, %_98
    %_106 = and %_104, %_105 
    br i1 %_106, label %43, label %42
42:
    call void @throw_oob() 
43:
    %_107 = add i32 %_98, 1
    %_108 = getelementptr i32, i32* %_101, i32 %_107 
    store i32 %_97, i32* %_108 
    %_109 = add i32 0, 19
    %_110 = add i32 0, 8
    %_111 = add i32 0, 8
    %_112 = getelementptr i8, i8* %_0, i32 %_111 
    %_113 = bitcast i8* %_112 to i32**
    %_114 = add i32 0, 0
    %_115 = load i32, i32* %_113
    %_116 = icmp slt i32 %_110, %_115
    %_117 = icmp slt i32 %_114, %_110
    %_118 = and %_116, %_117 
    br i1 %_118, label %45, label %44
44:
    call void @throw_oob() 
45:
    %_119 = add i32 %_110, 1
    %_120 = getelementptr i32, i32* %_113, i32 %_119 
    store i32 %_109, i32* %_120 
    %_121 = add i32 0, 5
    %_122 = add i32 0, 9
    %_123 = add i32 0, 8
    %_124 = getelementptr i8, i8* %_0, i32 %_123 
    %_125 = bitcast i8* %_124 to i32**
    %_126 = add i32 0, 0
    %_127 = load i32, i32* %_125
    %_128 = icmp slt i32 %_122, %_127
    %_129 = icmp slt i32 %_126, %_122
    %_130 = and %_128, %_129 
    br i1 %_130, label %47, label %46
46:
    call void @throw_oob() 
47:
    %_131 = add i32 %_122, 1
    %_132 = getelementptr i32, i32* %_125, i32 %_131 
    store i32 %_121, i32* %_132 
    %_133 = add i32 0, 0
    ret i32 %_133
}
define i32 @BBS.Start(i8* %_0, i32 %.0) {
    %0 = alloca i32
    store i32 %.0, i32* %0 
    %1 = alloca i32
    %_1 = bitcast i8* %_0 to i8***
    %_2 = load i8**, i8*** %_1
    %_3 = add i32 0, 3
    %_4 = getelementptr i8*, i8** %_2, i32 %_3 
    %_5 = load i8*, i8** %_4
    %_6 = bitcast i8* %_5 to i8*, i32)*
    %_7 = load i32, i32* %0 
    %_8 = call i32 %_6(i8* %_0, i32 %_7)

    store i32 %_8 i32* %1
    %_9 = bitcast i8* %_8 to i8***
    %_10 = load i8**, i8*** %_9
    %_11 = add i32 0, 2
    %_12 = getelementptr i8*, i8** %_10, i32 %_11 
    %_13 = load i8*, i8** %_12
    %_14 = bitcast i8* %_13 to i8*)*
    %_15 = call i32 %_14(i8* %_8)

    store i32 %_15 i32* %1
    %_16 = add i32 0, 99999
    call void (i32) @print_int(i32 %_16) 
    %_17 = bitcast i8* %_16 to i8***
    %_18 = load i8**, i8*** %_17
    %_19 = add i32 0, 1
    %_20 = getelementptr i8*, i8** %_18, i32 %_19 
    %_21 = load i8*, i8** %_20
    %_22 = bitcast i8* %_21 to i8*)*
    %_23 = call i32 %_22(i8* %_16)

    store i32 %_23 i32* %1
    %_24 = bitcast i8* %_23 to i8***
    %_25 = load i8**, i8*** %_24
    %_26 = add i32 0, 2
    %_27 = getelementptr i8*, i8** %_25, i32 %_26 
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i8*)*
    %_30 = call i32 %_29(i8* %_23)

    store i32 %_30 i32* %1
    %_31 = add i32 0, 0
    ret i32 %_31
}
define i32 @BBS.Sort(i8* %_0) {
    %0 = alloca i32
    %1 = alloca i32
    %2 = alloca i32
    %3 = alloca i32
    %4 = alloca i32
    %5 = alloca i32
    %6 = alloca i32
    %7 = alloca i32
    %8 = alloca i32
    %_1 = add i32 0, 16
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    %_5 = add i32 0, 1
    %_6 = sub i32 %_4 %_5
    store i32 %_6 i32* %1
    %_7 = add i32 0, 0
    %_8 = add i32 0, 1
    %_9 = sub i32 %_7 %_8
    store i32 %_9 i32* %2
0:
    %_10 = load i32, i32* %2 
    %_11 = load i32, i32* %1 
    %_12 = icmp slt i32 %_10, %_11
    br i1 %_12, label %1, label %2
1:
    %_13 = add i32 0, 1
    store i32 %_13 i32* %7
3:
    %_14 = load i32, i32* %7 
    %_15 = load i32, i32* %1 
    %_16 = add i32 0, 1
    %_17 = add i32 %_15, %_16
    %_18 = icmp slt i32 %_14, %_17
    br i1 %_18, label %4, label %5
4:
    %_19 = load i32, i32* %7 
    %_20 = add i32 0, 1
    %_21 = sub i32 %_19 %_20
    store i32 %_21 i32* %6
    %_22 = add i32 0, 8
    %_23 = getelementptr i8, i8* %_0, i32 %_22 
    %_24 = bitcast i8* %_23 to i32**
    %_25 = load i32*, i32** %_24
    %_26 = load i32, i32* %6 
    %_27 = add i32 0, 0
    %_28 = load i32, i32* %_25
    %_29 = icmp slt i32 %_26, %_28
    %_30 = icmp slt i32 %_27, %_26
    %_31 = and %_29, %_30 
    br i1 %_31, label %7, label %6
6:
    call void @throw_oob() 
7:
    %_32 = add i32 %_26, 1
    %_33 = getelementptr i32, i32* %_25, i32 %_32 
    %_34 = load i32, i32* %_33
    store i32 %_34 i32* %3
    %_35 = add i32 0, 8
    %_36 = getelementptr i8, i8* %_0, i32 %_35 
    %_37 = bitcast i8* %_36 to i32**
    %_38 = load i32*, i32** %_37
    %_39 = load i32, i32* %7 
    %_40 = add i32 0, 0
    %_41 = load i32, i32* %_38
    %_42 = icmp slt i32 %_39, %_41
    %_43 = icmp slt i32 %_40, %_39
    %_44 = and %_42, %_43 
    br i1 %_44, label %9, label %8
8:
    call void @throw_oob() 
9:
    %_45 = add i32 %_39, 1
    %_46 = getelementptr i32, i32* %_38, i32 %_45 
    %_47 = load i32, i32* %_46
    store i32 %_47 i32* %4
    %_48 = load i32, i32* %4 
    %_49 = load i32, i32* %3 
    %_50 = icmp slt i32 %_48, %_49
    br i1 %_50, label %10, label %11
10:
    %_51 = load i32, i32* %7 
    %_52 = add i32 0, 1
    %_53 = sub i32 %_51 %_52
    store i32 %_53 i32* %5
    %_54 = add i32 0, 8
    %_55 = getelementptr i8, i8* %_0, i32 %_54 
    %_56 = bitcast i8* %_55 to i32**
    %_57 = load i32*, i32** %_56
    %_58 = load i32, i32* %5 
    %_59 = add i32 0, 0
    %_60 = load i32, i32* %_57
    %_61 = icmp slt i32 %_58, %_60
    %_62 = icmp slt i32 %_59, %_58
    %_63 = and %_61, %_62 
    br i1 %_63, label %14, label %13
13:
    call void @throw_oob() 
14:
    %_64 = add i32 %_58, 1
    %_65 = getelementptr i32, i32* %_57, i32 %_64 
    %_66 = load i32, i32* %_65
    store i32 %_66 i32* %8
    %_67 = add i32 0, 8
    %_68 = getelementptr i8, i8* %_0, i32 %_67 
    %_69 = bitcast i8* %_68 to i32**
    %_70 = load i32*, i32** %_69
    %_71 = load i32, i32* %7 
    %_72 = add i32 0, 0
    %_73 = load i32, i32* %_70
    %_74 = icmp slt i32 %_71, %_73
    %_75 = icmp slt i32 %_72, %_71
    %_76 = and %_74, %_75 
    br i1 %_76, label %16, label %15
15:
    call void @throw_oob() 
16:
    %_77 = add i32 %_71, 1
    %_78 = getelementptr i32, i32* %_70, i32 %_77 
    %_79 = load i32, i32* %_78
    %_80 = load i32, i32* %5 
    %_81 = add i32 0, 8
    %_82 = getelementptr i8, i8* %_0, i32 %_81 
    %_83 = bitcast i8* %_82 to i32**
    %_84 = add i32 0, 0
    %_85 = load i32, i32* %_83
    %_86 = icmp slt i32 %_80, %_85
    %_87 = icmp slt i32 %_84, %_80
    %_88 = and %_86, %_87 
    br i1 %_88, label %18, label %17
17:
    call void @throw_oob() 
18:
    %_89 = add i32 %_80, 1
    %_90 = getelementptr i32, i32* %_83, i32 %_89 
    store i32 %_79, i32* %_90 
    %_91 = load i32, i32* %8 
    %_92 = load i32, i32* %7 
    %_93 = add i32 0, 8
    %_94 = getelementptr i8, i8* %_0, i32 %_93 
    %_95 = bitcast i8* %_94 to i32**
    %_96 = add i32 0, 0
    %_97 = load i32, i32* %_95
    %_98 = icmp slt i32 %_92, %_97
    %_99 = icmp slt i32 %_96, %_92
    %_100 = and %_98, %_99 
    br i1 %_100, label %20, label %19
19:
    call void @throw_oob() 
20:
    %_101 = add i32 %_92, 1
    %_102 = getelementptr i32, i32* %_95, i32 %_101 
    store i32 %_91, i32* %_102 
    br label 12
11:
    %_103 = add i32 0, 0
    store i32 %_103 i32* %0
    br label 12
12:
    %_104 = load i32, i32* %7 
    %_105 = add i32 0, 1
    %_106 = add i32 %_104, %_105
    store i32 %_106 i32* %7
    br label 3
5:
    %_107 = load i32, i32* %1 
    %_108 = add i32 0, 1
    %_109 = sub i32 %_107 %_108
    store i32 %_109 i32* %1
    br label 0
2:
    %_110 = add i32 0, 0
    ret i32 %_110
}
