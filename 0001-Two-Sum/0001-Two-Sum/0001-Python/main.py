class Solution(object):
    def twoSum(self, nums, target):
        for i in xrange(len(nums) - 1):
            for j in xrange(i+1, len(nums)):
                if nums[i] + nums[j] == target:
                    return [i, j]

so = Solution()
print(so.twoSum([3,2,4], 6))                  