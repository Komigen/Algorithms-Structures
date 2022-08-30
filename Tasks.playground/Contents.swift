import Foundation

var list = [0,8,3,5,1,6,4,9,2,7]
var listSort = [0,1,2,3,4,5,6,7,8,9]
var listSortDuplicates = [0,1,1,2,3,3,4,5,6,6]


//TASK 1: Найти пару чисел, которые дадут в сумме заданное число O(n)

func twoSum(array: [Int], target: Int) -> [Int] {
    var dict = [Int:Int]()
    for (i, n) in array.enumerated() {
        if let val = dict[target-n] { return [val, i] }
        dict[n] = i
    }
    return []
}

twoSum(array: list, target: 9)
