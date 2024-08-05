//
//  ReturnFormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Combine

final class ReturnFormsViewModel: FormsViewModel {
    @Published var forms: [ReturnForm]?
    @Published var isLoading: Bool = false
    
    private let usecase: FetchFormUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchFormUseCase) {
        self.usecase = usecase
    }
    
    func fetchForms() {
        isLoading.toggle()
        
        usecase.executeForReturn()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    print("Fetching return forms has been completed")
                case .failure(let error):
                    print("ReturnFormsViewModel.fetchForms() error : ", error)
                }
            }, receiveValue: { [weak self] in
                self?.forms = $0
            })
            .store(in: &cancellables)
    }
}
