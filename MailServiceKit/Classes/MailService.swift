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
    
    private /*lazy*/ var apiKey: String? {
        if provider != nil {
            if let key = Keychain.load(service: provider!.rawValue) {
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
    
    public func subscribeContact(email: String, list: String, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            
            switch provider! {
                
            case .sendinblue:
                SendinblueService.updateContactSubscription(apiKey: apiKey!, email: email, subscribe: true, list: list, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
        }
    }
    
    public func unsubscribeContact(email: String, list: String, completion: @escaping MailServiceClosure) {
        
        if apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
        else if provider == nil { completion(MailServiceError.missingProvider, nil) }
            
        else {
            
            switch provider! {
                
            case .sendinblue:
                SendinblueService.updateContactSubscription(apiKey: apiKey!, email: email, subscribe: false, list: list, completion: { (error, result) in
                    completion(error, result)
                })
                
            default: completion(MailServiceError.unimplemented, nil)
            }
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
    
}
