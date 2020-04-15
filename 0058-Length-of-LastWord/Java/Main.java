public class Main {
    public static void main(String[] args) {
        System.out.print(lengthOfLastWord("Hello World"));
    }

    public static int lengthOfLastWord(String s) {
        if (s.trim().length() == 0) return 0;
        String[] str = s.split(" ");
        String lastStr = str[str.length - 1];
        return lastStr.length();
    }
}
