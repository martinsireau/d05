//
//  Controller.swift
//  twitterClient
//
//  Created by Martin SIREAU on 10/6/17.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import Foundation

class APIController {
    
    weak var delegate : APITwitterDelegate?
    
    let token : String = ""
    
    init(twiterDelegate: APITwitterDelegate?, token: String) {
        self.delegate = twiterDelegate
        
    }
    
    func twitterRequest(request: String){
    
    }
}
