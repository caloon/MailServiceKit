//
//  SendinblueService.swift
//  MailServiceKit
//
//  Created by Work on 04.12.17.
//  Copyright © 2017 Josef Moser. All rights reserved.
//

import Foundation

internal class SendinblueService {
    
    static let api = "https://api.sendinblue.com/v3/"
    
    
    class func sendEmail(apiKey: String, sender: MailContact, recipients: [MailContact], subject: String, content: String, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create params
        var params = [String: Any]()
        params["sender"] = ["email": sender.email, "name": sender.fullname]
        
        var recipientParams = [Dictionary<String, Any>]()
        for recipient in recipients {
            recipientParams.append(["email":recipient.email, "name":recipient.fullname])
        }
        params["to"] = recipientParams
        params["subject"] = subject
        params["htmlContent"] = content
        params["replyTo"] = ["email": sender.email]
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "smtp/email")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        print(params)
        // parse JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        } catch let error {
            completion(error, nil)
        }
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            print(response)
            print(data)
            print(error)
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    
    class func getLists(apiKey: String, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts/lists")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    class func getList(apiKey: String, id: Int, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts/lists/" + String(id))!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    class func getContacts(apiKey: String, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    class func getContact(apiKey: String, email: String, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts/" + email)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
        
        
    }
    
    class func addContact(apiKey: String, email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create params
        var params = [String: Any]()
        params["email"] = email
        if let userAttributes = attributes {
            params["attributes"] = userAttributes
        }
        if let subscriptionLists = lists {
            params["listid"] = subscriptionLists
        }
        
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // parse JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        } catch let error {
            completion(error, nil)
        }
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    class func updateContact(apiKey: String, email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void) {
        
        // create params
        var params = [String: Any]()
        if let userAttributes = attributes {
            params["attributes"] = userAttributes
        }
        if let subscriptionLists = lists {
            params["listIds"] = subscriptionLists
        }
        
        
        // create request
        var request = URLRequest(url: URL(string: SendinblueService.api + "contacts/" + email)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        // parse JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        } catch let error {
            completion(error, nil)
        }
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                print(String(data: data!, encoding: String.Encoding.utf8))
                if String(data: data!, encoding: String.Encoding.utf8) != "" {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                    completion(error, jsonData)
                }
                completion(error, nil)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
}
