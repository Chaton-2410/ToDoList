//
//  ListModel.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 25.03.2024.
//

import Foundation

struct ListModel {
    let id: UUID
    let title: String
    let description: String
    let date: Date
    let category: AddTaskPickerData
    let isCompleted: Bool
}
