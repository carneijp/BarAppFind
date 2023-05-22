//
//  FlemisModel.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 22/05/23.
//

import SwiftUI

struct FlemisViewModel: View {
    @State var isShowingWorkingHours: Bool = true
    var indexEntrada: Int
    var workingHours: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Horário de Atendimento")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.top)
                
                Button(action: {
                    self.isShowingWorkingHours.toggle()
                }, label: {
                    Image(systemName: self.isShowingWorkingHours ? "chevron.up" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 34)
                        .offset(y: 8)
                        .foregroundColor(Color("gray4"))
                })
                .frame(width: 14, height: 28)
                
            }
            .padding(.bottom, 5)
            
            if self.isShowingWorkingHours {
                
                ForEach(0..<self.workingHours.count, id:\.self){ i in
                    if i == indexEntrada{
                        Text("\(self.workingHours[i])")
                            .font(.system(size: 14))
                            .padding(.bottom, 5)
                            .bold()
                    }else{
                        Text("\(self.workingHours[i])")
                            .font(.system(size: 14))
                            .padding(.bottom, 5)
                    }
                }
                .scrollContentBackground(.hidden)

            }
        }
        
        
    }
}

struct FlemisViewModel_Previews: PreviewProvider {
    static var previews: some View {
        FlemisViewModel(indexEntrada: 0, workingHours: [])
    }
}
