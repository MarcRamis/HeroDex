//
//  MyImageView.swift
//  RepasoClase
//
//  Created by Abraham Lopez on 27/4/23.
//

import Foundation
import UIKit

class MyImageView: UIImageView {
    
    private static let NoSecureDelegate = NoSecureCallDelegate()
    
    private static let ImageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession(configuration: config, delegate: NoSecureDelegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    private var currentTask: URLSessionDataTask? = nil
    
    func SetImageAsync(url: URL) {
        
        currentTask?.cancel()
        
        currentTask = MyImageView.ImageSession.dataTask(with: url) { imageData, response, error in
            if let imageData = imageData {
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self.image = image
                    }
                }
            }
        }
        
        currentTask?.resume()
    }
    
    private class NoSecureCallDelegate: NSObject, URLSessionDelegate {
        
        public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
        
    }
}
