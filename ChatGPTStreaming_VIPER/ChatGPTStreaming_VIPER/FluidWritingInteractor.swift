//
//  FluidWritingInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol FluidWritingInteractorInterface {
    var allChunks: [String] { get set }
    func addToQueue(string: String, completion: @escaping (String) -> Void)
}

final class FluidWritingInteractor: FluidWritingInteractorInterface {
    
    var allChunks: [String] = []
    
    private var timer: Timer?
    private let typingInterval: TimeInterval = 0.05
    private var currentChunkIndex: Int = 0
    private var isProcessingFluidWriting: Bool = false
    
    private var completionHandler: ((String) -> Void)?
    
    func processFluidWriting() {
        
        guard !isProcessingFluidWriting else { return }
        
        guard currentChunkIndex < allChunks.count else {
            return
        }
        
        let chunk = allChunks[currentChunkIndex]
        
        guard timer == nil else { return }
        
        var currentCharacterIndex = 0
        
        isProcessingFluidWriting = true
        
        timer = Timer.scheduledTimer(withTimeInterval: typingInterval, repeats: true, block: { [weak self] _ in
            
            guard let unwrappedSelf = self else { return }

            if currentCharacterIndex < chunk.count {
                let nextCharacterIndex = chunk.index(chunk.startIndex, offsetBy: currentCharacterIndex)
                let nextCharacter = String(chunk[nextCharacterIndex])
                self?.completionHandler?(nextCharacter)
                currentCharacterIndex += 1
            } else {
                unwrappedSelf.timer?.invalidate()
                unwrappedSelf.timer = nil

                unwrappedSelf.isProcessingFluidWriting = false
                unwrappedSelf.currentChunkIndex += 1
                self?.processFluidWriting()
            }
        })
    }
    
    func addToQueue(string: String, completion: @escaping (String) -> Void) {
                
        guard !string.isEmpty else { return }

        if self.completionHandler == nil {
            self.completionHandler = completion
        }
                
        allChunks.append(string)
        
        DispatchQueue.main.async {
            self.processFluidWriting()
        }
    }
}
