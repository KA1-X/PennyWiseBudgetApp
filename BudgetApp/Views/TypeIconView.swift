
//  Created by Jiaheng Pan on 12/7/24.

// Components/TypeIconView.swift
import SwiftUI

struct TypeIconView: View {
    let type: ExpenseTypes
    let tint: Color
    let icon: String
    
    init(type: ExpenseTypes) {
        self.type = type
        let result = TypeIconView.getIconConfig(type: type)
        self.tint = result.0
        self.icon = result.1
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(tint.opacity(0.2))
            Image(systemName: icon)
                .foregroundStyle(tint)
                .font(.system(size: 18))
        }
    }
    static func getIconConfig(type: ExpenseTypes) -> (Color, String) {
        switch type {
        case .housing:
            return(.blue, "house.fill")
        case .groceries:
            return(.green, "cart.fill")
        case .transport:
            return(.orange, "car.fill")
        case .education:
            return(.purple, "book.fill")
        case .healthcare:
            return(.cyan, "cross.fill")
        case .personal:
            return(.pink, "person.fill")
        case .savings:
            return(.mint, "banknote.fill")
        }
    }
}
