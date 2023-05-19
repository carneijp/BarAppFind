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
            
            HStack {
                VStack(alignment: .leading, spacing: 8){
                    Text(bar.name)
                        .font(.system(size: 16))
                        .bold()
                    
                    HStack{
                        Image(systemName: "star.fill")
                            .font(.system(size: 13))
                            .offset(y: -2)
                        
                        Text(String(format: "%.1f", bar.grade))
                            .font(.system(size: 14))
                        
                        Text("•")
                        
                        Text("\(bar.operatinHours[getDateOfweek()])")
                            .font(.system(size: 14))

                    }
                }
                
                Spacer ()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.all, 4)
                    .clipShape(Circle())
                    .shadow(radius: 2, y: 2)
                    .padding(.trailing, 6)
            }
            .padding(.top, 8)
            .padding(.horizontal)
        }
        .padding(.bottom)
        .background(Color("gray0"))
        .cornerRadius(15)
        .frame(width: 277, height: 228)
        .shadow(radius: 1, y: 2)
        
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
