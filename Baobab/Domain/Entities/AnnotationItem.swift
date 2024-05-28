//
//  AnnotationItem.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
