import Foundation

//
// You are the owner of a cemetery in New York with 18 meter deep graves.
//
// You are given a shipment of coffins. Their heights are represented by integers.
//
// You must pack the coffins into as few graves as possible.
//
// So, the sum of the coffin heights packed into each grave should not exceed 18.
//
// Input: List of coffin heights. (in meters)
//
// Output: List of graves with the heights of the coffins packed into them.
//
// ===========================
//
// Example 1:
//
// Input: [6, 10, 7, 6, 5, 2]
//
// Possible Solution:
//
// [6, 10, 2]
// [7, 6, 5]
//
// ===========================
//
// Example 2:
//
// Input: [7, 2, 9, 6, 2, 8, 5, 4, 2, 2, 7]
//
// Possible Solution:
//
// [7, 2, 9]
// [6, 2, 8, 2]
// [5, 4, 2, 7]
//

struct Grave {
    var coffins: [Int] = []
}

func packCoffinsInGraves(coffinHeights: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    if coffinHeights.count <= 0 { return result }
    var found = false
    for numberOfCoffins in 1...coffinHeights.count {
        
        if found { break }
        
        var test = [Grave](repeating: Grave(), count: numberOfCoffins)
        var placement = [Int](repeating: 0, count: coffinHeights.count)
        
        func helper(coffinIndex: Int) {
            if found { return }
            
            if coffinIndex == coffinHeights.count {
                found = true
                result = test.map {
                    $0.coffins
                }
                return
            }
            
            for placementIndex in 0..<numberOfCoffins {
                placement[coffinIndex] = placementIndex
                
                if test[placementIndex].coffins.reduce(0, +) + coffinHeights[coffinIndex] > 18 {
                    continue
                }
                
                test[placementIndex].coffins.append(coffinHeights[coffinIndex])
                helper(coffinIndex: coffinIndex + 1)
                test[placementIndex].coffins.removeLast()
            }
        }
        helper(coffinIndex: 0)
    }
    return result
}

// ===========================

let test_1_coffins = [6, 10, 7, 6, 5, 2]
let test_1_result = packCoffinsInGraves(coffinHeights: test_1_coffins)
print("test 1 results:")
for coffins in test_1_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [6, 10, 2]
// [7, 6, 5]

// ===========================

let test_2_coffins = [2, 6, 9, 3, 9, 6]
let test_2_result = packCoffinsInGraves(coffinHeights: test_2_coffins)
print("test 2 results:")
for coffins in test_2_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [2, 6, 9]
// [3, 9, 6]

// ===========================

let test_3_coffins = [10, 11]
let test_3_result = packCoffinsInGraves(coffinHeights: test_3_coffins)
print("test 3 results:")
for coffins in test_3_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [10]
// [11]

// ===========================

let test_4_coffins = [1, 2, 3, 1, 2, 3, 1, 2, 3]
let test_4_result = packCoffinsInGraves(coffinHeights: test_4_coffins)
print("test 4 results:")
for coffins in test_4_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [1, 2, 3, 1, 2, 3, 1, 2, 3]

// ===========================

let test_5_coffins = [6, 1, 8, 3, 4, 6, 6, 4, 2, 8, 6]
let test_5_result = packCoffinsInGraves(coffinHeights: test_5_coffins)
print("test 5 results:")
for coffins in test_5_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [6, 1, 8, 3]
// [4, 6, 6, 2]
// [4, 8, 6]

// ===========================

let test_6_coffins = [7, 2, 9, 6, 2, 8, 5, 4, 2, 2, 7]
let test_6_result = packCoffinsInGraves(coffinHeights: test_6_coffins)
print("test 6 results:")
for coffins in test_6_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [7, 2, 9]
// [6, 2, 8, 2]
// [5, 4, 2, 7]

// ===========================

let test_7_coffins = [18]
let test_7_result = packCoffinsInGraves(coffinHeights: test_7_coffins)
print("test 7 results:")
for coffins in test_7_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [18]

// ===========================

let test_8_coffins: [Int] = []
let test_8_result = packCoffinsInGraves(coffinHeights: test_8_coffins)
print("test 8 results:")
for coffins in test_8_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// (No Results)

// ===========================

let test_9_coffins = [6, 9, 8, 1, 7, 2, 4, 4, 3, 7, 5, 4, 3, 9]
let test_9_result = packCoffinsInGraves(coffinHeights: test_9_coffins)
print("test 9 results:")
for coffins in test_9_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [6, 9, 1, 2]
// [8, 7, 3]
// [4, 4, 7, 3]
// [5, 4, 9]

// ===========================

let test_10_coffins = [8, 4, 5, 7, 4, 6, 1]
let test_10_result = packCoffinsInGraves(coffinHeights: test_10_coffins)
print("test 10 results:")
for coffins in test_10_result {
    print(coffins)
}
print("===========================")

// Expected Result:
// [8, 4, 5, 1]
// [7, 4, 6]

// ===========================
