@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @QS.Start to i8*), i8* bitcast (i32 (i8*, i32, i32)* @QS.Sort to i8*), i8* bitcast (i32 (i8*)* @QS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @QS.Init to i8*)]
define i32 @QS.Start(i8* %this, i32 %.sz) {
    sym 2 = alloca i32
    store i32 reg 3 i32* sym 2
    store i32 reg 4 i32* sym 2
    reg 5 = add i32 0, 9999
    call void (i32) @print_int(i32 %_5) 
    reg 6 = load i32, i32* sym 1 
    reg 7 = add i32 0, 1
    reg 8 = sub i32 reg 6 reg 7
    store i32 reg 8 i32* sym 2
    reg 9 = add i32 0, 0
    reg 10 = load i32, i32* sym 2 
    store i32 reg 11 i32* sym 2
    store i32 reg 12 i32* sym 2
    reg 13 = add i32 0, 0
}
define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
    sym 3 = alloca i32
    sym 4 = alloca i32
    sym 5 = alloca i32
    sym 6 = alloca i32
    sym 7 = alloca i32
    sym 8 = alloca i1
    sym 9 = alloca i1
    sym 10 = alloca i32
    reg 14 = add i32 0, 0
    store i32 reg 14 i32* sym 7
    reg 15 = icmp slt i32 reg 14, reg 14
    br i1 reg 15, label sym 0, label sym 1
0:
    reg 16 = load i32*, i32** sym 0 
    reg 17 = add i32 0, 0
    %_18 = getelementptr i32, i32* %_16, i32 0 
    %_19 = load i32, i32* %_18
    reg 20 = icmp slt i32 reg 16, reg 19
    reg 21 = icmp slt i32 reg 17, reg 16
    reg 22 = and reg 20, reg 21 
    br i1 reg 22, label sym 4, label sym 3
3:
    call void @throw_oob() 
4:
    %_24 = getelementptr i32, i32* %_16, i32 %_23 
    store i32 reg 24 i32* sym 3
    reg 25 = add i32 0, 1
    reg 26 = sub i32 reg 24 reg 25
    store i32 reg 26 i32* sym 4
    store i32 reg 26 i32* sym 5
    reg 27 = add i1 0, 1 
    store i1 reg 27 i1* sym 8
5:
    reg 28 = load i1, i1* sym 8 
    br i1 reg 28, label sym 6, label sym 7
6:
    reg 29 = add i1 0, 1 
    store i1 reg 29 i1* sym 9
8:
    reg 30 = load i1, i1* sym 9 
    br i1 reg 30, label sym 9, label sym 10
9:
    reg 31 = load i32, i32* sym 4 
    reg 32 = add i32 0, 1
    %_33 = add i32 %_31, %_32
    store i32 reg 33 i32* sym 4
    reg 34 = load i32*, i32** sym 0 
    reg 35 = load i32, i32* sym 4 
    reg 36 = add i32 0, 0
    %_37 = getelementptr i32, i32* %_34, i32 0 
    %_38 = load i32, i32* %_37
    reg 39 = icmp slt i32 reg 35, reg 38
    reg 40 = icmp slt i32 reg 36, reg 35
    reg 41 = and reg 39, reg 40 
    br i1 reg 41, label sym 12, label sym 11
11:
    call void @throw_oob() 
12:
    %_43 = getelementptr i32, i32* %_34, i32 %_42 
    store i32 reg 43 i32* sym 10
    reg 44 = load i32, i32* sym 10 
    reg 45 = load i32, i32* sym 3 
    reg 46 = icmp slt i32 reg 44, reg 45
    reg 47 = not reg 47
    br i1 reg 47, label sym 13, label sym 14
13:
    reg 48 = add i1 0, 0 
    store i1 reg 48 i1* sym 9
    br label 15
14:
    reg 49 = add i1 0, 1 
    store i1 reg 49 i1* sym 9
    br label 15
15:
    br label 8
10:
    reg 50 = add i1 0, 1 
    store i1 reg 50 i1* sym 9
16:
    reg 51 = load i1, i1* sym 9 
    br i1 reg 51, label sym 17, label sym 18
17:
    reg 52 = load i32, i32* sym 5 
    reg 53 = add i32 0, 1
    reg 54 = sub i32 reg 52 reg 53
    store i32 reg 54 i32* sym 5
    reg 55 = load i32*, i32** sym 0 
    reg 56 = load i32, i32* sym 5 
    reg 57 = add i32 0, 0
    %_58 = getelementptr i32, i32* %_55, i32 0 
    %_59 = load i32, i32* %_58
    reg 60 = icmp slt i32 reg 56, reg 59
    reg 61 = icmp slt i32 reg 57, reg 56
    reg 62 = and reg 60, reg 61 
    br i1 reg 62, label sym 20, label sym 19
19:
    call void @throw_oob() 
20:
    %_64 = getelementptr i32, i32* %_55, i32 %_63 
    store i32 reg 64 i32* sym 10
    reg 65 = load i32, i32* sym 3 
    reg 66 = load i32, i32* sym 10 
    reg 67 = icmp slt i32 reg 65, reg 66
    reg 68 = not reg 68
    br i1 reg 68, label sym 21, label sym 22
21:
    reg 69 = add i1 0, 0 
    store i1 reg 69 i1* sym 9
    br label 23
22:
    reg 70 = add i1 0, 1 
    store i1 reg 70 i1* sym 9
    br label 23
23:
    br label 16
18:
    reg 71 = load i32*, i32** sym 0 
    reg 72 = load i32, i32* sym 4 
    reg 73 = add i32 0, 0
    %_74 = getelementptr i32, i32* %_71, i32 0 
    %_75 = load i32, i32* %_74
    reg 76 = icmp slt i32 reg 72, reg 75
    reg 77 = icmp slt i32 reg 73, reg 72
    reg 78 = and reg 76, reg 77 
    br i1 reg 78, label sym 25, label sym 24
24:
    call void @throw_oob() 
25:
    %_80 = getelementptr i32, i32* %_71, i32 %_79 
    store i32 reg 80 i32* sym 7
    reg 81 = load i32*, i32** sym 0 
    reg 82 = load i32, i32* sym 5 
    reg 83 = add i32 0, 0
    %_84 = getelementptr i32, i32* %_81, i32 0 
    %_85 = load i32, i32* %_84
    reg 86 = icmp slt i32 reg 82, reg 85
    reg 87 = icmp slt i32 reg 83, reg 82
    reg 88 = and reg 86, reg 87 
    br i1 reg 88, label sym 27, label sym 26
26:
    call void @throw_oob() 
27:
    %_90 = getelementptr i32, i32* %_81, i32 %_89 
    reg 91 = load i32, i32* sym 4 
    reg 92 = load i32, i32* sym 7 
    reg 93 = load i32, i32* sym 5 
    reg 94 = load i32, i32* sym 5 
    reg 95 = load i32, i32* sym 4 
    reg 96 = add i32 0, 1
    %_97 = add i32 %_95, %_96
    reg 98 = icmp slt i32 reg 94, reg 97
    br i1 reg 98, label sym 28, label sym 29
28:
    reg 99 = add i1 0, 0 
    store i1 reg 99 i1* sym 8
    br label 30
29:
    reg 100 = add i1 0, 1 
    store i1 reg 100 i1* sym 8
    br label 30
30:
    br label 5
7:
    reg 101 = load i32*, i32** sym 0 
    reg 102 = load i32, i32* sym 4 
    reg 103 = add i32 0, 0
    %_104 = getelementptr i32, i32* %_101, i32 0 
    %_105 = load i32, i32* %_104
    reg 106 = icmp slt i32 reg 102, reg 105
    reg 107 = icmp slt i32 reg 103, reg 102
    reg 108 = and reg 106, reg 107 
    br i1 reg 108, label sym 32, label sym 31
31:
    call void @throw_oob() 
32:
    %_110 = getelementptr i32, i32* %_101, i32 %_109 
    reg 111 = load i32, i32* sym 5 
    reg 112 = load i32*, i32** sym 0 
    reg 113 = add i32 0, 0
    %_114 = getelementptr i32, i32* %_112, i32 0 
    %_115 = load i32, i32* %_114
    reg 116 = icmp slt i32 reg 112, reg 115
    reg 117 = icmp slt i32 reg 113, reg 112
    reg 118 = and reg 116, reg 117 
    br i1 reg 118, label sym 34, label sym 33
33:
    call void @throw_oob() 
34:
    %_120 = getelementptr i32, i32* %_112, i32 %_119 
    reg 121 = load i32, i32* sym 4 
    reg 122 = load i32, i32* sym 7 
    reg 123 = load i32, i32* sym 4 
    reg 124 = add i32 0, 1
    reg 125 = sub i32 reg 123 reg 124
    store i32 reg 126 i32* sym 6
    reg 127 = load i32, i32* sym 4 
    reg 128 = add i32 0, 1
    %_129 = add i32 %_127, %_128
    store i32 reg 130 i32* sym 6
    br label 2
1:
    reg 131 = add i32 0, 0
    store i32 reg 131 i32* sym 6
    br label 2
2:
    reg 132 = add i32 0, 0
}
define i32 @QS.Print(i8* %this) {
    sym 11 = alloca i32
    reg 133 = add i32 0, 0
    store i32 reg 133 i32* sym 11
35:
    reg 134 = load i32, i32* sym 11 
    reg 135 = load i32, i32* sym 1 
    reg 136 = icmp slt i32 reg 134, reg 135
    br i1 reg 136, label sym 36, label sym 37
36:
    reg 137 = load i32*, i32** sym 0 
    reg 138 = load i32, i32* sym 11 
    reg 139 = add i32 0, 0
    %_140 = getelementptr i32, i32* %_137, i32 0 
    %_141 = load i32, i32* %_140
    reg 142 = icmp slt i32 reg 138, reg 141
    reg 143 = icmp slt i32 reg 139, reg 138
    reg 144 = and reg 142, reg 143 
    br i1 reg 144, label sym 39, label sym 38
38:
    call void @throw_oob() 
39:
    %_146 = getelementptr i32, i32* %_137, i32 %_145 
    call void (i32) @print_int(i32 %_146) 
    reg 147 = load i32, i32* sym 11 
    reg 148 = add i32 0, 1
    %_149 = add i32 %_147, %_148
    store i32 reg 149 i32* sym 11
    br label 35
37:
    reg 150 = add i32 0, 0
}
define i32 @QS.Init(i8* %this, i32 %.sz) {
    store i32 reg 150 i32* sym 1
    reg 153 = icmp slt i32 reg 0, reg 152
    br i1 reg 153, label sym 41, label sym 40
40:
    call void @throw_oob() 
    br label 41
41:
    reg 151 = call i8* @calloc(i32 reg 152, i32 reg 4)
    reg 152 = bitcast i8* reg 151 to i32*
    store i32 reg 152, i32* sym 152 
    store i32* reg 153 i32** sym 0
    reg 154 = add i32 0, 20
    reg 155 = add i32 0, 0
    reg 156 = add i32 0, 7
    reg 157 = add i32 0, 1
    reg 158 = add i32 0, 12
    reg 159 = add i32 0, 2
    reg 160 = add i32 0, 18
    reg 161 = add i32 0, 3
    reg 162 = add i32 0, 2
    reg 163 = add i32 0, 4
    reg 164 = add i32 0, 11
    reg 165 = add i32 0, 5
    reg 166 = add i32 0, 6
    reg 167 = add i32 0, 6
    reg 168 = add i32 0, 9
    reg 169 = add i32 0, 7
    reg 170 = add i32 0, 19
    reg 171 = add i32 0, 8
    reg 172 = add i32 0, 5
    reg 173 = add i32 0, 9
    reg 174 = add i32 0, 0
}
