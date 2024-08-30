//
//  ObjectCaptureViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import RealityKit
import SwiftUI
import os

@available(iOS 17, *)
final class ObjectCaptureViewModel: ObservableObject {
    typealias Stage = PhotogrammetrySession.Output.ProcessingStage
    
    @Published var requestProcessingStage: Stage? = nil
    @Published var requestProcessPercentage: Double = 0.0
    @Published var isProcessingComplete: Bool = false
    @Published var output: URL?
    
    func handleProcessingComplete() {
        withAnimation {
            isProcessingComplete.toggle()
        }
        
        output = getDocumentsDir().appendingPathComponent("model.usdz")
        deleteDocumentFile()
    }
    
    func handleRequestProgressInfo(_ processingStage: Stage?) {
        requestProcessingStage = processingStage
    }
    
    func handleRequestProcess(_ fractionComplete: Double) {
        requestProcessPercentage = fractionComplete
    }
    
    func deleteDocumentFile() {
        //Object Cature를 진행하면서 발생하는 임시 파일 경로
        let snapshotPath = getDocumentsDir().appendingPathComponent("Snapshots/")
        let imagePath = getDocumentsDir().appendingPathComponent("Images/")
        
        do {
            try FileManager.default.removeItem(at: snapshotPath)
            try FileManager.default.removeItem(at: imagePath)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func deleteModelFile() {
        let path = getDocumentsDir().appendingPathComponent("model.usdz")
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print("\(error)")
        }
    }
}
