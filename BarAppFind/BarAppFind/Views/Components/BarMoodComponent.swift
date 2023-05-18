//
//  BarMoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

struct BarMoodComponent: View {
    @State var bar: Bar
    @EnvironmentObject private var cloud: CloudKitCRUD
    var moodColor: String
    
    var body: some View {
        VStack(spacing: 0) {
            // logo dos bares
            if let photoLogo = bar.photosLogo, let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height: 120)
            }
                        
            VStack(alignment: .leading, spacing: 6) {
                Text(bar.name)
                    .font(.system(size: 16))
                    .bold()
                
                HStack {
                    Image(systemName: "star.fill")
                    Text(String(format: "%.1f", bar.grade))
                        .font(.system(size: 14))

                    Spacer()
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color(moodColor))
            
        }
        .frame(width: 160)
        .background(.black)
        .cornerRadius(8)
        .shadow(radius: 3, x: 0, y: 2)

    }
}

struct BarMoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarMoodComponent(bar: Bar(name: "", description: "", mood: [], grade: 0.0, latitude: 0.0, longitude: 0.0, operatinhours: [], endereco: "", regiao: "", caracteristicas: []), moodColor: "casal")
    }
}
