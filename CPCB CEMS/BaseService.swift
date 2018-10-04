//
//  BaseService.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import Alamofire

let constantUrl = "http://cpcbrtdms.nic.in/api/public/"

class BaseService: NSObject {
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil, completion:@escaping (_ response:Any? ,_ error:ErrorModal?) -> Void)
    {
        
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 15
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 15
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON {[weak self] response in
            
            self?.processResponse(response, completion: completion)
        }
    }
    
    func request(_ urlRequest: URLRequestConvertible, completion:@escaping (_ response:Any? ,_ error:ErrorModal?) -> Void) {
        
        Alamofire.request(urlRequest)
            .responseJSON{[weak self] response in
                self?.processResponse(response, completion: completion)
        }
    }
    
    func processResponse(_ response:DataResponse<Any> , completion:@escaping (_ response:Any? ,_ error:ErrorModal?) -> Void) {
        print(response)
        if response.result.isSuccess {
            if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 299{
                completion(response, nil)
            }
            else {
                var error = ErrorModal()
                
                completion(nil,error)
            }
        }
        else {
            let error = ErrorModal()
            
            let message:String = "Could not connect to the server. Please try again."
            error.title = "Oops!"
            error.message = message
            
            completion(response, error)
        }
    }
}

class ErrorModal: NSObject {
    
    var title:String = ""
    var message:String = ""
    var errorCode = 0
}

