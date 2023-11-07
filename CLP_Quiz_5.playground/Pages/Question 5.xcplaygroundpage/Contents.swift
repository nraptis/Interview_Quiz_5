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
//
// Find the shortest path from startPoint that visits all "." tiles.
// You may need to visit the same tile twice.
//
// You cannot step onto "x" tiles, you can only step onto "." tiles.
//
// From any tile, you can move up, right, down, and left (no diagonals).
//
// If there are ties, return any one of the solutions.
//
// There is guaranteed to be a solution.
//
// ===========================
//
// Example 1:
//
// Grid:
//      x|.|x|x
//      .|.|.|.
//
// Start Point:
// {1, 0}
//
// Expected Result:
// {1, 0}
// {1, 1}
// {0, 1}
// {1, 1}
// {2, 1}
// {3, 1}
//
// ===========================
//
// Example 2:
//
// Grid:
//      .|.|.|.|.
//      .|.|x|.|.
//      .|.|x|.|.
//
// Start Point:
// {0, 0}
//
// Possible Result:
// {0, 0}
// {0, 1}
// {0, 2}
// {1, 2}
// {1, 1}
// {1, 0}
// {2, 0}
// {3, 0}
// {4, 0}
// {4, 1}
// {3, 1}
// {3, 2}
// {4, 2}
//
// ===========================

struct GridPoint {
    let x: Int
    let y: Int
}

extension GridPoint: CustomStringConvertible {
    var description: String { "{\(x), \(y)}" }
}

func shortestPathVisitingAllValidTiles(from startPoint: GridPoint, in grid: [[Character]]) -> [GridPoint] {
    []
}

let test_1_string =
"""
x|.|x|x
.|.|.|.
"""
let test_1 = grid(from: test_1_string)
let test_1_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 1, y: 0),
                                                      in: test_1)
print("test 1 results:")
for point in test_1_result {
    print(point)
}
print("===========================")

// Expected Result:
// {1, 0}
// {1, 1}
// {0, 1}
// {1, 1}
// {2, 1}
// {3, 1}

// ===========================

let test_2_string =
"""
x|x|.|x|x
.|.|.|.|x
x|x|.|x|x
"""
let test_2 = grid(from: test_2_string)
let test_2_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 2, y: 0),
                                                      in: test_2)
print("test 2 results:")
for point in test_2_result {
    print(point)
}
print("===========================")

// Expected Result:
// {2, 0}
// {2, 1}
// {3, 1}
// {2, 1}
// {2, 2}
// {2, 1}
// {1, 1}
// {0, 1}

// ===========================

let test_3_string =
"""
.|x|.|x|.
.|x|.|x|.
.|.|.|.|.
"""
let test_3 = grid(from: test_3_string)
let test_3_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 0, y: 0),
                                                      in: test_3)
print("test 3 results:")
for point in test_3_result {
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
// {2, 1}
// {2, 2}
// {3, 2}
// {4, 2}
// {4, 1}
// {4, 0}

// ===========================

let test_4_string =
"""
.|.|.|x|.
.|.|.|x|.
.|.|.|.|.
"""
let test_4 = grid(from: test_4_string)
let test_4_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 0, y: 0),
                                                      in: test_4)
print("test 4 results:")
for point in test_4_result {
    print(point)
}
print("===========================")

// Possible Result:
// {0, 0}
// {1, 0}
// {2, 0}
// {2, 1}
// {1, 1}
// {0, 1}
// {0, 2}
// {1, 2}
// {2, 2}
// {3, 2}
// {4, 2}
// {4, 1}
// {4, 0}

// ===========================

let test_5_string =
"""
.|.|.|.|.
.|.|x|.|.
.|.|x|.|.
"""
let test_5 = grid(from: test_5_string)
let test_5_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 0, y: 0),
                                                      in: test_5)
print("test 5 results:")
for point in test_5_result {
    print(point)
}
print("===========================")

// Possible Result:
// {0, 0}
// {0, 1}
// {0, 2}
// {1, 2}
// {1, 1}
// {1, 0}
// {2, 0}
// {3, 0}
// {4, 0}
// {4, 1}
// {3, 1}
// {3, 2}
// {4, 2}

// ===========================

let test_6_string =
"""
x|.|x|.
x|.|x|.
.|.|.|.
x|.|x|.
"""

let test_6 = grid(from: test_6_string)
let test_6_result = shortestPathVisitingAllValidTiles(from: GridPoint(x: 3, y: 2),
                                                      in: test_6)
print("test 6 results:")
for point in test_6_result {
    print(point)
}
print("===========================")

// Possible Result:
// {3, 3}
// {3, 2}
// {3, 1}
// {3, 0}
// {3, 1}
// {3, 2}
// {2, 2}
// {1, 2}
// {0, 2}
// {1, 2}
// {1, 3}
// {1, 2}
// {1, 1}
// {1, 0}

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
