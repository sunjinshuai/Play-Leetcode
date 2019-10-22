package com.company;
import java.util.Stack;

public class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<Character>();
        for (int i= 0; i < s.length(); i++) {
            Character tempChar = s.charAt(i);
            if (tempChar == '(' || tempChar == '{' || tempChar == '[') {
                stack.push(tempChar);
            } else {
                if (stack.size() == 0) {return false;}
                Character lastChar = stack.peek();
                if (isPairMatch(lastChar, tempChar)) {
                    stack.pop();
                } else {
                    return false;
                }
            }
        }
        return stack.isEmpty();
    }

    public boolean isPairMatch(Character leftPair, Character rightPair) {
        return (leftPair == '(' && rightPair == ')') || (leftPair == '{' && rightPair == '}') || (leftPair == '[' && rightPair == ']');
    }
}
