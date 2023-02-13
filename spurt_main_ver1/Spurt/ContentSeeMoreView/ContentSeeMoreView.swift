//
//  ContentSeeMoreView.swift
//  Spurt
//
//  Created by 이제홍 on 2022/10/07.
//

import SwiftUI

// 더보기 탭 View
struct ContentSeeMoreView: View {
    
    
    // 프로필 사진 변경
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY월 M월 d일(E)"
        return formatter
    }()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // 커스텀 네비게이션 바
                HStack {
                    Text("더보기")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                // 1. 사용자 정보
                VStack(alignment: .leading, spacing: 0) {
                    
                    Divider()
                        .opacity(0)
                    
                    HStack {
                        
                        Image("1")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray)
                            )
                        
                        Spacer().frame(width: 10)

                        Text("\(SpurtApp.userID)")
                            .fontWeight(.semibold)
                            .font(.system(size: 30))
                    }
                    Spacer().frame(height: 30)
                    
                    // 관심 시험 목록
                    HStack(spacing: 20) {
                        Text("편입학(연고대)")
                            .fontWeight(.bold)
                            .font(.system(size:14))
                            .foregroundColor(.accentColor)
                            .padding(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.accentColor, lineWidth: 2)
                            )
                    }
                    
                } // VStack
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 0))
                .frame(maxWidth: .infinity)
                
                List {
                    
                    // 1. 사용자 정보
                    Section(content: {
                        
                        // 1-1. 이름 변경
                        HStack {
                            Text("이름 변경")
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .font(.system(size:20))
                        .foregroundColor(.black)
                        .onTapGesture {
                            alertTF(title: "이름 변경",
                                    message: "이름은 30일에 한 번 변경할 수 있습니다.",
                                    hintText: "10글자 이내",
                                    primaryTitle: "확인",
                                    secondaryTitle: "취소") { text in
                                if text.filter({!$0.isWhitespace}).count <= 10 && text.filter({!$0.isWhitespace}).count > 0 {
                                    SpurtApp.userID = text
                                }
                            } secondaryAction: {}
                        }
                        
                        // 1-2. 프로필 사진 변경
                        Menu {
                            Button("프로필 사진 변경", action: {})
                            Button("프로필 사진 삭제", action: {})
                        } label: {
                            HStack {
                                Text("프로필 사진 변경")
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .font(.system(size:20))
                        .foregroundColor(.black)
                        
                    })
                    
                    // 2. 주요 항목
                    Section(content: {
                        
                        // 2-1. 공지사항
                        NavigationLink(destination: NoticeView()) {
                            Text("공지사항")
                                .font(.system(size:20))
                                .foregroundColor(.black)
                        }
                        
                        // 2-2. 문의하기
                        NavigationLink(destination: InquiryView()) {
                            Text("문의하기")
                                .font(.system(size:20))
                                .foregroundColor(.black)
                        }
                    })
                    
                    // 3. 비 주요 항목
                    Section(content: {
                        
                        // 3-1. 앱 버전
                        HStack {
                            Text("앱 버전")
                                .font(.system(size:20))
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                            Spacer()
                            Text(SpurtApp.appVersion)
                                .font(.system(size:20))
                                .foregroundColor(.gray)
                                .frame(alignment: .trailing)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        }
                    })
                }.listStyle(GroupedListStyle())
                
                // 3. 저작권
                Text("SPURT by BLACKPORT")
                    .font(.system(size: 16))
                    .foregroundColor(Color("darkGray"))
                
            } // VStack
            
        } // NavigationView
        .navigationTitle("더보기")
        .navigationViewStyle(.stack)
    }
}

struct ContentSeeMoreView_Previews: PreviewProvider {
    static var previews: some View {
        ContentSeeMoreView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

// 닉네임 수정 버튼 extension
extension View {
    // MARK: Alert TF
    func alertTF(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String)->(), secondaryAction: @escaping ()->()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in}))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text{
                primaryAction(text)
            }
            else {
                primaryAction("")
            }
        }))
        
        // MARK: Presenting Alert
        rootController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: Root View Controller
    func rootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
