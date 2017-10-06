//
//  Bearer.swift
//  twitterClient
//
//  Created by Martin SIREAU on 10/6/17.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import Foundation

class Bearer {
    
    let url = URL(string: "https://api.twitter.com/oauth2/token")
    
    init() {
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + Singleton.BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            print(response ?? "RESPONSE IS NIL")
            if let err = error {
                print(err)
            } else if let d = data {
                do{
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary{
                        self.retrieveToken(myDic :dic)
                    }
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func retrieveToken(myDic: NSDictionary){
        Singleton.accessToken = myDic.value(forKey: "access_token") as! String
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goFetchTweet"), object: nil)
    }
}
