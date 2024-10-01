//
//  ReceivingViewModel+ModelFile.swift
//  Baobab
//
//  Created by 이정훈 on 9/30/24.
//

import Foundation

extension ReceivingViewModel {
    ///AR 모델 파일을 삭제하는 메서드
    func deleteModelFile() {
        for item in self.items {
            guard let filePath = item.modelFile else { continue }
            
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                print(error)
            }
        }
    }
}
