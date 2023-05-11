//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    var body: some View {
        Text("Profile View")
            .onAppear(){
//                cloud.addReview(review: Review(writerEmail: "JP@gmail.com", writerName: "Jao pAULAO", grade: 2, description: "Comida Top", barName: "Brita"))

//                cloud.addUser(clients: Clients(email: "EduardoRiboli71@gmail.con", firstName: "Edyardio", password: "321312", lastName: "Riboi"))
                
                cloud.validateClientLogin(email: "EduardoRiboli71@gmail.con", password: "321312") {
                    let client = cloud.client
                    
                    if client != nil {
                        cloud.addFavoriteBar(client: client!, barName: "Quentins")
                    }
                }
            }
        
        ForEach(cloud.reviewListByBar, id: \.self) { review in
            Text(review.writerEmail)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
