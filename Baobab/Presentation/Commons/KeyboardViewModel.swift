//
//  KeyboardViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 6/27/24.
//

import UIKit
import Combine
import Foundation

class KeyboardViewModel: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        monitorKeyboardAppear()
        monitorKeyboardDisappear()
    }
    
    //MARK: - 키보드 활성화 감지
    private func monitorKeyboardAppear() {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
        .map { notification -> CGFloat in
            guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                return 0
            }
            
            return keyboardSize.cgRectValue.height
        }
        .sink { [weak self] keyboardHeight in
            self?.keyboardHeight = keyboardHeight
        }
        .store(in: &cancellables)
    }
    
    //MARK: - 키보드 비활성화 감지
    private func monitorKeyboardDisappear() {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillHideNotification
        )
        .sink { [weak self] _ in
            self?.keyboardHeight = 0
        }
        .store(in: &cancellables)
    }
}
