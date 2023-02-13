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
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var fileName: String
    @State private var showingAlert = false

    var body: some View {
        
        VStack {
            
            // 타이틀 바
            ZStack {
                
                // 종료 버튼
                HStack {
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
                                Text("10분 0초 남았습니다.")
                            }
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 7.5, trailing: 0))
                    Spacer()
                }
                
                // 파일명
                HStack {
                    Spacer()
                    Text(fileName)
                    Spacer()
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 7.5, trailing: 0))
            }
            
            Divider()
            
            // 컨텐츠
            HStack {
                    
                // PDF
                PdfUIView(fileName: $fileName)
                
                // OMR
                OMRCard()
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
