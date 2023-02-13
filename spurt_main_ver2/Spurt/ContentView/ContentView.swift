//
//  ContentView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoading: Bool = true           // LaunchScreenView 변수
    @State private var selectedView: Int? = 0   // 최초 View 선택
    @ObservedObject var timer = TimerView()     // 시험 D-day
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY월 M월 d일(E)"
        return formatter
    }()
    
    var body: some View {
        
        ZStack {
            
            TabView {
                
                ContentTestView()
                    .tabItem {
                        Image(systemName: "pencil.line")
                        Text("모의고사")
                    }
                
                ContentReportView()
                    .tabItem {
                        Image(systemName: "doc.plaintext")
                        Text("학습 리포트")
                    }
                
                ContentSeeMoreView()
                    .tabItem {
                        Image(systemName: "ellipsis.circle")
                        Text("더보기")
                    }
                
            } // TabView
            
            // Launch Screen
            if isLoading {
                LaunchScreenView.transition(.opacity).zIndex(1)
            }
            
        } // ZStack
        .onAppear { // LaunchScreenView 1.0초간 유지
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                withAnimation { isLoading.toggle() }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
