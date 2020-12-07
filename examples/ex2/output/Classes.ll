@.Classes_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*)* @Classes.run to i8*)]

@.Base_vtable = global [2 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Base.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

@.Derived_vtable = global [2 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Derived.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

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
    %_4 = getelementptr [1 x i8*], [1 x i8*]* @.Classes_vtable, i32 0, i32 0 
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

define i32 @Classes.run(i8* %_0) {
    %1 = alloca i8*
    %2 = alloca i8*

    %_1 = add i32 0, 12
    %_2 = add i32 0, 1
    %_5 = call i8* @calloc(i32 %_2, i32 %_1)
    %_3 = bitcast i8* %_5 to i8***
    %_4 = getelementptr [2 x i8*], [2 x i8*]* @.Base_vtable, i32 0, i32 0 
    store i8** %_4, i8*** %_3 

    store i8* %_5, i8** %1

    %_6 = add i32 0, 20
    %_7 = add i32 0, 1
    %_10 = call i8* @calloc(i32 %_7, i32 %_6)
    %_8 = bitcast i8* %_10 to i8***
    %_9 = getelementptr [2 x i8*], [2 x i8*]* @.Derived_vtable, i32 0, i32 0 
    store i8** %_9, i8*** %_8 

    store i8* %_10, i8** %2
    %_11 = load i8*, i8** %1 
    %_12 = bitcast i8* %_11 to i8***
    %_13 = load i8**, i8*** %_12
    %_14 = add i32 0, 0
    %_15 = getelementptr i8*, i8** %_13, i32 %_14 
    %_16 = load i8*, i8** %_15
    %_17 = bitcast i8* %_16 to i32 (i8*, i32)*
    %_18 = add i32 0, 1
    %_19 = call i32 %_17(i8* %_11, i32 %_18)

    call void (i32) @print_int(i32 %_19) 
    %_20 = load i8*, i8** %2 
    store i8* %_20, i8** %1
    %_21 = load i8*, i8** %1 
    %_22 = bitcast i8* %_21 to i8***
    %_23 = load i8**, i8*** %_22
    %_24 = add i32 0, 0
    %_25 = getelementptr i8*, i8** %_23, i32 %_24 
    %_26 = load i8*, i8** %_25
    %_27 = bitcast i8* %_26 to i32 (i8*, i32)*
    %_28 = add i32 0, 3
    %_29 = call i32 %_27(i8* %_21, i32 %_28)

    call void (i32) @print_int(i32 %_29) 
    %_30 = load i8*, i8** %2 
    %_31 = bitcast i8* %_30 to i8***
    %_32 = load i8**, i8*** %_31
    %_33 = add i32 0, 1
    %_34 = getelementptr i8*, i8** %_32, i32 %_33 
    %_35 = load i8*, i8** %_34
    %_36 = bitcast i8* %_35 to i32 (i8*)*
    %_37 = call i32 %_36(i8* %_30)

    call void (i32) @print_int(i32 %_37) 
    %_38 = add i32 0, 0
    ret i32 %_38
}
define i32 @Base.set(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 8
    %_3 = getelementptr i8, i8* %_0, i32 %_2 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_1, i32* %_4
    %_5 = add i32 0, 8
    %_6 = getelementptr i8, i8* %_0, i32 %_5 
    %_7 = bitcast i8* %_6 to i32*
    %_8 = load i32, i32* %_7
    ret i32 %_8
}
define i32 @Base.get(i8* %_0) {
    %_1 = add i32 0, 8
    %_2 = getelementptr i8, i8* %_0, i32 %_1 
    %_3 = bitcast i8* %_2 to i32*
    %_4 = load i32, i32* %_3
    ret i32 %_4
}
define i32 @Derived.set(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 2
    %_3 = mul i32 %_1, %_2
    %_4 = add i32 0, 8
    %_5 = getelementptr i8, i8* %_0, i32 %_4 
    %_6 = bitcast i8* %_5 to i32*
    store i32 %_3, i32* %_6
    %_7 = add i32 0, 8
    %_8 = getelementptr i8, i8* %_0, i32 %_7 
    %_9 = bitcast i8* %_8 to i32*
    %_10 = load i32, i32* %_9
    ret i32 %_10
}
