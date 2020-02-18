public class Main {
    public static void main(String[] args) {
        System.out.println(strStr("haystack", "ll"));
    }

    public static int strStr(String haystack, String needle) {
        return haystack.indexOf(needle);
    }
}
