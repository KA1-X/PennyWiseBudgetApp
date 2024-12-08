
//  Created by Jiaheng Pan on 12/7/24.
//


// Components/TypeFilterChip.swift
import SwiftUI

struct TypeFilterChip: View {
    @Binding var filter: String
    var filterTitle: String
    
    var body: some View {
        Button {
            if filter == filterTitle {
                filter = ""
            } else {
                filter = filterTitle
            }
        } label: {
            Text(filterTitle.capitalized)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(filter == filterTitle ? Color.accentColor : Color(.systemGray6))
                .foregroundStyle(filter == filterTitle ? .white : .primary)
                .clipShape(Capsule())
        }
        .animation(.spring, value: filter)
    }
}
