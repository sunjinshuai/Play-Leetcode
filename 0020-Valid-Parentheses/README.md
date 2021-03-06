#### 题目描述
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：

* 左括号必须用相同类型的右括号闭合。
* 左括号必须以正确的顺序闭合。

注意空字符串可被认为是有效字符串。

示例 1:

```
输入: "()"
输出: true
```

示例 2:

```
输入: "()[]{}"
输出: true
```

示例 3:

```
输入: "(]"
输出: false
```

示例 4:

```
输入: "([)]"
输出: false
```

示例 5:

```
输入: "{[]}"
输出: true
```

#### 题目解析
验证输入的字符串是否为括号字符串，包括大括号，中括号和小括号；根据栈的特性是先进后出，后进先出的特点，可以用栈来解决这种问题。

#### 代码思路描述：
* 遍历输入字符串
* 如果当前字符为左半边括号时，则将其压入栈中；
* 如果遇到右半边括号时，分类讨论：</br>
1）如栈不为空且为对应的左半边括号，则取出栈顶元素，继续循环；</br>
2）若此时栈为空，则直接返回 false；</br>
3）若不为对应的左半边括号，反之返回 false；</br>

