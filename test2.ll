@.Classes_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*)* @Classes.run to i8*)]

@.Base_vtable = global [2 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Base.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

@.Derived_vtable = global [1 x i8*] [
   i8* bitcast (i32 (i8*, i32)* @Derived.set to i8*), 
   i8* bitcast (i32 (i8*)* @Base.get to i8*)]

define i32 @Classes.run(i8* %0) {
    %0 = alloca i8*
    %1 = alloca i8*

    %_2 = add i32 0, 12
    %_3 = add i32 0, 1
    %_6 = call i8* @calloc(i32 %_3, i32 %_2)
    %_4 = bitcast i8* %_6 to i8***
    %_5 = getelementptr [0 x i8*], [0 x i8*]* @.Base_vtable, i32 0 
    store i8** %_5, i8*** %_4 

    store i8* %_6 i8** %0

    %_7 = add i32 0, 20
    %_8 = add i32 0, 1
    %_11 = call i8* @calloc(i32 %_8, i32 %_7)
    %_9 = bitcast i8* %_11 to i8***
    %_10 = getelementptr [0 x i8*], [0 x i8*]* @.Derived_vtable, i32 0 
    store i8** %_10, i8*** %_9 

    store i8* %_11 i8** %1
    %_12 = load i8*, i8** %0 
    %_13 = bitcast i8* %_12 to i8***
    %_14 = load i8**, i8*** %_13
    %_15 = add i32 0, 0
    %_16 = getelementptr i8*, i8** %_14, i32 %_15 
    %_17 = load i8*, i8** %_16
    %_18 = bitcast i8* %_17 to i8*, i32)*
    %_19 = add i32 0, 1
    %_20 = call i32 %_18(i8* %_12, i32 %_19)

    call void (i32) @print_int(i32 %_20) 
    %_21 = load i8*, i8** %1 
    store i8* %_21 i8** %0
    %_22 = load i8*, i8** %0 
    %_23 = bitcast i8* %_22 to i8***
    %_24 = load i8**, i8*** %_23
    %_25 = add i32 0, 0
    %_26 = getelementptr i8*, i8** %_24, i32 %_25 
    %_27 = load i8*, i8** %_26
    %_28 = bitcast i8* %_27 to i8*, i32)*
    %_29 = add i32 0, 3
    %_30 = call i32 %_28(i8* %_22, i32 %_29)

    call void (i32) @print_int(i32 %_30) 
    %_31 = load i8*, i8** %1 
    %_32 = bitcast i8* %_31 to i8***
    %_33 = load i8**, i8*** %_32
    %_34 = add i32 0, 1
    %_35 = getelementptr i8*, i8** %_33, i32 %_34 
    %_36 = load i8*, i8** %_35
    %_37 = bitcast i8* %_36 to i8*)*
    %_38 = call i32 %_37(i8* %_31)

    call void (i32) @print_int(i32 %_38) 
    %_39 = add i32 0, 0
}
define i32 @Base.set(i8* %0, i32 %.0) {
    %0 = alloca i32
    store i32 %.0, i32* %0 
    %_2 = load i32, i32* %0 
    %_3 = getelementptr i8, i8* %_1, i32 %_8 
    %_4 = bitcast i8* %_3 to i32*
    store i32 %_2 i32* %_4
    %_5 = getelementptr i8, i8* %_1, i32 %_8 
    %_6 = bitcast i8* %_5 to i32*
    %_7 = load i32, i32* %_6
    %_9 = getelementptr i8, i8* %_8, i32 %_8 
    %_10 = bitcast i8* %_9 to i32*
    %_11 = load i32, i32* %_10
}
define i32 @Base.get(i8* %1) {
}
define i32 @Derived.set(i8* %0, i32 %.0) {
    %0 = alloca i32
    store i32 %.0, i32* %0 
    %_2 = load i32, i32* %0 
    %_3 = add i32 0, 2
    %_4 = mul i32 %_2 %_3
    %_5 = getelementptr i8, i8* %_1, i32 %_8 
    %_6 = bitcast i8* %_5 to i32*
    store i32 %_4 i32* %_6
    %_7 = getelementptr i8, i8* %_1, i32 %_8 
    %_8 = bitcast i8* %_7 to i32*
    %_9 = load i32, i32* %_8
}
