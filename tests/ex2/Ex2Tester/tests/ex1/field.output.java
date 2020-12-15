class Main {
    public static void main(String[] args) {
        System.out.println((new Example()).run());
    }
}

class Example {
    int y;

    int run() {
        y = 0;
        return (y) + (y);
    }

    int other() {
        int x;
        x = 1;
        return (x) - (1);
    }

}

