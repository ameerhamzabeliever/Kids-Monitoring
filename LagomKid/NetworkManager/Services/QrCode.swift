//
//  QrCodeApis.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 13/04/2022.
//

import Foundation
import Alamofire

extension NetworkManager{
    func qrSignIn(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPostRequest(
            BASE_URL: BaseUrl_StgCore,
            API : Constants.EndPoints.SIGN_IN,
            parameters: param,
            completion: completion)
    }
    func activateChild(
        param       : [String: Any],
        completion  : @escaping (DataResponse<String, AFError>) -> ()
    ){
        Helper.debugLogs(data: param, title: "Parameters")
        sendPostRequestAuthHeaders(
            BASE_URL: BaseUrl_StgCore,
            API: Constants.EndPoints.ACTIVATE,
            parameters: param,
            completion: completion)
    }
}
