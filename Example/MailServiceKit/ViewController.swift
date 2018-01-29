//
//  ViewController.swift
//  MailServiceKit
//
//  Created by Work on 04.12.17.
//  Copyright © 2017 Josef Moser. All rights reserved.
//

import UIKit
import MailServiceKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let sendinblue = MailService(provider: .sendinblue)
        
        // Send transactional emails
//        sendinblue.sendEmail(sender: MailContact(email: "test@test.com", fullname: "Josef Moser"),
//                              recipients: [MailContact(email: "test@test.com", fullname: "Josef Moser")],
//                              subject: "Test",
//                              content: "This is a test email sent from MailServiceKit") { (error, result) in
//                                print(error)
//                                print(result)
//        }
        
        // Contact Management
//        sendinblue.addContact(email: "test@josefmoser.de", attributes:nil, lists: ["4"]) { (error, result) in
//            print(error)
//            print(result)
//        }
//                sendinblue.getContacts { (error, result) in
//                    print(error)
//                    print(result)
//                }
//                sendinblue.getContact(email: "test@test.com") { (error, result) in
//                    print(error)
//                    print(result)
//                }
//                sendinblue.updateContact(email: "test@test.com", attributes: nil, lists: ["4"]) { (error, result) in
//                    print(error)
//                    print(result)
//                }
        
        sendinblue.subscribeContact(email: "test@test.com", list: "4") { (error, result) in
            //
        }
        
        sendinblue.unsubscribeContact(email: "test@test.com", list: "5") { (error, result) in
            //
        }
        
        
        // List Management
//                sendinblue.getLists { (error, result) in
//                    print(error)
//                    print(result)
//                }
//                sendinblue.getList(id: 4) { (error, result) in
//                    print(error)
//                    print(result)
//                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
