//
//  FetchGeoCodeUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import MapKit
import Combine

protocol FetchGeoCodeUseCase {
    func execute(for address: String) -> AnyPublisher<MKCoordinateRegion, Error>
}

final class FetchGeoCodeUseCaseImpl: FetchGeoCodeUseCase {
    private enum GeoCodeError: Error {
        case error(message: String)
    }
    
    func execute(for address: String) -> AnyPublisher<MKCoordinateRegion, Error> {
        return Future { promise in
            CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
                guard error == nil else {
                    promise(.failure(error!))
                    return
                }
                
                guard let placemark = placemarks?.first,
                      let location = placemark.location else {
                    promise(.failure(GeoCodeError.error(message: "placemark Parameter에서 nil 발생")))
                    return
                }
                
                let coordinate = location.coordinate
                promise(.success(MKCoordinateRegion(center: coordinate,
                                                    latitudinalMeters: 150,
                                                    longitudinalMeters: 150)))
            }
        }
        .eraseToAnyPublisher()
    }
}
