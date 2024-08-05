//
//  ItemStatus.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import Foundation

enum ItemStatus: String {
    case receiving = "RECEIVING"    //물품 입고 중
    case stored = "STORAGE"    //물품 입고 됨
    case returned = "TAKE_BACK"    //물품 반품 됨
    case returning = "TAKE_BACK_ING"    //물품 반품 중
    case shipping = "SHIPPING_ING"    //물품 출고 중
    case shipped = "SHIPPING"   //물품 출고 됨
    case used = "USED"    //중고 물품
}
