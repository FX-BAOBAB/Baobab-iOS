//
//  ObjectCaptureViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import RealityKit
import SwiftUI
import os

#if !targetEnvironment(simulator)
@MainActor
@available(iOS 17, *)
final class ObjectCaptureViewModel: ObservableObject {
    typealias Stage = PhotogrammetrySession.Output.ProcessingStage
    
    @Published var session: ObjectCaptureSession?
    @Published var requestProcessingStage: Stage?
    @Published var requestProcessPercentage: Double = 0.0
    @Published var output: URL?
    
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
    
    ///ObjectCaptureSession 초기화
    func setup() {
        var configuration = ObjectCaptureSession.Configuration()
        configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
        
        session = ObjectCaptureSession()
        session?.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                      configuration: configuration)
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
    
    ///클래스가 메모리에서 해제될 때 수행할 메서드
    func cleanup() {
        deleteTempFiles()
        session?.cancel()
        session = nil
        requestProcessingStage = nil
    }
}
#else
final class ObjectCaptureViewModel: ObservableObject {
    
}
#endif
