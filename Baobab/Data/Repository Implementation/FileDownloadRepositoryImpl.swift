//
//  FileDownloadRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

final class FileDownloadRepositoryImpl: FileDownloadRepository {
    private let fileDataSource: FileDataSource
    
    init(fileDataSource: FileDataSource) {
        self.fileDataSource = fileDataSource
    }
    
    ///이미지 URL을 통해 이미지 파일 다운로드
    func download(for url: URL) -> AnyPublisher<Data, any Error> {
        return fileDataSource.downloadFile(url)
    }
}
