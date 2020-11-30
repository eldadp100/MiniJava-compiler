@.Classes_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*)* @Classes.run to i8*)]

@.Base_vtable = global [2 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Base.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

@.Derived_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Derived.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

define i32 @Classes.run(i8* %0) {
    %1 = alloca i8*
    %2 = alloca i8*
    store i8* %_1 i8** %1
    store i8* %_1 i8** %2
    %_2 = load i8*, i8** %1 
    %_3 = add i32 0, 1
    call void (i32) @print_int(i32 %_4) 
    %_5 = load i8*, i8** %2 
    store i8* %_5 i8** %1
    %_6 = load i8*, i8** %1 
    %_7 = add i32 0, 3
    call void (i32) @print_int(i32 %_8) 
    %_9 = load i8*, i8** %2 
    call void (i32) @print_int(i32 %_10) 
    %_11 = add i32 0, 0
    %3 = alloca i32
}
define i32 @Base.set(i8* %4, i32 %.5) {
    %5 = alloca i32
    store i32 %.5, i32* %5 
    %_12 = load i32, i32* %5 
    store i32 %_12 i32* %3
    %_13 = load i32, i32* %3 
    %_14 = load i32, i32* %3 
}
define i32 @Base.get(i8* %6) {
}
define i32 @Derived.set(i8* %7, i32 %.8) {
    %8 = alloca i32
    store i32 %.8, i32* %8 
    %_15 = load i32, i32* %8 
    %_16 = add i32 0, 2
    %_17 = mul i32 %_15 %_16
    store i32 %_17 i32* %3
    %_18 = load i32, i32* %3 
}
