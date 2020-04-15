public class Main {
    public static void main(String[] args) {
        System.out.print(reverse(5678));
    }

    public static int reverse(int x) {
        long result = 0;
        while (x != 0) {
            result *= 10;
            result += x % 10;
            x /= 10;
        }
        if (result > Integer.MAX_VALUE || result < Integer.MIN_VALUE) return 0;
        return (int)result;
    }
}
