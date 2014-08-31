//
//  DockerImage.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/3/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import Foundation

public class DockerImage {
    struct Config {
        var attachStderr: Bool
        var attachStdin: Bool
        var attachStdout: Bool
        var cmd: [String]
        var cpuShares: Int
        var cpuset: String
        var domainname: String
        var entrypoint: AnyObject
        var env: [String]
        var exposedPorts: [String: AnyObject]
        var hostname: String
        var image: String
        var memory: Int
        var memorySwap: Int
        var networkDisabled: Bool
        var onBuild: AnyObject
        var openStdin: Bool
        var portSpecs: AnyObject
        var stdinOnce: Bool
        var tty: Bool
        var user: String
        var volumes: [String: AnyObject]
        var workingDir: String
    }
    
    struct ContainerConfig {
        var attachStderr: Bool
        var attachStdin: Bool
        var attachStdout: Bool
        var cmd: [String]
        var cpuShares: Int
        var cpuset: String
        var domainname: String
        var entrypoint: AnyObject
        var env: [String]
        var exposedPorts: [String: AnyObject]
        var hostname: String
        var image: String
        var memory: Int
        var memorySwap: Int
        var networkDisabled: Bool
        var onBuild: AnyObject
        var openStdin: Bool
        var portSpecs: AnyObject
        var stdinOnce: Bool
        var tty: Bool
        var user: String
        var volumes: [String: AnyObject]
        var workingDir: String
    }
    
    var architecture: String!
    var author: String!
    var comment: String!
    var config: Config!
    var container: String!
    var containerConfig: ContainerConfig!
    var created: NSDate!
    var dockerVersion: String!
    var id: String!
    var os: String!
    var parent: String!
    var parentId: String!
    var repoTags: [String]!
    var size: Int = 0
    var virtualSize: Int = 0
    
    init() { }
}