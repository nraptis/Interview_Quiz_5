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
// You have exactly 1 shot.
//
// Your shots pass through blank spaces (".") and enemy militants ("e").
// Your shots do not pass through walls ("x").
//
// Determine the starting position of the shot you should take to maximize the number of enemy militants hit.
// If there is no shot which hits an enemy militant, return nil.
// If there are ties, return any one of the solutions.
//
// Consider the below 2x2 grid.
//
//      v v
//
//    > e|x| <
//    > x|e| <
//
//      ^ ^
//
// These are your possible "shoot from" locations in (x, y) format:
// (-1, 0) shooting right
// (-1, 1) shooting right
// (0, -1) shooting down
// (1, -1) shooting down
// (2, 0) shooting left
// (2, 1) shooting left
// (0, 2) shooting up
// (1, 2) shooting up
//
// The "shoot from" locations / directions are represented in the diagram by carrots. ( > v < ^ )
//
// ===========================
//
// Example 1:
//
//      v v v v
//
//    > x|x|e|. <
//  * > e|e|e|x <
//    > e|.|x|. <
//
//      ^ ^ ^ ^
//
// Expected Result:
// Snipe Location: (-1, 1)
//
// ===========================
//
// Example 2:
//
//            *
//      v v v v
//
//    > x|x|.|e <
//    > .|e|x|e <
//    > e|x|e|e <
//    > e|.|e|x <
//
//      ^ ^ ^ ^
//
// Expected Result:
// Snipe Location: (3, -1)
//
// ===========================
//
// Example 3:
//
//
//      v v v v
//
//    > x|x|x|x <
//    > x|e|e|x <
//    > x|e|e|x <
//    > x|x|x|x <
//
//      ^ ^ ^ ^
//
// Expected Result:
// nil
//
// ===========================

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

func bestShot(grid: [[Character]]) -> GridPoint? {
    
    let width = grid.count
    guard width > 0 else { return nil }
    
    let height = grid[0].count
    guard height > 0 else { return nil }
    
    let borderPoints = borderPoints(width: width, height: height)
    
    var result: GridPoint?
    var resultCount = 0
    
    for borderPoint in borderPoints {
        
        var x = borderPoint.x
        var y = borderPoint.y
        
        x += borderPoint.dirX
        y += borderPoint.dirY
        
        var hitCount = 0
        
        while x >= 0 && x < width && y >= 0 && y < height &&
                (grid[x][y] == "e" || grid[x][y] == ".") {
            if grid[x][y] == "e" {
                hitCount += 1
            }
            x += borderPoint.dirX
            y += borderPoint.dirY
        }
        
        if hitCount > resultCount {
            resultCount = hitCount
            result = GridPoint(x: borderPoint.x,
                               y: borderPoint.y)
        }
    }
    return result
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
                    x|x|e|.
                    e|e|e|x
                    e|.|x|.
                    """
let test_grid_1 = grid(from: test_string_1)
let result1 = bestShot(grid: test_grid_1)
print("test 1, best shot: \(result1?.description ?? "nil")")

// Expected Result:
// {-1, 1}

// ===========================

let test_string_2 = """
                    x|x|.|e
                    .|e|x|e
                    e|x|e|e
                    e|.|e|x
                    """
let test_grid_2 = grid(from: test_string_2)
let result2 = bestShot(grid: test_grid_2)
print("test 2, best shot: \(result2?.description ?? "nil")")

// Expected Result:
// {3, -1}

// ===========================

let test_string_3 = """
                    .|x|x|.
                    x|e|e|x
                    x|e|e|x
                    .|x|x|.
                    """
let test_grid_3 = grid(from: test_string_3)
let result3 = bestShot(grid: test_grid_3)
print("test 3, best shot: \(result3?.description ?? "nil")")

// Expected Result:
// nil

// ===========================

let test_string_4 = """
                    x|x|e|e
                    e|e|x|e
                    x|x|e|x
                    x|e|e|e
                    """
let test_grid_4 = grid(from: test_string_4)
let result4 = bestShot(grid: test_grid_4)
print("test 4, best shot: \(result4?.description ?? "nil")")

// Expected Result:
// {4, 3}}

// ===========================

let test_string_5 = """
                    .|e|x|e
                    e|x|x|x
                    x|e|.|x
                    x|e|x|e
                    """
let test_grid_5 = grid(from: test_string_5)
let result5 = bestShot(grid: test_grid_5)
print("test 5, best shot: \(result5?.description ?? "nil")")

// Expected Result:
// {1, 4}}

// ===========================

let test_string_6 = """
                    e|.|x|.|e|.|e
                    .|x|e|e|x|e|.
                    x|e|.|e|.|e|.
                    e|.|e|x|e|.|x
                    x|.|e|e|x|e|.
                    x|e|e|e|e|x|.
                    """
let test_grid_6 = grid(from: test_string_6)
let result6 = bestShot(grid: test_grid_6)
print("test 6, best shot: \(result6?.description ?? "nil")")

// Expected Result:
// {2, 6}}

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
