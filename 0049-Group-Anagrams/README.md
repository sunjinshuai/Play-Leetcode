# 49. 字母异位词分组

## 题意与示例

将字符串数组按字母异位词分组。两个字符串中每个字母的出现次数都相同，就属于同一组。输入只包含小写英文字母，允许空字符串，返回顺序不限。见[力扣原题](https://leetcode.cn/problems/group-anagrams/)。

| `strs` | 一种合法输出 |
| --- | --- |
| `["eat", "tea", "tan", "ate", "nat", "bat"]` | `[["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]` |
| `[""]` | `[[""]]` |
| `["aab", "aba", "abb", "aab"]` | `[["aab", "aba", "aab"], ["abb"]]` |

## 排序 + 哈希表

把每个词排序后的字符串当作分组标签。哈希表的键是这个标签，值是对应的一组原词。第 242 题也用排序结果判断两个词是否为异位词。[第 242 题题解](../0242-Valid%20Anagram/README.md)

1. 遍历每个词，把字符排序得到分组键。例如 `"eat"`、`"tea"`、`"ate"` 的键都是 `"aet"`。
2. 将原词追加到该键对应的列表。空字符串用 `""` 作键，重复出现的词每次都要追加。
3. 返回哈希表中的所有列表。

遍历第一组示例时，每次只更新当前键对应的列表。

| 读到的词 | 排序后的键 | 该键对应的列表 |
| --- | --- | --- |
| `eat` | `aet` | `[eat]` |
| `tea` | `aet` | `[eat, tea]` |
| `tan` | `ant` | `[tan]` |
| `ate` | `aet` | `[eat, tea, ate]` |
| `nat` | `ant` | `[tan, nat]` |
| `bat` | `abt` | `[bat]` |

排序去掉了原来的顺序，同时保留了每种字母的次数。两个异位词排序后一定相同，两个排序结果相同的词也一定是异位词，所以相同的键恰好对应同一组。

设有 `n` 个字符串，最长长度为 `k`。按单词排序 `O(k log k)`、哈希表平均查找估算，当 `k ≥ 2` 时，总时间为 `O(nk log k)`，额外空间为 `O(nk)`（不含返回结果）。当 `k ≤ 1` 时，处理全部输入只需 `O(n)` 时间。

## 各语言源码

| 语言 | 构造分组键 | 追加原词 |
| --- | --- | --- |
| [Java](Java/Solution.java) | `Arrays.sort` 排序字符数组 | `computeIfAbsent` 取出或创建列表 |
| [Swift](Swift/Solution.swift) | `sorted()` 后构造 `String` | 字典的 `default:` 下标直接追加 |
| [Dart](Dart/solution.dart) | 排序 `codeUnits` 后用 `String.fromCharCodes` 构造字符串 | `putIfAbsent` 取出或创建列表 |

### Swift

```swift
let key = String(word.sorted())
groups[key, default: []].append(word)
```

`word.sorted()` 返回字符数组，`String(...)` 将它拼回字符串。以 `tea` 为例，先得到字符数组 `["a", "e", "t"]`，再得到键 `aet`。

`groups[key, default: []]` 在键不存在时使用空数组。直接在这个下标上调用 `append`，会把更新后的数组存入字典。Swift 的数组是值类型。如果先取出数组放进局部变量再追加，需要把更新后的数组写回字典。

### Dart

```dart
final codes = word.codeUnits.toList()..sort();
final key = String.fromCharCodes(codes);
groups.putIfAbsent(key, () => <String>[]).add(word);
```

`codeUnits` 返回 UTF-16 编码单元。本题只有小写英文字母，每个字母对应一个编码单元，按数值排序就是按字母顺序排序。`toList()` 创建可修改的列表，级联写法 `..sort()` 对它原地排序，整个表达式的值仍是这个列表。例如 `tea` 的编码从 `[116, 101, 97]` 排成 `[97, 101, 116]`，再由 `String.fromCharCodes` 转成键 `aet`。

`putIfAbsent` 在第一次遇到某个键时才调用回调创建空列表，之后直接返回已有列表。返回的是 Map 里存着的那个列表，所以 `add(word)` 会直接更新分组。

## 延伸：按字母频次分组

输入只有 `a` 到 `z`，也可以统计 26 个字母的次数，并将它们按固定顺序编码为键。这省去了排序，时间为 `O(n(k + 26))`。如果用字符串保存计数，记得加分隔符：`[1, 11]` 和 `[11, 1]` 直接拼接都会变成 `"111"`。
