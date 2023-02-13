//
//  NoticeCard.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/06.
//

// Animation 있는 버전, 수정 필요

import SwiftUI

struct NoticeCard : View {
    
    @State private var isNoticeActivated: Bool = false  // NoticeCard 클릭 시 활성화
    @State private var chevronRotationAngle: Double = 0        // Chevron 돌아가는 각도
    
    var noticeType : String
    var noticeTitle : String
    var noticeDate : String
    var noticeContent : String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                VStack (alignment: .leading) {
                    Divider()
                        .opacity(0)
                    
                    Spacer().frame(height: 5)

                    Text("[\(noticeType)] \(noticeTitle)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))

                    Spacer().frame(height: 5)

                    Text("\(noticeDate)")

                    Spacer().frame(height: 5)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .rotationEffect(Angle(degrees: chevronRotationAngle))
            }
            
            if isNoticeActivated {
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .opacity(0)
                    
                    Text("\(noticeContent)")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.leading)
                        .background(Color("lightGray"))
                }
                .contentShape(Rectangle())

            } // HStack
        } // VStack
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .cornerRadius(20)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                self.isNoticeActivated.toggle()
                chevronRotationAngle = chevronRotationAngle == 90 ? 0 : 90
            }
        }
    }
}

struct NoticeCard_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCard(noticeType: "공지", noticeTitle: "제목", noticeDate: "2022-01-01", noticeContent: "공지사항입니다.")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
