//
//  DrawingViewModel.swift
//  spurt
//
//  Created by 정준우 on 2022/11/25.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject{
    
    @Published var imageData: Data = Data(count: 0)
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    
}
