//
//  AboutTheBar.swift
//  Onde
//
//  Created by Eduardo Pretto on 23/05/23.
//

import SwiftUI

struct AboutTheBar: View {
    
    // MARK: - Setup View
    
    @EnvironmentObject var cloud: Model
    @Environment(\.dynamicTypeSize) private var size
    @State var bar: Bar
    
    // MARK: - Front-End View
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: BarName + Grade + Favorite
            HStack{
                Text(bar.name)
                    .font(.title2)
                    .bold()
//                    .lineLimit(1)
//                    .padding(.trailing)
                
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                
                let bar = bar
                let review = cloud.reviewListByBar.filter({ $0.barName == bar.name })
                let countBars = review.count
                
                if countBars == 0 {
                    Text(String(format: "%.1f", bar.grade))
                        .font(.body)
                }
                else {
                    var numeroDeEstrelas: String = String(format: "%.1f", getFinalGrade(from: bar, review: review))
                    Text(numeroDeEstrelas)
                        .font(.body)
                        .accessibilityLabel(numeroDeEstrelas + " estrelas")
                }
                
                Spacer()
                
                if var cliente = cloud.client {
                    if cliente.favorites.contains(bar.name){
                        Image(systemName:"heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                var favorites = cliente.favorites
                                if let index = favorites.firstIndex(of: bar.name) {
                                    favorites.remove(at: index)
                                }
                                cliente = cliente.updateClient(newFavorites: favorites)
                                cloud.updateUser(updatedUser: cliente) { _ in }
//                                cloud.removeFavoriteBar(client: cliente, barName: bar.name)
//                                let referencia = cliente.favorites.firstIndex(of: bar.name)
//                                cliente.favorites.remove(at: referencia ?? -1)
//                                cloud.client = cliente
                            }
                            .accessibilityLabel("Botão de favoritar já selecionado")
                    } else {
                        Image(systemName: "heart")
                            .onTapGesture {
                                var favorites = cliente.favorites
                                favorites.append(bar.name)
                                cliente = cliente.updateClient(newFavorites: favorites)
                                cloud.updateUser(updatedUser: cliente) { _ in }
//                                cloud.addFavoriteBar(client: cliente, barName: bar.name)
//                                cliente.favorites.append(bar.name)
//                                cloud.client = cliente
                            }
                            .accessibilityLabel("Botão de favoritar")
                    }
                    
                }
            }
            .padding(.top, 18)
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
            
            // MARK: Operation Hours
            let horario = bar.operatinHours[getDateOfweek()]
            if horario.localizedCaseInsensitiveContains("fechado"){
                Text(size == .accessibility5 ? "\(horario)" : "• \(horario)")
                    .font(.body)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(.red.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
                    .accessibilityLabel("horário de funcionamento: \(horario)")
            }else{
                Text(size == .accessibility5 ? "\(horario)" : "• \(horario)")
                    .font(.body)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(.green.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
                    .accessibilityLabel("horário de funcionamento: \(horario)")
            }
            
            // MARK: Description
            Text(bar.description)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom)
                .padding(.horizontal, 24)
            
            // MARK: Moods
            Text("Moods para este bar:")
                .padding(.horizontal, 24)
                .font(.body)
                .bold()
                .padding(.bottom, -8)
                .padding(.top, 10)
                .padding(.bottom, 6)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14){
                    let moods = bar.mood
                    ForEach(moods.indices, id:\.self) { indexMood in
                        NavigationLink {
                            MoodListView(moodName: moodsName[indexMood])
                                .toolbarRole(.editor)
                        } label: {
                            MoodSmallComponent(moodName: moodsName[indexMood])
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 24)
            }
            
            // MARK: About Enviroment
            HStack {
                Text("Sobre o ambiente")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            
            let caracteristicas = bar.caracteristicas
            VStack(alignment: .leading){
                ForEach(caracteristicas, id:\.self){ caracteristica in
                    Text("• \(caracteristica)")
                        .font(.title3)
                        .padding(.bottom, 3)
                }
            }
            .padding(.horizontal, 24)
        }
        
    }
}

// MARK: - Auxiliar Functions

extension AboutTheBar {
    func getFinalGrade(from bar: Bar, review: [Review]) -> Double {
        let grade = review.map{$0.grade}.reduce(0, +)
        let finalGrade = Double(grade) / Double(review.count)
        var index: Int = 0
        
        for i in 0..<cloud.barsList.count{
            if cloud.barsList[i].name == bar.name{
                index = i
                break
            }
        }
        
        if cloud.barsList.count <= 0 {
            return 0.0
        }
        
        cloud.barsList[index].grade = finalGrade
        let newBar = cloud.barsList[index].updateBar(newGrade: finalGrade)
        cloud.updateBar(updatedBar: newBar) { }
//        cloud.changeGrade(grade: finalGrade, barName: bar.name)
        
        return finalGrade
    }
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
    }
}


