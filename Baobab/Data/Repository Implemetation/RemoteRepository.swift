//
//  Repository.swift
//  Baobab
//
//  Created by 이정훈 on 5/30/24.
//


class RemoteRepository {
    let dataSource: RemoteDataSource
    
    init(dataSource: RemoteDataSource) {
        self.dataSource = dataSource
    }
}
