//
//  MapPopUpComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 10/05/23.
//

import SwiftUI

struct MapPopUpComponent: View {
    var bar: Bar
    var body: some View {
        VStack(alignment: .leading) {
            if let photoLogo = bar.photosToUse[0], let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 277, height: 147)
                    .clipped()
                
            }
            VStack(alignment: .leading){
                HStack{
                    Text(bar.name)
                        .font(.system(size: 14))
                        .bold()
                    
//                    Text("•")
//
//                    Text("3km")
//                        .font(.system(size: 12))
                }
//                    .foregroundColor(.white)
                HStack{
                    Image(systemName: "star.fill")

                    
                    Text(String(format: "%.1f", bar.grade))
                        .font(.system(size: 14))
                    
                    Text("•")
                    
                    Text("\(bar.operatinHours[getDateOfweek()])")
                        .font(.system(size: 12))

                }
//                .foregroundColor(.primary)
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
        .background(Color("gray5"))
        .cornerRadius(15)
        .frame(width: 277, height: 228)
        
    }
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
    }
}

struct MapPopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapPopUpComponent(bar: Bar(name: "", description: "", mood: [""], grade: 0.0, latitude: 51, longitude: 51, operatinhours: [""], endereco: "", regiao: "", caracteristicas: [""]))
    }
}
