////
////  ContentView.swift
////  Spurt
////
////  Created by 이제홍 on 2022/09/30.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @State var isLoading: Bool = true // LaunchScreenView 변수
//    @State private var selectedView: Int? = 0 // 최초 View 선택
//    @ObservedObject var timer = TimerView() // 시험 D-day
//    
//    static let dateFormat: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY월 M월 d일(E)"
//        return formatter
//    }()
//    
//    var body: some View {
//        
//        ZStack {
//            NavigationView {
//                
//                VStack(alignment: .leading, spacing: 0) {
//                    
//                    VStack {
//                        NavigationLink(destination: ExamCardView(urlToLoad: "http://oku.korea.ac.kr/attach/202112/1638320889913_0.pdf")){
//                            ExamCard(dDay: self.timer.dDayKoreaUnivTransfer, examName: "고려대학교 편입학 필기고사", examDate: self.timer.examDateKoreaUnivTransfer)
//                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
//                        }
//                        NavigationLink(destination: ExamCardView(urlToLoad: "http://att.pmg.co.kr/EtcData/board/5017/2022_%EC%97%B0%EC%84%B8%EB%8C%80%20%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf")){
//                            ExamCard(dDay: self.timer.dDayYonseiUnivTransfer, examName: "연세대학교 편입학 필기고사", examDate: self.timer.examDateYonseiUnivTransfer)
//                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
//                        }
//                    }
//                    .background(Color(uiColor: UIColor.systemGray6))
//                    
//                    List {
//                        NavigationLink(tag: 1, selection: self.$selectedView) {
//                            ContentTestsView()
//                        } label: {
//                            Label("모의고사", systemImage: "pencil.line")
//                        }
//                        
//                        NavigationLink {
//                            ContentReportsView()
//                        } label: {
//                            Label("학습 리포트", systemImage: "doc.plaintext")
//                        }
//                        
//                        NavigationLink {
//                            ContentSeeMoreView()
//                        } label: {
//                            Label("더보기", systemImage: "ellipsis.circle")
//                        }
//                    } // List
//                    .navigationBarHidden(true)
//
//                } // VStack
//     
//            } // NavigationView
//            .onAppear{
//                _ = UIDevice.current
//                self.selectedView = 1 // default view: tag==1
//            }
//            
//            // Launch Screen
//            if isLoading {
//                LaunchScreenView.transition(.opacity).zIndex(1)
//            }
//        } // ZStack
//        .onAppear { // LaunchScreenView 2초간 유지
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//                withAnimation { isLoading.toggle() }
//            })
//        }
//
//    }
//    
//    
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
