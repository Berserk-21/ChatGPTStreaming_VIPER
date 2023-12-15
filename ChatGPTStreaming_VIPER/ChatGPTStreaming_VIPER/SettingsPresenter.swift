//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsPresenterInterface {
    var dataSource: ListDataSourceInterface { get }
    func didSelectRowAt(indexPath: IndexPath)
}

class SettingsPresenter: SettingsPresenterInterface {

    let dataSource: ListDataSourceInterface
    
    let settingsTableViewDelegateInteractor: SettingsTableViewDelegateInteractor
    
    init(listDataSourceInteractor: ListDataSourceInteractor, settingsTableViewDelegateInteractor: SettingsTableViewDelegateInteractor) {
        self.dataSource = listDataSourceInteractor
        self.settingsTableViewDelegateInteractor = settingsTableViewDelegateInteractor
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        settingsTableViewDelegateInteractor.didSelectRowAt(indexPath: indexPath)
    }
    
}

