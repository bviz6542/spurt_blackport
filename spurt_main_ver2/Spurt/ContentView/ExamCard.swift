//
//  ExamCard.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/06.
//

import SwiftUI

// ContentView에서 시험 일정을 보여주는 Card
struct ExamCard : View {
    
    var dDay : String
    var examName : String
    var examDate : Date
    
    var body: some View {
            
        VStack(alignment: .leading, spacing: 0) {
            
            Divider().opacity(0)
            
            Text("\(dDay)")
                .fontWeight(.bold)
                .font(.system(size: 24))

                Spacer().frame(height: 5)
            
            Text("\(examName)")
                .fontWeight(.semibold)
                .font(.system(size: 22))
                .multilineTextAlignment(.leading)
            
            Spacer().frame(height: 2)
            
            Text("\(examDate, formatter: ContentView.dateFormat)")
                .font(.system(size: 18))
        } // VStack
        .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
        .foregroundColor(Color("blackGray"))
        .background(
           RoundedRectangle(cornerRadius: 20)
               .foregroundColor(.white)
               .shadow(color: .gray, radius: 1, x: 1, y: 1)
               .opacity(0.7)
           )
    }
}

struct ExamCard_Previews: PreviewProvider {
    static var previews: some View {
        ExamCard(dDay: "D-100", examName: "연세대 편입학 모의고사", examDate: Date())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
