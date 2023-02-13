//
//  MainView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView{
            LoginView()
                .tabItem({
                    Text("Login")
                })
                .tag(0)

            MainView()
                .tabItem({
                    Text("Main")
                })
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
