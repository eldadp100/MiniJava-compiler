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

    %_13 = add i32 0, 12
    %_14 = add i32 0, 1
    %_17 = call i8* @calloc(i32 %_14, i32 %_13)
    %_15 = bitcast i8* %_17 to i8***
    %_16 = getelementptr [0 x i8*], [0 x i8*]* @.Base_vtable, i32 0 
    store i8** %_16, i8*** %_15 

    store i8* %_17 i8** %1

    %_18 = add i32 0, 20
    %_19 = add i32 0, 1
    %_22 = call i8* @calloc(i32 %_19, i32 %_18)
    %_20 = bitcast i8* %_22 to i8***
    %_21 = getelementptr [0 x i8*], [0 x i8*]* @.Derived_vtable, i32 0 
    store i8** %_21, i8*** %_20 

    store i8* %_22 i8** %2
    %_23 = load i8*, i8** %1 
    %_24 = bitcast i8* %_23 to i8***
    %_25 = load i8**, i8*** %_24
    %_26 = add i32 0, 0
    %_27 = getelementptr i8*, i8** %_25, i32 %_26 
    %_28 = load i8*, i8** %_27
    %_29 = bitcast i8* %_28 to i8*, i32)*
    %_30 = add i32 0, 1
    %_31 = call i32 %_29(i8* 23, i32 30)

    call void (i32) @print_int(i32 %_31) 
    %_32 = load i8*, i8** %2 
    store i8* %_32 i8** %1
    %_33 = load i8*, i8** %1 
    %_34 = bitcast i8* %_33 to i8***
    %_35 = load i8**, i8*** %_34
    %_36 = add i32 0, 0
    %_37 = getelementptr i8*, i8** %_35, i32 %_36 
    %_38 = load i8*, i8** %_37
    %_39 = bitcast i8* %_38 to i8*, i32)*
    %_40 = add i32 0, 3
    %_41 = call i32 %_39(i8* 33, i32 40)

    call void (i32) @print_int(i32 %_41) 
    %_42 = load i8*, i8** %2 
    %_43 = bitcast i8* %_42 to i8***
    %_44 = load i8**, i8*** %_43
    %_45 = add i32 0, 1
    %_46 = getelementptr i8*, i8** %_44, i32 %_45 
    %_47 = load i8*, i8** %_46
    %_48 = bitcast i8* %_47 to i8*)*
    %_49 = call i32 %_48(i8* 42)

    call void (i32) @print_int(i32 %_49) 
    %_50 = add i32 0, 0
    %3 = alloca i32
}
define i32 @Base.set(i8* %4, i32 %.5) {
    %5 = alloca i32
    store i32 %.5, i32* %5 
    %_51 = load i32, i32* %5 
    store i32 %_51 i32* %3
    %_52 = load i32, i32* %3 
    %_53 = load i32, i32* %3 
}
define i32 @Base.get(i8* %6) {
}
define i32 @Derived.set(i8* %7, i32 %.8) {
    %8 = alloca i32
    store i32 %.8, i32* %8 
    %_54 = load i32, i32* %8 
    %_55 = add i32 0, 2
    %_56 = mul i32 %_54 %_55
    store i32 %_56 i32* %3
    %_57 = load i32, i32* %3 
}
