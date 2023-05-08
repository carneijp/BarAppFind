//
//  LogoComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct LogoComponent: View {
    var body: some View {
        Image(systemName: "pencil")
            .foregroundColor(.white)
            .padding(.all, 16)
            .background(.black)
            .clipShape(Circle())    
    }
}

struct LogoComponent_Previews: PreviewProvider {
    static var previews: some View {
        LogoComponent()
    }
}
