//
//  MailService.swift
//  MailServiceKit
//
//  Created by Work on 04.12.17.
//  Copyright © 2017 Josef Moser. All rights reserved.
//

import Foundation

public typealias MailServiceClosure = (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void

public enum MailServiceProvider: String {
    case intercom = "intercom"
    case mailchimp = "mailchimp"
    case sendinblue = "sendinblue"
    case sendgrid = "sendgrid"
}


public enum MailServiceError: Error {
    case missingAPIKey, missingProvider, listRequired, unimplemented
}

public class MailContact {
    var email: String
    var fullname: String
    
    public init(email: String, fullname: String) {
        self.email = email
        self.fullname = fullname
    }
}

public class MailService {
    
    private let mailchimpURL = "https://us16.api.mailchimp.com/3.0/lists/"
    private let sendinblueURL = "https://api.sendinblue.com/v2.0/"
    
    private /*lazy*/ var apiKey: String? {
        if provider != nil {
            if let key = Keychain.load(service: provider!.rawValue) {
                print(key)
                return key
            }
        }
        return nil
    }
    
    private /*lazy*/ var provider: MailServiceProvider?
    
    
    // -----------
    
    public class func with(provider: MailServiceProvider, apiKey: String) {
        Keychain.save(service: provider.rawValue, data: apiKey)
    }
    
    // -----------
    
    public init(provider: MailServiceProvider) {
        self.provider = provider
    }
    
    // -----------
    
    public func sendEmail(sender: MailContact, recipients: [MailContact], subject: String, content: String, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.sendEmail(apiKey: apiKey!, sender: sender, recipients: recipients, subject: subject, content: content, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func getContacts(completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.getContacts(apiKey: apiKey!, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    
   public func getContact(email: String, completion: @escaping MailServiceClosure) {
        
    if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
    else if provider == nil { completion(MailServiceError.missingProvider, nil) }
        
    else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.getContact(apiKey: apiKey!, email: email, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func addContact(email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.addContact(apiKey: apiKey!, email: email, attributes: attributes, lists: lists, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func updateContact(email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping MailServiceClosure) {

        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
        
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.updateContact(apiKey: apiKey!, email: email, attributes: attributes, lists: lists, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func subscribe(contact: String, list: Int, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            
        }
    }
    
    public func unsubscribe(contact: String, list: Int, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            
        }
    }
    
    public func getLists(completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.getLists(apiKey: apiKey!, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func getList(id: Int, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            switch provider! {
                
            case .sendinblue:
                SendinblueService.getList(apiKey: apiKey!, id: id, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    private func addMailchimpContact(email: String, attributes: Dictionary<String, Any>?, lists: Array<String>?, completion: @escaping MailServiceClosure) {
        
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
                var request = URLRequest(url: URL(string: mailchimpURL + list + "/members")!)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                // Manage Auth using API Key
                if apiKey == nil {
                    let credentials = "user:" + apiKey!
                    let credentialData = credentials.data(using: String.Encoding.utf8)!
                    let base64Credentials = credentialData.base64EncodedString()
                    request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
                } else {
                    completion(MailServiceError.missingAPIKey, nil)
                }
                
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
    
    private func getMailchimpLists(completion: @escaping MailServiceClosure) {
        completion(nil, nil)
    }
}
