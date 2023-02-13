//
//  OMRCard.swift
//  Spurt
//
//  Created by 이제홍 on 2022/12/22.
//

// 시험 카테고리 선택: subjectNum=3으로 임의 설정한 버전

import SwiftUI

// 시험 카테고리 선택 버튼
struct TestCategoryCard: View {

    @Binding var testCategoryDict: [String: [String]]
    @Binding var examSelectionNum: Int     // 고른 시험 종류
    @Binding var subjectSelectionNum: Int  // 고른 과목 종류
    
    @State var subjectNum: Int = 3
    @State var subjectList: [String] = ["", "", ""]
    
    var body: some View {
        
        let examNum  = testCategoryDict.count               // 시험 종류 수
        let examList = testCategoryDict.keys.sorted(by: <)  // 시험 종류
        
        VStack(spacing: 10) {
            
            // 시험 종류 선택
            HStack(spacing: 15) {
                
                Spacer().frame(width: 15)
                
                ForEach(0..<examNum) { examIdx in
                    Button(action: {
                        self.examSelectionNum = examIdx
                        
                        subjectNum  = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.count  // 과목 종류 수
                        subjectList = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.sorted(by: <) // 과목 종류
                    }) {
                        Text("\(Array(examList)[examIdx])")
                            .padding(10)
                            .fontWeight(.bold)
                            .foregroundColor(self.examSelectionNum == examIdx ? Color.white : Color("darkGray"))
                            .background(self.examSelectionNum == examIdx ? Color("blackGray") : Color.white)
                            .clipShape(Capsule())
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(self.examSelectionNum == examIdx ? Color("blackGray") : Color("darkGray"), lineWidth: 2))
                    }
                }
                
                Spacer()
                
            } // HStack
            
            // 시험 과목 선택
            HStack(spacing: 15) {
                
                Spacer().frame(width: 15)
                
                ForEach(0..<subjectNum) { subjectIdx in
                    Button(action: {
                        self.subjectSelectionNum = subjectIdx
                    }) {
                        Text("\(subjectList[subjectIdx])")
                            .padding(10)
                            .fontWeight(.bold)
                            .fontWeight(self.subjectSelectionNum == subjectIdx ? .bold : nil)
                            .foregroundColor(self.subjectSelectionNum == subjectIdx ? Color.white : Color("darkGray"))
                            .background(self.subjectSelectionNum == subjectIdx ? Color("spurtRed") : Color.white)
                            .clipShape(Capsule())
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(self.subjectSelectionNum == subjectIdx ? Color("spurtRed") : Color("darkGray"), lineWidth: 2))
                    }
                }
                
                Spacer()
                
            } // HStack
            
            Spacer().frame(height: 5)
            
        } // VStack
        
        .navigationBarTitle("더보기")
    } // View
}
