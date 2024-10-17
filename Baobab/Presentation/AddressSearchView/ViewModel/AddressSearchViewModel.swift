//
//  AddressSearchViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import Combine
import MapKit

final class AddressSearchViewModel: PostSearchable {
    @Published var searchedAddress: String = ""
    @Published var selectedAddress: Address?
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
    }
    
    func calculateMapCoordinates() {
        $searchedAddress
            .dropFirst(1)
            .flatMap { [weak self] address -> AnyPublisher<MKCoordinateRegion, Error> in
                guard let self else {
                    return Empty<MKCoordinateRegion, Error>().eraseToAnyPublisher()
                }
                
                return fetchGeoCodeUseCase.execute(for: address)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch the geocode has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.searchedAddressRegion = region
            })
            .store(in: &cancellables)
    }
}
