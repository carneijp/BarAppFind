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
    
//    init(isExpanded: Binding<Bool>, content: () -> Content, label: () -> Label)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                DisclosureGroup(isExpanded: $isShowingWorkingHours){
                                        ForEach(0..<self.workingHours.count, id:\.self){ i in
                                            HStack{
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
                                                Spacer()
                                            }
                                        }
                                        .scrollContentBackground(.hidden)
                } label: {
                    Text("Horário de Atendimento")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.vertical)
                }
            }
            .padding(.bottom, 5)
        }
        
        
    }
}

struct FlemisViewModel_Previews: PreviewProvider {
    static var previews: some View {
        FlemisViewModel(indexEntrada: 0, workingHours: [])
    }
}
