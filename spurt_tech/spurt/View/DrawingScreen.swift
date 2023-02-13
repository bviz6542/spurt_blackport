//
//  DrawingScreen.swift
//  spurt
//
//  Created by 정준우 on 2022/11/25.
//


/*
import SwiftUI
import PencilKit
import PDFKit

struct DrawingScreen: View{
    // @EnvironmentObject var model: DrawingViewModel
    var body: some View{
        //CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker)
        
        gogoView()
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        gogoView()
    }
}

struct gogoView: UIViewRepresentable{
    
    func makeUIView(context: Context) -> PDFView {
        
        let path = Bundle.main.url(forResource: "test", withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.delegate = context.coordinator
        
        let annotation = LineAnnotation()
        let firstPage = pdfView.document?.page(at: 0)
        firstPage?.addAnnotation(annotation)
        
        return pdfView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, PDFDocumentDelegate, PDFViewDelegate{
        
    }
}


struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .pencilOnly
        //
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        let subView = canvas.subviews[0]
        subView.addSubview(pdfView)
        //subView.sendSubviewToBack(pdfView)
        //canvasView.addArrangedSubview(canvasView)
        pdfView.leadingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.bottomAnchor).isActive = true

        let path = Bundle.main.url(forResource: "test", withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        pdfView.document = pdfDocument
        //
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

class LineAnnotation: PDFAnnotation {
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        // Draw original content under the new content.
        super.draw(with: box, in: context)
        
        // Draw a custom purple line.
        UIGraphicsPushContext(context)
        context.saveGState()
        
        let path = UIBezierPath()
        path.lineWidth = 10
        path.move(to: CGPoint(x: bounds.minX + startPoint.x, y: bounds.minY + startPoint.y))
        path.addLine(to: CGPoint(x: bounds.minX + endPoint.x, y: bounds.minY + endPoint.y))
        UIColor.systemPurple.setStroke()
        path.stroke()

        context.restoreGState()
        UIGraphicsPopContext()
    }
}
*/
