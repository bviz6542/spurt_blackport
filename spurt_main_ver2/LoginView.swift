////
////  LoginView.swift
////  Spurt
////
////  Created by 이제홍 on 2022/09/29.
////
//
//import AuthenticationServices
//import SwiftUI
//
//struct LoginView: View {
//
//    static let dateFormat: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY M월 d일(EE)    HH:mm:ss"
//        return formatter
//    }()
//
//    @ObservedObject var timer = TimerView()
//
//
//    // 애플로그인 변수
//    @Environment(\.colorScheme) var colorScheme
//
//    @AppStorage("email") var email: String = ""
//    @AppStorage("firstName") var firstName: String = ""
//    @AppStorage("lastName") var lastName: String = ""
//    @AppStorage("userId") var userId: String = ""
//
//    private var isSignedIn: Bool {
//        !userId.isEmpty
//    }
//
//    var body: some View {
//
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
