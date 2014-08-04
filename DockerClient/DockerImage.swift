//
//  DockerImage.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/3/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import Foundation

public class DockerImage {
    public var repoTags: [String]?
    public var id: String?
    public var created: Int?
    public var size: Int?
    public var virtualSize: Int?
    
    init(repoTags: [String], id: String, created: Int, size: Int, virtualSize: Int) {
        self.repoTags = repoTags
        self.id = id
        self.created = created
        self.size = size
        self.virtualSize = virtualSize
    }
}