////
////  NoticeCard.swift
////  Spurt
////
////  Created by 이제홍 on 2022/11/06.
////
//
//import SwiftUI
//

// Animation 없는 버전

//struct NoticeCard : View {
//    
//    @State private var isNoticeActivated: Bool = false
//    
//    var noticeType : String
//    var noticeTitle : String
//    var noticeDate : String
//    var noticeContent : String
//    
//    var body: some View {
//                
//        VStack(alignment: .leading, spacing: 0) {
//            
//            HStack {
//                VStack (alignment: .leading) {
//                    Divider()
//                        .opacity(0)
//                    
//                    Spacer().frame(height: 5)
//
//                    Text("[\(noticeType)] \(noticeTitle)")
//                        .fontWeight(.bold)
//                        .font(.system(size: 20))
//
//                    Spacer().frame(height: 5)
//
//                    Text("\(noticeDate)")
//
//                    Spacer().frame(height: 5)
//                }
//                
//                Image(systemName: isNoticeActivated ? "chevron.down" : "chevron.right")
//                    .font(.system(size: 20))
//            }
//            
//            if isNoticeActivated {
//                
//                VStack(alignment: .leading) {
//                    Rectangle()
//                        .frame(width: .infinity, height: 1)
//                        .opacity(0)
//                    
//                    Text("\(noticeContent)")
//                        .font(.system(size: 20))
//                        .multilineTextAlignment(.leading)
//                        .background(Color("lightGray"))
//                }
//                .contentShape(Rectangle())
//
//            } // HStack
//        } // VStack
//        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//        .cornerRadius(20)
//        .contentShape(Rectangle())
//        .onTapGesture {
//            self.isNoticeActivated.toggle()
//        }
//    }
//}
//
//struct NoticeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NoticeCard(noticeType: "공지", noticeTitle: "제목", noticeDate: "2022-01-01", noticeContent: "공지사항입니다.")
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
