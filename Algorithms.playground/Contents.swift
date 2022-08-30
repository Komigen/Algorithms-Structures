import Foundation

var list = [0,8,3,5,1,6,4,9,2,7]
var listSort = [0,1,2,3,4,5,6,7,8,9]


//MARK: Рекурсия

func recSum(numList: [Int]) -> Int {
    let size = numList.count
    assert(size > 0)
    return size == 1 ? numList.first! : recSum(numList: Array(numList[1..<size]))
}

func numStringConvert(num: Int, base: Int) -> String {
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F",]

    if (num < base) {
        return numbers[num]
    } else {
        return numStringConvert(num: num / base, base: base) + numbers[num % base]
    }
}


//MARK: - Сортировка пузырьком (n^2) -

func bubbleSort<T: Comparable>(list: inout [T]) -> [T] {
    let maxIndex = list.count - 1
    
    for i in 0...maxIndex {
        let index = maxIndex - i
        
        for j in 0..<index {
            
            if list[j] > list[j + 1] {
                (list[j + 1], list[j]) = (list[j], list[j + 1])
            }
        }
    }
    return list
}

//MARK: Сортировка слиянием - MergeSort (nlogn)

func merge<T: Comparable>(left: [T], right: [T]) -> [T] {
    var mergedArray = [T]()
    var left = left
    var right = right
    
    while left.count > 0 && right.count > 0 {
        
        if left.first! < right.first! {
            mergedArray.append(left.removeFirst())
        } else {
            mergedArray.append(right.removeFirst())
        }
    }
    return mergedArray + left + right
}


func mergeSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    let leftArray = Array(array[0..<array.count/2])
    let rightArray = Array(array[array.count/2..<array.count])
    
    return merge(left: mergeSort(array: leftArray), right: mergeSort(array: rightArray))
}

/*
 divide  :  O(n)
 conquer :  T(n) = > 2 * T(n / 2) : O(logn)
 combine :  O(n) = > O(nlogn)
 */

//MARK: Сортировки подсчётом (n^2) создается доп. массивы

func countingSort(list: [Int], maxVal: Int) -> [Int] {
    let size = list.count

    guard size > 1 else { return list }

    var container = Array(repeatElement(0, count: maxVal + 1))

    for value in list {
        container[value] += 1
    }

    var sortedList = Array(repeatElement(0, count: size))
    var i = 0

    for value in 0...maxVal {
        for _ in 0..<container[value] {
            sortedList[i] = value
            i += 1
        }
    }
    return sortedList
}

//MARK: Сортировки выбором (n^2)

func selectionSort<T: Comparable>(list: [T]) -> [T] {
    guard list.count > 1 else { return list }

    var list = list

    for index in 0..<list.count {
        var low = index

        for i in (low + 1)..<list.count {
            if list[i] < list[low] {
                low = i
            }
        }
        if index != low {
            (list[index], list[low]) = (list[low], list[index])
        }
    }
    return list
}


//MARK: Сортировка вставкой (O(n) - O(n^2))

func insertionSort<T: Comparable>(list: [T]) -> [T] {
    guard list.count > 1 else { return list }

    var list = list

    for i in 1..<list.count {

        var j = i
        while j > 0 && list[j - 1] > list[j] {
            (list[j], list[j - 1]) = (list[j - 1], list[j])
            j -= 1
        }
    }
    return list
}

insertionSort(list: list)

//MARK: Быстрая сортировка (n^2)

/* v1 */

func quickSort1<T: Comparable>(list: [T]) -> [T] {
    guard list.count > 1 else { return list }
    
    var less = [T]()
    var equal = [T]()
    var greater = [T]()
    
    let pivot = list[1]
    
    for element in list {
        if element < pivot {
            less.append(element)
        } else if element == pivot {
            equal.append(element)
        } else {
            greater.append(element)
        }
    }
    return quickSort1(list: less) + equal + quickSort1(list: greater)
}

/* v2 - swift style*/

func quickSort2<T: Comparable>(list: [T]) -> [T] {
    guard list.count > 1 else { return list }
    let pivot = list[0]
    let sublist = list
    
    let less = sublist.filter{ $0 < pivot }
    let equal = sublist.filter{ $0 == pivot }
    let greater = sublist.filter{ $0 > pivot }
    
    return quickSort2(list: less) + equal + quickSort2(list: greater)
}

/* v3 - без создания доп. массивов */

func quickSort3<T: Comparable>(list: inout [T], start: Int, end: Int) {
    guard end - start < 2 else { return }

    let pivot = list[start + (end - start) / 2]
    var low = start
    var high = end - 1

    while (low <= high) {
        if list[low] < pivot {
            low += 1
            continue
        }

        if list[high] > pivot {
            high -= 1
            continue
        }

        (list[low], list[high]) = (list[high], list[low])
        low += 1
        high -= 1
    }

    quickSort3(list: &list, start: start, end: high + 1)
    quickSort3(list: &list, start: high + 1, end: end)
}

//MARK: - Бинарный поиск (log(n)) -

func binarySearch<T: Comparable>(key: T, array: [T]) -> Int? {
    var lowIndex = 0
    var highIndex = array.count - 1
    
    while lowIndex <= highIndex {
        let midIndex = lowIndex + (highIndex - lowIndex) / 2
        
        if key < array[midIndex] {
            highIndex = midIndex - 1
        } else if key > array[midIndex] {
            lowIndex = midIndex + 1
        } else {
            return midIndex
        }
    }
    return nil
}



//MARK: - Структуры данных - Stack -

struct Stack<T> {
    
    var container = [T]()
    
    var isEmpty: Bool {
        get {
            return container.isEmpty
        }
    }
    
    var top: T? {
        get {
            return container.last
        }
    }
    
    var size: Int {
        get {
            return container.count
        }
    }
    
    mutating func push(elem: T) {
        container.append(elem)
    }
    
    
    mutating func pop() -> T? {
        if !isEmpty {
            return container.removeLast()
        } else {
            return nil
        }
    }
}

//MARK: Структуры данных - Queue

struct Queue<T: CustomStringConvertible> {
    
    var description: String {
        return container.description
    }
    
    var container = [T]()
    
    var isEmpty: Bool {
        get {
            return container.isEmpty
        }
    }
    
    var size: Int {
        get {
            return container.count
        }
    }
    
    var head: T? {
        get {
            return container.first
        }
    }
    
    var tail: T? {
        get {
            return container.last
        }
    }
    
    mutating func enqueue(elem: T) {
        container.append(elem)
    }
    
    mutating func dequeue() -> T? {
        if !isEmpty {
            return container.removeFirst()
        }
        return nil
    }
}

//MARK: Структуры данных - linked list

class ListNode<T> {
    
    var item: T
    var next: ListNode?
    var previous: ListNode<T>?
    
    init(item: T) {
        self.item = item
    }
}

struct LinkedList<T> {
    
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    var first: ListNode<T>? {
        return head ?? nil
    }
    
    var last: ListNode<T>? {
        return tail ?? nil
    }
    
    var size: Int {
        var current = head
        var counter = 0
        while current != nil {
            current = current?.next
            counter += 1
        }
        return counter
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var description: String {
        var text = "["
        var node = head
        
        while node != nil {
            text += "\(node!.item)"
            node = node?.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
    
    mutating func append(item: T) {
        
        let newNode = ListNode(item: item)
        
        if tail != nil {
            newNode.previous = tail
            tail?.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    mutating func remove(node: ListNode<T>) -> T? {
        guard !isEmpty else { return nil }
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        node.previous = nil
        node.next = nil
        
        return node.item
    }
}

extension LinkedList: CustomStringConvertible {
    
}

//var linkedList = LinkedList<Int>()
//linkedList.append(item: 1)
//linkedList.append(item: 2)
//linkedList.append(item: 3)
//linkedList.description

//TASK 1: Reverse solution

func reverseList(head: ListNode<Any>?) -> ListNode<Any>? {
    
    var currentNode = head
    var prev: ListNode<Any>?
    var next: ListNode<Any>?
    
    while currentNode != nil {
        next = currentNode?.next
        currentNode?.next = prev
        prev = currentNode
        currentNode = currentNode?.next
    }
    return prev
}


//MARK: Binary Tree

class Node: CustomStringConvertible {
    
    var description: String {
        return String(value)
    }
    
    var value: Int
    let left: Node?
    let right: Node?
    
    init(value: Int, left: Node?, right: Node?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

//TASK 1: Поиск в ширину

func search(searchValue: Int, node: Node?) -> Bool {
    guard node != nil else { return false }
    
    if node?.value == searchValue {
        return true
    } else if searchValue < node!.value {
        return search(searchValue: searchValue, node: node?.left)
    } else {
        return search(searchValue: searchValue, node: node?.right)
    }
}

//TASK 2: Поиск max глубины бинарного дерева

func maxDepth(head: Node?) -> Int {
    
    guard let head = head else { return 0 }
    var maxLevel = 0
    
    var queue = Queue<Node>()
    queue.enqueue(elem: head)
    
    while !queue.isEmpty {
        maxLevel += 1
        
        let count = queue.container.count
        
        for _ in 0..<count {
            
            let current = queue.dequeue()
            
            if let left = current?.left {
                queue.enqueue(elem: left)
            }
            if let right = current?.right {
                queue.enqueue(elem: right)
            }
        }
    }
    return maxLevel
}

//MARK Структуры данных - дек == двусторонняя очередь
//MARK Хеш-таблицы == Dictionary (O(1))
//MARK Красно-чёрное дерево

//MARK Алгоритм Дейкстры (...) GRAF - взвешенный
//MARK Жадный алгоритм поиска (n^2) - для сложных задач Коммивояжера

//MARK Динамическое программирование (n^2) - таблицы
//MARK Алгоритм К - ближайших соседей (...)

//MARK MapReduce - распределенные алгоритмы
//MARK Преобразование Фурье
