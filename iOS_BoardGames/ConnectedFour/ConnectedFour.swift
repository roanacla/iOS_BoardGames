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
}
