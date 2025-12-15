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
    
    public func checkWinner(forRow row: Int, col: Int, piece: CFSlot) throws -> Bool {
        guard row >= 0, row < board.height, col >= 0, col < board.width else {
            throw GameError.invalidPosition
        }
        guard board[row, col] == piece else {
            return false
        }
        let isWinner = countMatches(startingFrom: row, col: col, dRow: -1, dCol: 0, piece: piece) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: 0, piece: piece) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: 0, dCol: -1, piece: piece) + countMatches(startingFrom: row, col: col, dRow: 0, dCol: 1, piece: piece) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: -1, dCol: 1, piece: piece) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: -1, piece: piece) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: -1, dCol: -1, piece: piece) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: 1, piece: piece) + 1 >= 4
        return isWinner
    }
    
    private func countMatches(startingFrom row: Int, col: Int, dRow: Int, dCol: Int, piece: CFSlot) -> Int {
        let nextRow = row + dRow
        let nextColumn = col + dCol
        guard nextRow >= 0, nextRow < board.height, nextColumn >= 0, nextColumn < board.width, board[nextRow, nextColumn] == piece else {
            return 0
        }
        return 1 + countMatches(startingFrom: nextRow, col: nextColumn, dRow: dRow, dCol: dCol, piece: piece)
    }
}
