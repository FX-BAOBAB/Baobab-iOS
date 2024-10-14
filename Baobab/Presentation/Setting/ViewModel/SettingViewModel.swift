//
//  SettingViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/23/24.
//

import Combine
import Foundation

final class SettingViewModel: ObservableObject {
    @Published var isLogout: Bool = false
    @Published var appVersion: String = ""
    @Published var isShowingAlert: Bool = false
    
    private let usecase: DeleteTokenUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: DeleteTokenUseCase) {
        self.usecase = usecase
    }
    
    func logout() {
        usecase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("AccessToken & RefreshToken have been deleted")
                case .failure(let error):
                    print("SettingViewModel.logout() error : " , error)
                }
            }, receiveValue: { [weak self] in
                if $0.allSatisfy({ $0 == true }) {
                    UserDefaults.standard.set(false, forKey: "hasToken")    //토큰 저장 상태 업데이트
                    self?.isLogout.toggle()
                }
            })
            .store(in: &cancellables)
    }
    
    func getAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }
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
        
        isShowingAlert.toggle()
    }
}
