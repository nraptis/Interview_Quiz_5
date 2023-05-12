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

class PathNode: MaxHeapIndexedElement {
    
    var parent: PathNode?
    var x: Int
    var y: Int
    
    var gCost = Int.max
    var hCost = Int.max
    var fCost = Int.max
    
    var index: Int = 0
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    convenience init(gridPoint: GridPoint) {
        self.init(x: gridPoint.x, y: gridPoint.y)
    }
}

extension PathNode: Comparable {
    static func < (lhs: PathNode, rhs: PathNode) -> Bool {
        lhs.hCost < rhs.hCost
    }
}

extension PathNode: Hashable {
    static func ==(lhs: PathNode, rhs: PathNode) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

func shortestPath(from startPoint: GridPoint, to endPoint: GridPoint, in grid: [[Character]]) -> [GridPoint] {
    
    let width = grid.count
    guard width > 0 else { return [] }
    
    let height = grid[0].count
    guard height > 0 else { return [] }
    
    var _grid = [[PathNode?]](repeating: [PathNode?](repeating: nil, count: height), count: width)
    
    for x in 0..<width {
        for y in 0..<height {
            if grid[x][y] == "." {
                _grid[x][y] = PathNode(x: x, y: y)
            }
        }
    }
    
    var startNode = PathNode(gridPoint: startPoint)
    startNode.gCost = 0
    startNode.hCost = 0
    startNode.fCost = 0
    
    var openSet = Set<PathNode>()
    openSet.insert(startNode)
    
    var closedSet = Set<PathNode>()
    
    var openHeap = MaxIndexedHeap<PathNode>()
    openHeap.insert(startNode)
    
    func h(x: Int, y: Int) -> Int {
        abs(x - startPoint.x) + abs(y - startPoint.y)
    }

    let dirX = [-1, 0, 1, 0]
    let dirY = [0, -1, 0, 1]

    while !openHeap.isEmpty {
        
        var current = openHeap.pop()!
        openSet.remove(current)
        closedSet.insert(current)
        
        if current.x == endPoint.x && current.y == endPoint.y {
            var result = [GridPoint]()
            result.append(GridPoint(x: current.x, y: current.y))
            while let parent = current.parent {
                current = parent
                result.append(GridPoint(x: current.x, y: current.y))
            }
            result.reverse()
            return result
        }
        
        for neighborIndex in 0..<dirX.count {
            let x = current.x + dirX[neighborIndex]
            let y = current.y + dirY[neighborIndex]
            
            guard x >= 0 && x < width && y >= 0 && y < height else { continue }
            guard let neighbor = _grid[x][y] else { continue }
            
            if closedSet.contains(neighbor) { continue }
            
            let gCost = current.gCost + 1
            if gCost < neighbor.gCost {
                neighbor.parent = current
                neighbor.gCost = gCost
                neighbor.fCost = gCost + h(x: neighbor.x, y: neighbor.y)
                if openSet.contains(neighbor) {
                    openHeap.remove(neighbor)
                    openHeap.insert(neighbor)
                } else {
                    openSet.insert(neighbor)
                    openHeap.insert(neighbor)
                }
            }
        }
    }
    return []
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

protocol MaxHeapIndexedElement: Comparable {
    var index: Int { set get }
}

struct MaxIndexedHeap<Element: MaxHeapIndexedElement> {
    
    private(set) var data = [Element]()
    private(set) var count: Int = 0
    
    mutating func insert(_ element: Element?) {
        if let element = element {
            if count < data.count {
                data[count] = element
            } else {
                data.append(element)
            }
            data[count].index = count
            var bubble = count
            var parent = (((bubble - 1)) >> 1)
            count += 1
            while bubble > 0 {
                if data[bubble] > data[parent] {
                    data.swapAt(bubble, parent)
                    let holdIndex = data[bubble].index
                    data[bubble].index = data[parent].index
                    data[parent].index = holdIndex
                    bubble = parent
                    parent = (((bubble - 1)) >> 1)
                } else {
                    break
                }
            }
        }
    }
    
    func peek() -> Element? {
        if count > 0 { return data[0] }
        return nil
    }
    
    mutating func pop() -> Element? {
        if count > 0 {
            let result = data[0]
            count -= 1
            data[0] = data[count]
            data[0].index = 0
            
            var bubble = 0
            var leftChild = 1
            var rightChild = 2
            var maxChild = 0
            while leftChild < count {
                maxChild = leftChild
                if rightChild < count && data[rightChild] > data[leftChild] {
                    maxChild = rightChild
                }
                if data[bubble] < data[maxChild] {
                    data.swapAt(bubble, maxChild)
                    let holdIndex = data[bubble].index
                    data[bubble].index = data[maxChild].index
                    data[maxChild].index = holdIndex
                    bubble = maxChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            return result
        }
        return nil
    }
    
    var isEmpty: Bool {
        count == 0
    }
    
    mutating func remove(_ element: Element) {
        _ = remove(at: element.index)
    }
    
    mutating func remove(at index: Int) -> Element? {
        let newCount = count - 1
        if index != newCount {
            data.swapAt(index, newCount)
            
            var holdIndex = data[index].index
            data[index].index = data[newCount].index
            data[newCount].index = holdIndex
            
            var bubble = index
            var leftChild = bubble * 2 + 1
            var rightChild = leftChild + 1
            var maxChild = 0
            while leftChild < newCount {
                maxChild = leftChild
                if rightChild < newCount && data[rightChild] > data[leftChild] {
                    maxChild = rightChild
                }
                if data[bubble] < data[maxChild] {
                    data.swapAt(bubble, maxChild)
                    
                    holdIndex = data[bubble].index
                    data[bubble].index = data[maxChild].index
                    data[maxChild].index = holdIndex
                    
                    bubble = maxChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            bubble = index
            var parent = (((bubble - 1)) >> 1)
            while bubble > 0 {
                if data[bubble] > data[parent] {
                    data.swapAt(bubble, parent)
                    
                    holdIndex = data[bubble].index
                    data[bubble].index = data[parent].index
                    data[parent].index = holdIndex
                    
                    bubble = parent
                    parent = (((bubble - 1)) >> 1)
                } else {
                    break
                }
            }
        }
        count = newCount
        return data[count]
    }
    
    func isValid() -> Bool {
        if count <= 1 { return true }
        return isValid(index: 0)
    }
    
    private func isValid(index: Int) -> Bool {
        
        if data[index].index != index {
            return false
        }
        
        let leftChild = index * 2 + 1
        if leftChild < count {
            
            if data[leftChild].index != leftChild {
                return false
            }
            
            if data[leftChild] > data[index] {
                return false
            }
            if !isValid(index: leftChild) {
                return false
            }
        }
        
        let rightChild = leftChild + 1
        if rightChild < count {
            if data[rightChild].index != rightChild {
                return false
            }
            if data[rightChild] > data[index] {
                return false
            }
            if !isValid(index: rightChild) {
                return false
            }
        }
        return true
    }
}
