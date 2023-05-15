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
    
    var body: some View {
        HStack {
            if let photoLogo = bar.photosLogo, let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primary, lineWidth: 0.5))
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 5)
            }

            HStack {
                VStack {
                    HStack {
                        Text("**\(bar.name)** • 3km")
                            .font(.system(size: 14))
                        
                        Spacer()
                    }
                    .padding(.bottom, 0.5)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text(String(format: "%.1f", bar.grade) + " • \(bar.operatinHours[0])")
                            .font(.system(size: 14))
                        
                        Spacer()
                    }
                }
                if let cliente = cloud.client {
                    if cliente.favorites.contains(bar.name){
                        Image(systemName:"heart.fill")
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
                        }
                }
            }
        }
    }
}

struct BarComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarComponent(bar: Bar(name: "", description: "", mood: [], grade: 0.0, latitude: 0.0, longitude: 0.0, operatinhours: [], endereco: "", regiao: "", caracteristicas: []))
    }
}
