//
//  TempTimer.swift
//  Spurt
//
//  Created by 이제홍 on 2023/01/10.
//

import SwiftUI

struct OMRCardTimer: View {
    var minutes: Int!
    @State private var remainingTime = ""
    @State private var remainingMinutes = ""
    @State private var remainingSeconds = ""
    @State private var timer: Timer?
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "clock")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            Text(remainingMinutes)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(Color("blackGray"))
                .frame(width: 55)
            Text(remainingSeconds)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(Color("blackGray"))
                .frame(width: 55)
        }.onAppear(perform: startTimer)
    }
    
    private func startTimer() {
        let totalTime = Double(minutes) * 60
        let startTime = Date().timeIntervalSinceReferenceDate
        var currentTime = startTime
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            currentTime = Date().timeIntervalSinceReferenceDate
            let timeRemaining = totalTime - (currentTime - startTime)
            if timeRemaining > 0 {
                let minutesRemaining = Int(timeRemaining / 60)
                let secondsRemaining = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
                self.remainingMinutes = String(format: "%02d분", minutesRemaining)
                self.remainingSeconds = String(format: "%02d초", secondsRemaining)
            } else {
                self.remainingMinutes = "시간"
                self.remainingSeconds = "초과"
                timer.invalidate()
            }
        }
    }
}

struct OMRCardTimer_Previews: PreviewProvider {
    static var previews: some View {
        OMRCardTimer()
    }
}
