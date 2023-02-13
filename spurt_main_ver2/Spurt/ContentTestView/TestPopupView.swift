//
//  TestPopupView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/12/27.
//

// 시험 상세정보
import SwiftUI

struct TestPopupView: View {
    
    @Binding var showingTestPopup: Bool
    @Binding var showingPDFSheet: Bool
    @Binding var fileName: String
    @Binding var testThumbnail: TestThumbnail
    
    var body: some View {
            
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.vertical)
                .onTapGesture {
                    withAnimation(Animation.easeIn(duration: 0.1)) {
                        showingTestPopup.toggle()
                    }
                }
            
            VStack {
                
                // 시험 상세정보
                HStack {
                    Image(testThumbnail.imgName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200 * 1.414, alignment: .center)
                        .clipped()
                        .padding(EdgeInsets(top: 36, leading: 30, bottom: 24, trailing: 20))
                    
                    VStack(alignment: .leading) {
                        
                        Spacer().frame(height: 10)

                        // 과목명
                        Text(testThumbnail.subjectName)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("blackGray").opacity(0.9))
                        
                        Spacer().frame(height: 5)
                        
                        // 출제자
                        Text(testThumbnail.author)
                            .font(.system(size: 20))
                            .foregroundColor(Color("blackGray").opacity(0.9))

                        // 기타 정보
                        Text("최고점수: 90 / 100")
                            .font(.system(size: 20))
                            .foregroundColor(Color("blackGray").opacity(0.9))

                        Spacer()
                        
                    } // VStack
                    .frame(height: 200 * 1.414)
                    
                    Spacer()
                    
                } // HStack
                
                // 응시하기 버튼
                Button(action: {
                    self.showingTestPopup.toggle()
                    showingPDFSheet.toggle()
                }, label: {
                    Text("응시하기")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color("spurtOrange"))
                        .foregroundColor(Color.white)
                })
                .fullScreenCover(isPresented: $showingPDFSheet, content: {
                    PDFSheet(fileName: $fileName) //,
//                             testQuestionNum: $testThumbnail.testQuestionNum,
//                             testMinutes: $testThumbnail.testMinutes)
                })
            }
            .frame(width:600)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
        }
    }
}
