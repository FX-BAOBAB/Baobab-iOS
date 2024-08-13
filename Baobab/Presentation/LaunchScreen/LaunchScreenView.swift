//
//  LaunchScreenView.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import SwiftUI

struct LaunchScreenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()!
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //Nothing
    }
}
