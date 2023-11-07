import Foundation

//
// You are a character in a video game walking through a 2-D grid of Characters.
//
// The values in the Character grid are all "." or "x"
//
// "." represents blank space
// "x" represents a wall
//
// You are given:
// 1.) The grid
// 2.) A starting point (startPoint)
// 2.) An ending point (endPoint)
//
// Find the shortest path from startPoint to endPoint.
//
// You cannot step onto "x" tiles, you can only step onto "." tiles.
//
// From any tile, you can move up, right, down, and left (no diagonals).
//
// If there are ties, return any one of the solutions.
//
// If there is no path, return an empty array.
//
// ===========================
//
// Example 1:
//
// Grid:
//    .|x|.
//    .|x|.
//    .|.|.
//    x|x|x
//
// Start Point:
// {0, 0}
//
// End Point:
// {2, 0}
//
// Expected Result:
// {0, 0}
// {0, 1}
// {0, 2}
// {1, 2}
// {2, 2}
// {2, 1}
// {2, 0}
//
// ===========================
//
// Example 2:
//
// Grid:
//    .|.|x|.|.
//    .|.|x|.|.
//    .|.|x|.|.
//
// Start Point:
// {0, 1}
//
// End Point:
// {4, 1}
//
// Expected Result:
// (No Path)
//
// ===========================

struct GridPoint {
    let x: Int
    let y: Int
}

extension GridPoint: CustomStringConvertible {
    var description: String { "{\(x), \(y)}" }
}

func shortestPath(from startPoint: GridPoint, to endPoint: GridPoint, in grid: [[Character]]) -> [GridPoint] {
    []
}

let test_1_string =
"""
.|x|.
.|x|.
.|.|.
x|x|x
"""
let test_1 = grid(from: test_1_string)
let test_1_result = shortestPath(from: GridPoint(x: 0, y: 0),
                           to: GridPoint(x: 2, y: 0),
                           in: test_1)
print("test 1 results:")
for point in test_1_result {
    print(point)
}
print("===========================")

// Expected Result:
// {0, 0}
// {0, 1}
// {0, 2}
// {1, 2}
// {2, 2}
// {2, 1}
// {2, 0}

// ===========================

let test_2_string =
"""
.|x|x|.
.|.|.|.
x|x|x|.
.|.|.|.
"""
let test_2 = grid(from: test_2_string)
let test_2_result = shortestPath(from: GridPoint(x: 0, y: 3),
                           to: GridPoint(x: 3, y: 0),
                           in: test_2)
print("test 2 results:")
for point in test_2_result {
    print(point)
}
print("===========================")

// Expected Result:
// {0, 3}
// {1, 3}
// {2, 3}
// {3, 3}
// {3, 2}
// {3, 1}
// {3, 0}

// ===========================

let test_3_string =
"""
.|x|.|.|.|.
.|x|.|x|.|x
.|.|.|.|.|.
.|x|.|x|x|x
.|x|.|.|.|.
"""
let test_3 = grid(from: test_3_string)
let test_3_result = shortestPath(from: GridPoint(x: 5, y: 2),
                           to: GridPoint(x: 5, y: 0),
                           in: test_3)
print("test 3 results:")
for point in test_3_result {
    print(point)
}
print("===========================")

// Expected Result:
// {5, 2}
// {4, 2}
// {4, 1}
// {4, 0}
// {5, 0}

// ===========================

let test_4_string =
"""
.|.|.|.|.|.
.|.|.|.|.|.
.|.|.|.|.|.
.|.|.|.|.|.
.|.|.|.|.|.
"""
let test_4 = grid(from: test_4_string)
let test_4_result = shortestPath(from: GridPoint(x: 3, y: 4),
                           to: GridPoint(x: 3, y: 0),
                           in: test_4)
print("test 4 results:")
for point in test_4_result {
    print(point)
}
print("===========================")

// Expected Result:
// {3, 4}
// {3, 3}
// {3, 2}
// {3, 1}
// {3, 0}

// ===========================

let test_5_string =
"""
.|.|.|.|.|.
.|.|x|x|.|.
.|.|x|x|.|.
.|.|x|x|.|.
.|.|.|.|.|.
"""
let test_5 = grid(from: test_5_string)
let test_5_result = shortestPath(from: GridPoint(x: 0, y: 2),
                           to: GridPoint(x: 5, y: 2),
                           in: test_5)
print("test 5 results:")
for point in test_5_result {
    print(point)
}
print("===========================")

// Possible Result:
// {0, 2}
// {0, 3}
// {1, 3}
// {1, 4}
// {2, 4}
// {3, 4}
// {4, 4}
// {4, 3}
// {4, 2}
// {5, 2}

// ===========================

let test_6_string =
"""
.|.|x|.|.
.|.|x|.|.
.|.|x|.|.
"""
let test_6 = grid(from: test_6_string)
let test_6_result = shortestPath(from: GridPoint(x: 0, y: 1),
                           to: GridPoint(x: 4, y: 1),
                           in: test_6)
print("test 6 results:")
for point in test_6_result {
    print(point)
}
print("===========================")

// Expected Result:
// (No Path)

// ===========================

let test_7_string =
"""
.|x|.|.|.|x|x|.
.|x|.|x|.|x|.|.
.|.|.|x|.|.|.|x
x|x|.|x|.|x|.|x
.|.|.|x|.|.|.|.
.|x|.|.|.|x|x|.
.|x|.|x|x|.|.|.
.|.|.|.|.|.|.|.
"""
let test_7 = grid(from: test_7_string)
let test_7_result = shortestPath(from: GridPoint(x: 0, y: 0),
                           to: GridPoint(x: 7, y: 0),
                           in: test_7)
print("test 7 results:")
for point in test_7_result {
    print(point)
}
print("===========================")

// Expected Result:
// {0, 0}
// {0, 1}
// {0, 2}
// {1, 2}
// {2, 2}
// {2, 1}
// {2, 0}
// {3, 0}
// {4, 0}
// {4, 1}
// {4, 2}
// {5, 2}
// {6, 2}
// {6, 1}
// {7, 1}
// {7, 0}

// ===========================

func grid(from gridString: String) -> [[Character]] {
    let rows = gridString.split(separator: "\n")
        .map { String($0) }
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { $0.count > 0 }
    let inverted = rows.map {
        $0.split(separator: "|")
            .map { String($0) }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.count > 0 }
            .compactMap {
                Array($0).first
            }
    }
    let height = inverted.count
    guard height > 0 else { return [[Character]]() }
    let width = inverted[0].count
    guard width > 0 else { return [[Character]]() }
    var result = [[Character]](repeating: [Character](), count: width)
    for x in 0..<width {
        result[x] = [Character](repeating: ".", count: height)
        for y in 0..<height {
            result[x][y] = inverted[y][x]
        }
    }
    return result
}
