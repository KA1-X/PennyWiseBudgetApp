
//  Created by Jiaheng Pan on 12/7/24.
//

// Views/CreateRecordView.swift
import SwiftUI
import RealmSwift

struct CreateRecordView: View {
    @State var recordTitle: String = ""
    @State var amount: String = ""
    @State var type: ExpenseTypes = .housing
    @State var date: Date = Date()
    @State var showError: Bool = false
    
    @ObservedResults(ExpenseRecord.self) var records
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("Title", text: $recordTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("Amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Picker("Category", selection: $type) {
                        ForEach(ExpenseTypes.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.appPrimary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appPrimary)
                }
                
                Spacer()
            }
            .padding(24)
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New Expense")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    save()
                }
                .foregroundColor(.appPrimary)
            }
        }
        .alert("Empty Fields", isPresented: $showError) { }
    }
    
    private func save() {
        if recordTitle.isEmpty || amount.isEmpty {
            showError = true
            return
        }
        
        let record = ExpenseRecord()
        record.title = recordTitle
        record.date = date
        record.amount = amount
        record.type = type.rawValue
        
        $records.append(record)
        presentationMode.wrappedValue.dismiss()
    }
}
