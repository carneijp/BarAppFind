//
//  SplashScreen.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 17/05/23.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var map: MapViewModel
    @EnvironmentObject var cloud: CloudKitCRUD
    @State var size: Double = 0.8
    @State var isActive: Bool = false
    @State var hasEthernet: Bool = true
    
    var body: some View{
        if !hasEthernet {
            ErrorView(noInternet: $hasEthernet)
        }else{
            if isActive{
                GeneralTab()
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
                    NetworkConnection.shared.startMonitoring()
                    
                    cloud.fetchBars(){ result in
                        if result {
                            DispatchQueue.main.async{
                                isActive = true
                            }
                            map.chekIfLocationService{ permission in
                                if permission{
                                    for i in 0..<cloud.barsList.count{
                                        cloud.barsList[i].calculateDistance(userLocation: map.userCLlocation2d ?? MapDetails.initialCoordinate)
                                    }
                                    cloud.barsList.sort{$0.distanceFromUser ?? 100000 < $1.distanceFromUser ?? 100000}
                                }
                            }
                            
                        }
                    }
                    
                    withAnimation(.easeIn(duration: 3)){
                        size = 1.5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        hasEthernet = NetworkConnection.shared.isConnected
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        isActive = true
                    }
                    
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
