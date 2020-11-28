@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @QS.Start to i8*), i8* bitcast (i32 (i8*, i32, i32)* @QS.Sort to i8*), i8* bitcast (i32 (i8*)* @QS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @QS.Init to i8*)]
define i32 @QS.Start(i8* %2, i32 %.3) {
    %3 = alloca i32
    store i32 %.3, i32* %3 
    %4 = alloca i32
    %_3 = load i32, i32* %3 
    store i32 %_4 i32* %4
    store i32 %_5 i32* %4
    %_6 = add i32 0, 9999
    call void (i32) @print_int(i32 %_6) 
    %_7 = load i32, i32* %1 
    %_8 = add i32 0, 1
    %_9 = sub i32 %_7 %_8
    store i32 %_9 i32* %4
    %_10 = add i32 0, 0
    %_11 = load i32, i32* %4 
    store i32 %_12 i32* %4
    store i32 %_13 i32* %4
    %_14 = add i32 0, 0
}
define i32 @QS.Sort(i8* %5, i32 %.6, i32 %.7) {
    %6 = alloca i32
    store i32 %.6, i32* %6 
    %7 = alloca i32
    store i32 %.7, i32* %7 
    %8 = alloca i32
    %9 = alloca i32
    %10 = alloca i32
    %11 = alloca i32
    %12 = alloca i32
    %13 = alloca i1
    %14 = alloca i1
    %15 = alloca i32
    %_15 = add i32 0, 0
    store i32 %_15 i32* %12
    %_16 = load i32, i32* %6 
    %_17 = load i32, i32* %7 
    %_18 = icmp slt i32 %_16, %_17
    br i1 %_18, label %0, label %1
0:
    %_19 = load i32*, i32** %0 
    %_20 = load i32, i32* %7 
    %_21 = add i32 0, 0
    %_22 = load i32, i32* %_19
    %_23 = icmp slt i32 %_20, %_22
    %_24 = icmp slt i32 %_21, %_20
    %_25 = and %_23, %_24 
    br i1 %_25, label %4, label %3
3:
    call void @throw_oob() 
4:
    %_26 = add i32 %_20, 1
    %_27 = getelementptr i32, i32* %_19, i32 %_26 
    %_28 = load i32, i32* %_27
    store i32 %_28 i32* %8
    %_29 = load i32, i32* %6 
    %_30 = add i32 0, 1
    %_31 = sub i32 %_29 %_30
    store i32 %_31 i32* %9
    %_32 = load i32, i32* %7 
    store i32 %_32 i32* %10
    %_33 = add i1 0, 1 
    store i1 %_33 i1* %13
5:
    %_34 = load i1, i1* %13 
    br i1 %_34, label %6, label %7
6:
    %_35 = add i1 0, 1 
    store i1 %_35 i1* %14
8:
    %_36 = load i1, i1* %14 
    br i1 %_36, label %9, label %10
9:
    %_37 = load i32, i32* %9 
    %_38 = add i32 0, 1
    %_39 = add i32 %_37, %_38
    store i32 %_39 i32* %9
    %_40 = load i32*, i32** %0 
    %_41 = load i32, i32* %9 
    %_42 = add i32 0, 0
    %_43 = load i32, i32* %_40
    %_44 = icmp slt i32 %_41, %_43
    %_45 = icmp slt i32 %_42, %_41
    %_46 = and %_44, %_45 
    br i1 %_46, label %12, label %11
11:
    call void @throw_oob() 
12:
    %_47 = add i32 %_41, 1
    %_48 = getelementptr i32, i32* %_40, i32 %_47 
    %_49 = load i32, i32* %_48
    store i32 %_49 i32* %15
    %_50 = load i32, i32* %15 
    %_51 = load i32, i32* %8 
    %_52 = icmp slt i32 %_50, %_51
    %_53 = not %_53
    br i1 %_53, label %13, label %14
13:
    %_54 = add i1 0, 0 
    store i1 %_54 i1* %14
    br label 15
14:
    %_55 = add i1 0, 1 
    store i1 %_55 i1* %14
    br label 15
15:
    br label 8
10:
    %_56 = add i1 0, 1 
    store i1 %_56 i1* %14
16:
    %_57 = load i1, i1* %14 
    br i1 %_57, label %17, label %18
17:
    %_58 = load i32, i32* %10 
    %_59 = add i32 0, 1
    %_60 = sub i32 %_58 %_59
    store i32 %_60 i32* %10
    %_61 = load i32*, i32** %0 
    %_62 = load i32, i32* %10 
    %_63 = add i32 0, 0
    %_64 = load i32, i32* %_61
    %_65 = icmp slt i32 %_62, %_64
    %_66 = icmp slt i32 %_63, %_62
    %_67 = and %_65, %_66 
    br i1 %_67, label %20, label %19
19:
    call void @throw_oob() 
20:
    %_68 = add i32 %_62, 1
    %_69 = getelementptr i32, i32* %_61, i32 %_68 
    %_70 = load i32, i32* %_69
    store i32 %_70 i32* %15
    %_71 = load i32, i32* %8 
    %_72 = load i32, i32* %15 
    %_73 = icmp slt i32 %_71, %_72
    %_74 = not %_74
    br i1 %_74, label %21, label %22
21:
    %_75 = add i1 0, 0 
    store i1 %_75 i1* %14
    br label 23
22:
    %_76 = add i1 0, 1 
    store i1 %_76 i1* %14
    br label 23
23:
    br label 16
18:
    %_77 = load i32*, i32** %0 
    %_78 = load i32, i32* %9 
    %_79 = add i32 0, 0
    %_80 = load i32, i32* %_77
    %_81 = icmp slt i32 %_78, %_80
    %_82 = icmp slt i32 %_79, %_78
    %_83 = and %_81, %_82 
    br i1 %_83, label %25, label %24
24:
    call void @throw_oob() 
25:
    %_84 = add i32 %_78, 1
    %_85 = getelementptr i32, i32* %_77, i32 %_84 
    %_86 = load i32, i32* %_85
    store i32 %_86 i32* %12
    %_87 = load i32*, i32** %0 
    %_88 = load i32, i32* %10 
    %_89 = add i32 0, 0
    %_90 = load i32, i32* %_87
    %_91 = icmp slt i32 %_88, %_90
    %_92 = icmp slt i32 %_89, %_88
    %_93 = and %_91, %_92 
    br i1 %_93, label %27, label %26
26:
    call void @throw_oob() 
27:
    %_94 = add i32 %_88, 1
    %_95 = getelementptr i32, i32* %_87, i32 %_94 
    %_96 = load i32, i32* %_95
    %_97 = load i32, i32* %9 
    %_98 = load i32*, i32** %0 
    %_99 = add i32 0, 0
    %_100 = load i32, i32* %_98
    %_101 = icmp slt i32 %_97, %_100
    %_102 = icmp slt i32 %_99, %_97
    %_103 = and %_101, %_102 
    br i1 %_103, label %29, label %28
28:
    call void @throw_oob() 
29:
    %_104 = add i32 %_97, 1
    %_105 = getelementptr i32, i32* %_98, i32 %_104 
    store i32 %_96, i32* %0 
    %_106 = load i32, i32* %12 
    %_107 = load i32, i32* %10 
    %_108 = load i32*, i32** %0 
    %_109 = add i32 0, 0
    %_110 = load i32, i32* %_108
    %_111 = icmp slt i32 %_107, %_110
    %_112 = icmp slt i32 %_109, %_107
    %_113 = and %_111, %_112 
    br i1 %_113, label %31, label %30
30:
    call void @throw_oob() 
31:
    %_114 = add i32 %_107, 1
    %_115 = getelementptr i32, i32* %_108, i32 %_114 
    store i32 %_106, i32* %0 
    %_116 = load i32, i32* %10 
    %_117 = load i32, i32* %9 
    %_118 = add i32 0, 1
    %_119 = add i32 %_117, %_118
    %_120 = icmp slt i32 %_116, %_119
    br i1 %_120, label %32, label %33
32:
    %_121 = add i1 0, 0 
    store i1 %_121 i1* %13
    br label 34
33:
    %_122 = add i1 0, 1 
    store i1 %_122 i1* %13
    br label 34
34:
    br label 5
7:
    %_123 = load i32*, i32** %0 
    %_124 = load i32, i32* %9 
    %_125 = add i32 0, 0
    %_126 = load i32, i32* %_123
    %_127 = icmp slt i32 %_124, %_126
    %_128 = icmp slt i32 %_125, %_124
    %_129 = and %_127, %_128 
    br i1 %_129, label %36, label %35
35:
    call void @throw_oob() 
36:
    %_130 = add i32 %_124, 1
    %_131 = getelementptr i32, i32* %_123, i32 %_130 
    %_132 = load i32, i32* %_131
    %_133 = load i32, i32* %10 
    %_134 = load i32*, i32** %0 
    %_135 = add i32 0, 0
    %_136 = load i32, i32* %_134
    %_137 = icmp slt i32 %_133, %_136
    %_138 = icmp slt i32 %_135, %_133
    %_139 = and %_137, %_138 
    br i1 %_139, label %38, label %37
37:
    call void @throw_oob() 
38:
    %_140 = add i32 %_133, 1
    %_141 = getelementptr i32, i32* %_134, i32 %_140 
    store i32 %_132, i32* %0 
    %_142 = load i32*, i32** %0 
    %_143 = load i32, i32* %7 
    %_144 = add i32 0, 0
    %_145 = load i32, i32* %_142
    %_146 = icmp slt i32 %_143, %_145
    %_147 = icmp slt i32 %_144, %_143
    %_148 = and %_146, %_147 
    br i1 %_148, label %40, label %39
39:
    call void @throw_oob() 
40:
    %_149 = add i32 %_143, 1
    %_150 = getelementptr i32, i32* %_142, i32 %_149 
    %_151 = load i32, i32* %_150
    %_152 = load i32, i32* %9 
    %_153 = load i32*, i32** %0 
    %_154 = add i32 0, 0
    %_155 = load i32, i32* %_153
    %_156 = icmp slt i32 %_152, %_155
    %_157 = icmp slt i32 %_154, %_152
    %_158 = and %_156, %_157 
    br i1 %_158, label %42, label %41
41:
    call void @throw_oob() 
42:
    %_159 = add i32 %_152, 1
    %_160 = getelementptr i32, i32* %_153, i32 %_159 
    store i32 %_151, i32* %0 
    %_161 = load i32, i32* %12 
    %_162 = load i32, i32* %7 
    %_163 = load i32*, i32** %0 
    %_164 = add i32 0, 0
    %_165 = load i32, i32* %_163
    %_166 = icmp slt i32 %_162, %_165
    %_167 = icmp slt i32 %_164, %_162
    %_168 = and %_166, %_167 
    br i1 %_168, label %44, label %43
43:
    call void @throw_oob() 
44:
    %_169 = add i32 %_162, 1
    %_170 = getelementptr i32, i32* %_163, i32 %_169 
    store i32 %_161, i32* %0 
    %_171 = load i32, i32* %6 
    %_172 = load i32, i32* %9 
    %_173 = add i32 0, 1
    %_174 = sub i32 %_172 %_173
    store i32 %_175 i32* %11
    %_176 = load i32, i32* %9 
    %_177 = add i32 0, 1
    %_178 = add i32 %_176, %_177
    %_179 = load i32, i32* %7 
    store i32 %_180 i32* %11
    br label 2
1:
    %_181 = add i32 0, 0
    store i32 %_181 i32* %11
    br label 2
2:
    %_182 = add i32 0, 0
}
define i32 @QS.Print(i8* %16) {
    %17 = alloca i32
    %_183 = add i32 0, 0
    store i32 %_183 i32* %17
45:
    %_184 = load i32, i32* %17 
    %_185 = load i32, i32* %1 
    %_186 = icmp slt i32 %_184, %_185
    br i1 %_186, label %46, label %47
46:
    %_187 = load i32*, i32** %0 
    %_188 = load i32, i32* %17 
    %_189 = add i32 0, 0
    %_190 = load i32, i32* %_187
    %_191 = icmp slt i32 %_188, %_190
    %_192 = icmp slt i32 %_189, %_188
    %_193 = and %_191, %_192 
    br i1 %_193, label %49, label %48
48:
    call void @throw_oob() 
49:
    %_194 = add i32 %_188, 1
    %_195 = getelementptr i32, i32* %_187, i32 %_194 
    %_196 = load i32, i32* %_195
    call void (i32) @print_int(i32 %_196) 
    %_197 = load i32, i32* %17 
    %_198 = add i32 0, 1
    %_199 = add i32 %_197, %_198
    store i32 %_199 i32* %17
    br label 45
47:
    %_200 = add i32 0, 0
}
define i32 @QS.Init(i8* %18, i32 %.19) {
    %19 = alloca i32
    store i32 %.19, i32* %19 
    %_201 = load i32, i32* %19 
    store i32 %_201 i32* %1
    %_202 = load i32, i32* %19 
    %_206 = icmp slt i32 %_0, %_202
    br i1 %_206, label %51, label %50
50:
    call void @throw_oob() 
    br label 51
51:
    %_205 = add i32 %_202, 1
    %_203 = call i8* @calloc(i32 %_205, i32 %_4)
    %_204 = bitcast i8* %_203 to i32*
    store i32 %_202, i32* %204 
    store i32* %_206 i32** %0
    %_207 = add i32 0, 20
    %_208 = add i32 0, 0
    %_209 = load i32*, i32** %0 
    %_210 = add i32 0, 0
    %_211 = load i32, i32* %_209
    %_212 = icmp slt i32 %_208, %_211
    %_213 = icmp slt i32 %_210, %_208
    %_214 = and %_212, %_213 
    br i1 %_214, label %53, label %52
52:
    call void @throw_oob() 
53:
    %_215 = add i32 %_208, 1
    %_216 = getelementptr i32, i32* %_209, i32 %_215 
    store i32 %_207, i32* %0 
    %_217 = add i32 0, 7
    %_218 = add i32 0, 1
    %_219 = load i32*, i32** %0 
    %_220 = add i32 0, 0
    %_221 = load i32, i32* %_219
    %_222 = icmp slt i32 %_218, %_221
    %_223 = icmp slt i32 %_220, %_218
    %_224 = and %_222, %_223 
    br i1 %_224, label %55, label %54
54:
    call void @throw_oob() 
55:
    %_225 = add i32 %_218, 1
    %_226 = getelementptr i32, i32* %_219, i32 %_225 
    store i32 %_217, i32* %0 
    %_227 = add i32 0, 12
    %_228 = add i32 0, 2
    %_229 = load i32*, i32** %0 
    %_230 = add i32 0, 0
    %_231 = load i32, i32* %_229
    %_232 = icmp slt i32 %_228, %_231
    %_233 = icmp slt i32 %_230, %_228
    %_234 = and %_232, %_233 
    br i1 %_234, label %57, label %56
56:
    call void @throw_oob() 
57:
    %_235 = add i32 %_228, 1
    %_236 = getelementptr i32, i32* %_229, i32 %_235 
    store i32 %_227, i32* %0 
    %_237 = add i32 0, 18
    %_238 = add i32 0, 3
    %_239 = load i32*, i32** %0 
    %_240 = add i32 0, 0
    %_241 = load i32, i32* %_239
    %_242 = icmp slt i32 %_238, %_241
    %_243 = icmp slt i32 %_240, %_238
    %_244 = and %_242, %_243 
    br i1 %_244, label %59, label %58
58:
    call void @throw_oob() 
59:
    %_245 = add i32 %_238, 1
    %_246 = getelementptr i32, i32* %_239, i32 %_245 
    store i32 %_237, i32* %0 
    %_247 = add i32 0, 2
    %_248 = add i32 0, 4
    %_249 = load i32*, i32** %0 
    %_250 = add i32 0, 0
    %_251 = load i32, i32* %_249
    %_252 = icmp slt i32 %_248, %_251
    %_253 = icmp slt i32 %_250, %_248
    %_254 = and %_252, %_253 
    br i1 %_254, label %61, label %60
60:
    call void @throw_oob() 
61:
    %_255 = add i32 %_248, 1
    %_256 = getelementptr i32, i32* %_249, i32 %_255 
    store i32 %_247, i32* %0 
    %_257 = add i32 0, 11
    %_258 = add i32 0, 5
    %_259 = load i32*, i32** %0 
    %_260 = add i32 0, 0
    %_261 = load i32, i32* %_259
    %_262 = icmp slt i32 %_258, %_261
    %_263 = icmp slt i32 %_260, %_258
    %_264 = and %_262, %_263 
    br i1 %_264, label %63, label %62
62:
    call void @throw_oob() 
63:
    %_265 = add i32 %_258, 1
    %_266 = getelementptr i32, i32* %_259, i32 %_265 
    store i32 %_257, i32* %0 
    %_267 = add i32 0, 6
    %_268 = add i32 0, 6
    %_269 = load i32*, i32** %0 
    %_270 = add i32 0, 0
    %_271 = load i32, i32* %_269
    %_272 = icmp slt i32 %_268, %_271
    %_273 = icmp slt i32 %_270, %_268
    %_274 = and %_272, %_273 
    br i1 %_274, label %65, label %64
64:
    call void @throw_oob() 
65:
    %_275 = add i32 %_268, 1
    %_276 = getelementptr i32, i32* %_269, i32 %_275 
    store i32 %_267, i32* %0 
    %_277 = add i32 0, 9
    %_278 = add i32 0, 7
    %_279 = load i32*, i32** %0 
    %_280 = add i32 0, 0
    %_281 = load i32, i32* %_279
    %_282 = icmp slt i32 %_278, %_281
    %_283 = icmp slt i32 %_280, %_278
    %_284 = and %_282, %_283 
    br i1 %_284, label %67, label %66
66:
    call void @throw_oob() 
67:
    %_285 = add i32 %_278, 1
    %_286 = getelementptr i32, i32* %_279, i32 %_285 
    store i32 %_277, i32* %0 
    %_287 = add i32 0, 19
    %_288 = add i32 0, 8
    %_289 = load i32*, i32** %0 
    %_290 = add i32 0, 0
    %_291 = load i32, i32* %_289
    %_292 = icmp slt i32 %_288, %_291
    %_293 = icmp slt i32 %_290, %_288
    %_294 = and %_292, %_293 
    br i1 %_294, label %69, label %68
68:
    call void @throw_oob() 
69:
    %_295 = add i32 %_288, 1
    %_296 = getelementptr i32, i32* %_289, i32 %_295 
    store i32 %_287, i32* %0 
    %_297 = add i32 0, 5
    %_298 = add i32 0, 9
    %_299 = load i32*, i32** %0 
    %_300 = add i32 0, 0
    %_301 = load i32, i32* %_299
    %_302 = icmp slt i32 %_298, %_301
    %_303 = icmp slt i32 %_300, %_298
    %_304 = and %_302, %_303 
    br i1 %_304, label %71, label %70
70:
    call void @throw_oob() 
71:
    %_305 = add i32 %_298, 1
    %_306 = getelementptr i32, i32* %_299, i32 %_305 
    store i32 %_297, i32* %0 
    %_307 = add i32 0, 0
}
