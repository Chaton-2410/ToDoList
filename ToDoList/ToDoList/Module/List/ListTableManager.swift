//
//  ListTableManager.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 25.03.2024.
//

import UIKit

protocol ListTableManagerDelegate: AnyObject {
    func didSelectRow(_ model: ListModel)
}

final class ListTableManager: NSObject {
    var tableData: [ListModel] = []
    weak var delegate: ListTableManagerDelegate?
}

//MARK: - UITableViewDataSource
extension ListTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: ListModel = tableData[indexPath.row]
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell) else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListTableManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: ListModel = tableData[indexPath.row]
        delegate?.didSelectRow(model)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}
