//
//  ApiHandler.swift
//  Matrix
//
//  Created by Siddhant Nigam on 03/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift

struct ApiHandler {
    
    
    static let shared = ApiHandler()
    static let disposebag = DisposeBag()
    
    
    
    static func postApiCall(urlMethod: String,params: [String: Any]) -> (Observable<Data>?) {
        
        
        guard let url = URL(string: Constants.baseUrl + urlMethod) else {return nil}
        
        return Observable.create({ (observable) -> Disposable in
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:])
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        let responseData = response.data
                        guard let data = responseData else {
                             UIUtility.showErrorAlert("", message: "Something Went Wrong.")
                            return }
                        observable.onNext(data)
                        observable.onCompleted()
                        
                    case .failure(let error):
                        print(error)
                        UIUtility.showErrorAlert("", message: "Something Went Wrong.")
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        })
        
    }
    
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
