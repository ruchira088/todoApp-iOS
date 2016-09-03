//
//  ViewController.swift
//  Todo App
//
//  Created by Ruchira Jayasekara on 3/09/2016.
//  Copyright © 2016 Ruchira Jayasekara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginTouchUp(sender: UIButton)
    {
        let username: String! = usernameField.text
        let password: String! = passwordField.text
        
        let body = ["username": username, "password": password]
        
        do {
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            
            let url = NSURL(string: "http://52.63.69.15:8000/account/login")
            
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.setValue("application/json; chartset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonBody

            let requestTask = NSURLSession.sharedSession().dataTaskWithRequest(request){data, response, error in
                
                if error != nil {
                    print(error)
                    return
                }
                
                do {
                    let responseData = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:String]
                    print(responseData["token"]!)
                }
                catch
                {
                    
                }
            }
            
            requestTask.resume()
            
        } catch
        {
            
        }
    }

}

