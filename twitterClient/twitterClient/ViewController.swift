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
    
    let querie = "lol"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Bearer.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchTweet), name: NSNotification.Name(rawValue: "goFetchTweet"), object: nil)
    }
    
    func fetchTweet(){
//        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=%23\(querie)lang=fr&result_type=recent=100")
        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=%23freebandnames&since_id=24012619984051000&max_id=250126199840518145&result_type=mixed")

        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Singleton.accessToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            print(response ?? "RESPONSE IS NIL")
            if let err = error {
                print(err)
            } else if let d = data {
                do{
//                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary{
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary{
                        print("\n\n")
                        print(dic)
//                        self.processResult(data: d, response: response!, error: error)
                    }
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
    }
    
//    func processResult(data: Data, response:URLResponse, error: Error?) {
//
//        var errorPointer : NSErrorPointer = nil
//
//        if let results: NSDictionary = JSONSerialization .JSONObjectWithData(data, options: JSONSerialization.ReadingOptions.AllowFragments  , error: errorPointer) as? NSDictionary {
//
//            if var users = results["users"] as? NSMutableArray {
//                for user in users {
//                    let follower = TwitterFollower(name: user["name"] as! String, url: user["profile_image_url"] as! String)
//                    self.delegate?.finishedDownloading(follower)
//                }
//
//            } else {
//                println(results["errors"])
//            }
//        }
//    }
}

