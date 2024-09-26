//
//  ObjectCaptureViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import os
import SwiftUI
import RealityKit

#if !targetEnvironment(simulator)
@available(iOS 17, *)
@MainActor
final class ObjectCaptureViewModel: ObservableObject {
    typealias Stage = PhotogrammetrySession.Output.ProcessingStage
    
    @Published var objectCaptureSession: ObjectCaptureSession?
    @Published var photogrammetrySession: PhotogrammetrySession?
    @Published var requestProcessingStage: Stage?
    @Published var requestProcessPercentage: Double = 0.0
    @Published var output: URL?
    
    static let instance: ObjectCaptureViewModel = .init()
    
    private init() {}
    
    func handleProcessingComplete() {        
        output = getDocumentsDir().appendingPathComponent("model.usdz")
        deleteTempFiles()
    }
    
    func handleRequestProgressInfo(_ processingStage: Stage?) {
        requestProcessingStage = processingStage
    }
    
    func handleRequestProcess(_ fractionComplete: Double) {
        requestProcessPercentage = fractionComplete
    }
    
    ///Object Capture 중 촬영한 사진들을 삭제하는 메서드
    func deleteTempFiles() {
        DispatchQueue.global(qos: .background).async {
            //Object Cature를 진행하면서 발생하는 임시 파일 경로
            let snapshotPath = getDocumentsDir().appendingPathComponent("Snapshots/")
            let imagePath = getDocumentsDir().appendingPathComponent("Images/")
            
            do {
                try FileManager.default.removeItem(at: snapshotPath)
                try FileManager.default.removeItem(at: imagePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    ///AR 모델 파일을 삭제하는 메서드
    func deleteModelFile() {
        DispatchQueue.global(qos: .background).async {
            //AR Model이 저장되는 경로
            let path = getDocumentsDir().appendingPathComponent("model.usdz")
            
            do {
                try FileManager.default.removeItem(at: path)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func startNewCapture() {
        var configuration = ObjectCaptureSession.Configuration()
        configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
        
        objectCaptureSession = ObjectCaptureSession()
        objectCaptureSession?.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                                    configuration: configuration)
    }
    
    @MainActor
    func startReconstruction() throws {
        var configuration = PhotogrammetrySession.Configuration()
        configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
        
        photogrammetrySession = try PhotogrammetrySession(
            input: getDocumentsDir().appendingPathComponent("Images/"),
            configuration: configuration
        )
        
        try photogrammetrySession?.process(requests: [
            .modelFile(url: getDocumentsDir().appendingPathComponent("model.usdz"))
        ])
    }
    
    ///클래스가 메모리에서 해제될 때 수행할 메서드
    @MainActor
    func cleanup() {
        deleteTempFiles()
        objectCaptureSession = nil
        photogrammetrySession = nil
        requestProcessingStage = nil
    }
}
#else
class ObjectCaptureViewModel: ObservableObject {
    
}
#endif
