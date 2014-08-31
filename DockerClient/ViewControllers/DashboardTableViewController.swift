//
//  DashboardTableViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/9/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    @IBOutlet weak var slideMenuBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateUI() -> Void {
        self.navigationController.navigationBar.barTintColor = UIColor(red: 0.165, green: 0.169, blue: 0.231, alpha: 1)
        self.navigationController.navigationBar.translucent = false
        for view in self.navigationController.navigationBar.subviews {
            for view2 in view.subviews {
                if let subView = view2 as? UIImageView {
                    if subView.frame.size.height < 2 {
                        subView.removeFromSuperview()
                    }
                }
            }
        }
        
        if let rvc: SWRevealViewController = self.revealViewController() {
            rvc.toggleAnimationDuration = 0.16
            rvc.toggleAnimationType = SWRevealToggleAnimationType.EaseOut
            self.slideMenuBarButtonItem.target = self.revealViewController()
            self.slideMenuBarButtonItem.action = "revealToggle:"
            self.navigationController.navigationBar.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.231, alpha: 1)
        self.tableView.registerNib(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "dashboardCellIdentifier")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.scrollEnabled = false
        self.tableView.tableFooterView = UIView(frame: CGRectZero) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: DashboardTableViewCell = tableView.dequeueReusableCellWithIdentifier("dashboardCellIdentifier", forIndexPath: indexPath) as DashboardTableViewCell!
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 160
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
