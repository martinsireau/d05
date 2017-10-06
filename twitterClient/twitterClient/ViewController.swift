//
//  ViewController.swift
//  twitterClient
//
//  Created by Martin SIREAU on 10/6/17.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import UIKit

protocol APITwitterDelegate : class {
    func processTweet(tweets: [Tweet])
    func errorBack(error: NSError)
}

class ViewController: UIViewController {
    
    let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?lang=fr&result_type=recent=100")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Bearer.init()
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Singleton.accessToken, forHTTPHeaderField: "Authorization")
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
                        print(dic)
                    }
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
    }
}

