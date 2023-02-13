//
//  LaunchScreenView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/13.
//

import SwiftUI

extension ContentView {
    
    var LaunchScreenView: some View {
        ZStack(alignment: .center) {
            
            LinearGradient(gradient: Gradient(colors: [.white, .white]),
                            startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            Image("spurt_logo_text")
                .frame(width: 500)
            
        }
    }
}
