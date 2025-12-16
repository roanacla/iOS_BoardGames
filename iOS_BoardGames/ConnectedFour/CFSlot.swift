//
//  Piece.swift
//  iOS_BoardGames
//
//  Created by Roger Navarro Claros on 12/12/25.
//
import Foundation

enum CFSlot {
    case red
    case black
    case empty
    
    var localizedName: String {
        switch self {
        case .red:
            return String(localized: "Red", comment: "Team color red")
        case .black:
            return String(localized: "Black", comment: "Team color black")
        case .empty:
            return String(localized: "Empty", comment: "Empty slot")
        }
    }
}
