//
//  HttpHelper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/2/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class HttpHelper : NSObject, URLSessionDelegate {
    
    // MARK: - Constants

    private struct MultiPart {
        static let boundaryEnd = "\r\n--*****--\r\n"
        static let boundaryStart = "--*****\r\n"
        static let crLf = "\r\n"
        static let fieldFormat: NSString = "Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
        static let fileFormat = "Content-Disposition: form-data; name=\"file\"; filename=\"founderphoto\"\r\n\r\n"
        static let methodPost = "POST"
    }

    // MARK: - Properties

    var downloadTask: URLSessionDataTask!

    // MARK: - Singleton
    
    static let shared = HttpHelper()
    
    fileprivate override init() { }

    // MARK: - Public API

    func postMultipartContent(urlString: String,
                              parameters: [String : String],
                              image: UIImage,
                              completionHandler: (Data?) -> ()) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url,
                                     cachePolicy: .reloadIgnoringLocalCacheData,
                                     timeoutInterval: 10)
            let body = NSMutableString()

            for (key, value) in parameters {
                addFormField(payload: body, fieldName: key, value: value)
            }

            body.append(MultiPart.boundaryStart)
            body.append(MultiPart.fileFormat)

            let requestData = NSMutableData()

            requestData.append(body.data(using: String.Encoding.utf8.rawValue)!)
            requestData.append(UIImageJPEGRepresentation(image, 1.0)!)
            requestData.append(MultiPart.boundaryEnd.data(using: String.Encoding.utf8)!)

            request.httpBody = requestData as Data
            request.httpMethod = MultiPart.methodPost

            let semaphore = DispatchSemaphore(value: 0)
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration,
                                     delegate: self,
                                     delegateQueue: nil)
            var resultData: Data?

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

    private func addFormField(payload: NSMutableString, fieldName: String, value: String) {
        payload.append(MultiPart.boundaryStart)
        payload.appendFormat(MultiPart.fieldFormat, fieldName)
        payload.append(value + MultiPart.crLf)
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.protectionSpace.host == "scriptures.byu.edu" {
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

                completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
            }
        }
    }
}
