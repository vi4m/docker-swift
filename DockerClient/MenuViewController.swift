//
//  MenuViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/8/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    var dockerHostUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 3
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cellIdentifier = "cellIdentifier"
        switch (indexPath.row) {
            case 0:
                cellIdentifier = "dashboardCellIdentifier"
                break
            case 1:
                cellIdentifier = "containersCellIdentifier"
                break
            case 2:
                cellIdentifier = "imagesCellIdentifier"
            default:
                break
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor(red: 0.541, green: 0.545, blue: 0.588, alpha: 1)
        return cell
    }
    
    
    func updateUI() -> Void {
        self.tableView.backgroundColor = UIColor(red: 0.541, green: 0.545, blue: 0.588, alpha: 1)
        // self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let tableViewCell = sender as? UITableViewCell {
            var nc: UINavigationController = segue.destinationViewController as UINavigationController
            if let itvc = nc.childViewControllers.first as? ImagesTableViewController {
                if (dockerHostUrl != nil) {
                    itvc.dockerHostUrl = dockerHostUrl
                }
            }
        }
    }

}
