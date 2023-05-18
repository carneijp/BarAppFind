//
//  BarListView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 10/05/23.
//

import SwiftUI

struct BarListView: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Binding var showSignIn: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cloud.barsList, id: \.self) { bar in
                    NavigationLink {
                        BarPageView(barname: bar.name)
                            .toolbarRole(.editor)
                    } label: {
                        BarComponent(bar: bar, showSignIn: $showSignIn)
                            .foregroundColor(.primary)
                            .padding(.bottom, 10)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
        .navigationTitle("Todos os Bares")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            if cloud.barsList.count != 10 {
                cloud.fetchBars()
            }
        }
    }
}

struct BarListView_Previews: PreviewProvider {
    static var previews: some View {
        BarListView(showSignIn: .constant(false))
    }
}
