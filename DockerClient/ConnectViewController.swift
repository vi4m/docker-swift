//
//  ConnectViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/5/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dockerHostTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dockerHostTextField.delegate = self
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        dockerHostTextField.resignFirstResponder()
        super.touchesBegan(touches, withEvent: event)
    }
    
    func updateUI() -> Void {
        var placeholderColor = UIColor(red: 0.675, green: 0.678, blue: 0.710, alpha: 1)
        dockerHostTextField.attributedPlaceholder = NSAttributedString(string: "Docker Host", attributes: [NSForegroundColorAttributeName: placeholderColor])
        
    }
    
    @IBAction func connectBtnPressed(sender: UIButton) {
        dockerHostTextField.resignFirstResponder()
    }
}
