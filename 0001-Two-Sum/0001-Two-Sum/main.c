#include <stdio.h>
#include <stdlib.h>

int *twoSum(int *nums, int numsSize, int target) {
    
    int index1 = 0,index2 = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                if (nums[i] <= nums[j]) {
                    index1=i+1;
                    index2=j+1;
                } else {
                    index1=j+1;
                    index2=i+1;
                }
            }
        }
    }
    
    printf("[%d,%d]",index1,index2);
    int *array = (int *)malloc(sizeof(int) * 2);
    array[0] = index1;
    array[1] = index2;
    return array;
}

int main(int argc, const char * argv[]) {
    int nums[] = {2, 7, 11, 15};
    int *p = twoSum(nums, 4, 9);
    free(p);
    return 0;
}