public class Main {
    public static void main(String[] args) {
        int[] num = {2, 9, 9};
        System.out.print(Arrays.toString(plusOne(num)));
    }

    public static int[] plusOne(int[] digits) {
        for (int i = digits.length - 1; i >= 0; i--) {
            if (digits[i] == 9) {
                digits[i] = 0;
            }
            if (digits[i] != 0) {
                digits[i]++;
                return digits;
            }
        }
        digits = new int[digits.length + 1];
        digits[0] = 1;
        return digits;
    }
}
