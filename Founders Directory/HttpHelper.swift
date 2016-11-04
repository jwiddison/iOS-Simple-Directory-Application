//
//  HttpHelper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/2/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation

class HttpHelper : NSObject, URLSessionDelegate {
    
    // MARK: - Properties

    // MARK: - Singleton
    
    static let shared = HttpHelper()
    
    fileprivate override init() { }
    
    func getContent(urlString: String, completionHandler: (Data?) -> ()) {
        if let url = URL(string: urlString) {
            var resultData: Data?
            let semaphore = DispatchSemaphore(value: 0)
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration,
                                     delegate: self,
                                     delegateQueue: nil)

            session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    resultData = data
                }
                
                semaphore.signal()
            }.resume()
            
            semaphore.wait()
            completionHandler(resultData)
        }
    }
    
    func getContent(urlString: String, failureCode: String, completionHandler: (String) -> ()) {
        if let url = URL(string: urlString) {
            var content = ""
            let semaphore = DispatchSemaphore(value: 0)

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil || data == nil {
                    content = failureCode
                }

                content = String(data: data!, encoding: String.Encoding.utf8) ?? failureCode
                semaphore.signal()
            }.resume()

            semaphore.wait()
            completionHandler(content)
        }
    }

    func postContent(urlString: String, completionHandler: (Data?) -> ()) {
        if let url = URL(string: urlString) {
            var resultData: Data?
            let semaphore = DispatchSemaphore(value: 0)

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    resultData = data
                }

                semaphore.signal()
            }.resume()

            semaphore.wait()
            completionHandler(resultData)
        }
    }
    
    // MARK: - Session delegate

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.protectionSpace.host == "scriptures.byu.edu" {
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

                completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
            }
        }
    }
}
