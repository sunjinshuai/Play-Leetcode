class Solution {
  List<List<String>> groupAnagrams(List<String> strs) {
    final groups = <String, List<String>>{};
    for (final word in strs) {
      final codes = word.codeUnits.toList()..sort();
      final key = String.fromCharCodes(codes);
      groups.putIfAbsent(key, () => <String>[]).add(word);
    }
    return groups.values.toList();
  }
}
