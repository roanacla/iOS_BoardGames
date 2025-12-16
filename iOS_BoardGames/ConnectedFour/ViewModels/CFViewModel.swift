//
//  CFViewModel.swift
//  iOS_BoardGames
//
//  Created by Roger Navarro Claros on 12/15/25.
//
import Foundation

@Observable
public class CFViewModel {
    var game: ConnectedFour
    var errorMessage: String
    var status: String
    
    init() {
        self.game = ConnectedFour()
        self.errorMessage = ""
        self.status = "Playing"
    }
    
    func makeMove(at column: Int) {
        do {
            let _ = try game.drop(at: column)
            switch game.state {
            case .playing:
                status = "Player \(game.turn.rawValue) plays next"
            case .won(let winner):
                status = "Player \(winner.rawValue) wins!"
            case .draw:
                status = "It's a draw!"
            }
        } catch let error as GameError {
            switch error {
            case .gameIsOver:
                errorMessage = "Game is over"
            case .invalidMove:
                errorMessage = "Invalid move"
            case .invalidColumn:
                errorMessage = "Invalid column"
            case .columnFull:
                errorMessage = "Column is full"
            }
        } catch {
            errorMessage = "Unknown error"
        }
    }
    
    func reset() {
        game.reset()
    }
}
