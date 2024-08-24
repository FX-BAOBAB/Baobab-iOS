//
//  ItemStatusConversionViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/23/24.
//

import Combine

final class ItemStatusConversionViewModel: ObservableObject {
    enum AlertType {
        case success
        case failure
    }
    
    @Published var isProcess: Bool = false
    @Published var isShowingAlert: Bool = false
    
    var alertType: AlertType = .success
    private let usecase: ConvertItemStatusUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: ConvertItemStatusUseCase) {
        self.usecase = usecase
    }
    
    func convertStatus(id: Int) {
        isProcess.toggle()
        
        usecase.execute(for: id)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("The conversion of the item status has been completed")
                case .failure(let error):
                    print("ItemStatusConversionViewModel.convertStatus() error", error)
                }
                
                self?.alertType = .success
                self?.isProcess.toggle()
                self?.isShowingAlert.toggle()
                
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
