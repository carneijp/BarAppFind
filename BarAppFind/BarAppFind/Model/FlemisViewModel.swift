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
                                                    let separatedString = self.workingHours[i].components(separatedBy: "-")
                                                if separatedString.count > 1 {
                                                    let open = String(separatedString[0])
                                                    let close = String(separatedString[1])
                                                    let secondSeparatedString = open.components(separatedBy: ":")
                                                    let weekDay = secondSeparatedString[0]
                                                    let newOpen = secondSeparatedString[1]
                                                    
                                                    if i == indexEntrada{
                                                        Text("\(self.workingHours[i])")
                                                            .font(.body)
                                                            .padding(.bottom, 5)
                                                            .bold()
                                                            .accessibilityLabel("\(weekDay) aberto das \(newOpen) até as \(close)")
                                                    }else{
                                                        Text("\(self.workingHours[i])")
                                                            .font(.body)
                                                            .padding(.bottom, 5)
                                                            .accessibilityLabel("\(weekDay) aberto das \(newOpen) até as \(close)")
                                                    }
                                                } else {
                                                    let separatedString = self.workingHours[i].components(separatedBy: ":")
                                                    let weekDay = String(separatedString[0])
                                                    let fechado = String(separatedString[1])
                                                    if i == indexEntrada{
                                                        Text("\(self.workingHours[i])")
                                                            .font(.body)
                                                            .padding(.bottom, 5)
                                                            .bold()
                                                            .accessibilityLabel("\(weekDay) está \(fechado)")
                                                    }else{
                                                        Text("\(self.workingHours[i])")
                                                            .font(.body)
                                                            .padding(.bottom, 5)
                                                            .accessibilityLabel("\(weekDay) está \(fechado)")
                                                    }
                                                }
                                                
                                                Spacer()
                                            }
                                        }
                                        .scrollContentBackground(.hidden)
                } label: {
                    Text("Horário de Atendimento")
                        .font(.title2)
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
