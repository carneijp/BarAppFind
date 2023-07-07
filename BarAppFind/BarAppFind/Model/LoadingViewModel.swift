//
//  Loading'Component.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 23/05/23.
//

import SwiftUI

struct LoadingViewModel: View {
    @State var hasEthernet: Bool = true
    
    var body: some View {
        if !hasEthernet {
            ErrorView(noInternet: $hasEthernet)
        }else{
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.top, 20)
                    .padding(.horizontal, 100)
                
                Text("Carregando...")
                    .font(.caption)
                    .foregroundColor(Color("gray2"))
                    .padding(.top, 10)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background()
            .onAppear {
                NetworkConnection.shared.startMonitoring()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    hasEthernet = NetworkConnection.shared.isConnected
                }
            }
        }
    }
}

struct LoadingViewModel_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViewModel()
    }
}
