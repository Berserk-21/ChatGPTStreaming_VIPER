//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsPresenterInterface {
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell?
    func numberOfRows() -> Int
}

class SettingsPresenter: SettingsPresenterInterface {
    
    let settingsTableViewCellInteractor: SettingsTableViewCellInteractor
    
    init(settingsTableViewCellInteractor: SettingsTableViewCellInteractor) {
        self.settingsTableViewCellInteractor = settingsTableViewCellInteractor
    }
    
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> SettingsTableViewCell? {
        
        if let cell = settingsTableViewCellInteractor.cellFor(tableView: tableView, indexPath: indexPath) {
            return cell
        }
        
        return nil
    }
    
    func numberOfRows() -> Int {
        return settingsTableViewCellInteractor.numberOfRows()
    }
    
}

