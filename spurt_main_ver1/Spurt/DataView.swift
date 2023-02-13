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
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    @Published var currentTimer = Date()
    
    // Korea University
    
    @Published var timeIntervalKoreaUnivTransfer = TimeInterval()
    @Published var dateIntervalKoreaUnivTransfer: Int = 0
    @Published var examDateKoreaUnivTransfer = TimerView.dateFormat.date(from: "2022-12-18") ?? Date()
    @Published var dDayKoreaUnivTransfer: String = ""
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTimer = Date()
            
            // 시간 차이
            self.timeIntervalKoreaUnivTransfer = self.examDateKoreaUnivTransfer.timeIntervalSince(self.currentTimer)
            // 시간 차이(일 단위)
            self.dateIntervalKoreaUnivTransfer = Int(self.timeIntervalKoreaUnivTransfer / 86400) + 1
            // D-day
            self.dDayKoreaUnivTransfer = self.dateIntervalKoreaUnivTransfer >= 0 ? "D-\(self.dateIntervalKoreaUnivTransfer)" : "D+\(-self.dateIntervalKoreaUnivTransfer)"
        }
    }
}
