class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var best = 0

        while left < right {
            let width = right - left
            let waterLevel = min(height[left], height[right])
            best = max(best, width * waterLevel)

            if height[left] <= height[right] {
                left += 1
            } else {
                right -= 1
            }
        }

        return best
    }
}
