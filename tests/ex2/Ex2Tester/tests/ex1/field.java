class Main {
    public static void main(String[] args) {
        System.out.println((new Example()).run());
    }
}

class Example {
    int x;

    int run() {
        x = 0;
        return (x) + (x);
    }

    int other() {
        int x;
        x = 1;
        return (x) - (1);
    }

}

