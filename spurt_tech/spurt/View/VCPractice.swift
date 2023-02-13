//
//  VCPractice.swift
//  spurt
//
//  Created by 정준우 on 2022/11/26.
//

import SwiftUI

struct VCPractice: View {
    
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack{
            Text("hi")
            
            if let image = image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Click Here")
            }).sheet(isPresented: $showScreen, content: {
                //BUVCR(labelText: "wow wow wow")
                IPVC(image: $image, showScreen: $showScreen)
            })
        }
    }
}

struct VCPractice_Previews: PreviewProvider {
    static var previews: some View {
        VCPractice()
    }
}

struct IPVC: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    //UIKit으로부터 SwiftUI로 정보 보냄
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else{return}
            image = newImage
            showScreen = false
        }
    }
}

struct BUVCR: UIViewControllerRepresentable{
    let labelText: String
    func makeCoordinator() -> () {
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyVC()
        vc.labelText = labelText
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class MyVC: UIViewController{
    var labelText: String = "Initial"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        
        view.addSubview(label)
        label.frame = view.frame
    }
}
