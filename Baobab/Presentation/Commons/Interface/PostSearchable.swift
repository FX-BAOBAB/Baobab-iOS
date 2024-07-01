//
//  PostSearchable.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import MapKit

protocol PostSearchable: ObservableObject {
    var searchedAddress: String { get set }
    var searchedAddressRegion: MKCoordinateRegion? { get set }
    var searchedPostCode: String { get set }
    var detailedAddressInput: String { get set }
    
    func registerAsSelectedAddress()
}
