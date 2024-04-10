//
//  ListSearchManager.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 08.04.2024.
//

import UIKit

protocol ListSearchManagerDelegate: AnyObject {
    func searchBar(textDidChange searchText: String)
}

final class ListSearchManager: NSObject {
    weak var delegate: ListSearchManagerDelegate?
}

extension ListSearchManager: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBar(textDidChange: searchText)
    }
}
