//
//  TimerView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/09/30.
//

import Foundation
import SwiftUI
import Combine
 
class TimerView: ObservableObject {
    
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
    
    // Yonsei University
    @Published var timeIntervalYonseiUnivTransfer = TimeInterval()
    @Published var dateIntervalYonseiUnivTransfer: Int = 0
    @Published var examDateYonseiUnivTransfer = TimerView.dateFormat.date(from: "2022-12-18") ?? Date()
    @Published var dDayYonseiUnivTransfer: String = ""
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTimer = Date()
            
            // 2023학년도 시험일 = 2022.12.25
            // 초 단위 차이
//            self.timeInterval = TimerView.dateFormat.date(from: "2022-12-25")?.timeIntervalSince(self.currentTimer) ?? 0
            
            // Korea University
            
            // 시간 차이
            self.timeIntervalKoreaUnivTransfer = self.examDateKoreaUnivTransfer.timeIntervalSince(self.currentTimer)
            // 시간 차이(일 단위)
            self.dateIntervalKoreaUnivTransfer = Int(self.timeIntervalKoreaUnivTransfer / 86400) + 1
            // D-day
            self.dDayKoreaUnivTransfer = self.dateIntervalKoreaUnivTransfer >= 0 ? "D-\(self.dateIntervalKoreaUnivTransfer)" : "D+\(-self.dateIntervalKoreaUnivTransfer)"
            
            
            // Yonsei University
            
            // 시간 차이
            self.timeIntervalYonseiUnivTransfer = self.examDateYonseiUnivTransfer.timeIntervalSince(self.currentTimer)
            // 시간 차이(일 단위)
            self.dateIntervalYonseiUnivTransfer = Int(self.timeIntervalYonseiUnivTransfer / 86400) + 1
            // D-day
            self.dDayYonseiUnivTransfer = self.dateIntervalYonseiUnivTransfer >= 0 ? "D-\(self.dateIntervalYonseiUnivTransfer)" : "D+\(-self.dateIntervalYonseiUnivTransfer)"
        }
    }
}
