//
//  NetworkAPI.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import Foundation
import RxSwift
protocol NetworkServiceProtocol {
    func fetchRepositories<T: Decodable>(type : T.Type , _ api: AppStoreApi) -> Observable<T>
}
