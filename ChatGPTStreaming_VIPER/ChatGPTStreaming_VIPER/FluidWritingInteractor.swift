//
//  FluidWritingInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol FluidWritingInteractorInterface {
    var tokensList: [String] { get set }
    func addToQueue(string: String, completion: @escaping (String) -> Void)
}

final class FluidWritingInteractor: FluidWritingInteractorInterface {
    
    var tokensList: [String] = []
    
    private var timer: Timer?
    private let typingInterval: TimeInterval = 0.05
    private var currentTokenIndex: Int = 0
    
    private var completionHandler: ((String) -> Void)?
    
    func processFluidWriting() {
        
        guard timer == nil else { return }
        
        guard currentTokenIndex < tokensList.count else {
            return
        }
        
        let chunk = tokensList[currentTokenIndex]
        
        var currentCharacterIndex = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: typingInterval, repeats: true, block: { [weak self] _ in
            
            guard let unwrappedSelf = self else { return }

            if currentCharacterIndex < chunk.count {
                let nextCharacterIndex = chunk.index(chunk.startIndex, offsetBy: currentCharacterIndex)
                let nextCharacter = String(chunk[nextCharacterIndex])
                unwrappedSelf.completionHandler?(nextCharacter)
                currentCharacterIndex += 1
            } else {
                unwrappedSelf.resetTimer()

                unwrappedSelf.currentTokenIndex += 1
                unwrappedSelf.processFluidWriting()
            }
        })
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func addToQueue(string: String, completion: @escaping (String) -> Void) {
                
        guard !string.isEmpty else { return }

        tokensList.append(string)

        if self.completionHandler == nil {
            self.completionHandler = completion
        }
        
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.processFluidWriting()
            }
        } else {
            self.processFluidWriting()
        }
    }
}
