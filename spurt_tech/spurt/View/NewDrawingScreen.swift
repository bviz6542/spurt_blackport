//
//  NewDrawingScreen.swift
//  spurt
//
//  Created by 정준우 on 2022/11/25.
//

import SwiftUI
import PDFKit
import PencilKit

struct NewDrawingScreen: View{
    @State private var showScreen: Bool = false
    var body: some View{
        VStack{
            Text("Greetings for you all")
            NavigationLink(destination: BasicVC()){
               RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .opacity(0.25)
                    .frame(width: 200, height: 60)
                    .overlay(Text("open pdf")
                        .font(.largeTitle).foregroundColor(.blue))
            }
            .navigationBarTitle("Select PDF Page")
        }
    }
}

struct NewDrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewDrawingScreen()
    }
}

struct BasicVC: UIViewRepresentable{
    let pdfView = PDFView()
    func makeUIView(context: Context) -> PDFView {
        
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.delegate = context.coordinator
        pdfView.pageOverlayViewProvider = context.coordinator
        pdfView.usePageViewController(true)
        pdfView.backgroundColor = .clear
        let path = Bundle.main.url(forResource: "test", withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        pdfView.document = pdfDocument
        pdfDocument?.delegate = context.coordinator
        
        return pdfView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        let toolPicker: PKToolPicker = PKToolPicker()
        toolPicker.setVisible(true, forFirstResponder: pdfView)
        pdfView.becomeFirstResponder()
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // UIKit에서 SwiftUI로 정보 전송
    class Coordinator: NSObject, PDFViewDelegate, PDFPageOverlayViewProvider, PDFDocumentDelegate{
        var pageToViewMappping = [PDFPage: UIView]()
        func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
            
            var resultView: PKCanvasView? = nil
            if let overlayView = pageToViewMappping[page] {
                resultView = overlayView as? PKCanvasView
            } else{
                let canvasView = PKCanvasView(frame: .zero)
                canvasView.drawingPolicy = .pencilOnly
                canvasView.tool = PKInkingTool(.pen, color: .systemYellow, width: 20)
                canvasView.backgroundColor = UIColor.clear
                pageToViewMappping[page] = canvasView
                resultView = canvasView
            }
        
            let page = page as? MyPDFPage
            if let drawing = page?.drawing{
                resultView?.drawing = drawing;
            }
            return resultView
        }
        func pdfView(_ pdfView: PDFView, willDisplayOverlayView overlayView: UIView, for page: PDFPage) {
            print("\n등장--")
        }
        func pdfView(_ pdfView: PDFView, willEndDisplayingOverlayView overlayView: UIView, for page: PDFPage) {
            let overlayView = overlayView as! PKCanvasView
            let page = page as? MyPDFPage
            print("\n--후퇴")
            page?.drawing = overlayView.drawing
            if let page: MyPDFPage = page{
                pageToViewMappping.removeValue(forKey: page)
            }
        }
        
        func classForPage() -> AnyClass {
            return MyPDFPage.self
        }
        func `class`(forAnnotationType annotationType: String) -> AnyClass {
            return MyPDFAnnotation.self
        }
    }
}

class MyPDFPage: PDFPage{
    var drawing: PKDrawing? = PKDrawing()
}

class MyPDFAnnotation: PDFAnnotation{
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        UIGraphicsPushContext(context)
        
        print("\n킹받아")
        
        context.saveGState()
        let page = self.page as! MyPDFPage
        if let drawing = page.drawing{
            let image = drawing.image(from: drawing.bounds, scale: 1)
            image.draw(in: drawing.bounds)
        }
        context.restoreGState()
        UIGraphicsPopContext()
    }
}

class MyPDFDocument: UIDocument{
    var pdfDocument: PDFDocument?
    override func contents(forType typeName: String) throws -> Any {
        print("\nㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ")
        if let pdfDocument = pdfDocument {
            for i in 0...pdfDocument.pageCount-1 {
                if let page = pdfDocument.page(at:i){
                    if let drawing = (page as! MyPDFPage).drawing{
                        let newAnnotation = MyPDFAnnotation(bounds: drawing.bounds, forType: .stamp, withProperties: nil)
                        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: drawing, requiringSecureCoding: true)
                        newAnnotation.setValue(codedData, forAnnotationKey: PDFAnnotationKey(rawValue: "drawingData"))
                        page.addAnnotation(newAnnotation)
                    }
                }
            }
            if let resultData = pdfDocument.dataRepresentation(){
                return resultData
            }
        }
        return Data()
    }
}
