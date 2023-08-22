////
////  SerafiniComponent.swift
////  BarAppFind
////
////  Created by Guilherme Borges Cavali on 19/05/23.
////
//
//import SwiftUI
//
//struct SerafiniComponent: View {
//    @Binding var isShow: Bool
//    @EnvironmentObject var cloud: Model
//    @State var bar: Bar?
//
//    var body: some View {
//        VStack(spacing: 2) {
//            Text("Atenção!")
//                .font(.system(size: 28))
//                .bold()
//                .foregroundColor(.white)
//                .padding(.bottom, 6)
//
//            if let photoLogo = bar?.photosLogo, let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .clipShape(Circle())
//                    .frame(width: 100, height: 100)
//                    .padding(.vertical)
//            }
//
//            Text("Você está sendo convocado(a) a comparecer no maior evento do Academy 2023!")
//                .font(.system(size: 14))
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//                .padding(.bottom)
//
//            NavigationLink {
//                BarPageView(barname: "Casa Serafini")
//            } label: {
//                HStack {
//                    Spacer()
//                    Text("Baile Funk do Serafini!")
//                        .font(.system(size: 15))
//                        .foregroundColor(.black)
//                    Spacer()
//                }
//            }
//            .padding(.vertical, 10)
//            .padding(.horizontal, 24)
//            .background(.white)
//            .cornerRadius(10)
//            .shadow(radius: 1, y: 2)
//            .onTapGesture {
//                self.isShow = false
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width - 140)
//        .padding([.vertical, .horizontal], 30)
//        .background(LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
//        .cornerRadius(40)
//        .animation(.spring())
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
//        .background(.secondary.opacity(0.01))
//        .offset(y: isShow ? -10 : UIScreen.main.bounds.height)
//        .onTapGesture {
//            isShow = false
//        }
//        .onAppear() {
//            cloud.fetchBar(barName: "Casa Serafini") { bar in
//                self.bar = bar
//            }
//            self.cloud.reviewListByBar = []
//            cloud.fetchItemsReview(barName: "Casa Serafini") {}
//        }
//    }
//
//}
//
////struct SerafiniComponent_Previews: PreviewProvider {
////    static var previews: some View {
////        SerafiniComponent(isShow: .constant(true))
////    }
////}
