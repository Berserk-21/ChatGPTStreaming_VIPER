//
//  SettingsTableViewCellInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

// On fait un fichier séparer pour les protocol top niveau comme lui ?
protocol ListDataSourceInterface {
    func dataForItem(at indexPath: IndexPath) -> AnyModel
    var numberOfRows: Int { get }
}

protocol SettingsDataSourceInterface: ListDataSourceInterface {}

class SettingsDataSourceInteractor: SettingsDataSourceInterface {
    
    var numberOfRows: Int {
        return getSettingsModel().count
    }
    
    func dataForItem(at indexPath: IndexPath) -> AnyModel {
        return getModelAt(indexPath: indexPath)
    }
    
    // MARK: - Helper Methods
    
    private func getModelAt(indexPath: IndexPath) -> AnyModel {
        
        return getSettingsModel()[indexPath.row]
    }
    
    private func getSettingsModel() -> [SettingsModel] {
        let models = [
            SettingsModel(title: "Mode: " + GPTModel.gpt3.modelName),
            SettingsModel(title: "Role: " + GPTRole.teacher.content)
        ]
        
        return models
    }
}
