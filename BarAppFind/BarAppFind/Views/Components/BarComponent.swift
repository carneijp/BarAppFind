//
//  BarComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct BarComponent: View {
    @State var bar: Bar
    @Environment(\.dynamicTypeSize) var size
    @EnvironmentObject var cloud: Model
//    @Binding var showSignIn: Bool
    @Binding var showSignInList: Bool
    @Binding var viewIndex: Int
    @State var open: String = ""
    @State var close: String = ""
    @State var weekDay: String = ""
    
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
                            .accessibilityLabel(Text(bar.name))
                            .font(.subheadline)
//                            .lineLimit(1)
//                            .padding(.trailing, 4)
                        
                        if let distancia = bar.distanceFromUser{
                            Text(String(format: "• %.1fKm", distancia))
                                .accessibilityLabel(Text(String(format: "• %.1fKm", distancia)))
                                .font(.subheadline)
                                .padding(.leading, -5)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 0.5)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.primary)
                            .font(.footnote)
                        
                        
                            Text(String(format: "%.1f", bar.grade) + " • \(bar.operatinHours[getDateOfweek()])")
                            .accessibilityLabel(open != "Fechado" ? Text(String(format: "%.1f", bar.grade) + " estrelas, aberto \(weekDay) das \(open) até as \(close)") : Text(String(format: "%.1f", bar.grade) + " estrelas, fechado \(weekDay)"))
                            .font(.subheadline)
                        
                        Spacer()
                    }
                }
                if var cliente = cloud.client {
                    if cliente.favorites.contains(bar.name) {
                        Image(systemName:"heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
//                                if var cliente = cloud.client {
                                    var favorites = cliente.favorites
                                    if let index = favorites.firstIndex(of: bar.name) {
                                        favorites.remove(at: index)
                                    }
                                    cliente = cliente.updateClient(newFavorites: favorites)
                                    cloud.updateUser(updatedUser: cliente) { _ in }
//                                }
                            }
                            .accessibilityLabel("Favoritar")
                    }else{
                        Image(systemName: "heart")
                            .onTapGesture {

                                    var favorites = cliente.favorites
                                    favorites.append(bar.name)
                                    cliente = cliente.updateClient(newFavorites: favorites)
                                    cloud.updateUser(updatedUser: cliente) { _ in }

                            }
                    }
                    
                }
            }
        }
        .task {
            
            let separatedString = bar.operatinHours[getDateOfweek()].components(separatedBy: ":")
            self.weekDay = String(separatedString[0])
            
            if separatedString[1] != " Fechado" {
                let secondSeparatedString = separatedString[1].components(separatedBy: "-")
                self.open = String(secondSeparatedString[0])
                self.close = String(secondSeparatedString[1])
            }else {
                
                self.open = "Fechado"
            }
        }
    }
    
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
    }
}
