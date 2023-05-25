//
//  CustomTabBar.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 24/05/23.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack {
            Button {
                // Tab 1
            } label: {
                VStack {
                    Image(systemName: "home")
                    Text("fanfjsan")
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 80)
        .background(.red)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
