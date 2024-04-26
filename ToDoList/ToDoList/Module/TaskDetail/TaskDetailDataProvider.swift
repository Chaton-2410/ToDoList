//
//  TaskDetailDataProvider.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 25.04.2024.
//

import Foundation
import CoreData

protocol TaskDetailDataProviderProtocol {
    func updateTaskStatus(for model: ListModel)
    func deletaTask(for model: ListModel)
}

final class TaskDetailDataProvider: TaskDetailDataProviderProtocol {

    private let coreDataManeger: CoreDataManagerProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataManeger: CoreDataManagerProtocol) {
        self.coreDataManeger = coreDataManeger
        self.context = coreDataManeger.persistentContainer.viewContext
    }
    
    func updateTaskStatus(for model: ListModel) {
        let fetchRequest: NSFetchRequest<ListCoreDataModel> = ListCoreDataModel.fetchRequest()
        
        let prediate = NSPredicate(format: "id = '\(model.id)'")
        fetchRequest.predicate = prediate
        
        let objects: [ListCoreDataModel]? = try? context.fetch(fetchRequest)
        guard let objectUpdate = objects?.first as? NSManagedObject else { return }
        objectUpdate.setValue(true, forKey: "isCompleted")
        
        try? context.save()
    }
    
    func deletaTask(for model: ListModel) {
        let fetchRequest: NSFetchRequest<ListCoreDataModel> = ListCoreDataModel.fetchRequest()
        
        let prediate = NSPredicate(format: "id = '\(model.id)'")
        fetchRequest.predicate = prediate
        
        let objects: [ListCoreDataModel]? = try? context.fetch(fetchRequest)
        guard let objectUpdate = objects?.first as? NSManagedObject else { return }
        
        context.delete(objectUpdate)
        coreDataManeger.saveContext()
    }
}

//extension TaskDetailDataProvider {
//    
//    private func encodeCoreDataModel (with model: ListModel) -> ListCoreDataModel {
//        let coreDataTask: ListCoreDataModel = ListCoreDataModel(context: context)
//        
//        coreDataTask.id = model.id
//        coreDataTask.title = model.title
//        coreDataTask.subtitle = model.description
//        coreDataTask.category = model.category.rawValue
//        coreDataTask.date = model.date
//        coreDataTask.isCompleted = model.isCompleted
//        
//        return coreDataTask
//    }
//}
