//
//  DataView.swift
//  Spurt
//
//  Created by 이제홍 on 2023/01/09.
//

import SwiftUI

class DataView: ObservableObject {
    
    // 시험 카테고리 dict
    @Published var testCategoryDict = ["CPA"     : ["경영학", "경제원론", "상법", "세법개론", "회계학"],
                                       "LEET"    : ["추리논증", "언어이해", "논술"],
                                       "연고대편입" : ["수학", "물리", "화학", "생물", "지구과학", "정보"]]  // TestCategoryCard_legacy
    
    // 시험 목록 array
    @Published var testThumbnailList = [
        TestThumbnail(fileName: "PDF1", examName: "CPA", subjectName: "경영학", author: "금융감독원", imgName: "1"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF2", examName: "CPA", subjectName: "경제원론", author: "금융감독원", imgName: "2"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF3", examName: "CPA", subjectName: "상법", author: "금융감독원", imgName: "3"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF4", examName: "CPA", subjectName: "세법개론", author: "금융감독원", imgName: "4"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF5", examName: "CPA", subjectName: "회계학", author: "금융감독원", imgName: "5"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "추리논증", author: "법학전문대학원협의회", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "언어이해", author: "법학전문대학원협의회", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "LEET", subjectName: "논술", author: "법학전문대학원협의회", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "수학", author: "연세대학교", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "물리", author: "연세대학교", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "화학", author: "연세대학교", imgName: "6"), //, testQuestionNum: 20, testMinutes: 45),
        TestThumbnail(fileName: "PDF6", examName: "연고대편입", subjectName: "생물", author: "연세대학교", imgName: "6") //, testQuestionNum: 20, testMinutes: 45)
    ]
}
