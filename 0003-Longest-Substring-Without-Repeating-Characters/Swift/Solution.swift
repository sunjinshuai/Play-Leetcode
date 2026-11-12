class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var seen = Set<Character>()
        var left = 0
        var best = 0

        for (right, c) in chars.enumerated() {
            while seen.contains(c) {
                seen.remove(chars[left])
                left += 1
            }

            seen.insert(c)
            best = max(best, right - left + 1)
        }

        return best
    }
}
