//
//  BarComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct BarComponent: View {
    @State var bar: Bar
    @EnvironmentObject var cloud: CloudKitCRUD
    @Binding var showSignIn: Bool
    @Binding var showSignInList: Bool
    @Binding var viewIndex: Int
    
    var body: some View {
        HStack {
            if let photoLogo = bar.photosLogo, let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 5)
//                    .shadow(color: .gray, radius: 2, x: 0, y: 2)

            }
            
            HStack {
                VStack {
                    HStack {
                        Text("**\(bar.name)**")
                            .font(.system(size: 14))
//                            .padding(.trailing, 4)
                        
                        if let distancia = bar.distanceFromUser{
                            Text(String(format: " • %.1fKm", distancia))
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                    .padding(.bottom, 0.5)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.primary)
                            .font(.system(size: 13))
                        
                        
                            Text(String(format: "%.1f", bar.grade) + "•  \(bar.operatinHours[getDateOfweek()])")
                                .font(.system(size: 14))
                        
                        Spacer()
                    }
                }
                if let cliente = cloud.client {
                    if cliente.favorites.contains(bar.name){
                        Image(systemName:"heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                cloud.removeFavoriteBar(client: cliente, barName: bar.name)
                                let referencia = cliente.favorites.firstIndex(of: bar.name)
                                cliente.favorites.remove(at: referencia ?? -1)
                                cloud.client = cliente
                            }
                    }else{
                        Image(systemName: "heart")
                            .onTapGesture {
                                cloud.addFavoriteBar(client: cliente, barName: bar.name)
                                cliente.favorites.append(bar.name)
                                cloud.client = cliente
                            }
                    }
                    
                } else{
                    Image(systemName: "heart")
                        .onTapGesture {
                            print("Voce deve estar logado para favoritar.")
                            if viewIndex == 0 {
                                showSignIn = true
                            } else {
                                showSignIn = false
                                showSignInList = true
                            }
                        }
                    
                    
                }
            }
        }
    }
    
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
    }
}

//struct BarComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        BarComponent(bar: Bar(name: "", description: "", mood: [], grade: 0.0, latitude: 0.0, longitude: 0.0, operatinhours: [], endereco: "", regiao: "", caracteristicas: []), showSignIn: .constant(true))
//    }
//}
