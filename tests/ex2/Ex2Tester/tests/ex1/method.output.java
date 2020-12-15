class Main {
    public static void main(String[] args) {
        System.out.println((new Example()).flee());
    }
} 

class Example {	
	int flee() {
		Example e;
		e = new Example();
		return (e).flee();
	}

}

class NonExample {
	int run() {
		return (new NonExample()).run();
	}

}

