import Foundation

/// Reason to use Struct: Performance: Generic structs support "Static Dispatch." The compiler knows exactly what code to run at compile time. Protocols use "Dynamic Dispatch," which is slightly slower. Also, in Swift, structs are highly optimized value types. Your current approach is simple, fast, and safe.
struct Board<T> {
    var width: Int
    var height: Int
    
    private var cells: [T]
    
    private init(width: Int, height: Int, cells: [T]) {
        self.width = width
        self.height = height
        self.cells = cells
    }
    
    subscript (row: Int, column: Int) -> T {
        get { cells[row * width + column] }
        set { cells[row * width + column] = newValue }
    }
}

extension Board {
    
    /// Factory: Creates a board filled with a single default value.
    /// Good for games like Minesweeper (initially empty) or Go.
    static func createEmpty(width: Int, height: Int, defaultElement: T) -> Board<T> {
        let count = width * height
        let cells = Array(repeating: defaultElement, count: count)
        
        // We call the private init here internally
        return Board(width: width, height: height, cells: cells)
    }
    
    /// Factory: Functional generation.
    /// Good for procedural maps where the value depends on the coordinate (x, y).
    static func createProcedural(width: Int, height: Int, generator: (Int, Int) -> T) -> Board<T> {
        var cells = [T]()
        cells.reserveCapacity(width * height)
        
        for y in 0..<height {
            for x in 0..<width {
                cells.append(generator(x, y))
            }
        }
        
        return Board(width: width, height: height, cells: cells)
    }
}
