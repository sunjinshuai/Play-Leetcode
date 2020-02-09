public class Main {

    // 时间复杂度 O(2^N)
    public static int fib1(int N) {
        if (N <= 1) return N;
        return fib1(N - 1) + fib1(N - 2);
    }

    // 时间复杂度 O(N)
    public static int fib2(int N) {
        int firstNum = 0;
        int secondNum = 1;
        for (int i = 0; i < N; i++) {
            secondNum += firstNum;
            firstNum = secondNum - firstNum;
        }
        return secondNum;
    }

    public static void main(String[] args) {
        System.out.println(fib2(2));
        System.out.println(fib2(3));
        System.out.println(fib2(4));
        System.out.println(fib2(5));
    }
}
