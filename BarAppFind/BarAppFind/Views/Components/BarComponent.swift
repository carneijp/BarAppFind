//
//  BarComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct BarComponent: View {
    var bar: Bar
    
    var body: some View {
        HStack {
            
            if let photoLogo = bar.photosLogo, let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 56, height: 56)
            }


            HStack {
                VStack {
                    HStack {
                        Text("**\(bar.name)** • 3km")
                            .font(.system(size: 14))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text("\(bar.grade) • \(bar.operatinHours[0])")
                            .font(.system(size: 14))
                        
                        Spacer()
                    }
                }
                
                Image(systemName: "heart")
                
            }
        }
    }
}

struct BarComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarComponent(bar: Bar(name: "", description: "", mood: [], grade: 0.0, latitude: 0.0, longitude: 0.0, operatinhours: [], endereco: "", regiao: "", caracteristicas: []))
    }
}
