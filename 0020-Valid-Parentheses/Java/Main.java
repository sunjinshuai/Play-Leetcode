package com.company;
public class Main {

    public static void main(String[] args) {

        printBool((new Solution()).isValid("){"));
        printBool((new Solution()).isValid("()[]{}"));
        printBool((new Solution()).isValid("(]"));
        printBool((new Solution()).isValid("([)]"));
    }

    private static void printBool(boolean b) {
        System.out.println(b ? "True" : "False");
    }
}

