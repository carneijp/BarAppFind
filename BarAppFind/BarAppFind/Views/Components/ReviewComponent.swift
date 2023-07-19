//
//  ReviewComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 08/05/23.
//

import SwiftUI

struct ReviewComponent: View {
    @State var showReviewOptions: Bool = false
    @State var showSheetReviewReport: Bool = false
    @EnvironmentObject var cloud: CloudKitCRUD
    let review: Review
    
    var body: some View {
        VStack{
            HStack{
                Text(review.writerName)
                    .font(.system(size: 16))
                    .padding(.top, 5)
                
                ForEach(1..<6){ i in
                    if(i<=Int(review.grade)){
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                    }
                    else{
                        Image(systemName: "star")
                            .font(.system(size: 14))
                    }
                }
                
                Spacer()
                Button(){
                    showReviewOptions = true
                }label: {
                    Text("•••")
                }
                .confirmationDialog("Gostaria de reportar este review?", isPresented: $showReviewOptions) {
                    Button("Reportar",role: .destructive) {
                        showSheetReviewReport = true
                    }
                }message: {
                    Text(review.writerName)
                }

            }
            .padding(.vertical, 5)
            HStack {
                Text(review.description)
                    .font(.system(size: 14))
                    .padding(.bottom, 10)
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Color("gray0"))
        .cornerRadius(12)
        
        .sheet(isPresented: $showSheetReviewReport){
            ReviewReport(showSheet: $showSheetReviewReport, review: review)
        }
    }
}

//struct ReviewComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewComponent(showReviewOptions: false, review: Review(writerEmail: "aa", writerName: "Eduardo", grade: 3, description: "muiro bom", barName: "aa", writerId: "abc"))
//    }
//}
