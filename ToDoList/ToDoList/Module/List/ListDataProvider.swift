//
//  ListDataProvider.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 16.04.2024.
//

import Foundation
import CoreData

protocol ListDataProviderProtocol {
    func fetchTasks() -> [ListModel]
}

final class ListDataProvider: ListDataProviderProtocol {
   
    private let coreDataManeger: CoreDataManagerProtocol
    private let contex: NSManagedObjectContext
    
    init(coreDataManeger: CoreDataManagerProtocol) {
        self.coreDataManeger = coreDataManeger
        self.contex = coreDataManeger.persistentContainer.viewContext
    }
    
    func fetchTasks() -> [ListModel] {
        let fetchRequest: NSFetchRequest<ListCoreDataModel> = ListCoreDataModel.fetchRequest()
        
        guard let fetchedData = try? contex.fetch(fetchRequest) else { return [] }
        
        let viewModel = fetchedData.map {
            ListModel(
                id: $0.id ?? UUID(),
                title: $0.title ?? "",
                description: $0.subtitle ?? "",
                date: $0.date ?? Date(),
                category: AddTaskPickerData(rawValue: $0.category ?? "") ?? .other,
                isCompleted: $0.isCompleted
            )
        }
        
        return viewModel
    }
}
