////
////  OMRCard.swift
////  Spurt
////
////  Created by 이제홍 on 2022/12/22.
////
//
//// 시험 카테고리 선택: testCategoryArr 만든 버전
//
//import SwiftUI
//
//// 시험 카테고리 선택 버튼
//struct TestCategoryCard: View {
//
//    var testCategoryDict = ContentTestView().testCategoryDict
//    var testCategoryArr  = [String]()
//    
//    @State var testCategoryArrKey = [String]()
//    @State var testCategoryArrVal = [String]()
//    
//    @State private var examSelectionNum = 0     // 고른 시험의 index
//    @State private var subjectSelectionNum = 0  // 고른 과목의 index
//    
//    @State var subjectNum: Int = 0           // 시험별 과목 종류 수
//    @State var subjectList: [String] = [""]     // 시험별 과목 종류
//    
//    init() {
//        for (key, value) in testCategoryDict {
//            testCategoryArr.append("\(key)$$\(value)")
//        }
//        
//        testCategoryArr = testCategoryArr.sorted(by: <)
//        
//        for item in testCategoryArr {
//            testCategoryArrKey.append(item.components(separatedBy: "$$")[0]
//                .replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
//                .replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil))
//            testCategoryArrVal.append(item.components(separatedBy: "$$")[1]
//                .replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
//                .replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil))
//        }
//        
//        subjectNum  = testCategoryArrVal[0].count
//        subjectList = testCategoryArrVal[0]
//            .replacingOccurrences(of: "[", with: "", options: NSString.CompareOptions.literal, range: nil)
//            .replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)
//            .components(separatedBy: ", ")
//    }
//    
//    var body: some View {
//        
//        let examNum  = testCategoryDict.count                // 시험 종류 수
//        let examList = testCategoryDict.keys.sorted(by: <)   // 시험 종류
//        
//        VStack(spacing: 10) {
//            
//            // 시험 종류 선택
//            HStack(spacing: 15) {
//                
//                Spacer().frame(width: 15)
//                
//                ForEach(0..<examNum) { examIdx in
//                    Button(action: {
//                        withAnimation(Animation.easeIn(duration: 0.1)) {
//                            self.examSelectionNum = examIdx
//
//                            subjectNum  = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.count  // 과목 종류 수
//                            subjectList = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!        // 과목 종류
////                            subjectNum  = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.count  // 과목 종류 수
////                            subjectList = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!        // 과목 종류
//                        }
//                    }) {
//                        Text("\(Array(examList)[examIdx])")
//                            .padding(10)
//                            .fontWeight(self.examSelectionNum == examIdx ? .bold : nil)
//                            .foregroundColor(self.examSelectionNum == examIdx ? Color.white : Color("spurtRed"))
//                            .background(self.examSelectionNum == examIdx ? Color("spurtRed") : Color.white)
//                            .clipShape(Capsule())
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 25)
//                                    .stroke(Color("spurtRed"), lineWidth: 2))
//                    }
//                }
//                
//                Spacer()
//                
//            } // HStack
//            
//            // 시험 과목 선택
//            HStack(spacing: 15) {
//                
//                Spacer().frame(width: 15)
//                
//                ForEach(0..<subjectNum) { subjectIdx in
//                    Button(action: {
//                        withAnimation(Animation.easeIn(duration: 0.1)) {
//                            self.subjectSelectionNum = self.subjectSelectionNum == subjectIdx ? 0 : subjectIdx
//                        }
//                    }) {
//                        Text("\(subjectList[subjectIdx])")
//                            .padding(10)
//                            .fontWeight(self.subjectSelectionNum == subjectIdx ? .bold : nil)
//                            .foregroundColor(self.subjectSelectionNum == subjectIdx ? Color.white : Color("spurtRed"))
//                            .background(self.subjectSelectionNum == subjectIdx ? Color("spurtRed") : Color.white)
//                            .clipShape(Capsule())
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 25)
//                                    .stroke(Color("spurtRed"), lineWidth: 2))
//                    }
//                }
//                
//                Spacer()
//                
//            } // HStack
//            
//            Spacer().frame(height: 5)
//            
//        } // VStack
//    } // View
//}
