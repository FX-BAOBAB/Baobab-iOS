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
    typealias ProgressInfo = PhotogrammetrySession.Output.ProgressInfo
    
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
    @Published var estimatedRemainingTime: TimeInterval?
    @Published var output: URL?
    @Published var feedbackMessage: String?
    
    private var tasks: [Task<Void, Never>] = []
    private var currentFeedback: Set<Feedback> = []
    private var messageList: [String] = []
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
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
            let path = getDocumentsDir().appendingPathComponent(self.fileName)
            
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
            .modelFile(url: getDocumentsDir().appendingPathComponent(fileName))
        ])
    }
    
    ///클래스가 메모리에서 해제될 때 수행할 메서드
    func reset() {
        deleteTempFiles()
        objectCaptureSession = nil
        photogrammetrySession = nil
    }
}

@available(iOS 17, *)
extension ObjectCaptureViewModel {
    func handleProcessingComplete() {
        output = getDocumentsDir().appendingPathComponent(fileName)
        deleteTempFiles()
    }
    
    func handleRequestProgressInfo(_ progressInfo: ProgressInfo) {
        requestProcessingStage = progressInfo.processingStage
        estimatedRemainingTime = progressInfo.estimatedRemainingTime
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
                    print("Task got async feedback change to: \(String(describing: newFeedback))")
                    self?.updateFeedback(newFeedback)
                }
            })
    }
    
    private func updateFeedback(_ feedbacks: Set<Feedback>) {
        //기존 피드백과 교집합
        let intersection = currentFeedback.intersection(feedbacks)
        
        //차 집합으로 사용하지 않는 피드백 제거
        let unnecessaryFeedback = currentFeedback.subtracting(intersection)
        for feedback in unnecessaryFeedback {
            if let idx = messageList.firstIndex(of: FeedbackMessages.getFeedbackString(for: feedback)) {
                messageList.remove(at: idx)
            }
        }
        
        //새로운 피드백 추가
        let existingFeedback = feedbacks.intersection(currentFeedback)
        let newFeedback = feedbacks.subtracting(existingFeedback)
        for feedback in newFeedback {
            messageList.append(FeedbackMessages.getFeedbackString(for: feedback))
        }
        
        currentFeedback = feedbacks
        feedbackMessage = messageList.first
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

struct FeedbackMessages {
    @available(iOS 17, *)
    static func getFeedbackString(for feedback: ObjectCaptureSession.Feedback) -> String {
        switch feedback {
        case .environmentLowLight:
            return "좀 더 밝은 곳으로 이동하세요"
        case .environmentTooDark:
            return "주변이 너무 어두워요"
        case .movingTooFast:
            return "너무 빨리 움직이고 있어요"
        case .objectTooClose:
            return "너무 가까이 있어요"
        case .objectTooFar:
            return "너무 멀어요"
        case .outOfFieldOfView:
            return "필드 밖으로 나갔어요"
        case .overCapturing:
            return "너무 많이 캡쳐하고 있어요"
        case .objectNotDetected:
            return "물체를 인식하지 못했어요"
        case .objectNotFlippable:
            return "물체를 뒤집을 수 없어요"
        @unknown default:
            return ""
        }
    }
}
