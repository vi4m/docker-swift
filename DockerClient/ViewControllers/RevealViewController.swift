//
//  RevealViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/9/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController {
    var dockerHostUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sw_front" {
            if let dvc = (segue.destinationViewController as? UINavigationController)?.childViewControllers.first as? ImagesTableViewController {
                dvc.dockerHostUrl = dockerHostUrl
            }
        }
        
        if let dvc = segue.destinationViewController as? MenuViewController {
            dvc.dockerHostUrl = dockerHostUrl
        }
    }

}
