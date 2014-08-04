//
//  DockerClient.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/3/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import Foundation

class DockerClient {
    class var connection: DockerClient {
        struct Static {
            static let instance: DockerClient = DockerClient()
        }
        return Static.instance
    }
    
    private init() { }
    
    func request(url: String, completionBlock: (error: NSErrorPointer, responseArray:[DockerImage]) -> ()) {
        let url = NSURL(string: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {(data: NSData!, response: NSURLResponse!, error:NSError!) -> Void in
            if (error) {
                println(error.localizedDescription)
            }
            
            
            var err: NSError?
            
            var images = [DockerImage]()
            if let json: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSArray {
                for image in json {
                    var repoTags: [String] = image["RepoTags"] as [String]
                    var id: String = image["Id"] as String
                    var created: Int = image["Created"] as Int
                    var size: Int = image["Size"] as Int
                    var virtualSize: Int = image["VirtualSize"] as Int
                    
                    var image: DockerImage = DockerImage(repoTags: repoTags, id: id, created: created, size: size, virtualSize: virtualSize)
                    images.append(image)
                }
            }
            
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            completionBlock(error: &err, responseArray: images)
        })
        
        task.resume()
    }
    
    
}