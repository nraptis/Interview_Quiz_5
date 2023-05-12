import Foundation

//
// You are an army sniper shooting enemy militants.
//
// You have a 2-D grid of Characters that represents a hostile territory.
// The values in the grid are "." "x" and "e"
//
// "." represents blank space
// "x" represents a wall
// "e" represents an enemy militant
//
// You shoot from outside of the grid, in a straight line.
// You cannot shoot diagonal, only in straight horizontal and vertical lines.
// You have up to 3 shots.
//
// Your shots pass through blank spaces (".") and enemy militants ("e").
// Your shots do not pass through walls ("x").
//
// Determine the starting position of the shots you should take to:
// 1.) Maximize the number of enemy militants hit. (priority 1)
// 2.) Minimize the number of bullets used. (priority 2)
//
// Hitting the same enemy with subsequent shots does not count as additional hits.
// you can hit each enemy one time.
//
// If there is no shot which hits an enemy militant, return an empty array.
// If there are ties, return any one of the solutions.
//
// ===========================
//
// Example 1:
//
//        v v v v
//
//    >   .|.|x|.  <
//  * >   e|e|e|x  <
//    >   .|.|e|.  <
//    >   .|.|e|.  <
//
//        ^ ^ ^ ^
//            *
//
// Expected Result:
// {-1, 1}
// {2, 4}
//
// ===========================
//
// Example 2:
//
//       v v v v v
//
//  * >  e|.|e|e|x  <
//    >  x|.|.|.|.  <
//    >  .|e|e|e|.  < *
//    >  e|.|x|.|x  <
//  * >  e|.|e|e|.  <
//
//       ^ ^ ^ ^ ^
//
// Expected Result:
// {-1, 0}
// {5, 2}
// {-1, 4}
//
// ===========================
//
// Example 3:
//
//          *   *
//        v v v v v
//
//     >  x|e|e|e|x  <
//     >  e|e|e|e|x  <
//     >  e|e|x|e|x  <
//     >  e|e|e|e|x  <
//     >  e|x|e|x|e  <
//
//        ^ ^ ^ ^
//        *
//
// Expected Result:
// {0, 5}
// {1, -1}
// {3, -1}
//
// ===========================
//
// Example 4:
//
//      v v v v
//
//    > x|e|e|e < *
//  * > e|e|e|x <
//    > .|.|.|. <
//    > x|e|e|e < *
//    > x|x|x|x <
//
//      ^ ^ ^ ^
//
// Expected Result:
// {4, 0}
// {-1, 1}
// {4, 3}
//

struct GridPoint {
    let x: Int
    let y: Int
}

extension GridPoint: CustomStringConvertible {
    var description: String { "{\(x), \(y)}" }
}

struct BorderPoint {
    let x: Int
    let y: Int
    let dirX: Int
    let dirY: Int
}

extension BorderPoint: CustomStringConvertible {
    var description: String { "{{\(x), \(y)}|{\(dirX), \(dirY)}}" }
}

func bestShots(grid: [[Character]]) -> [GridPoint] {
    
    let width = grid.count
    guard width > 0 else { return [] }
    
    let height = grid[0].count
    guard height > 0 else { return [] }
    
    let borderPoints = borderPoints(width: width, height: height)
    
    var bestHitCount = 0
    var bestHitShots = [GridPoint]()
    
    for index1 in 0..<borderPoints.count {
        let borderPoint1 = borderPoints[index1]
        for index2 in 0..<borderPoints.count where index2 != index1 {
            let borderPoint2 = borderPoints[index2]
            for index3 in 0..<borderPoints.count where index3 != index2 && index3 != index1 {
                let borderPoint3 = borderPoints[index3]
                
                var testGrid = grid
                
                var borderPoints = [borderPoint1, borderPoint2, borderPoint3]
                var hits = [0, 0, 0]
                
                for borderPointIndex in 0..<3 {
                    
                    let borderPoint = borderPoints[borderPointIndex]
                    
                    var x = borderPoint.x
                    var y = borderPoint.y
                    
                    x += borderPoint.dirX
                    y += borderPoint.dirY
                    
                    var hitCount = 0
                    
                    while x >= 0 && x < width && y >= 0 && y < height &&
                            (testGrid[x][y] == "e" || testGrid[x][y] == "." || testGrid[x][y] == "k") {
                        if testGrid[x][y] == "e" {
                            testGrid[x][y] = "k"
                            hitCount += 1
                        }
                        x += borderPoint.dirX
                        y += borderPoint.dirY
                    }
                    hits[borderPointIndex] = hitCount
                }
                
                var bulletsUsed = 0
                var totalHits = 0
                for i in 0..<3 {
                    if hits[i] > 0 {
                        bulletsUsed += 1
                        totalHits += hits[i]
                    }
                }
                if (totalHits > bestHitCount) || (totalHits == bestHitCount && bulletsUsed < bestHitShots.count) {
                    bestHitCount = totalHits
                    bestHitShots.removeAll(keepingCapacity: true)
                    for i in 0..<3 {
                        if hits[i] > 0 {
                            let borderPoint = borderPoints[i]
                            bestHitShots.append(GridPoint(x: borderPoint.x,
                                                          y: borderPoint.y))
                        }
                    }
                }
            }
        }
    }
    return bestHitShots
}

func borderPoints(width: Int, height: Int) -> [BorderPoint] {
    
    if width <= 0 { return [] }
    if height <= 0 { return [] }
    
    var result = [BorderPoint]()
    
    // top row
    for x in 0..<width {
        result.append(BorderPoint(x: x,
                                  y: -1,
                                  dirX: 0,
                                  dirY: 1))
    }
    
    // right row
    for y in 0..<height {
        result.append(BorderPoint(x: width,
                                  y: y,
                                  dirX: -1,
                                  dirY: 0))
    }
    
    // bottom row
    for x in 0..<width {
        
        result.append(BorderPoint(x: x,
                                  y: height,
                                  dirX: 0,
                                  dirY: -1))
    }
    
    // left row
    for y in 0..<height {
        result.append(BorderPoint(x: -1,
                                  y: y,
                                  dirX: 1,
                                  dirY: 0))
    }
    return result
}

// ===========================

let test_string_1 = """
                    .|.|x|.
                    e|e|e|x
                    .|.|e|.
                    .|.|e|.
                    """
let test_grid_1 = grid(from: test_string_1)
let result1 = bestShots(grid: test_grid_1)

print("test 1 result:")
for shot in result1 {
    print(shot)
}
print("===========================")

// Expected Result:
// {-1, 1}
// {2, 4}

// ===========================

let test_string_2 = """
                    e|.|e|e|x
                    x|.|.|.|.
                    .|e|e|e|.
                    e|.|x|.|x
                    e|e|e|e|.
                    """
let test_grid_2 = grid(from: test_string_2)
let result2 = bestShots(grid: test_grid_2)

print("test 2 result:")
for shot in result2 {
    print(shot)
}
print("===========================")

// Possible Result:
// {-1, 0}
// {5, 2}
// {5, 4}

// ===========================

let test_string_3 = """
                    x|e|e|e|x
                    e|e|e|e|x
                    x|e|x|e|x
                    e|e|e|e|x
                    x|e|e|e|e
                    """
let test_grid_3 = grid(from: test_string_3)
let result3 = bestShots(grid: test_grid_3)

print("test 3 result:")
for shot in result3 {
    print(shot)
}
print("===========================")

// Possible Result:
// {1, -1}
// {2, -1}
// {3, -1}

// ===========================

let test_string_4 = """
                    x|e|e|e
                    e|e|e|x
                    .|.|.|.
                    x|e|e|e
                    x|x|x|x
                    """
let test_grid_4 = grid(from: test_string_4)
let result4 = bestShots(grid: test_grid_4)

print("test 4 result:")
for shot in result4 {
    print(shot)
}
print("===========================")

// Expected Result:
// {-1, 1}
// {4, 0}
// {4, 3}

// ===========================

let test_string_5 = """
                    .|.|x|.|x|.
                    .|e|.|e|e|x
                    .|.|.|.|.|.
                    e|.|e|e|.|e
                    """
let test_grid_5 = grid(from: test_string_5)
let result5 = bestShots(grid: test_grid_5)

print("test 5 result:")
for shot in result5 {
    print(shot)
}
print("===========================")

// Expected Result:
// {-1, 1}
// {6, 3}

// ===========================

let test_string_6 = """
                    x|e|.|e|x|e|.|e|e
                    .|.|e|.|e|x|.|.|.
                    x|.|e|e|e|.|.|e|e
                    .|e|.|.|e|.|.|e|.
                    .|.|e|e|.|e|.|.|.
                    .|e|e|e|.|.|e|e|x
                    .|x|x|x|e|e|.|.|.
                    """
let test_grid_6 = grid(from: test_string_6)
let result6 = bestShots(grid: test_grid_6)

print("test 6 result:")
for shot in result6 {
    print(shot)
}
print("===========================")

// Possible Result:
// {-1, 5}
// {9, 0}
// {9, 2}

// ===========================

let test_string_7 = """
                    e|e
                    """
let test_grid_7 = grid(from: test_string_7)
let result7 = bestShots(grid: test_grid_7)

print("test 7 result:")
for shot in result7 {
    print(shot)
}
print("===========================")

// Expected Result:
// {2, 0}

// ===========================

let test_string_8 = """
                    e
                    """
let test_grid_8 = grid(from: test_string_8)
let result8 = bestShots(grid: test_grid_8)

print("test 8 result:")
for shot in result8 {
    print(shot)
}
print("===========================")

// Possible Result:
// {0, -1}

// ===========================

let test_string_9 = """
                    x|e|e|e|x
                    e|e|e|e|x
                    e|e|x|e|x
                    e|e|e|e|x
                    e|x|e|x|e
                    """
let test_grid_9 = grid(from: test_string_9)
let result9 = bestShots(grid: test_grid_9)

print("test 9 result:")
for shot in result9 {
    print(shot)
}
print("===========================")

// Possible Result:
// {1, -1}
// {3, -1}
// {0, 5}

// ===========================

let test_string_10 = """
                    x|x
                    .|x
                    """
let test_grid_10 = grid(from: test_string_10)
let result10 = bestShots(grid: test_grid_10)

print("test 10 result:")
for shot in result10 {
    print(shot)
}
print("===========================")

// Expected Result:
// (Empty Array)

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
