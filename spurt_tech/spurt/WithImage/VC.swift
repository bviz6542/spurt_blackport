//
//  VC.swift
//  spurt
//
//  Created by 정준우 on 2022/12/26.
//
/*

import Foundation
import UIKit
import SwiftUI
import PDFKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    // 필요한 상수, 변수
    private let baseView = UIView()
    private var moduleViews = [ModuleScrollView]()
    private var toolPicker = PKToolPicker()
    private var saveBtn = UIButton()
    private var landscapeConstraint = [NSLayoutConstraint]()
    private var portraitConstraint = [NSLayoutConstraint]()
    
    
    // init 변수
    var item1 = Initializers(leadingScale: 0.05, topScale: 0.1, widthScale: 0.4, heightScale: 2.0, saveCase: "problem", id: "1", fileName: "sample1", extention: "png")
    var item2 = Initializers(leadingScale: 0.4, topScale: 0.2, widthScale: 0.3, heightScale: 3.0, saveCase: "problem", id: "2", fileName: "sample2", extention: "png")
    private var longerWidth: CGFloat = 0
    private var shorterWidth: CGFloat = 0
    private var isFlat = false
    private var previousOrientation = ""
    
    // 첫 설정: 회색 바탕 + 흰색 모듈
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        longerWidth = view.bounds.width > view.bounds.height ? view.bounds.width : view.bounds.height
        shorterWidth = view.bounds.width < view.bounds.height ? view.bounds.width : view.bounds.height
        let initialFrame = CGRect(x:0, y:0, width: 0, height: 0)
        moduleViews += [ModuleScrollView(longerWidth: longerWidth, shorterWidth: shorterWidth, initializers: item1, toolPicker: toolPicker, frame: initialFrame)]
        moduleViews += [ModuleScrollView(longerWidth: longerWidth, shorterWidth: shorterWidth, initializers: item2, toolPicker: toolPicker, frame: initialFrame)]
        
        self.view.addSubview(baseView)
        setUIView()
        //        makeDir()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // 화면 회전 시 호출
    @objc private func rotated() {
        
        DispatchQueue.main.async() {
            
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                if (!self.isFlat || self.previousOrientation == "Portrait") {
                    for constraint in self.portraitConstraint {
                        constraint.isActive = false
                    }
                    for constraint in self.landscapeConstraint {
                        constraint.isActive = true
                    }
                    for moduleView in self.moduleViews {
                        moduleView.setLandscape()
                    }
                }
                self.isFlat = false
                self.previousOrientation = "Landscape"
                
            } else if UIDevice.current.orientation.isPortrait {
                print("Portrait")
                if (!self.isFlat || self.previousOrientation == "Landscape") {
                    for constraint in self.landscapeConstraint {
                        constraint.isActive = false
                    }
                    for constraint in self.portraitConstraint {
                        constraint.isActive = true
                    }
                    for moduleView in self.moduleViews {
                        moduleView.setPortrait()
                    }
                }
                self.isFlat = false
                self.previousOrientation = "Portrait"
            } else if UIDevice.current.orientation.isFlat {
                print("Flat")
                self.isFlat = true
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                
            }
        }
    }
    
    // 스크롤뷰 설정
    private func setUIView() {
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        baseView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 12).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -12).isActive = true
        
        baseView.backgroundColor = .gray
        
        baseView.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.leadingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -100).isActive = true
        saveBtn.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 20).isActive = true
        saveBtn.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20).isActive = true
        saveBtn.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: 40).isActive = true
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.black, for: .normal)
        saveBtn.titleLabel?.font = .systemFont(ofSize: 12)
        saveBtn.backgroundColor = .white
        saveBtn.layer.cornerRadius = 10
        saveBtn.addTarget(self, action: #selector(self.saveDrawing), for: .touchUpInside)
        
        setModuleView()
    }
    
    // 캔버스뷰 저장
    @objc func saveDrawing(sender: UIButton!) {
        print("Save")
        for moduleView in moduleViews {
            let getCanvas = moduleView.canvasView
            if getCanvas.drawing.dataRepresentation().count > 50 {
                do { let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: getCanvas.drawing, requiringSecureCoding: false)
                    //                    let fileManager = FileManager.default
                    //                    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    //                    let directoryURL = documentsURL.appendingPathComponent(moduleView.item.directoryName, isDirectory: true)
                    //                    let pencilDirURL = directoryURL.appendingPathComponent("p_pencil", isDirectory: true)
                    //                    let filePath = pencilDirURL.appendingPathComponent(moduleView.item.fileName+".data", isDirectory: true)
                    //                    do {
                    //                        try encodedData.write(to: filePath)
                    //                        } catch {
                    //                        print("Error", error)
                    //                    }
                    DataBase.setValue(.init(rawValue: moduleView.item.saveCase)!, value: encodedData, id: moduleView.item.id)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // 모듈뷰 설정
    private func setModuleView() {
        
        toolPicker.addObserver(moduleViews[0].canvasView)
        toolPicker.setVisible(true, forFirstResponder: moduleViews[0].canvasView)
        moduleViews[0].canvasView.becomeFirstResponder()
        
        for moduleView in moduleViews {
            
            baseView.addSubview(moduleView)
            moduleView.translatesAutoresizingMaskIntoConstraints = false
            
            let landscapeModuleLeading = moduleView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: moduleView.item.canvasLeadingScale * longerWidth)
            let landscapeModuleTop = moduleView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: moduleView.item.canvasTopScale * shorterWidth)
            let landscapeModuleWidth = moduleView.widthAnchor.constraint(equalToConstant: moduleView.item.canvasWidthScale * longerWidth)
            var landscapeModuleHeight = moduleView.heightAnchor.constraint(equalToConstant: moduleView.item.canvasHeightScale * longerWidth)
            if (shorterWidth <= moduleView.item.canvasHeightScale * longerWidth + moduleView.item.canvasTopScale * shorterWidth) {
                landscapeModuleHeight = moduleView.heightAnchor.constraint(equalToConstant: shorterWidth * 0.95 - moduleView.item.canvasTopScale * shorterWidth)
            }
            landscapeConstraint += [landscapeModuleLeading, landscapeModuleTop, landscapeModuleWidth, landscapeModuleHeight]
            
            let portraitModuleLeading = moduleView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: moduleView.item.canvasLeadingScale * shorterWidth)
            let portraitModuleTop = moduleView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: moduleView.item.canvasTopScale * longerWidth)
            let portraitModuleWidth = moduleView.widthAnchor.constraint(equalToConstant: moduleView.item.canvasWidthScale * shorterWidth)
            var portraitModuleHeight = moduleView.heightAnchor.constraint(equalToConstant: moduleView.item.canvasHeightScale * shorterWidth)
            if (longerWidth <= moduleView.item.canvasHeightScale * shorterWidth + moduleView.item.canvasTopScale * longerWidth) {
                portraitModuleHeight = moduleView.heightAnchor.constraint(equalToConstant: longerWidth * 0.95 - moduleView.item.canvasTopScale * longerWidth)
            }
            portraitConstraint += [portraitModuleLeading, portraitModuleTop, portraitModuleWidth, portraitModuleHeight]
            
            if moduleView.item.isLandscape {
                landscapeModuleLeading.isActive = true
                landscapeModuleTop.isActive = true
                landscapeModuleWidth.isActive = true
                landscapeModuleHeight.isActive = true
            } else {
                portraitModuleLeading.isActive = true
                portraitModuleTop.isActive = true
                portraitModuleWidth.isActive = true
                portraitModuleHeight.isActive = true
            }
            
            moduleView.maximumZoomScale = 3.0
            moduleView.showsVerticalScrollIndicator = false
            moduleView.showsHorizontalScrollIndicator = false
            moduleView.backgroundColor = .white
            moduleView.layer.cornerRadius = 10
            
            moduleView.setStackView()
            
        }
    }
}
*/
