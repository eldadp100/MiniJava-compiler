@.Simple_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @Simple.bar to i8*)]

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
define i32 @Simple.bar(i8* %this) {
	%x = alloca i32
	store i32 10, i32* %x
	%_0 = load i32, i32* %x
	%_1 = icmp slt i32 %_0, 2
	br i1 %_1, label %if0, label %if1
if0:
	call void (i32) @print_int(i32 0)
	br label %if2
if1:
	call void (i32) @print_int(i32 1)
	br label %if2
if2:
	ret i32 0
}
