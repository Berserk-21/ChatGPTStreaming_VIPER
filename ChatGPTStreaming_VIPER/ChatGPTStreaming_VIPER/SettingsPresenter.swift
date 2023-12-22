//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol SettingsPresenterInterface {
    var dataSource: SettingsDataSourceInterface { get }
}

class SettingsPresenter: SettingsPresenterInterface {

    let dataSource: SettingsDataSourceInterface
    
    init(listDataSourceInteractor: SettingsDataSourceInteractor) {
        self.dataSource = listDataSourceInteractor
    }
}

