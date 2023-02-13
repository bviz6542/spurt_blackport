//
//  ModuleScrollView.swift
//  spurt
//
//  Created by 정준우 on 2022/12/26.
//
/*
import UIKit
import SwiftUI
import Foundation
import PencilKit

class ModuleScrollView: UIScrollView {
        
        var longerWidth: CGFloat
        var shorterWidth: CGFloat
        var item: Initializers
        var toolPicker: PKToolPicker
        
        init (longerWidth: CGFloat, shorterWidth: CGFloat, initializers: Initializers, toolPicker: PKToolPicker, frame: CGRect) {
            self.longerWidth = longerWidth
            self.shorterWidth = shorterWidth
            self.item = initializers
            self.toolPicker = toolPicker
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private let stackView = UIStackView()
        let canvasView: PKCanvasView = PKCanvasView()
        private let quizView: UIImageView = UIImageView()
        private var drawing = PKDrawing()
        private var landscapeConstraint = [NSLayoutConstraint]()
        private var portraitConstraint = [NSLayoutConstraint]()
        
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
        
    }
*/
