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
//                Text("Horário de Atendimento")
//                    .font(.system(size: 20))
//                    .bold()
//                    .foregroundColor(.primary)
//                    .padding(.top)
//
//                Button(action: {
//                    self.isShowingWorkingHours.toggle()
//                }, label: {
//                    Image(systemName: self.isShowingWorkingHours ? "chevron.up" : "chevron.down")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 16, height: 34)
//                        .offset(y: 8)
//                        .foregroundColor(Color("gray4"))
//                })
//                .frame(width: 14, height: 28)
//                DisclosureGroup("Horário de Atendimento", isExpanded: $isShowingWorkingHours){
//                    ForEach(0..<self.workingHours.count, id:\.self){ i in
//                        HStack{
//                            if i == indexEntrada{
//                                Text("\(self.workingHours[i])")
//                                    .font(.system(size: 14))
//                                    .padding(.bottom, 5)
//                                    .bold()
//                            }else{
//                                Text("\(self.workingHours[i])")
//                                    .font(.system(size: 14))
//                                    .padding(.bottom, 5)
//                            }
//                            Spacer()
//                        }
//                    }
//                    .padding(.top)
//                    .scrollContentBackground(.hidden)
//                }
//                .font(.system(size: 20))
//                .bold()
//                .foregroundColor(.primary)
                DisclosureGroup(isExpanded: $isShowingWorkingHours){
                                        ForEach(0..<self.workingHours.count, id:\.self){ i in
                                            HStack{
                                                if i == indexEntrada{
                                                    Text("\(self.workingHours[i])")
                                                        .font(.body)
                                                        .padding(.bottom, 5)
                                                        .bold()
                                                }else{
                                                    Text("\(self.workingHours[i])")
                                                        .font(.body)
                                                        .padding(.bottom, 5)
                                                }
                                                Spacer()
                                            }
                                        }
//                                        .padding(.top)
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
            
//            if self.isShowingWorkingHours {
//
//                ForEach(0..<self.workingHours.count, id:\.self){ i in
//                    if i == indexEntrada{
//                        Text("\(self.workingHours[i])")
//                            .font(.system(size: 14))
//                            .padding(.bottom, 5)
//                            .bold()
//                            .animation(.easeIn, value: 10)
//                    }else{
//                        Text("\(self.workingHours[i])")
//                            .font(.system(size: 14))
//                            .padding(.bottom, 5)
//                            .animation(.easeIn, value: 10)
//                    }
//                }
//                .scrollContentBackground(.hidden)
//
//
//            }
        }
        
        
    }
}

struct FlemisViewModel_Previews: PreviewProvider {
    static var previews: some View {
        FlemisViewModel(indexEntrada: 0, workingHours: [])
    }
}
