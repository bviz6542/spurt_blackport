//
//  LoginView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/09/29.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {

    // 카카오로그인 변수
    @StateObject var kakaoAuthVM : KakaoAuthVM = KakaoAuthVM()

    let loginStatusInt : (Bool) -> Int = { isLoggedIn in
        return isLoggedIn ? 1 : 0
    }

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY M월 d일(EE)    HH:mm:ss"
        return formatter
    }()

    @ObservedObject var timer = TimerView()


    // 애플로그인 변수
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""

    private var isSignedIn: Bool {
        !userId.isEmpty
    }

    var body: some View {

        NavigationView {
            VStack(spacing: 20){

                Spacer()

                Text("질주하는 모든 수험생을 응원합니다")
                    .font(.system(size: 40))
                    .fontWeight(.black)

                Text("\(self.timer.currentTimer, formatter: LoginView.dateFormat)")
                    .font(.system(size: 24))

                Spacer()

                Button(action: {
                    kakaoAuthVM.handleKakaoLogin()
                }) {
                    HStack {
                        Image(systemName: "message.fill")
                            .font(.system(size: 20))
                        Spacer()
                        Text("카카오 로그인")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .frame(width: 240)
                    .padding()
                    .foregroundColor(Color(red: 25/255, green: 25/255, blue: 25/255))
                    .background(Color(red: 254/255, green: 229/255, blue: 0/255))
                    .cornerRadius(6)
                }

                if !isSignedIn {
                    SignedInButtonView()
                }
                else {
                    // Signed In
                    Text("Welcome back!")
                }



                Spacer()
            }
//            Image("kakao_login_medium_narrow")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 240, height: 50)
//                .clipped
        }.navigationViewStyle(.stack)


    }
}

struct SignedInButtonView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""


    var body: some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in

            switch result {
            case .success(let auth):

                switch auth.credential {
                case let credential as ASAuthorizationAppleIDCredential:

                    // User ID
                    let userId = credential.user

                    // User Info
                    let email = credential.email
                    let firstName = credential.fullName?.givenName
                    let lastName = credential.fullName?.familyName

                    self.email = email ?? ""
                    self.userId = userId
                    self.firstName = firstName ?? ""
                    self.lastName = lastName ?? ""

                default:
                    break
                }

            case .failure(let error):
                print(error)
            }

        }
        .signInWithAppleButtonStyle(
            colorScheme == .dark ? .white : .black
        )
        .frame(width: 250, height: 50)
        .cornerRadius(6)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
