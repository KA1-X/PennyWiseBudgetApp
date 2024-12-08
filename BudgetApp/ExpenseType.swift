
//  Created by Jiaheng Pan on 12/7/24.
//

// Models/ExpenseType.swift
import Foundation
import SwiftUI
import RealmSwift

struct ExpenseType {
  let type: ExpenseTypes
  var percentage: Int = 0
  var amount: Double = 0
  
  init(type: ExpenseTypes) {
    self.type = type
  }
  
  static func getColor(type: ExpenseTypes) -> Color {
    switch type {
    case .housing:
      return(.pink)
    case .groceries:
      return(.brown)
    case .transport:
      return(.purple)
    case .education:
      return(.orange)
    case .healthcare:
      return(.green)
    case .personal:
      return(.yellow)
    case .savings:
      return(.blue)
    }
  }
}
