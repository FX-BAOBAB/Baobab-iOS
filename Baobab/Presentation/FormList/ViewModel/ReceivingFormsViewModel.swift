//
//  ReceivingFormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine

final class ReceivingFormsViewModel: FormsViewModel {
    @Published var forms: [ReceivingForm]? = nil
    @Published var isLoading: Bool = false
    
    private let usecase: FetchFormUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchFormUseCase) {
        self.usecase = usecase
    }
    
    func fetchForms() {
        isLoading.toggle()
        
        usecase.executeForReceiving()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    print("Fetching receiving forms has been completed.")
                case .failure(let error):
                    print("ReceivingFormsViewModel.fetchForms() error : ", error)
                }
            }, receiveValue: { [weak self] in
                self?.forms = $0
            })
            .store(in: &cancellables)
    }
}
