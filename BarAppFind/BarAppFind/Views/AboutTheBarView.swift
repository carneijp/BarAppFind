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
                        .font(.system(size: 14))
                }
                else {
                    Text(String(format: "%.1f", getFinalGrade(from: bar, review: review)))
                        .font(.system(size: 14))
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
                    }
                    
                }
            }
            .padding(.top, 18)
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
            
            // MARK: Operation Hours
            let horario = bar.operatinHours[getDateOfweek()]
            if horario.localizedCaseInsensitiveContains("fechado"){
                Text("• \(bar.operatinHours[getDateOfweek()])")
                    .font(.system(size: 14))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(.red.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
            }else{
                Text("• \(bar.operatinHours[getDateOfweek()])")
                    .font(.system(size: 14))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(.green.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
            }
            
            // MARK: Description
            Text(bar.description)
                .font(.system(size: 16))
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom)
                .padding(.horizontal, 24)
            
            // MARK: Moods
            Text("Moods para este bar:")
                .padding(.horizontal, 24)
                .font(.system(size: 16))
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
                    .font(.system(size:20))
                    .bold()
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            
            let caracteristicas = bar.caracteristicas
            VStack(alignment: .leading){
                ForEach(caracteristicas, id:\.self){ caracteristica in
                    Text("• \(caracteristica)")
                        .font(.system(size: 16))
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


