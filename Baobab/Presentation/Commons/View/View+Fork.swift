//
//  View+Fork.swift
//  Baobab
//
//  Created by 이정훈 on 7/24/24.
//

import SwiftUI

extension View {
    func fork<V: View>(@ViewBuilder _ merge: (Self) -> V) -> V { merge(self) }
}
