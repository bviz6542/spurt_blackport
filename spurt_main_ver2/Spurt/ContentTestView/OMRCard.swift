//
//  OMRCard.swift
//  Spurt
//
//  Created by 이제홍 on 2022/12/22.
//

import SwiftUI

// PDFSheet의 OMR 부분
struct OMRCard: View {

    // TODO: 서버에서 testQuestionNum, questionAnswerNum 받아오기
    
    // Binding 변수
//    @Binding var testQuestionNum: Int                                  // 시험지 문항 수
//    @Binding var testMinutes: Int                                      // 시험 시간
    var testQuestionNum: Int = 40
    var testMinutes: Int = 45
    
    // 시험 관련 변수
    var questionAnswerNum           = 5                                // OMR 선택지 수
    let omrOptionList               = [Int](1...5)                     // OMR 선택지 종류
    @State public var omrAnswerList = [Int](repeating: -1, count: 40)  // OMR 정답 선택 인덱스 리스트
    @State var remainingAnswerNum   = 40                               // 풀지 않고 남은 문제 수
    
    // Timer
    @State private var remainingMinutes = ""
    @State private var remainingSeconds = ""
    @State private var timer: Timer?
    
    // 기타
    @State private var showingAlert = false                            // alert창 변수
    @Environment(\.presentationMode) var presentationMode              // 페이지 닫기
    
    var body: some View {

        VStack {
            
            // 1. 상단 제출 버튼
            Button(action: {
                self.showingAlert.toggle()
            }) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("spurtRed"))
                    .opacity(0.8)
                    .frame(width: 230, height: 50)
                    .overlay(
                        Text("제출하기")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white))
                    .overlay(RoundedRectangle(cornerRadius: 24)
                        .stroke(.white, lineWidth: 7)
                    )
                    .alert("제출하시겠습니까?", isPresented: $showingAlert) {
                        Button("취소", role: .cancel) {}
                        Button("제출", role: .destructive) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        // TODO: 시간 표시 연동
                        if (remainingAnswerNum == 0) {
                            Text("\(remainingMinutes) \(remainingSeconds) 남았습니다.")
                        } else {
                            Text("\(remainingAnswerNum)문제가 마킹되지 않았습니다.")
                        }
                    }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            
            // 2. OMR 카드의 Scroll 부분
            ScrollView() {
                
                VStack(spacing: 20) {
                    
                    // 2-1. Timer
                    HStack(alignment: .center) {
                        Image(systemName: "clock")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text(remainingMinutes)
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("blackGray"))
                            .frame(width: 55)
                        Text(remainingSeconds)
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("blackGray"))
                            .frame(width: 55)
                    }.onAppear(perform: startTimer)
                    
                    Rectangle()
                        .frame(width: 200, height: 1).opacity(0.5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    // 2-2. OMR
                    ForEach(0..<testQuestionNum) { questionIdx in
                        
                        HStack(spacing: 15) {
                            
                            // OMR 각 문제 번호
                            Text("\(questionIdx + 1).") // 10번째 문제마다 강조 표시
                                .foregroundColor(questionIdx % 10 == 9 ? Color("blackGray") : Color("darkGray"))
                                .fontWeight(questionIdx % 10 == 9 ? .bold : nil)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            
                            // OMR 각 문제 답 입력
                            ForEach(0..<questionAnswerNum) { option in
                                Button(action: {
                                    if (self.omrAnswerList[questionIdx] == option) {
                                        self.omrAnswerList[questionIdx] = -1
                                        remainingAnswerNum += 1
                                    } else {
                                        self.omrAnswerList[questionIdx] = option
                                        remainingAnswerNum -= 1
                                    }
                                }) {
                                    Text("\(self.omrOptionList[option])")
                                        .padding(5)
                                        .foregroundColor(self.omrAnswerList[questionIdx] == option ? Color.white : Color("blackGray"))
                                        .background(self.omrAnswerList[questionIdx] == option ? Color("blackGray") : Color.white)
                                        .clipShape(Capsule())
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color("blackGray"), lineWidth: 2))
                                }
                            }
                        } // HStack
                    }
                    
                } // VStack
                .padding(20)
                
            } // ScrollView
            .background(Color("lightGray"))
            
        } // VStack
        
    } // View
    
    // 타이머에 사용되는 함수
    private func startTimer() {
        let totalTime = Double(testMinutes) * 60
        let startTime = Date().timeIntervalSinceReferenceDate
        var currentTime = startTime
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            currentTime = Date().timeIntervalSinceReferenceDate
            let timeRemaining = totalTime - (currentTime - startTime)
            if timeRemaining > 0 {
                let minutesRemaining = Int(timeRemaining / 60)
                let secondsRemaining = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
                self.remainingMinutes = String(format: "%02d분", minutesRemaining)
                self.remainingSeconds = String(format: "%02d초", secondsRemaining)
            } else {
                self.remainingMinutes = "시간"
                self.remainingSeconds = "초과"
                timer.invalidate()
            }
        }
    }
}
