//
//  Way.swift
//  spurt
//
//  Created by 정준우 on 2022/12/31.
//

import SwiftUI
import PDFKit

struct Way: View {
    
    @State private var pdfView: PDFView!
    @State private var thumbnailView: PDFThumbnailView!
    @State private var thumbnailViewContainer: UIView!
    
    var body: some View {
        VStack{
            Text("Greetings for you all")
            NavigationLink(destination: Whale()){
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

struct Way_Previews: PreviewProvider {
    static var previews: some View {
        Way()
    }
}

struct Whale: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    func makeCoordinator() -> () {}
}
