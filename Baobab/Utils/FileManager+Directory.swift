//
//  FileManager+Directory.swift
//  Baobab
//
//  Created by 이정훈 on 8/29/24.
//

import Foundation

//데이터 저장을 위한 디렉토리 경로를 반환하는 함수
func getDocumentsDir() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
