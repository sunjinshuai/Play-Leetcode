#include <stdio.h>
#include <stdlib.h>

int *twoSum(int *nums, int numsSize, int target) {
    int *array = (int*)malloc(2*sizeof(int));
      for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; (j < numsSize && j != i); j++) {
            if (nums[i] + nums[j] == target) {
                array[0] = i;
                array[1] = j;
            }
        }
    }
    return array;
}

int main(int argc, const char * argv[]) {
    int nums[] = {2, 7, 11, 15, 1, 8};
    int *p = twoSum(nums, 6, 9);
    printf("[%d,%d]",p[0],p[1]);
    free(p);
    return 0;
}