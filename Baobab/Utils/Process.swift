//
//  Process.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Foundation

struct Process: Identifiable{
    let id: Int
    let status: String
    let description: String
}

let receivingProcess = [
    "TAKING": Process(id: 1, status: "접수 중", description: "접수가 요청되어 픽업 일정을 조정하는 중입니다."),
    "REGISTERED": Process(id: 2, status: "접수 완료", description: "픽업 일정이 확정되었습니다."),
    "CHECKING": Process(id: 3, status: "입고 심사", description: "픽업자가 입고 전 심사를 진행 중입니다."),
    "CONFIRMATION": Process(id: 4, status: "입고 확정", description: "입고가 확정되어 입고 일정을 조정하는 중입니다."),
    "DELIVERY": Process(id: 5, status: "배송 중", description: "물건을 안전하게 배송 중입니다."),
    "RECEIVING": Process(id: 6, status: "배송 완료", description: "물건이 지정된 창고에 도착하였습니다."),
    "LOADING": Process(id: 7, status: "입고 진행 중", description: "최종 검수 및 창고 적재 진행 중입니다."),
    "STORAGE": Process(id: 8, status: "입고 완료", description: "입고가 완료되어 안전하게 보관 중입니다."),
    "CLOSE": Process(id: 9, status: "CLOSE", description: "요청이 닫힌 상태입니다.")
]
