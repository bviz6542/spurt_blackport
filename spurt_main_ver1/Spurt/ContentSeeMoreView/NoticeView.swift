//
//  NoticeView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/06.
//

import SwiftUI

// 공지사항 View
struct NoticeView: View {
    
    @Binding var isNavigationBarHidden: Bool
    
    init(isNavigationBarHidden: Binding<Bool> = .constant(false)) {
        _isNavigationBarHidden = isNavigationBarHidden
    }
    
    var body: some View {
        
        List{
            NoticeCard(noticeType: "공지", noticeTitle: "스퍼트 베타버전이 출시되었습니다.", noticeDate: "2022.12.01.", noticeContent: "스퍼트 베타버전이 출시되었습니다. 많은 관심 부탁드려요.")
            
            ForEach(1...3, id: \.self){ itemIndex in
                NoticeCard(noticeType: "공지", noticeTitle: "제목\(itemIndex)", noticeDate: "2020.01.01.", noticeContent: "공지내용\(itemIndex)")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("공지사항")
        .onAppear{
            self.isNavigationBarHidden = false
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
