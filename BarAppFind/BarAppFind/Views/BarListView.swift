//
//  BarListView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 10/05/23.
//

import SwiftUI

struct BarListView: View {
    @StateObject var cloud: CloudKitCRUD = CloudKitCRUD()
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cloud.barsList, id: \.self) { bar in
                    NavigationLink {
                        BarPageView()
                    } label: {
                        BarComponent(bar: bar)
                            .foregroundColor(.primary)
                            .padding(.bottom, 10)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
        }
//        .searchable(text: $text)
        .onAppear() {
            if cloud.barsList.count != 10 {
                cloud.fetchBars()
            }
        }
    }
}

struct BarListView_Previews: PreviewProvider {
    static var previews: some View {
        BarListView()
    }
}
