//
//  ttt.swift
//  spurt
//
//  Created by 정준우 on 2022/12/21.
//

import SwiftUI
import CoreData

class CoreVM: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities: [TestEntity] = []
    
    init (){
        container = NSPersistentContainer(name: "tttContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchTest()
    }
    func fetchTest(){
        let request = NSFetchRequest<TestEntity>(entityName: "TestEntity")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching \(error)")
        }
    }
    func addTest(text: String){
        let newTest = TestEntity(context: container.viewContext)
        newTest.name = text
        saveData()
    }
    func saveData(){
        do{
            try container.viewContext.save()
            fetchTest()
        } catch let error{
            print("Error saving \(error)")
        }
    }
}

struct ttt: View {
    
    @StateObject var vm = CoreVM()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ttt_Previews: PreviewProvider {
    static var previews: some View {
        ttt()
    }
}
