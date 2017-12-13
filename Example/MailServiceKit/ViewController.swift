//
//  ViewController.swift
//  MailServiceKit
//
//  Created by Work on 04.12.17.
//  Copyright © 2017 Josef Moser. All rights reserved.
//

import UIKit
import MailService

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let mailservice = MailService(apiKey: "", provider: .sendinblue)
        
        // Send transactional emails
        mailservice.sendEmail(sender: MailContact(email: "test@test.com", fullname: "Josef Moser"),
                              recipients: [MailContact(email: "test@josefmoser.de", fullname: "Josef Moser")],
                              subject: "Test",
                              content: "This is a test email sent from MailServiceKit") { (error, result) in
                                print(error)
                                print(result)
        }
        
        // Contact Management
        //        mailservice.getContacts { (error, result) in
        //            print(error)
        //            print(result)
        //        }
        //        mailservice.getContact(email: "test@josefmoser.de") { (error, result) in
        //            print(error)
        //            print(result)
        //        }
        //        mailservice.updateContact(email: "test2@josefmoser.de", attributes: nil, lists: ["4"]) { (error, result) in
        //            print(error)
        //            print(result)
        //        }
        
        
        // List Management
        //        mailservice.getLists { (error, result) in
        //            print(error)
        //            print(result)
        //        }
        //        mailservice.getList(id: 4) { (error, result) in
        //            print(error)
        //            print(result)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
