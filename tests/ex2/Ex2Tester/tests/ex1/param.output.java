class Main {
    public static void main(String[] args) {
        System.out.println((new Example()).run(3));
    }
} 

class Example {
	int x;

	int run(int y) {
		y = 0;
		return (y) + (y);
	}

	int other() {
		int x;
		x = 1;
		return (x) - (1);
	}

}

