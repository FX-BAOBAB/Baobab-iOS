//
//  LocalDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol LocalDataSource {
    func save(data: Data, to url: URL) async throws
    func delete(at url: URL) async throws
}

final class LocalDataSourceImpl: LocalDataSource {
    ///파일 저장 함수
    func save(data: Data, to url: URL) async throws {
        //Task 수행이 완료될 때까지 기다리고 에러를 호출자 쪽으로 전달
        try await Task.detached(priority: .background) {
            try data.write(to: url)
        }.value
    }
    
    ///파일 삭제 함수
    func delete(at url: URL) async throws {
        //Task 수행이 완료될 때까지 기다리고 에러를 호출자 쪽으로 전달
        try await Task.detached(priority: .background) {
            try FileManager.default.removeItem(at: url)
        }.value
    }
}
