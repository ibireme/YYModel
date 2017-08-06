//
//  SwiftGithubUser.swift
//  ModelBenchmark
//
//  Created by ibireme on 2017/8/6.
//  Copyright © 2017年 ibireme. All rights reserved.
//

import Foundation
import QuartzCore

import ObjectMapper
import HandyJSON
import SwiftyJSON


extension GithubUserObjectMapper {
    static func benchmark() {
        
        var start, end, time: Double
        var data: Data
        var json: [String: Any]
        do {
            let path = Bundle.main.url(forResource: "user", withExtension: "json")
            data = try Data(contentsOf: path!);
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        } catch let error {
            print("Decode `user.json` in main bundle failed.")
            print(error)
            return
        }
        
        
        
        print("Codable(*#):        ", separator: "", terminator: "")
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = try! decoder.decode(GithubUserCodable.self, from: data)
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time) + "   ", separator: "", terminator: "")
        
        
        let githubUserCodable = try! decoder.decode(GithubUserCodable.self, from: data)
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = try! encoder.encode(githubUserCodable)
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time), separator: "", terminator: "")
        print("")
        
        
        
        print("ObjectMapper(#):    ", separator: "", terminator: "")
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = GithubUserObjectMapper(JSON: json)
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time) + "   ", separator: "", terminator: "")
        
        
        let githubUserObjectMapper = GithubUserObjectMapper(JSON: json)
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = githubUserObjectMapper?.toJSON()
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time), separator: "", terminator: "")
        print("")
        
        
        
        
        
        
        
        print("HandyJSON(#):       ", separator: "", terminator: "")
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = GithubUserHandyJSON.deserialize(from: json as NSDictionary)
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time) + "   ", separator: "", terminator: "")
        
        
        let githubUserHandyJSON = GithubUserHandyJSON.deserialize(from: json as NSDictionary)
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = githubUserHandyJSON?.toJSON()
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time), separator: "", terminator: "")
        print("")
        
        
        
        
        
        
        print("SwiftyJSON(#):      ", separator: "", terminator: "")
        let swiftJson = JSON(data: data)
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = GithubUserSwifty(fromJson: swiftJson)
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time) + "   ", separator: "", terminator: "")
        
        
        let githubUserSwifty = GithubUserSwifty(fromJson: swiftJson)
        start = CACurrentMediaTime()
        for _ in 1...10000 {
            _ = githubUserSwifty.toDictionary()
        }
        end = CACurrentMediaTime()
        time = (end - start) * 1000.0
        print(String(format:"%8.2f", time), separator: "", terminator: "")
        print("")
        
        
        
    }
}


// Swift Codable
struct GithubUserCodable: Codable {
    var login: String?
    var userID: UInt64?
    var avatarURL: String?
    var gravatarID: String?
    var url: String?
    var htmlURL: String?
    var followersURL: String?
    var followingURL: String?
    var gistsURL: String?
    var starredURL: String?
    var subscriptionsURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin : Bool?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var createdAt: Date?
    var updatedAt: Date?
    
    enum CodingKeys : String, CodingKey {
        case login              = "login"
        case userID             = "id"
        case avatarURL          = "avatar_url"
        case gravatarID         = "gravatar_id"
        case url                = "url"
        case htmlURL            = "html_url"
        case followersURL       = "followers_url"
        case followingURL       = "following_url"
        case gistsURL           = "gists_url"
        case starredURL         = "starred_url"
        case subscriptionsURL   = "subscriptions_url"
        case organizationsURL   = "organizations_url"
        case reposURL           = "repos_url"
        case eventsURL          = "events_url"
        case receivedEventsURL  = "received_events_url"
        case type               = "type"
        case siteAdmin          = "site_admin"
        case name               = "name"
        case company            = "company"
        case blog               = "blog"
        case location           = "location"
        case email              = "email"
        case hireable           = "hireable"
        case bio                = "bio"
        case publicRepos        = "public_repos"
        case publicGists        = "public_gists"
        case followers          = "followers"
        case following          = "following"
        case createdAt          = "created_at"
        case updatedAt          = "updated_at"
    }
}







// ObjectMapper
class GithubUserObjectMapper : Mappable {
    var login: String?
    var userID: UInt64?
    var avatarURL: String?
    var gravatarID: String?
    var url: String?
    var htmlURL: String?
    var followersURL: String?
    var followingURL: String?
    var gistsURL: String?
    var starredURL: String?
    var subscriptionsURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin : Bool?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var test: NSValue?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        login              <- map["login"]
        userID             <- map["id"]
        avatarURL          <- map["avatar_url"]
        gravatarID         <- map["gravatar_id"]
        url                <- map["url"]
        htmlURL            <- map["html_url"]
        followersURL       <- map["followers_url"]
        followingURL       <- map["following_url"]
        gistsURL           <- map["gists_url"]
        starredURL         <- map["starred_url"]
        subscriptionsURL   <- map["subscriptions_url"]
        organizationsURL   <- map["organizations_url"]
        reposURL           <- map["repos_url"]
        eventsURL          <- map["events_url"]
        receivedEventsURL  <- map["received_events_url"]
        type               <- map["type"]
        siteAdmin          <- map["site_admin"]
        name               <- map["name"]
        company            <- map["company"]
        blog               <- map["blog"]
        location           <- map["location"]
        email              <- map["email"]
        hireable           <- map["hireable"]
        bio                <- map["bio"]
        publicRepos        <- map["public_repos"]
        publicGists        <- map["public_gists"]
        followers          <- map["followers"]
        following          <- map["following"]
        createdAt          <- (map["created_at"], DateTransform())
        updatedAt          <- (map["updated_at"], DateTransform())
        test               <- map["test"]
    }
    
}






// HandyJSON
class GithubUserHandyJSON: HandyJSON {
    var login: String?
    var userID: UInt64?
    var avatarURL: String?
    var gravatarID: String?
    var url: String?
    var htmlURL: String?
    var followersURL: String?
    var followingURL: String?
    var gistsURL: String?
    var starredURL: String?
    var subscriptionsURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin : Bool?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var test: NSValue?
    
    required init() {}
}


// SwiftyJSON
// Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport
class GithubUserSwifty : NSObject, NSCoding{
    
    var avatarUrl : String!
    var bio : String!
    var blog : String!
    var company : String!
    var email : String!
    var eventsUrl : String!
    var followers : Int!
    var followersUrl : String!
    var following : Int!
    var followingUrl : String!
    var gistsUrl : String!
    var gravatarId : String!
    var hireable : String!
    var htmlUrl : String!
    var id : Int!
    var location : String!
    var login : String!
    var name : String!
    var organizationsUrl : String!
    var publicGists : Int!
    var publicRepos : Int!
    var receivedEventsUrl : String!
    var reposUrl : String!
    var siteAdmin : Bool!
    var starredUrl : String!
    var subscriptionsUrl : String!
    var type : String!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        avatarUrl = json["avatar_url"].stringValue
        bio = json["bio"].stringValue
        blog = json["blog"].stringValue
        company = json["company"].stringValue
        email = json["email"].stringValue
        eventsUrl = json["events_url"].stringValue
        followers = json["followers"].intValue
        followersUrl = json["followers_url"].stringValue
        following = json["following"].intValue
        followingUrl = json["following_url"].stringValue
        gistsUrl = json["gists_url"].stringValue
        gravatarId = json["gravatar_id"].stringValue
        hireable = json["hireable"].stringValue
        htmlUrl = json["html_url"].stringValue
        id = json["id"].intValue
        location = json["location"].stringValue
        login = json["login"].stringValue
        name = json["name"].stringValue
        organizationsUrl = json["organizations_url"].stringValue
        publicGists = json["public_gists"].intValue
        publicRepos = json["public_repos"].intValue
        receivedEventsUrl = json["received_events_url"].stringValue
        reposUrl = json["repos_url"].stringValue
        siteAdmin = json["site_admin"].boolValue
        starredUrl = json["starred_url"].stringValue
        subscriptionsUrl = json["subscriptions_url"].stringValue
        type = json["type"].stringValue
        url = json["url"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if avatarUrl != nil{
            dictionary["avatar_url"] = avatarUrl
        }
        if bio != nil{
            dictionary["bio"] = bio
        }
        if blog != nil{
            dictionary["blog"] = blog
        }
        if company != nil{
            dictionary["company"] = company
        }
        if email != nil{
            dictionary["email"] = email
        }
        if eventsUrl != nil{
            dictionary["events_url"] = eventsUrl
        }
        if followers != nil{
            dictionary["followers"] = followers
        }
        if followersUrl != nil{
            dictionary["followers_url"] = followersUrl
        }
        if following != nil{
            dictionary["following"] = following
        }
        if followingUrl != nil{
            dictionary["following_url"] = followingUrl
        }
        if gistsUrl != nil{
            dictionary["gists_url"] = gistsUrl
        }
        if gravatarId != nil{
            dictionary["gravatar_id"] = gravatarId
        }
        if hireable != nil{
            dictionary["hireable"] = hireable
        }
        if htmlUrl != nil{
            dictionary["html_url"] = htmlUrl
        }
        if id != nil{
            dictionary["id"] = id
        }
        if location != nil{
            dictionary["location"] = location
        }
        if login != nil{
            dictionary["login"] = login
        }
        if name != nil{
            dictionary["name"] = name
        }
        if organizationsUrl != nil{
            dictionary["organizations_url"] = organizationsUrl
        }
        if publicGists != nil{
            dictionary["public_gists"] = publicGists
        }
        if publicRepos != nil{
            dictionary["public_repos"] = publicRepos
        }
        if receivedEventsUrl != nil{
            dictionary["received_events_url"] = receivedEventsUrl
        }
        if reposUrl != nil{
            dictionary["repos_url"] = reposUrl
        }
        if siteAdmin != nil{
            dictionary["site_admin"] = siteAdmin
        }
        if starredUrl != nil{
            dictionary["starred_url"] = starredUrl
        }
        if subscriptionsUrl != nil{
            dictionary["subscriptions_url"] = subscriptionsUrl
        }
        if type != nil{
            dictionary["type"] = type
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        avatarUrl = aDecoder.decodeObject(forKey: "avatar_url") as? String
        bio = aDecoder.decodeObject(forKey: "bio") as? String
        blog = aDecoder.decodeObject(forKey: "blog") as? String
        company = aDecoder.decodeObject(forKey: "company") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        eventsUrl = aDecoder.decodeObject(forKey: "events_url") as? String
        followers = aDecoder.decodeObject(forKey: "followers") as? Int
        followersUrl = aDecoder.decodeObject(forKey: "followers_url") as? String
        following = aDecoder.decodeObject(forKey: "following") as? Int
        followingUrl = aDecoder.decodeObject(forKey: "following_url") as? String
        gistsUrl = aDecoder.decodeObject(forKey: "gists_url") as? String
        gravatarId = aDecoder.decodeObject(forKey: "gravatar_id") as? String
        hireable = aDecoder.decodeObject(forKey: "hireable") as? String
        htmlUrl = aDecoder.decodeObject(forKey: "html_url") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        location = aDecoder.decodeObject(forKey: "location") as? String
        login = aDecoder.decodeObject(forKey: "login") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        organizationsUrl = aDecoder.decodeObject(forKey: "organizations_url") as? String
        publicGists = aDecoder.decodeObject(forKey: "public_gists") as? Int
        publicRepos = aDecoder.decodeObject(forKey: "public_repos") as? Int
        receivedEventsUrl = aDecoder.decodeObject(forKey: "received_events_url") as? String
        reposUrl = aDecoder.decodeObject(forKey: "repos_url") as? String
        siteAdmin = aDecoder.decodeObject(forKey: "site_admin") as? Bool
        starredUrl = aDecoder.decodeObject(forKey: "starred_url") as? String
        subscriptionsUrl = aDecoder.decodeObject(forKey: "subscriptions_url") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if avatarUrl != nil{
            aCoder.encode(avatarUrl, forKey: "avatar_url")
        }
        if bio != nil{
            aCoder.encode(bio, forKey: "bio")
        }
        if blog != nil{
            aCoder.encode(blog, forKey: "blog")
        }
        if company != nil{
            aCoder.encode(company, forKey: "company")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if eventsUrl != nil{
            aCoder.encode(eventsUrl, forKey: "events_url")
        }
        if followers != nil{
            aCoder.encode(followers, forKey: "followers")
        }
        if followersUrl != nil{
            aCoder.encode(followersUrl, forKey: "followers_url")
        }
        if following != nil{
            aCoder.encode(following, forKey: "following")
        }
        if followingUrl != nil{
            aCoder.encode(followingUrl, forKey: "following_url")
        }
        if gistsUrl != nil{
            aCoder.encode(gistsUrl, forKey: "gists_url")
        }
        if gravatarId != nil{
            aCoder.encode(gravatarId, forKey: "gravatar_id")
        }
        if hireable != nil{
            aCoder.encode(hireable, forKey: "hireable")
        }
        if htmlUrl != nil{
            aCoder.encode(htmlUrl, forKey: "html_url")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if login != nil{
            aCoder.encode(login, forKey: "login")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if organizationsUrl != nil{
            aCoder.encode(organizationsUrl, forKey: "organizations_url")
        }
        if publicGists != nil{
            aCoder.encode(publicGists, forKey: "public_gists")
        }
        if publicRepos != nil{
            aCoder.encode(publicRepos, forKey: "public_repos")
        }
        if receivedEventsUrl != nil{
            aCoder.encode(receivedEventsUrl, forKey: "received_events_url")
        }
        if reposUrl != nil{
            aCoder.encode(reposUrl, forKey: "repos_url")
        }
        if siteAdmin != nil{
            aCoder.encode(siteAdmin, forKey: "site_admin")
        }
        if starredUrl != nil{
            aCoder.encode(starredUrl, forKey: "starred_url")
        }
        if subscriptionsUrl != nil{
            aCoder.encode(subscriptionsUrl, forKey: "subscriptions_url")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        
    }
    
}


