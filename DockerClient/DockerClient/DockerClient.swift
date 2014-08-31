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
    
    func urlFormatter(baseUrl: String = "", port: Int = 80, path: String = "", query: String = "") -> NSURL {
        var components = NSURLComponents(URL: NSURL(string: baseUrl), resolvingAgainstBaseURL: false)
        if let scheme = components.scheme {
            components.scheme = "http"
        }
        components.port = port
        components.path = path
        components.query = query
        return components.URL
    }
    
    func getImages(baseUrl: String, port: Int = 80, all: Bool = false, completionBlock: (error: NSErrorPointer, responseArray: [DockerImage]) -> ()) {
        // Format URI
        var query = all ? "all=1" : "all=0"
        var url: NSURL = urlFormatter(baseUrl: baseUrl, port: port, path: "/images/json", query: query)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {(data: NSData!, response: NSURLResponse!, error:NSError!) -> Void in
            if ((error) != nil) {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            var images = [DockerImage]()
            if let json: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSArray {
                for image in json {
                    var repoTags: [String] = image["RepoTags"] as [String]
                    var id: String = image["Id"] as String
                    var created: NSDate = NSDate(timeIntervalSince1970: image["Created"] as NSTimeInterval)
                    var size: Int = image["Size"] as Int
                    var virtualSize: Int = image["VirtualSize"] as Int
                    
                    var image: DockerImage = DockerImage()
                    image.repoTags = repoTags
                    image.id = id
                    image.created = created
                    image.size = size
                    image.virtualSize = virtualSize
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
    
    func inspectImage(baseUrl: String, port: Int = 80, name: String, completionBlock: (error: NSErrorPointer, image: DockerImage) -> ()) {
        var url: NSURL = urlFormatter(baseUrl: baseUrl, port: port, path: "/images/\(name)/json")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {(data: NSData!, response: NSURLResponse!, error:NSError!) -> Void in
            if ((error) != nil) {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            if let imageDetails: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                var image = DockerImage()
                image.architecture = imageDetails["Architecture"] as String
                image.author = imageDetails["Author"] as String
                image.comment = imageDetails["Comment"] as String
                var configJSON: NSDictionary = imageDetails["Config"] as NSDictionary
                image.config = DockerImage.Config(
                    attachStderr: configJSON["AttachStderr"] as Bool,
                    attachStdin: configJSON["AttachStdin"] as Bool,
                    attachStdout: configJSON["AttachStdout"] as Bool,
                    cmd: configJSON["Cmd"] as [String],
                    cpuShares: configJSON["CpuShares"] as Int,
                    cpuset: configJSON["Cpuset"] as String,
                    domainname: configJSON["Domainname"] as String,
                    entrypoint: configJSON["Entrypoint"]!,
                    env: configJSON["Env"] as [String],
                    exposedPorts: configJSON["ExposedPorts"] as [String: AnyObject],
                    hostname: configJSON["Hostname"] as String,
                    image: configJSON["Image"] as String,
                    memory: configJSON["Memory"] as Int,
                    memorySwap: configJSON["MemorySwap"] as Int,
                    networkDisabled: configJSON["NetworkDisabled"] as Bool,
                    onBuild: configJSON["OnBuild"]!,
                    openStdin: configJSON["OpenStdin"] as Bool,
                    portSpecs: configJSON["PortSpecs"]!,
                    stdinOnce: configJSON["StdinOnce"] as Bool,
                    tty: configJSON["Tty"] as Bool,
                    user: configJSON["User"] as String,
                    volumes: configJSON["Volumes"] as [String: AnyObject],
                    workingDir: configJSON["WorkingDir"] as String
                )
                image.container = imageDetails["Container"] as String
                var containerConfigJSON: NSDictionary = imageDetails["ContainerConfig"] as NSDictionary
                image.containerConfig = DockerImage.ContainerConfig(
                    attachStderr: containerConfigJSON["AttachStderr"] as Bool,
                    attachStdin: containerConfigJSON["AttachStdin"] as Bool,
                    attachStdout: containerConfigJSON["AttachStdout"] as Bool,
                    cmd: containerConfigJSON["Cmd"] as [String],
                    cpuShares: containerConfigJSON["CpuShares"] as Int,
                    cpuset: containerConfigJSON["Cpuset"] as String,
                    domainname: containerConfigJSON["Domainname"] as String,
                    entrypoint: containerConfigJSON["Entrypoint"]!,
                    env: containerConfigJSON["Env"] as [String],
                    exposedPorts: containerConfigJSON["ExposedPorts"] as [String: AnyObject],
                    hostname: containerConfigJSON["Hostname"] as String,
                    image: containerConfigJSON["Image"] as String,
                    memory: containerConfigJSON["Memory"] as Int,
                    memorySwap: containerConfigJSON["MemorySwap"] as Int,
                    networkDisabled: containerConfigJSON["NetworkDisabled"] as Bool,
                    onBuild: containerConfigJSON["OnBuild"]!,
                    openStdin: containerConfigJSON["OpenStdin"] as Bool,
                    portSpecs: containerConfigJSON["PortSpecs"]!,
                    stdinOnce: containerConfigJSON["StdinOnce"] as Bool,
                    tty: containerConfigJSON["Tty"] as Bool,
                    user: containerConfigJSON["User"] as String,
                    volumes: containerConfigJSON["Volumes"] as [String: AnyObject],
                    workingDir: containerConfigJSON["WorkingDir"] as String
                )
                var formatter: NSDateFormatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSZ"
                image.created = formatter.dateFromString(imageDetails["Created"] as String)
                image.dockerVersion = imageDetails["DockerVersion"] as String
                image.id = imageDetails["Id"] as String
                image.os = imageDetails["Os"] as String
                image.parent = imageDetails["Parent"] as String
                image.size = imageDetails["Size"] as Int
                
                completionBlock(error: &err, image: image)
            }
            
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
        })
        
        task.resume()
    }
}