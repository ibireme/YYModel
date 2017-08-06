//
//  File.swift
//  ModelBenchmark
//
//  Created by ibireme on 2017/8/6.
//  Copyright © 2017年 ibireme. All rights reserved.
//

import Foundation

@objc class GithubUserBenchmark : NSObject {
    @objc static public func benchmark() {
        
        GithubUserObjectMapper.benchmark()
    }
}
