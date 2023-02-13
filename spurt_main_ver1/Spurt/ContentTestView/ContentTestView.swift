//
//  ContentTestView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/10/07.
//

import SwiftUI

struct TestThumbnail: Identifiable {
    let id = UUID()
    let fileName: String
    let examName: String
    let subjectName: String
    let author: String
    let imgName: String
}

// 모의고사 탭 View
struct ContentTestView: View {

    // TODO: 1) 모의고사 클릭하면 해당 모의고사 Sheet 열기 2) Grid 출력 정상화 3) 데이터 송수신

    // 시험 카테고리 dict
    @State var testCategoryDict = ["CPA"     : ["경영학", "경제원론", "상법", "세법개론", "회계학"],
                                   "LEET"    : ["추리논증", "언어이해", "논술"],
                                   "연고대편입" : ["수학", "물리", "화학", "생물", "지구과학", "정보"]]  // TestCategoryCard_legacy

    
    // 시험 목록 array
    @State var testThumbnailList = [
        TestThumbnail(fileName: "PDF1", examName: "CPA", subjectName: "경영학", author: "금융감독원", imgName: "1"),
        TestThumbnail(fileName: "PDF2", examName: "CPA", subjectName: "경제원론", author: "금융감독원", imgName: "2"),
        TestThumbnail(fileName: "PDF3", examName: "CPA", subjectName: "상법", author: "금융감독원", imgName: "3"),
        TestThumbnail(fileName: "PDF4", examName: "CPA", subjectName: "세법개론", author: "금융감독원", imgName: "4"),
        TestThumbnail(fileName: "PDF5", examName: "CPA", subjectName: "회계학", author: "금융감독원", imgName: "5"),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "추리논증", author: "법학전문대학원협의회", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "언어이해", author: "법학전문대학원협의회", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "논술", author: "법학전문대학원협의회", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "수학", author: "연세대학교", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "물리", author: "연세대학교", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "화학", author: "연세대학교", imgName: "6"),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "생물", author: "연세대학교", imgName: "6")
    ]
    
    var testNum = 12                          // 총 시험 수
    var testPerRow = 3                        // 한 행 당 시험 수
    let spacing: CGFloat = 20                 // Grid 간격
    let columns: [GridItem]                   // LazyVGrid에 표시될 아이템
    
    @State var fileNameList: [String]         // 파일 이름
    @State var showingPDFSheetList: [Bool]    // 열린-닫힌 pdf 파일의 true-false 리스트
    @State var showingTestPopup: Bool = false // 모의고사 썸네일 클릭시 상세정보 팝업
    
    @State var examSelectionNum = 0     // 고른 시험 종류
    @State var subjectSelectionNum = 0  // 고른 과목 종류
    
    @State var showingPDFSheetIdx: Int = -1   // 팝업뷰에 파일 정보 전달하는 인덱스
    @State var fileName: String = ""
    
    @ObservedObject var data = DataView()     // 시험 D-day

    init() {
        columns = [GridItem](repeating: GridItem(.flexible(), spacing: spacing), count: testPerRow)
        fileNameList = ["PDF1", "PDF2", "PDF3", "PDF4", "PDF5", "PDF6", "PDF6", "PDF6", "PDF6", "PDF6", "PDF6", "PDF6"]
        showingPDFSheetList = [Bool](repeating: false, count: testNum)
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                // 커스텀 네비게이션 바
                HStack {
                    Text("모의고사")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                // 시험 종류 선택 버튼
                TestCategoryCard(testCategoryDict:    $data.testCategoryDict, //$testCategoryDict,
                                 examSelectionNum:    $examSelectionNum,
                                 subjectSelectionNum: $subjectSelectionNum)
                
                // 시험 썸네일 스크롤뷰
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing, pinnedViews: []) {
                        
                        ForEach(0..<testNum) { testIdx in
                            
                            var examNameTemp = testThumbnailList[testIdx].examName
                            
                            // 누른 버튼에 맞는 카테고리의 시험만 보여줌
                            if examNameTemp == data.testCategoryDict.keys.sorted(by:<)[examSelectionNum]{
                                
                                Button(action: {
                                    withAnimation(Animation.easeIn(duration: 0.1)) {
                                        showingTestPopup = true
                                        showingPDFSheetIdx = testIdx
                                        fileName = fileNameList[testIdx]
                                    }
                                }) {
                                    TestThumbnailView(testThumbnail: testThumbnailList[testIdx])
                                }
                                .buttonStyle(ThumbnailButtonStyle())
                                .fullScreenCover(isPresented: $showingPDFSheetList[testIdx],
                                                 content: {PDFSheet(fileName: $fileNameList[testIdx])
                                })
                            }
                            
                        }
                    } // LazyVGrid
                    .zIndex(1)
                    .padding(spacing)
                    
                } // ScrollView
                .padding(30 - spacing)
                .navigationViewStyle(.stack)
                
            } // VStack

            // 모의고사 눌렀을 때 상세정보 표시
            if $showingTestPopup.wrappedValue {
                TestPopupView(showingTestPopup: $showingTestPopup,
                              showingPDFSheet: $showingPDFSheetList[showingPDFSheetIdx],
                              fileName: $fileName,
                              testThumbnail: $testThumbnailList[showingPDFSheetIdx])
                .zIndex(2)
            }
            
            // 캡처/녹화 감지
            BlockView()
            
        } // ZStack
        
    } // View
    
}

// 썸네일 버튼 효과 지정
struct ThumbnailButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        } // ZStack
        .clipShape(Rectangle())
    }
}

// 썸네일 뷰
struct TestThumbnailView: View {
    
    let testThumbnail: TestThumbnail
    
    var body: some View {
        
        GeometryReader { reader in
            
            let imgWidth:  CGFloat = reader.size.width * 0.2
            let imgHeight: CGFloat = imgWidth * 1.414
            
            HStack {
                Image(testThumbnail.imgName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imgWidth, height: imgHeight, alignment: .center)
                    .clipped()
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 0))
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(testThumbnail.subjectName)
                        .font(.system(size: 20, weight: .medium))
                    
                    Text(testThumbnail.author)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                    
                } // VStack
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 0))
                
                Spacer()
                
            } // HStack
            .frame(width: reader.size.width, height: reader.size.height)
            .contentShape(Rectangle())
            .background(Color.white)
            
        } // GeometryReader
        .frame(height: 141.4 + 10)
        .border(Color("coolGray").opacity(0.7), width: 1)
    }
}

struct ContentTestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTestView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
