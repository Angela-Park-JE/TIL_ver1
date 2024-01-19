    nums = []
    for i in dots:
        for j in i:
            nums.append(j)
    nums = sorted(list(set(nums)))
    if len(nums) == 2:
        answer = (nums[1]-nums[0])*(nums[1]-nums[0])
    elif len(nums) == 3:
        answer = (nums[1]-nums(0))*(nums[2]-nums[0])
    else:
        answer = (nums[3]-nums[1])*(nums[2]-nums[0])
        
