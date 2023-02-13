//
//  ImageCanvas.swift
//  spurt
//
//  Created by 정준우 on 2022/12/23.
//

import SwiftUI
import PDFKit
import PencilKit

struct ImageCanvas: View {
    
    @StateObject var drawingvm = DrawingViewModel()
    
    var body: some View {
        Shoulder()
        //CanvasView()
    }
}

struct Shoulder: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        
        var canvas: PKCanvasView = PKCanvasView()
        var toolPicker: PKToolPicker = PKToolPicker()
        var pdfView = PDFView()
        
        canvas.tool = PKInkingTool(.pen, color: .black, width: 15)
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .pencilOnly
        
        pdfView.delegate = context.coordinator
        //pdfView.pageOverlayViewProvider = context.coordinator
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .horizontal
        
        let subView = pdfView.subviews[0]
        subView.addSubview(canvas)
        //canvas.addArrangedSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.bottomAnchor).isActive = true

        toolPicker.addObserver(canvas)
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        let path = Bundle.main.url(forResource: "test", withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        pdfView.document = pdfDocument
        
        return pdfView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, PDFViewDelegate, PDFPageOverlayViewProvider, PDFDocumentDelegate{
        var pageToViewMappping = [PDFPage: UIView]()
        func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
            
            var resultView: PKCanvasView? = nil
            if let overlayView = pageToViewMappping[page] {
                resultView = overlayView as? PKCanvasView
            } else{
                let canvasView = PKCanvasView(frame: .zero)
                canvasView.drawingPolicy = .anyInput
                canvasView.tool = PKInkingTool(.pen, color: .systemYellow, width: 20)
                canvasView.backgroundColor = UIColor.clear
                pageToViewMappping[page] = canvasView
                print(page)
                resultView = canvasView
            }
            //let page = page as? MyPDFPage
            //if let drawing = page?.drawing{
            //    resultView?.drawing = drawing;
            //}
            return resultView
        }
        func pdfView(_ pdfView: PDFView, willDisplayOverlayView overlayView: UIView, for page: PDFPage) {
        }
        func pdfView(_ pdfView: PDFView, willEndDisplayingOverlayView overlayView: UIView, for page: PDFPage) {
            let overlayView = overlayView as! PKCanvasView
            print("/n/n와우안녕친구들빡빡이아저씨야/n111")
            //let page = page as? MyPDFPage
            print("/n/n와우안녕친구들빡빡이아저씨야/n222")
            //page?.drawing = overlayView.drawing
            //if let page: MyPDFPage = page{
            //    pageToViewMappping.removeValue(forKey: page)
            //}
        }
    }
}

struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView // 왜 굳이 외부에서 캔버스 받아
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    /*
    let stackView = UIStackView()
    let canvasView: PKCanvasView = PKCanvasView()
    let quizView: UIImageView = UIImageView()
    
    var drawing = PKDrawing()
    var landscapeConstraint = [NSLayoutConstraint]()
    var portraitConstraint = [NSLayoutConstraint]()
    var toolPicker: PKToolPicker
    var longerWidth: CGFloat
    var shorterWidth: CGFloat
    var item: Initializers
    */
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.tool = PKInkingTool(.pen, color: .black, width: 15)
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .pencilOnly
        
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .horizontal
        
        let subView = canvas.subviews[0]
        subView.addSubview(pdfView)
        //canvasView.addArrangedSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: subView.safeAreaLayoutGuide.bottomAnchor).isActive = true

        toolPicker.addObserver(canvas)
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        let path = Bundle.main.url(forResource: "test", withExtension: "pdf")
        let pdfDocument = PDFDocument(url: path!)
        pdfView.document = pdfDocument
        
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
    /*
    func setLandscape() {
        
        let landscapeFrame = CGRect(x:0, y:0, width: self.item.quizWidthScale * self.longerWidth, height: self.item.quizHeightScale * self.longerWidth)
        let landscapeZoom = self.longerWidth / self.shorterWidth
        
        for constraint in self.portraitConstraint {
            constraint.isActive = false
        }
        for constraint in self.landscapeConstraint {
            constraint.isActive = true
        }
        self.quizView.frame = landscapeFrame
        self.canvasView.setZoomScale(landscapeZoom, animated: false)
        self.canvasView.minimumZoomScale = landscapeZoom
        self.canvasView.setContentOffset(CGPoint.zero, animated: false)
    }
    

    func setPortrait() {
        
        let portraitFrame = CGRect(x:0, y:0, width: self.item.quizWidthScale * self.shorterWidth, height: self.item.quizHeightScale * self.shorterWidth)
        let portraitZoom = self.shorterWidth / self.longerWidth
        
        for constraint in self.landscapeConstraint {
            constraint.isActive = false
        }
        for constraint in self.portraitConstraint {
            constraint.isActive = true
        }
        self.quizView.frame = portraitFrame
        self.canvasView.setZoomScale(portraitZoom, animated: false)
        self.canvasView.minimumZoomScale = 1.0
        self.canvasView.setContentOffset(CGPoint.zero, animated: false)
    }

    
    // 스택뷰 설정
    func setStackView() {
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let landscapeStackWidth = stackView.widthAnchor.constraint(equalToConstant: self.item.quizWidthScale * longerWidth)
        let landscapeStackHeight = stackView.heightAnchor.constraint(equalToConstant: self.item.quizHeightScale * longerWidth)
        landscapeConstraint += [landscapeStackWidth, landscapeStackHeight]
        
        let portraitStackWidth = stackView.widthAnchor.constraint(equalToConstant: self.item.quizWidthScale * shorterWidth)
        let portraitStackHeight = stackView.heightAnchor.constraint(equalToConstant: self.item.quizHeightScale * shorterWidth)
        portraitConstraint += [portraitStackWidth, portraitStackHeight]

        if self.item.isLandscape {
            landscapeStackWidth.isActive = true
            landscapeStackHeight.isActive = true
        } else {
            portraitStackWidth.isActive = true
            portraitStackHeight.isActive = true
        }
        
        self.setCanvasView()
    }
    

    // 캔버스뷰 설정
    private func setCanvasView() {
        
        stackView.addArrangedSubview(canvasView)
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        canvasView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        canvasView.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        
        canvasView.backgroundColor = .clear
        canvasView.bouncesZoom = false
        canvasView.bounces = false
        canvasView.showsVerticalScrollIndicator = false
        canvasView.showsHorizontalScrollIndicator = false
        canvasView.drawingPolicy = PKCanvasViewDrawingPolicy.pencilOnly
        canvasView.layer.cornerRadius = 10
        canvasView.isUserInteractionEnabled = true
        canvasView.drawingGestureRecognizer.isEnabled = true
    
        self.setToolkit()
        self.setQuizView()
    }
    
    // 펜슬 설정
    private func setToolkit() {
        
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        self.canvasView.becomeFirstResponder()
        
        self.loadCanvasData()
    }
    
    // 퀴즈뷰 설정
    private func setQuizView() {

        if let contentView = canvasView.subviews.first {
            contentView.insertSubview(quizView, at: 0)
            let urlContents = try? Data(contentsOf: self.item.sampleQuizImage)
            if let imageData = urlContents {
                quizView.image = UIImage(data: imageData)!
            }
        }
        
        quizView.accessibilityViewIsModal = true
        quizView.translatesAutoresizingMaskIntoConstraints = false
        let landscapeQuizWidth = quizView.widthAnchor.constraint(equalToConstant: self.item.quizWidthScale * longerWidth)
        let landscapeQuizHeight = quizView.heightAnchor.constraint(equalToConstant: self.item.quizHeightScale * longerWidth)
        let portraitQuizWidth = quizView.widthAnchor.constraint(equalToConstant: self.item.quizWidthScale * shorterWidth)
        let portraitQuizHeight = quizView.heightAnchor.constraint(equalToConstant: self.item.quizHeightScale * shorterWidth)

        if self.item.isLandscape {
            landscapeQuizWidth.isActive = true
            landscapeQuizHeight.isActive = true
        } else {
            portraitQuizWidth.isActive = true
            portraitQuizHeight.isActive = true
        }
        
        canvasView.contentInset = UIEdgeInsets.zero
        canvasView.setContentOffset(CGPoint.zero, animated: true)
        canvasView.maximumZoomScale = 3.0
    }

    // 캔버스데이터 불러오기
    func loadCanvasData() {
        let getCanvas = self.canvasView
        var planDraw = Data()
        planDraw = DataBase.getData((.init(rawValue: self.item.saveCase) ?? .problem), id: self.item.id)
        do {
//                let fileManager = FileManager.default
//                let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                let directoryURL = documentsURL.appendingPathComponent(self.item.directoryName, isDirectory: true)
//                let pencilDirURL = directoryURL.appendingPathComponent("p_pencil", isDirectory: true)
//                let filePath = pencilDirURL.appendingPathComponent(self.item.fileName+".data", isDirectory: true)
//                let getDraw = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(contentsOf: filePath)) as? PKDrawing
            let getDraw = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(planDraw) as? PKDrawing
            DispatchQueue.main.async {
                getCanvas.drawing = getDraw ?? PKDrawing()
            }
        } catch {
        print(error)
        }
    }
     */
}

struct ImageCanvas_Previews: PreviewProvider {
    static var previews: some View {
        ImageCanvas()
    }
}

