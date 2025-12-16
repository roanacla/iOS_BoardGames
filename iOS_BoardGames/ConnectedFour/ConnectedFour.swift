//
//  ConnectedFour.swift
//  iOS_BoardGames
//
//  Created by Roger Navarro Claros on 12/12/25.
//

struct ConnectedFour {
    var board: Board<CFSlot>
    // Make GameState conform to Equatable
    enum GameState: Equatable {
        case playing
        case won(CFSlot)
        case draw
    }
    
    var turn : CFSlot = .red
    var state: GameState = .playing
    private var moveCount = 0
    
    
    init() {
        self.board = Board.createEmpty(width: 7, height: 6, defaultElement: .empty)
    }
    
    mutating func drop(at column: Int) throws -> (row: Int, col: Int) {
        guard state == .playing else {
            throw GameError.gameIsOver
        }
        guard column >= 0 && column < board.width else {
            throw GameError.invalidColumn
        }
        
        var row = board.height - 1
        while board[row, column] != .empty {
            if row == 0 {
                throw GameError.columnFull
            }
            row -= 1
        }
        board[row, column] = turn
        moveCount += 1
        
        if try checkWinner(forRow: row, col: column) {
            state = .won(turn)
        } else {
            if moveCount == 42 {
                state = .draw
            } else {
                turn = turn == .red ? .black : .red
            }
        }
        
        return (row, column)
    }
    
    mutating func reset() {
        self.board = Board.createEmpty(width: 7, height: 6, defaultElement: .empty)
        self.turn = .red
        self.state = .playing
        self.moveCount = 0
    }
    
    private mutating func checkWinner(forRow row: Int, col: Int) throws -> Bool {
        guard row >= 0, row < board.height, col >= 0, col < board.width else {
            throw GameError.invalidMove
        }
        guard board[row, col] == turn else {
            return false
        }
        return countMatches(startingFrom: row, col: col, dRow: -1, dCol: 0) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: 0) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: 0, dCol: -1) + countMatches(startingFrom: row, col: col, dRow: 0, dCol: 1) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: -1, dCol: 1) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: -1) + 1 >= 4 ||
        countMatches(startingFrom: row, col: col, dRow: -1, dCol: -1) + countMatches(startingFrom: row, col: col, dRow: 1, dCol: 1) + 1 >= 4
    }
    
    private func countMatches(startingFrom row: Int, col: Int, dRow: Int, dCol: Int) -> Int {
        let nextRow = row + dRow
        let nextColumn = col + dCol
        guard nextRow >= 0, nextRow < board.height, nextColumn >= 0, nextColumn < board.width, board[nextRow, nextColumn] == turn else {
            return 0
        }
        return 1 + countMatches(startingFrom: nextRow, col: nextColumn, dRow: dRow, dCol: dCol)
    }
}
