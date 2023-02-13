//
//  HomeView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/18.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            Text("Logged in as user")
                .navigationBarTitle("Firebase Login")
                .navigationBarItems(trailing: Button("Log Out") {
                    self.userInfo.isUserAuthenticated = .signedOut
                })
        }
    }
}
