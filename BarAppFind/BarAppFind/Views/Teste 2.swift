//
//  Teste.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 09/05/23.
//

import SwiftUI

struct CollapsableSectionsDemoView: View {
  
    let contacts = [
      "John",
      "Ashley",
      "Bobby",
      "Jimmy",
      "Fredie"
    ]
    
    struct ItemLista: Identifiable{
        let id = UUID()
        let title: String
        var ItensList: [ItemLista]?
    }
  
  var body: some View {
    NavigationView {
        VStack{
            List{
                Section("Horários de atendimento"){
                    ForEach(contacts, id: \.self){ contact in
                        Text(contact)
                    }
                }
            }
            
        }
    }
  }
}

struct CollapsableSectionsDemoView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableSectionsDemoView()
    }
}
