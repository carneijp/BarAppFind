//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var cloud = CloudKitCRUD()
    var body: some View {
        VStack{
            Button{
                cloud.addBar(bar: Bar(name: "Quentins", description: "Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino", fakeID: "1234", mood: ["Feliz", "Triste"], expensive: "4", grade: 4.0, latitude: -30.040181010490798, longitude: -51.21888666132587, operatinhours: ["Monday: 18:00-22:00", "Thruesday: 18:00-22:00"]))
            }
            label: {
                Text("Mochila Mochila...")
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
