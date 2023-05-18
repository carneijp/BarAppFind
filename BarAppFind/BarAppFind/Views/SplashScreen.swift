//
//  SplashScreen.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 17/05/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var efect = false
    var body: some View {
        ZStack{
            Color("azulescuro")
            Image("logo")
                .resizable()
                .scaledToFit()
                .scaleEffect(efect ? 1.5 : 1)
                .frame(width: 337, height: 327)
        }
        .onAppear {
            withAnimation {
                efect = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    efect = false
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
