class Solution {
  List<int> twoSum(List<int> nums, int target) {
    final Map<int, int> indexByNumber = {};
    for (final (index, number) in nums.indexed) {
      final int needed = target - number;
      final int? previousIndex = indexByNumber[needed];
      if (previousIndex != null) {
        return [previousIndex, index];
      }
      indexByNumber[number] = index;
    }
    return [];
  }
}
