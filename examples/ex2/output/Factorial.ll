@.Fac_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]

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
    %_4 = getelementptr [1 x i8*], [1 x i8*]* @.Fac_vtable, i32 0, i32 0 
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

define i32 @Fac.ComputeFac(i8* %_0, i32 %.1) {
    %1 = alloca i32
    store i32 %.1, i32* %1 
    %2 = alloca i32
    %_1 = load i32, i32* %1 
    %_2 = add i32 0, 1
    %_3 = icmp slt i32 %_1, %_2
    br i1 %_3, label %l0, label %l1
l0:
    %_4 = add i32 0, 1
    store i32 %_4, i32* %2
    br label %l2
l1:
    %_5 = load i32, i32* %1 
    %_6 = bitcast i8* %_0 to i8*
    %_7 = bitcast i8* %_6 to i8***
    %_8 = load i8**, i8*** %_7
    %_9 = add i32 0, 0
    %_10 = getelementptr i8*, i8** %_8, i32 %_9 
    %_11 = load i8*, i8** %_10
    %_12 = bitcast i8* %_11 to i32 (i8*, i32)*
    %_13 = load i32, i32* %1 
    %_14 = add i32 0, 1
    %_15 = sub i32 %_13, %_14
    %_16 = call i32 %_12(i8* %_6, i32 %_15)

    %_17 = mul i32 %_5, %_16
    store i32 %_17, i32* %2
    br label %l2
l2:
    %_18 = load i32, i32* %2 
    ret i32 %_18
}
