
//  Created by Jiaheng Pan on 12/7/24.

// Views/RecordsView.swift
import SwiftUI
import RealmSwift

struct RecordsView: View {
    @State var query = ""
    @State var sortField: String = "date"
    @State var ascending: Bool = false
    @State var typeFilter: String = ""
    
    @ObservedResults(ExpenseRecord.self) var records
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search expenses", text: $query)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(ExpenseTypes.allCases, id: \.self) { type in
                                Button {
                                    withAnimation {
                                        typeFilter = typeFilter == type.rawValue ? "" : type.rawValue
                                    }
                                } label: {
                                    Text(type.rawValue.capitalized)
                                        .font(.system(size: 15, weight: .medium))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(typeFilter == type.rawValue ?
                                                     Color.appPrimary.opacity(0.2) :
                                                     Color(.systemGray6))
                                        }
                                        .foregroundColor(typeFilter == type.rawValue ?
                                                       .appPrimary : .primary)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal, 8)
                    
                    HStack(spacing: 12) {
                        Button {
                            sortField = sortField == "date" ? "amount" : "date"
                        } label: {
                            HStack(spacing: 4) {
                                Text("Sort by")
                                Image(systemName: sortField == "date" ? "calendar" : "dollarsign.circle")
                                    .foregroundColor(.appPrimary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        Button {
                            ascending.toggle()
                        } label: {
                            HStack(spacing: 4) {
                                Text("Order")
                                Image(systemName: ascending ? "arrow.up" : "arrow.down")
                                    .foregroundColor(.appPrimary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if records.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.text")
                                .font(.system(size: 32))
                                .foregroundColor(.secondary)
                                .padding(.bottom, 4)
                            Text("No expenses yet")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("Tap + to add your first expense")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(records
                                .filter(getFilterPredicate())
                                .sorted(byKeyPath: sortField, ascending: ascending),
                                   id: \.id) { record in
                                ExpenseRow(title: record.title,
                                         dateString: formatDate(record.date),
                                         amount: String(format: "$%.2f", Double(record.amount) ?? 0),
                                         type: record.typeEnum) {
                                    $records.remove(record)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer(minLength: 80)
                }
                .padding(.top)
            }
            .navigationTitle("Expense Records")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateRecordView()) {
                        Text("Add")
                            .foregroundColor(.appPrimary)
                            .fontWeight(.semibold)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func getFilterPredicate() -> NSPredicate {
        if typeFilter.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "type CONTAINS[c] %@", typeFilter)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
    }
}
