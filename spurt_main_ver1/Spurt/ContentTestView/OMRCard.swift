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
    var testQuestionNum             = 20                               // 시험지 문항 수
    var questionAnswerNum           = 5                                // OMR 선택지 수
    let omrOptionList               = [Int](1...5)                     // OMR 선택지 종류
    @State public var omrAnswerList = [Int](repeating: -1, count: 20)  // OMR 정답 선택 인덱스 리스트
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode              // 페이지 닫기


    var body: some View {

        ScrollView() {
            VStack(spacing: 20) {
                
                
                // OMR
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
                                self.omrAnswerList[questionIdx] = self.omrAnswerList[questionIdx] == option ? -1 : option
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

                // 제출 버튼
                Button(action: {
                    self.showingAlert.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color("spurtOrange"))
                        .opacity(0.8)
                        .frame(width: 200, height: 50)
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
                            Text("10분 0초 남았습니다.")
                        }
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 5))

            } // VStack
            .padding(20)
        } // ScrollView
        .background(Color("lightGray"))
    } // View
}

struct OMRCard_Previews: PreviewProvider {
    static var previews: some View {
        OMRCard()
    }
}
