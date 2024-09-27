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
@MainActor final class ObjectCaptureViewModel: ObservableObject {
    typealias Stage = PhotogrammetrySession.Output.ProcessingStage
    typealias Feedback = ObjectCaptureSession.Feedback
    
    @Published var objectCaptureSession: ObjectCaptureSession? {
        willSet {
            detachListener()
        }
        
        didSet {
            guard objectCaptureSession != nil else { return }
            attachListener()
        }
    }
    
    @Published var photogrammetrySession: PhotogrammetrySession?
    @Published var requestProcessingStage: Stage?
    @Published var requestProcessPercentage: Double = 0.0
    @Published var output: URL?
    @Published var feedbackMessage: String?
    
    static let instance: ObjectCaptureViewModel = .init()
    private var tasks: [Task<Void, Never>] = []
    private var currentFeedback: Set<Feedback> = []
    
    private init() {}
    
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
    
    func startNewCapture() {
        var configuration = ObjectCaptureSession.Configuration()
        configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
        
        objectCaptureSession = ObjectCaptureSession()
        objectCaptureSession?.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                                    configuration: configuration)
    }
    
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
    func reset() {
        deleteTempFiles()
        objectCaptureSession = nil
        photogrammetrySession = nil
        requestProcessingStage = nil
        output = nil
        requestProcessPercentage = 0.0
    }
}

@available(iOS 17, *)
extension ObjectCaptureViewModel {
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
}

@available(iOS 17, *)
extension ObjectCaptureViewModel {
    private func attachListener() {
        guard let session = objectCaptureSession else {
            fatalError("Logic error")
        }
        
        tasks.append(
            Task<Void, Never> { [weak self] in
                for await newFeedback in session.feedbackUpdates {
                    self?.updateFeedback(newFeedback)
                }
            })
    }
    
    private func updateFeedback(_ feedback: Set<Feedback>) {
        let intersection = currentFeedback.intersection(feedback)    //기존 피드백과 교집합
        let removedFeeadback = currentFeedback.subtracting(intersection)    //차 집합으로 새로운 피드백만 필터링
        
        for feedback in removedFeeadback {
            self.feedbackMessage = FeedbackMessages.getFeedbackString(for: feedback)
        }
    }
    
    private func detachListener() {
        for task in tasks {
            task.cancel()
        }
        
        tasks.removeAll()
    }
}
#else
@MainActor
class ObjectCaptureViewModel: ObservableObject {
    static let instance: ObjectCaptureViewModel = .init()
}
#endif
