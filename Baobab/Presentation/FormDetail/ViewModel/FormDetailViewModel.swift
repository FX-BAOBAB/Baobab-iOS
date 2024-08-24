//
//  FormDetailViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import Combine

final class FormDetailViewModel: ObservableObject {
    enum AlertType {
        case success
        case failure
    }
    
    @Published var isProgress: Bool = false
    @Published var isShowingAlert: Bool = false
    
    var alertType: AlertType = .success
    private let usecase: AbandonOwnershipUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: AbandonOwnershipUseCase) {
        self.usecase = usecase
    }
    
    func abandonOwnership(formId: Int) {
        isProgress.toggle()
        
        usecase.execute(formId: formId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The Request for transportation ownership has been completed")
                case .failure(let error):
                    print("FormDetailViewModel.abandonOwnership() error:", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.alertType = .success
                } else {
                    self?.alertType = .failure
                }
                
                self?.isProgress.toggle()
                self?.isShowingAlert.toggle()
            })
            .store(in: &cancellables)
    }
}
