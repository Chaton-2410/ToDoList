//
//  AddTaskDataProvider.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 17.04.2024.
//

import Foundation
import CoreData

protocol AddTaskDataProviderProtocol {
    func createTask(with model: ListModel)
}

final class AddTaskDataProvider: AddTaskDataProviderProtocol {
    
    private let coreDataManeger: CoreDataManagerProtocol
    
    init(coreDataManeger: CoreDataManagerProtocol) {
        self.coreDataManeger = coreDataManeger
    }
   
    func createTask(with model: ListModel) {
        
        let contex = coreDataManeger.persistentContainer.viewContext
        let task: ListCoreDataModel = ListCoreDataModel(context: contex)
        
        task.id = model.id
        task.title = model.title
        task.subtitle = model.description
        task.date = model.date
        task.category = model.category.rawValue
        task.isCompleted = task.isCompleted
        
        coreDataManeger.saveContext()
    }
}
