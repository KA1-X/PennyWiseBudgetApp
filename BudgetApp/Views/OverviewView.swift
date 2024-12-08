
import SwiftUI
import Charts
import RealmSwift

struct OverviewView: View {
    @State var types: [ExpenseType] = [
        .init(type: .housing),
        .init(type: .groceries),
        .init(type: .transport),
        .init(type: .education),
        .init(type: .healthcare),
        .init(type: .personal),
        .init(type: .savings)
    ]
    
    @ObservedResults(ExpenseRecord.self) var records
    @State var sum: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                // Total expenses card
                VStack(spacing: 8) {
                    Text("Total monthly expenses")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text(String(format: "$%.2f", sum))
                        .font(.system(size: 46, weight: .bold))
                        .foregroundColor(.appPrimary)
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.05), radius: 10)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Chart
                Chart(types, id: \.type.rawValue) { item in
                    SectorMark(angle: .value("Data", (item.amount / sum) * 100))
                        .foregroundStyle(ExpenseType.getColor(type: item.type).gradient)
                        .opacity(0.8)
                }
                .frame(height: 160)
                .padding(.horizontal)
                
                // Categories section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Categories")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.appPrimary)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(types, id: \.type.rawValue) { type in
                            ExpenseTypeRow(type: type)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 10)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 80)
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            calculateSums()
        }
    }
    
    func calculateSums() {
        var amounts: [ExpenseTypes : Double] = [
            .housing: 0.00,
            .groceries: 0.00,
            .transport: 0.00,
            .education: 0.00,
            .healthcare: 0.00,
            .personal: 0.00,
            .savings: 0.00
        ]
        
        sum = 0
        
        for record in records {
            amounts[record.typeEnum]! += Double(record.amount) ?? 0
            sum += Double(record.amount) ?? 0
        }
        
        for index in types.indices {
            types[index].amount = amounts[types[index].type]!
        }
    }
}
