//
//  UserSettings.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/17.
//

import Foundation

class UserSettings: ObservableObject {
    enum Sex: String {
        case male
        case female
        case other
    }
    
    enum Exam: String {
        case transfer_yk        // 연고대 편입
        case transfer_other     // 타대학 편입
        case toeic              // 토익
        case teps               // 텝스
        case cpa                // CPA
        case mdeet              // MDEET
        case leet               // LEET
        case suneung            // 수능
        case governmentofficer  // 공무원
        case firefighter        // 소방
        case policeofficer      // 경찰
        case other
    }

    @Published var name: String? = "수험생"
    @Published var sex: Sex
    @Published var exam: Exam

    init(name: String, sex: Sex, exam: Exam) {
        self.name = name
        self.sex = sex
        self.exam = exam
    }
}
