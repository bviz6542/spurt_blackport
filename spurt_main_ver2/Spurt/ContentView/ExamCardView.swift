//
//  ExamCardView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/17.
//

import SwiftUI
import WebKit

// ExamCard를 클릭했을 때 웹 화면을 띄워주는 View
struct ExamCardView: UIViewRepresentable {
    
    var urlToLoad: String
    
    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        // unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        
        // 웹뷰 인스턴스 생성
        let webview = WKWebView()
        
        // 웹뷰를 로드한다.
        webview.load(URLRequest(url: url))
        
        return webview
        
    }
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<ExamCardView>) {
        
    }
}


struct ExamCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExamCardView(urlToLoad: "https://www.naver.com")
    }
}
