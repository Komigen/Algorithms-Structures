import Foundation

var list = [0,8,3,5,1,6,4,9,2,7]
var listSort = [0,1,2,3,4,5,6,7,8,9]
var listSortDuplicates = [0,1,1,2,3,3,4,5,6,6]



/* MARK: Short solution leetcode

1. Two Sum
    HashTable
 
70. Climbing Stairs
    Dynamic programming
 
104. Maximum Depth of Binary Tree
    return max(maxDepth(root.left), maxDepth(root.right)) + 1
 
136. Single Number
    var result = 0
    for i in nums { result ^= i }
    return result
 
168. Majority Element
    sorted -> nums[mid]

 
217. Contains Duplicate
    return Set(nums).count != nums.count

226. Invert Binary Tree
    recursion
 
268. Missing Number
    Gauss' formula
 
448. Find All Numbers Disappeared in an Array
    return Array(Set(1...nums.count).subtracting(nums)
 
977. Squares of a Sorted Array
    map -> sorted
 
 */



