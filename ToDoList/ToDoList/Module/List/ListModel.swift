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
            ListModel(title: "Title1", description: "Description"),
            ListModel(title: "Title2", description: "Description"),
            ListModel(title: "Title3", description: "Description"),
            ListModel(title: "Title4", description: "Description"),
            ListModel(title: "Title5", description: "Description")
        ]
        
        return array
    }
}
