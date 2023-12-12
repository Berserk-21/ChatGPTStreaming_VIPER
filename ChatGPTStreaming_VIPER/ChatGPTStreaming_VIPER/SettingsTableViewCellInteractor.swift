//
//  SettingsTableViewCellInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsTableViewCellInteractorInterface {
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell?
    func numberOfRows() -> Int
}

class SettingsTableViewCellInteractor: SettingsTableViewCellInteractorInterface {
    
    func numberOfRows() -> Int {
        return getSettingsModel().count
    }
    
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return nil }
        
        cell.titleLabel.text = getSettingsModel()[indexPath.row].title
        
        return cell
    }
    
    // MARK: - Helper Methods
    
    private func getSettingsModel() -> [SettingsModel] {
        let models = [
            SettingsModel(title: "Mode: " + GPTModel.gpt3.modelName),
            SettingsModel(title: "Role: " + GPTRole.teacher.content)
        ]
        
        return models
    }
}
