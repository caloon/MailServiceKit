//
//  MailchimpService.swift
//  MailServiceKit
//
//  Created by Work on 25.01.18.
//

import Foundation



internal class MailchimpService {
    
    static let api = "https://us16.api.mailchimp.com/3.0/"
    
    
    class func addContact(apiKey: String, email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping MailServiceClosure) {
        
        // create params
        var params = [String: Any]()
        params["email"] = email
        if let userAttributes = attributes {
            for attribute in userAttributes {
                params[attribute.key] = attribute.value
            }
        }
        
        
        if let subscriptionLists = lists {
            for list in subscriptionLists {
                // create request
                var request = URLRequest(url: URL(string: MailchimpService.api + "lists/" + list + "/members")!)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                // Manage Auth using API Key
                let credentials = "user:" + apiKey
                let credentialData = credentials.data(using: String.Encoding.utf8)!
                let base64Credentials = credentialData.base64EncodedString()
                request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")

                
                // parse JSON
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: params)
                } catch let error {
                    completion(error, nil)
                }
                
                // URLSession > send request to server
                URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completion(error, jsonData)
                    } catch let e {
                        completion(e, nil)
                    }
                    }.resume()
            }
        } else {
            completion(MailServiceError.listRequired, nil)
        }
        
    }
}
