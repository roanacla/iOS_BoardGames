import Foundation

class BattleShip {
    var turn: Player
    var playerOneBoard: Board<BSSlot>
    var playerTwoBoard: Board<BSSlot>
    
    init(boardSetupStrategy: BSBoardStrategy) {
        //TODO: initialize board with strategy
        self.playerOneBoard = Board.createEmpty(width: 10, height: 10, defaultElement: .empty)
        self.playerTwoBoard = Board.createEmpty(width: 10, height: 10, defaultElement: .empty)
        self.turn = .player1
    }

}
