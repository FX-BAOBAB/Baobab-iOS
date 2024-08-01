//
//  ShippingFormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Combine

final class ShippingFormsViewModel: FormsViewModel {
    @Published var forms: [ShippingForm]?
    
    private let usecase: FetchFormUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchFormUseCase) {
        self.usecase = usecase
        self.forms = ShippingForm.sampleData
    }
    
    func fetchForms() {
        usecase.executeForShipping()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching shipping forms has been completed")
                case .failure(let error):
                    print("ShippingViewModel.fetchForms() error : ", error)
                }
            }, receiveValue: { [weak self] in
                self?.forms = $0
            })
            .store(in: &cancellables)
    }
}
