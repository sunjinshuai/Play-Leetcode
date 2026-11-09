class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var indexByNumber: [Int: Int] = [:]
        for (index, number) in nums.enumerated() {
            let needed = target - number
            if let previousIndex = indexByNumber[needed] {
                return [previousIndex, index]
            }
            indexByNumber[number] = index
        }
        return []
    }
}
