
//  Created by Jiaheng Pan on 12/7/24.
import SwiftUI

struct ExpenseRow: View {
    let title: String
    let dateString: String
    let amount: String
    let type: ExpenseTypes
    
    @State var offsetX: CGFloat = 0
    var onDelete: ()->()
    
    var body: some View {
        ZStack(alignment: .trailing) {
            deleteIcon()
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    TypeIconView(type: type)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                        Text(dateString)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    Text(amount)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(type == .housing ? .appPrimary : .primary)  // Changed from foregroundStyle
                }
                .padding(.vertical, 8)
                .offset(x: offsetX)
                .gesture(DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if UIScreen.main.bounds.width * 0.6 < -value.translation.width {
                                withAnimation {
                                    offsetX = -UIScreen.main.bounds.width
                                    onDelete()
                                }
                            } else {
                                offsetX = 0
                            }
                        }
                    }
                )
                
                Divider()
                    .padding(.horizontal, -16)
            }
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
        }
    }
    
    @ViewBuilder
    func deleteIcon() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .offset(x: 30)
            .offset(x: offsetX * 0.5)
            .scaleEffect(CGSize(width: -offsetX * 0.006,
                              height: -offsetX * 0.006))
            .foregroundColor(.red)
    }
}
