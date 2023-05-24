//
//  Loading'Component.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 23/05/23.
//

import SwiftUI

struct LoadingViewModel: View {
//    @State private var progress: Float = 0.0
    
    var body: some View {
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
        .navigationTitle("Loading...")
        .navigationBarTitleDisplayMode(.inline)
//        .onAppear() {
//            withAnimation(Animation.linear(duration: 2.5).repeatForever()) {
//                progress = 0.92
//            }
//        }
        
    }
}

struct LoadingViewModel_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViewModel()
    }
}
