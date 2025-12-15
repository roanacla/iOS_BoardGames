//
//  ConnectedFour.swift
//  iOS_BoardGames
//
//  Created by Roger Navarro Claros on 12/12/25.
//

struct ConnectedFour {
    var board: Board<CFSlot>
    
    init() {
        self.board = Board.createEmpty(width: 7, height: 6, defaultElement: .empty)
    }
    
    mutating func drop(at column: Int, piece: CFSlot) throws -> (row: Int, col: Int) {
        guard column >= 0 && column < board.width else {
            throw GameError.invalidColumn
        }
        var current = board.height - 1
        while board[current, column] != .empty {
            if current == 0 {
                throw GameError.columnFull
            }
            current -= 1
        }
        board[current, column] = piece
        return (current, column)
    }
}
