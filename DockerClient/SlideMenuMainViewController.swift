//
//  SlideMenuMainViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/7/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class SlideMenuMainViewController: AMSlideMenuMainViewController {
    var dockerHostUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segueIdentifierForIndexPathInLeftMenu(indexPath: NSIndexPath!) -> String! {
        var identifier: String?
        switch indexPath.row {
            case 0:
                identifier = "imagesSegue"
            case 1:
                identifier = "containersSegue"
            default:
                identifier = nil
        }
        
        return identifier
    }
    
    override func configureLeftMenuButton(button: UIButton!) {
        var menuButtonImage = UIImage(named: "slideMenuBarButtonItem.png")
        var frame = button.frame
        frame.origin = CGPoint(x: 0, y: 0)
        frame.size = CGSize(width: 40, height: 40)
        button.frame = frame
        button.setImage(menuButtonImage, forState: UIControlState.Normal)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "leftMenu" {
            var lsmtvc: LeftSlideMenuTableViewController? = segue.destinationViewController as? LeftSlideMenuTableViewController
            if let dvc = lsmtvc {
                dvc.dockerHostUrl = dockerHostUrl
            }
        }
    }

}
