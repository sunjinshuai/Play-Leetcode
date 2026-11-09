class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [String: [String]] = [:]
        for word in strs {
            let key = String(word.sorted())
            groups[key, default: []].append(word)
        }
        return Array(groups.values)
    }
}
