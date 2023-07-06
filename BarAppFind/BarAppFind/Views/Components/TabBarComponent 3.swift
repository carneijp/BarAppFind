//
//  TabBarComponent.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 25/05/23.
//

import SwiftUI

struct TabBarComponent: View {
    var tabIcon: String
    var tabName: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 4) {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 50, height: 2)
                .padding(.bottom, 6)
            Image(systemName: tabIcon)
                .foregroundColor(.primary)
                .font(.system(size: 26))
            Text(tabName)
                .font(.system(size: 12))
                .bold()
                .foregroundColor(.primary)
        }
    }
}

struct TabBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        TabBarComponent(tabIcon: "map.fill", tabName: "Mapa")
    }
}
