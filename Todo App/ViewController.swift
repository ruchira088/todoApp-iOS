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
    
    @IBOutlet weak var errorPanel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func covertToDictionary(data: NSData?) -> [String: Any] {
        do
        {
            return try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: String]
        }
        catch
        {
            return [String: Any]()
        }
    }
    
    func isSuccessful(response: NSURLResponse?) -> Bool
    {
        let httpResponse = response! as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        return (statusCode < 300 && statusCode >= 200)
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
                
                if error != nil
                {
                    self.errorPanel.text = "Unable to connect to the server."
                    return
                }
                
                if self.isSuccessful(response)
                {
                    do {
                        let responseData = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:String]
                        print(responseData["token"]!)
                        
                        return
                    }
                    catch
                    {
                        
                    }
                    
                }
                else
                {
                    print("Invalid credentials")
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.errorPanel.text = "Invalid credentials"
                    }
                    
                    
                }
            }
            
            requestTask.resume()
            
        } catch
        {
            
        }
    }

}

