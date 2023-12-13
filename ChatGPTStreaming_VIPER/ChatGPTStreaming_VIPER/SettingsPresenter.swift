//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsPresenterInterface {
    var settingsTableViewCellInteractor: SettingsTableViewDataSourceInteractor { get }
}

class SettingsPresenter: SettingsPresenterInterface {
    
    let settingsTableViewCellInteractor: SettingsTableViewDataSourceInteractor
    
    init(settingsTableViewCellInteractor: SettingsTableViewDataSourceInteractor) {
        self.settingsTableViewCellInteractor = settingsTableViewCellInteractor
    }
    
}

