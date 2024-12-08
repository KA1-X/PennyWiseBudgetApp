
//  Created by Jiaheng Pan on 12/7/24.
//
// Components/ExpenseTypeRow.swift
import SwiftUI

struct ExpenseTypeRow: View {
  var type: ExpenseType
  var body: some View {
    HStack {
      HStack {
        TypeIconView(type: type.type)
        Text(type.type.rawValue.capitalized)
          .font(.system(size: 15))
      }
      
      Spacer()
      
      Text(String(format: "$%.2f", type.amount))
        .bold()
    }
  }
}
