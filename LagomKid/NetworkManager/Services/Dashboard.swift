//
//  Home.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 27/04/2022.
//

import Foundation
import Alamofire

extension NetworkManager{
    func contacts(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPutRequestHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.CONTACTS,
            parameters: param,
            completion: completion)
    }
    func location(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPutRequestHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.LOCATIONS,
            parameters: param,
            completion: completion)
    }
    func sos(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPostRequestHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.SOS,
            parameters: param,
            completion: completion)
    }
    
    func pickme(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPutRequestHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.PICKME,
            parameters: param,
            completion: completion)
    }
    func userProfile(
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        sendGetRequestWithHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.USER_PROFILE,
            completion: completion)
    }
    func fencingPlaces(
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        sendGetRequestWithHeaders(
            BASE_URL: BaseUrl_StgMesh,
            API: Constants.EndPoints.FENCING_PLACES,
            completion: completion)
    }
}
