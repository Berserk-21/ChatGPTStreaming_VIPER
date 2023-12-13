//
//  SettingsTableViewCellInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsTableViewDataSourceInteractor {
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell?
    func numberOfRows() -> Int
}

class SettingsTableViewCellInteractor: SettingsTableViewDataSourceInteractor {
    
    func numberOfRows() -> Int {
        return getSettingsModel().count
    }
    
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return nil }
        
        let settingsModel = getSettingsModel()[indexPath.row]
        
        cell.configure(with: settingsModel)
        
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
