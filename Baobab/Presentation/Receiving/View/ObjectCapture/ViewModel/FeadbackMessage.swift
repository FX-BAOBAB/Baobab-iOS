//
//  FeedbackMessage.swift
//  Baobab
//
//  Created by 이정훈 on 9/27/24.
//

import RealityKit
import SwiftUI

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
