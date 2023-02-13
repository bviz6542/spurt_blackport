//
//  ContentReportView.swift
//  eatpdf
//
//  Created by 정준우 on 2022/12/02.
//

import SwiftUI
import CoreData

// 학습 리포트 탭 View
struct ContentReportView: View {
    
    var tests = [
        AnyView(Image("1")
            .resizable()
            .scaledToFill()),
        AnyView(Image("2")
            .resizable()
            .scaledToFill()),
        AnyView(Image("3")
            .resizable()
            .scaledToFill()),
        AnyView(Image("4")
            .resizable()
            .scaledToFill()),
        AnyView(Image("5")
            .resizable()
            .scaledToFill()),
        AnyView(Image("6")
            .resizable()
            .scaledToFill()),
        AnyView(Image("7")
            .resizable()
            .scaledToFill()),
        AnyView(Image("8")
            .resizable()
            .scaledToFill()),
        AnyView(Image("9")
            .resizable()
            .scaledToFill()),
        AnyView(Image("10")
            .resizable()
            .scaledToFill()),
        AnyView(Image("11")
            .resizable()
            .scaledToFill()),
        AnyView(Image("12")
            .resizable()
            .scaledToFill())
    ]
    var itemsPerRow = 4
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<getRowCount(numerator: tests.count, denominator: itemsPerRow)) {i in
                        RowView(itemsPerRow: 4, tests: getRowContent(rowNumber: i, itemsPerRow: itemsPerRow))
                    }
                }
            }
//            .navigationTitle("학습 리포트")
            .navigationViewStyle(.stack)

            // 캡처/녹화 감지
            BlockView()
        }
    }

    func getRowCount(numerator: Int, denominator: Int) -> Int {
        if numerator % denominator == 0 {
            return numerator/denominator
        } else {
            return (numerator/denominator) + 1
        }
    }

    func getRowContent(rowNumber: Int, itemsPerRow: Int) -> [AnyView] {
        var returnItems:[AnyView] = []
        for i in 0..<itemsPerRow {
            let itemIndex = rowNumber * itemsPerRow + i
            returnItems.append(tests[itemIndex])
        }

        return returnItems
    }
}


struct RowView: View {

    var itemsPerRow: CGFloat
    var tests: [AnyView]

    var body: some View {
        
        VStack {
            // 커스텀 네비게이션 바
            HStack {
                Text("학습 리포트")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                ForEach(0..<tests.count) {i in
                    self.tests[i]
                        .frame(
                            width: UIScreen.main.bounds.width/(self.itemsPerRow+2),
                            height: UIScreen.main.bounds.width/(self.itemsPerRow+2)
                        )
                        .clipped()
                        .background(Color.blue)
                }
            }
        }
    }
}

// 얼럿창 데이터
struct AlertData : Identifiable {
    var id: UUID
    let title: String
    let message: String
    
    init(title: String = "안녕하세요!" , message : String = "스크린 캡쳐를 하셨군요! 🔦") {
        
        self.id = UUID()
        self.title = title
        self.message = message
    }
}

// 화면 캡처/동영상 녹화 감지 코드
/// 블럭 처리 뷰
struct BlockView : View {
    
    // ios 시스템 에서는 시스템 이벤트를 알려준다. - 노티피케이션 센터
    // 노티피케이션 -> publisher 로 받을수 있다.
    // SwiftUi 에서는 publisher 이벤트를 onReceive 로 받는다.
    
    @State private var alertData: AlertData?
    
    // 녹화중 여부
    @State var isRecordingScreen = false
    
    var body: some View {
        ZStack {
            if isRecordingScreen {
                Color.white
                Text("화면 녹화중입니다! 🎥")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification), perform: { _ in
            print("UIScreen.main.isCaptured : \(UIScreen.main.isCaptured)")
            isRecordingScreen = UIScreen.main.isCaptured
            print(isRecordingScreen ? "녹화 시작" : "녹화 중지")
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification), perform: { _ in
            
            print("스크린샷이 찍어졌다.")
            alertData = AlertData()
            
        })
        .edgesIgnoringSafeArea(.all)
        .alert(item: $alertData, content: { alertData in
            Alert(title: Text(alertData.title),
                  message: Text(alertData.message),
                  dismissButton: Alert.Button.cancel(Text("닫기")))
        })
    }
}


////
////  ContentReportView.swift
////  Spurt
////
////  Created by 이제홍 on 2022/10/07.
////
//
//import SwiftUI
//import FirebaseStorage
//import FirebaseFirestore
//
//struct ContentReportView: View {
//
//    // 전체
//    // 1. 응시한 시험의 수
//    var totalNumberOfTakenExams: Int = 0
//
//    // 각 시험 당
//    // 1. 문제의 수
//    // 2. 응시 시간
//    // 3. 평균 점수
//    // 4. 표준편차
//    // 5. 백분위
//    var testNumberOfQestions: [Int] = []
//    var testTimeConsumed: [Int] = []
//    var testScoreAverage: [Float] = []
//    var testScoreStd: [Float] = []
//    var testScorePercentage: [Float] = []
//
//    // 각 문제 당
//    // 1. 정답
//    // 2. 정답 여부
//    // 3. 걸린 시간
//    // 4. 정답률
//    var questionAnswer: [Int] = []
//    var quetionIsCorrect: [Bool] = []
//    var questionTimeConsumed: [Int] = []
//
//    // Photo Upload test
//    @State var isPickerShowing = false
//    @State var selectedImage: UIImage?
//    @State var retrievedImages = [UIImage]()
//
//    var body: some View {
//
//        VStack {
//
//            if selectedImage != nil {
//                Image(uiImage: selectedImage!)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//            }
//
//            Button {
//
//                // Show the image picker
//                isPickerShowing = true
//            } label: {
//                Text("Select a Photo")
//            }
//
//            // Upload Button
//            if selectedImage != nil {
//                Button {
//                    // Upload the image
//                    uploadPhoto()
//                } label: {
//                    Text("Upload photo")
//                }
//            }
//
//            Divider()
//
//            HStack {
//
//                // Loop through the images and display them
//                ForEach(retrievedImages, id: \.self) { image in
//                    Image(uiImage: image)
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                }
//
//            }
//
//        }
//        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
//            // Image picker
//            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
//        }
//        .onAppear {
//            retrievePhotos()
//        }
//        .navigationTitle("학습 리포트")
//    }
//
//    func uploadPhoto() {
//
//        // Make sure that the selected image property isn't nil
//        guard selectedImage != nil else {
//            return
//        }
//
//        // Create stor  age reference
//        let storageRef = Storage.storage().reference()
//
//        //Turn out image into data
//        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
//
//        // Check that we were able to convert it to data
//        guard imageData != nil else {
//            return
//        }
//
//        // Specify the file path and name
//        let path = "images/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
//
//        // Upload that data
//        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
//            metadata, error in
//
//            // Check for errors
//            if error == nil && metadata != nil {
//
//                // Save a reference to the file in Firebase DB
//                let db = Firestore.firestore()
//                db.collection("images").document().setData(["url":path]) { error in
//
//                    // If there were no errors, display the new image
//                    if error == nil {
//
//                        DispatchQueue.main.async {
//
//                            // Add the uploaded image to the list of images for display
//                            self.retrievedImages.append(self.selectedImage!)
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    func retrievePhotos() {
//
//        // Get the data from the database
//        let db = Firestore.firestore()
//
//        db.collection("images").getDocuments { snapshot, error in
//
//            var paths = [String]()
//
//            if error == nil && snapshot != nil {
//
//                // Loop through all the returned docs
//                for doc in snapshot!.documents {
//
//                    // Extract the file path
//                    paths.append(doc["url"] as! String)
//                }
//
//                // Loop through each file path and fetch the data from storage
//                for path in paths {
//
//                    // Get a reference to storage
//                    let storageRef = Storage.storage().reference()
//
//                    // Specify the path
//                    let fileRef = storageRef.child(path)
//
//                    // Retrieve the data
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//
//                        // Check for errors
//                        if error == nil && data !=  nil {
//
//                            // Create a UIImage and put it into our array for display
//                            if let image = UIImage(data: data!) {
//
//                                DispatchQueue.main.async {
//                                    retrievedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                } // end loop through paths
//            }
//        }
//
//        // Get the image data in storage for each image reference
//
//    }
//}
//
//struct ContentReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentReportView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
