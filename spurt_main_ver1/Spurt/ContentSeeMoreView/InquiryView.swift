//
//  InquiryView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/11/06.
//

import SwiftUI
import MessageUI


struct InquiryView : View {
    
    @State private var showingAlert = false // 문의접수 Alert
    @State var text: String = ""
    @Binding var isNavigationBarHidden: Bool
    
    init(isNavigationBarHidden: Binding<Bool> = .constant(false)) {
        _isNavigationBarHidden = isNavigationBarHidden
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnSubmit : some View { Button(action: {
        showingAlert = true
        }) {
            HStack {
                Text("접수하기")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 20))
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .foregroundColor(.accentColor)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack(alignment: .topLeading) {
                    let placeholder : String = "스퍼트는 소중한 피드백을 통해 매일 발전하고 있습니다. (10글자 이상)"
                    
                    TextEditor(text: $text)
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .lineSpacing(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        .disableAutocorrection(true)
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .lineSpacing(10)
                            .foregroundColor(Color.primary.opacity(0.25))
                            .padding(.top, 38)
                            .padding(.horizontal, 45)
                    }
                } // ZStack
                .frame(height: 300)

                // 접수하기 버튼
                if text.filter{!$0.isWhitespace}.count < 10 {
                    // 10글자 미만: 버튼 비활성화
                    
                    HStack {
                        Text("접수하기")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .foregroundColor(.gray)
                    .cornerRadius(40)
                    .overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(.gray, lineWidth: 2))
                }
                else {
                    // 10글자 이상: 버튼 활성화
                    btnSubmit
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("문의를 접수하시겠습니까?"),
                              primaryButton: .default(
                                Text("확인"), action: {
                                    presentationMode.wrappedValue.dismiss()}),
                              secondaryButton: .cancel(Text("취소")))
                    }
                }

                Rectangle()
                    .frame(maxHeight: .infinity)
                    .opacity(0)
            } // VStack
        }
        .navigationTitle("문의하기")
        .navigationViewStyle(.stack)
        .onAppear{
            self.isNavigationBarHidden = false
        }
        
    }
}

struct InquiryView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView()
    }
}
