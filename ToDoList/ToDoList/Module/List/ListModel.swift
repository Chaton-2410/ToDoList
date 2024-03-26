//
//  ListModel.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 25.03.2024.
//

struct ListModel {
    let title: String
    let description: String
}

final class ListModelGenerator {
    static func getData() -> [ListModel] {
        let array: [ListModel] = [
            ListModel(title: "Title", description: "Description"),
            ListModel(title: "Title", description: "Description"),
            ListModel(title: "Title", description: "Description"),
            ListModel(title: "Title", description: "Description"),
            ListModel(title: "Title", description: "Description")
        ]
        
        return array
    }
}
