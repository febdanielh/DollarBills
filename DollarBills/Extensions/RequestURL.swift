//
//  RequestURL.swift
//  DollarBills
//
//  Created by Febrian Daniel on 16/11/23.
//

import Foundation


func POSTrequestRule() {
    guard let url = URL(string: "https://api.appstoreconnect.apple.com/v1/gameCenterMatchmakingRules") else {
        return
    }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: [String: Any]] = [
        "data": [
            "type": "gameCenterMatchmakingRules",
            "attributes": [
                "type": "MATCH",
                "description": "Check whether the players use the same game settings.",
                "referenceName": "sameDuration",
                "expression": "requests[0].properties.theme == requests[1].properties.theme",
                "weight": 10
            ],
            "relationships": [
                "ruleSet": [
                    "data": [
                        "type": "gameCenterMatchmakingRuleSets",
                        "id": "6f1a0e6a-a260-4d68-a6fb-6fb382b2f946"
                    ]
                ]
            ]
        ]
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {return}
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(response)
        } catch {
            print(error)
        }
    }
    task.resume()
}

func POSTrequestRuleSet() {
    guard let url = URL(string: "https://api.appstoreconnect.apple.com/v1/gameCenterMatchmakingRuleSets") else {
        return
    }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: [String: Any]] = [
        "data": [
            "type": "gameCenterMatchmakingRuleSets",
            "attributes": [
                "referenceName": "duelRuleSet",
                "ruleLanguageVersion": 1,
                "minPlayer": 2,
                "maxPlayer": 2
            ],
            "relationships": [
                "ruleSet": [
                    "data": [
                        "type": "gameCenterMatchmakingRuleSets",
                        "id": "6f1a0e6a-a260-4d68-a6fb-6fb382b2f946"
                    ]
                ]
            ]
        ]
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {return}
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(response)
        } catch {
            print(error)
        }
    }
    task.resume()
}

func GETrequest() {
    
}
