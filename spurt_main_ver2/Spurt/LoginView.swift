//
//  LoginView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/18.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        Button("Login") {
            self.userInfo.isUserAuthenticated = .signedIn
        }
    }
}
