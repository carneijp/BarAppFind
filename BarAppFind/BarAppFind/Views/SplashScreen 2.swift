//
//  SplashScreen.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 17/05/23.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @State var size: Double = 0.8
    @State var isActive: Bool = false
    
    var body: some View{
        if isActive{
            GeneralTab()
//                .environmentObject(CloudKitCRUD())
        }else{
            ZStack{
                Color("AzulSplash")
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 337)
                    .scaleEffect(size)
                
                
                
            }
            .ignoresSafeArea()
            .onAppear{
                cloud.fetchBars()
                withAnimation(.easeIn(duration: 2)){
                    size = 1.5
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    isActive = true
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}