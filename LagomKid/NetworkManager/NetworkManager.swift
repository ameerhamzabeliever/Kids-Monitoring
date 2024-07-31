//
//  NetworkManager.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 13/04/2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    func sendGetRequest(
        BASE_URL : String,
        API: String,
        completion: @escaping (DataResponse<String, AFError>) -> Void
    ) -> Void {
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API,
            method: .get
        ).responseString { response in
            completion(response)
        }
    }
    func sendGetRequestWithHeaders(
        BASE_URL : String,
        API        : String,
        completion : @escaping (DataResponse<String, AFError>) -> Void
    ) -> Void {
        let headers = Constants.sharedInstance.httpUserToken
        AF.request(
            BASE_URL + API,
            method  : .get,
            headers : headers
        ).responseString { response in
            completion(response)
        }
    }
    
    func sendPostRequest(
        BASE_URL : String,
        API         : String,
        parameters  : Parameters,
        encoderRequest: URLEncoding = URLEncoding.default,
        completion  : @escaping (DataResponse<String, AFError>) -> Void
    ){
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method      : .post,
            parameters  : parameters,
            encoding    : encoderRequest
        ).responseString { (response) in
            completion(response)
        }
    }
    
    func sendPostRequestHeaders(
        BASE_URL    : String,
        API         : String,
        parameters  : Parameters,
        completion  : @escaping (DataResponse<String, AFError>) -> Void
    ){
        let headers = Constants.sharedInstance.httpUserToken
        Helper.debugLogs(data: headers, title: "Auth Header")
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method      : .post,
            parameters  : parameters,
            encoding    : JSONEncoding.default,
            headers     : headers
        ).responseString { (response) in
            completion(response)
        }
    }
    func sendPostRequestAuthHeaders(
        BASE_URL    : String,
        API         : String,
        parameters  : Parameters,
        completion  : @escaping (DataResponse<String, AFError>) -> Void
    ){
        let headers = Constants.sharedInstance.authHttpHeaders
        Helper.debugLogs(data: headers, title: "Auth Header")
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method      : .post,
            parameters  : parameters,
            encoding    : JSONEncoding.default,
            headers     : headers
        ).responseString { (response) in
            completion(response)
        }
    }
    func sendPutRequestHeaders(
        BASE_URL    : String,
        API         : String,
        parameters  : Parameters,
        completion  : @escaping (DataResponse<String, AFError>) -> Void
    ){
        let headers = Constants.sharedInstance.httpUserToken
        Helper.debugLogs(data: headers, title: "Auth Header")
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method      : .put,
            parameters  : parameters,
            encoding    : JSONEncoding.default,
            headers     : headers
        ).responseString { (response) in
            completion(response)
        }
    }
    func sendPutRequestAuthHeaders(
        BASE_URL    : String,
        API         : String,
        parameters  : Parameters,
        completion  : @escaping (DataResponse<String, AFError>) -> Void
    ){
        let headers = Constants.sharedInstance.authHttpHeaders
        Helper.debugLogs(data: headers, title: "Auth Header")
        Helper.debugLogs(data: BASE_URL + API, title: "Api Url")
        AF.request(
            BASE_URL + API.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method      : .put,
            parameters  : parameters,
            encoding    : JSONEncoding.default,
            headers     : headers
        ).responseString { (response) in
            completion(response)
        }
    }
}
