//
//  ErrorView.swift
//  Onde
//
//  Created by Isadora Brasil L. Brendler on 25/05/23.
//

//import Foundation
import SwiftUI
 
struct ErrorView: View {
    @Binding var noInternet: Bool
    var body: some View {
//        NavigationStack{
            ZStack{
                Color(.white)
                VStack{
                    LogoComponent()
                        .padding(.top, 20)
                    Spacer ()
                    Image ("erro404")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250, alignment:.center)
                    
                    Text ("Parece que tivemos um problema")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top)
                    Text ("Verifique sua conexão com a Internet")
                        .foregroundColor(.gray)
                    Spacer ()
                    Button{
                        self.noInternet = NetworkConnection.shared.isConnected
                    }label: {
                        Text("Tentar novamente")
                            .foregroundColor(.purple)
//                            .underline()
                    }
                    
//                    NavigationLink (destination: EmptyView(), label: { Text ("Tentar novamente") })
//                    //                    .underline()
//                        .foregroundColor(.purple)
//                        .underline()
                    
                    Spacer()
                }
                .padding(.horizontal,24)
            }
//        }
    }
}
//struct ErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//       ErrorView()
//    }
//}
