//
//  PDFSheet.swift
//  Spurt
//
//  Created by 이제홍 on 2022/12/22.
//

import SwiftUI
import PDFKit
import PencilKit

struct PDFSheet: View {
    
    @ObservedObject var appDataView = AppDataView()
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var fileName: String      // 파일명
//    @Binding var testQuestionNum: Int  // 문항 수
//    @Binding var testMinutes: Int      // 시험시간
    
    @State private var showingAlert = false
    @State private var isOmrRightSide = true
    
    var body: some View {
        
        VStack {
            
            // 타이틀 바
            HStack {
                
                // 종료 버튼
                Button(action: {
                    self.showingAlert.toggle()
                }) {
                    Image(systemName: "xmark")
                        .alert("시험을 종료할까요?", isPresented: $showingAlert) {
                            Button("취소", role: .cancel) {}
                            Button("확인", role: .destructive) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } message: {
                            Text("답안을 제출하지 않습니다.")
                        }
                }
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 7.5, trailing: 0))
                Spacer()
                
                // 파일명
                HStack {
                    Spacer()
                    Text(fileName)
                    Spacer()
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 7.5, trailing: 0))
                Spacer()
                
                // OMR 위치 버튼4
                Button(action: {
                    self.showingAlert.toggle()
                }) {
                    Image(systemName: "sidebar.left")
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 7.5, trailing: 20))
            }
            Divider()
            
            // 컨텐츠
            HStack {
                    
                // PDF
                PdfUIView(fileName: $fileName)
                
                // OMR
                OMRCard() //testQuestionNum: $testQuestionNum, testMinutes: $testMinutes)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PdfUIView: UIViewRepresentable{
    
    @Binding var fileName: String
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        let path = Bundle.main.url(forResource: fileName, withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        pdfView.document = pdfDocument
        return pdfView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    class Coordinator: NSObject, PDFViewDelegate {
        
    }
}
