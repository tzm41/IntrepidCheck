//
//  SlackService.swift
//  IntrepidCheck
//
//  Created by Colin Tan on 6/13/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import Foundation

enum PostResponse {
    case Success
    case Failure(ErrorType)
}

class SlackService {
    static let sharedService = SlackService()
    
	private let session: NSURLSession = {
		let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
		sessionConfig.HTTPAdditionalHeaders = ["Content-Type": "application/json",
        "Accept": "application/json"]

		let session = NSURLSession(configuration: sessionConfig)
		return session
	}()
    
    func postMessageWithBody(body: String, completion: ((PostResponse) -> Void)? = nil) {
        let webhookPath = "https://hooks.slack.com/services/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"
        guard let url = NSURL(string: webhookPath) else {
            return
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        do {
            let dict: [String: String] = [
                "text": body
            ]
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: [])
            
            let task = session.uploadTaskWithRequest(request, fromData: jsonData) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                var result: PostResponse
                
                if let data = data {
                    print("data \(data)")
                    result = PostResponse.Success
                } else {
                    print("failure")
                    result = PostResponse.Failure(error!)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    completion?(result)
                }
            }
            task.resume()
        } catch let error as NSError {
            completion?(PostResponse.Failure(error))
        }
    }
}
