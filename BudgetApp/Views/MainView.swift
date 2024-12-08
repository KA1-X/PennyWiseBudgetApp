
//  Created by Jiaheng Pan on 12/7/24.

import SwiftUI

struct MainView: View {
    @State var activeTab = 1
    
    var body: some View {
        TabView(selection: $activeTab) {
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "list.clipboard.fill")
                }
                .tag(1)
            
            NavigationStack {
                RecordsView()
            }
            .tabItem {
                Label("Records", systemImage: "archivebox.fill")
            }
            .tag(2)
        }
        .tint(.appPrimary)
    }
}
