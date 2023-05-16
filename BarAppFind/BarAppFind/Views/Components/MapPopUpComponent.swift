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
        VStack {
            if let photoLogo = bar.photosToUse[0], let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
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
                    .foregroundColor(.white)
                HStack{
                    Image(systemName: "star.fill")

                    
                    Text("\(bar.grade)")
                        .font(.system(size: 14))
                    
                    Text("•")
                    
                    Text("Hoje: 8h às 20h")
                        .font(.system(size: 12))

                }
                    .foregroundColor(.white)

            }
        }
        .padding(.bottom)
        .background(Color.gray)
        .cornerRadius(15)
        .frame(width: 225, height: 185)
        
    }
}

struct MapPopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapPopUpComponent(bar: Bar(name: "", description: "", mood: [""], grade: 0.0, latitude: 51, longitude: 51, operatinhours: [""], endereco: "", regiao: "", caracteristicas: [""]))
    }
}
