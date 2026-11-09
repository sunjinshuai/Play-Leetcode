# 242. 有效的字母异位词

## 题目描述

给定两个由小写英文字母组成的字符串 `s` 和 `t`，判断 `t` 是否是 `s` 的字母异位词。

若两个字符串中每个字母的出现次数都相同，它们就是字母异位词。

## 示例

### 示例 1

```text
输入: s = "anagram", t = "nagaram"
输出: true
```

### 示例 2

```text
输入: s = "rat", t = "car"
输出: false
```

## 解题思路

### 方法一：排序比较

- 将两个字符串排序后比较是否相等。
- 时间复杂度 `O(n log n)`
- 额外空间复杂度 `O(n)`

```java
public boolean isAnagram(String s, String t) {
    if (s.length() != t.length()) return false;
    char[] sArr = s.toCharArray();
    char[] tArr = t.toCharArray();
    Arrays.sort(sArr);
    Arrays.sort(tArr);
    return Arrays.equals(sArr, tArr);
}
```

### 方法二：频次计数

- 使用长度为 26 的整型数组统计每个字母出现次数。
- 相同字母次数必须完全一致。
- 时间复杂度 `O(n)`
- 额外空间复杂度 `O(1)`，计数数组长度固定。

```java
public boolean isAnagram(String s, String t) {
    if (s.length() != t.length()) return false;
    int[] count = new int[26];
    for (int i = 0; i < s.length(); i++) {
        count[s.charAt(i) - 'a']++;
        count[t.charAt(i) - 'a']--;
    }
    for (int c : count) {
        if (c != 0) return false;
    }
    return true;
}
```

## 边界测试用例

| s        | t        | 输出   | 说明                   |
|----------|----------|--------|------------------------|
| "a"      | "a"      | true   | 单字符，完全相同       |
| "ab"     | "ba"     | true   | 两字符，顺序不同       |
| "abc"    | "abd"    | false  | 不同字母               |
| "aacc"   | "ccac"   | false  | 字母数量不一致         |

## 总结

- 该题是经典的字符串处理问题，考察字符串频率统计技巧。
- 对于只包含小写字母的情况，推荐使用计数法，效率更高。
- 字符集扩大到 Unicode 时，可以按码点遍历字符串，并用 `HashMap<Integer, Integer>` 统计频次。

## 相关题目推荐

- LeetCode 49. 字母异位词分组（Group Anagrams）
- LeetCode 567. 字符串的排列（Permutation in String）
