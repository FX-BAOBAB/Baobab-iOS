//
//  StoreViewModel+MapKit.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import MapKit

extension StoreViewModel {    
    func showLocationOnMap(_ address: String) {
        CLGeocoder().geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard error == nil else {
                print("geocoding error")
                return
            }
            
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                print("No Location Found")
                return
            }
            
            let coordinate = location.coordinate
            self?.region = MKCoordinateRegion(center: coordinate,
                                              latitudinalMeters: 150,
                                              longitudinalMeters: 150)
        }
    }
}
