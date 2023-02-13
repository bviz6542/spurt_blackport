//
//  SpurtApp.swift
//  Spurt
//
//  Created by 이제홍 on 2022/09/29.
//

import SwiftUI

@main
struct SpurtApp: App {
    
    // 앱 버전
    static let appVersion : String = "0.1"
    static var userID : String = "수험생"
    
    @UIApplicationDelegateAdaptor var appDelegate : AppDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
