//
//  DockerContainer.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/17/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import Foundation

public class DockerContainer {
    struct Config {
        var attachStderr: Bool
        var attachStdin: Bool
        var attachStdout: Bool
        var cmd: [String]
        var cpuShares: Int
        var cpuset: String
        var domainname: String
        var entrypoint: [String]
        var env: [String]
        var exposedPorts: [String:AnyObject]
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
        var user: String?
        var volumes: [String:AnyObject]
        var workingDir: String
    }
    
    struct HostConfig {
        var binds: AnyObject
        var containerIDFile: String
        var dns: AnyObject
        var dnsSearch: AnyObject
        var links: AnyObject
        var lxcConfg: AnyObject
        var networkMode: String
        var portBindings: [String:AnyObject]
        var privileged: Bool
        var publishAllPorts: Bool
        var volumesFrom: AnyObject
    }
    
    struct NetworkSettings {
        var bridge: String
        var gateway: String
        var IPAddress: String
        var IPPrefixLen: Int
        var portMapping: AnyObject
        var ports: [String:AnyObject]
    }
    
    struct State {
        var exitCode: Int
        var finishedAt: NSDate
        var paused: Bool
        var pid: Int
        var running: Bool
        var startedAt: NSDate
    }
    
    var args: [String]!
    var config: Config!
    var created: NSDate!
    var driver: String!
    var execDriver: String!
    var hostConfig: HostConfig!
    var hostnamePath: String!
    var hostsPath: String!
    var id: String!
    var image: String!
    var mountLabel: String!
    var networkSettings: NetworkSettings!
    var path: String!
    var processLabel: String!
    var resolvConfPath: String!
    var state: State!
    var volumes: [String:String]!
    var volumesRW: [String:Bool]!
    
    init() { }
}