class Main {
	public static void main(String[] a) {
	    System.out.println(new Simple().bar());
	}
}

class Simple {
	public int bar() {
	    int[] x;
	    x = new int[2];

        x[0] = 1;
        x[1] = 2;

	    System.out.println((x[0]) + (x[1]));
	    
	    return 0;
	}
} 