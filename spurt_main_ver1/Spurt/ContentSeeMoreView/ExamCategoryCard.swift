////
////  ExamCategoryCard.swift
////  Spurt
////
////  Created by 이제홍 on 2023/01/09.
////
//
//import SwiftUI
//
//struct ExamCategoryCard: View {
//    var body: some View {
//
//        // 시험 목록 array
//        @State var testThumbnailList = [
//            TestThumbnail(fileName: "PDF1", examName: "CPA", subjectName: "경영학", author: "금융감독원", imgName: "1"),
//            TestThumbnail(fileName: "PDF2", examName: "CPA", subjectName: "경제원론", author: "금융감독원", imgName: "2"),
//            TestThumbnail(fileName: "PDF3", examName: "CPA", subjectName: "상법", author: "금융감독원", imgName: "3"),
//            TestThumbnail(fileName: "PDF4", examName: "CPA", subjectName: "세법개론", author: "금융감독원", imgName: "4"),
//            TestThumbnail(fileName: "PDF5", examName: "CPA", subjectName: "회계학", author: "금융감독원", imgName: "5"),
//            TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "추리논증", author: "법학전문대학원협의회", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "언어이해", author: "법학전문대학원협의회", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "논술", author: "법학전문대학원협의회", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "수학", author: "연세대학교", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "물리", author: "연세대학교", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "화학", author: "연세대학교", imgName: "6"),
//            TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "생물", author: "연세대학교", imgName: "6")
//        ]
//
//        var testNum = 12                          // 총 시험 수
//        var testPerRow = 3                        // 한 행 당 시험 수
//        let spacing: CGFloat = 20                 // Grid 간격
//        let columns: [GridItem]                   // LazyVGrid에 표시될 아이템
//
//        @State var fileNameList: [String]         // 파일 이름
//        @State var showingPDFSheetList: [Bool]    // 열린-닫힌 pdf 파일의 true-false 리스트
//        @State var showingTestPopup: Bool = false // 모의고사 썸네일 클릭시 상세정보 팝업
//
//        @State var examSelectionNum = 0     // 고른 시험 종류
//        @State var subjectSelectionNum = 0  // 고른 과목 종류
//
//        @State var showingPDFSheetIdx: Int = -1   // 팝업뷰에 파일 정보 전달하는 인덱스
//        @State var fileName: String = ""
//
//        // 시험 종류 선택
//        HStack(spacing: 15) {
//
//            Spacer().frame(width: 15)
//
//            ForEach(0..<examNum) { examIdx in
//                Button(action: {
//                    self.examSelectionNum = examIdx
//
//                    subjectNum  = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.count  // 과목 종류 수
//                    subjectList = testCategoryDict[Array(testCategoryDict.keys)[examIdx]]!.sorted(by: <) // 과목 종류
//                }) {
//                    Text("\(Array(examList)[examIdx])")
//                        .padding(10)
//                        .fontWeight(.bold)
//                        .foregroundColor(self.examSelectionNum == examIdx ? Color.white : Color("darkGray"))
//                        .background(self.examSelectionNum == examIdx ? Color("blackGray") : Color.white)
//                        .clipShape(Capsule())
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(self.examSelectionNum == examIdx ? Color("blackGray") : Color("darkGray"), lineWidth: 2))
//                }
//            }
//
//            Spacer()
//
//        } // HStack
//    }
//}
//
//struct ExamCategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ExamCategoryCard()
//    }
//}
