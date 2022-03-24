//
//  NetworkingAPI.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkingAPI : NetworkServiceProtocol{
    static let shared = NetworkingAPI()
    
    func fetchRepositories<T: Decodable>(type : T.Type , _ api: AppStoreApi) -> Observable<T> {

        URLSession.shared.rx
            .data(request : api.asURLRequest())
            .map{ item in
                let product = try JSONDecoder().decode(T.self, from: item)
                return product
            }

    }
}

class MockNetworking  : NetworkServiceProtocol{
    static let shared = MockNetworking()

    let jsonDecoder = JSONDecoder()

    func fetchRepositories<T: Decodable>(type : T.Type , _ api: AppStoreApi) -> Observable<T> {
        
        
        switch api{
        case .SERARCH_RECOMEND_APP(let term ) :
            
            let item =  try! jsonDecoder.decode(T.self, from: stubbedResponse("Search\(term)"))
            
            
            return Observable.of(item)
            
            
        }

    }
    
    
    
 
    
    
    
    func stubbedResponse(_ filename: String) -> Data! {
        let bundlePath = Bundle.main.path(forResource: "Json", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
    
}
    
//Moya 처럼 사용 가능하게 만들기위해
typealias HTTPHeaders = [String : String]

protocol TargetType {
    var baseURL: String { get }
    var headers : HTTPHeaders { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

enum HTTPMethod : String{
    case GET = "GET"
    case POST = "POST"
}




enum AppStoreApi {
    
    case SERARCH_RECOMEND_APP(term : String)
    
    
}

extension AppStoreApi : TargetType{
    
    
    var baseURL: String {
        return  "https://itunes.apple.com"
    }
    
    var headers : HTTPHeaders {
        return [:]
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var path: String {
        switch self {
        case .SERARCH_RECOMEND_APP :
            return "/search"
        }
        
       
    }
    
    var parameters: RequestParams {
        switch self{
        case .SERARCH_RECOMEND_APP(let term) :
            let param : SearchRequestModel = SearchRequestModel(term : term)
            
            return .query(param)
            
        }
    }
    
}



extension TargetType {

    // URLRequestConvertible 구현
    func asURLRequest() -> URLRequest {
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        
        switch parameters {
        case .query(let request):
            let params = request?.toDictionary ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let request):
            let params = request?.toDictionary ?? [:]
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        }

        
        return urlRequest
    }
}

//요청은 Json으로 만들기 때문에 Encodeable
enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}


