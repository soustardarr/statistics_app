//
//  Visitor.swift
//  BusinessLogicFramework
//
//  Created by Ruslan Kozlov on 19.05.2025.
//

import Foundation
import RealmSwift

public class Visitor: Object, Codable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var userName: String
    @Persisted public var sex: String
    @Persisted public var age: Int
    @Persisted public var isOnline: Bool
    @Persisted public var files: List<File>

    public enum Sex: String, Codable {
        case M = "M"
        case F = "W"
    }

    public enum CodingKeys: String, CodingKey {
        case userName = "username"
        case id
        case sex
        case age
        case isOnline
        case files
    }

    override public init() {
        super.init()
        files = List<File>()
    }

    public convenience init(userName: String, id: Int, sex: Sex, age: Int, isOnline: Bool, files: [File]) {
        self.init()
        self.userName = userName
        self.id = id
        self.sex = sex.rawValue
        self.age = age
        self.isOnline = isOnline
        self.files.append(objectsIn: files)
    }
}

public class File: Object, Codable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var url: String
    @Persisted public var type: String

    public enum TypeFile: String, Codable {
        case avatar = "avatar"
    }

    public enum CodingKeys: String, CodingKey {
        case id
        case url
        case type
    }

    override public init() {
        super.init()
    }

    public convenience init(id: Int, url: String, type: TypeFile) {
        self.init()
        self.id = id
        self.url = url
        self.type = type.rawValue
    }
}
public class Statistics: Object, Codable {
    @Persisted(primaryKey: true) private var _id: String = UUID().uuidString
    @Persisted public var user_id: Int
    @Persisted public var type: String
    @Persisted public var dates: List<Int>

    public enum StatisticsType: String, Codable {
        case view = "view"
        case subscription = "subscription"
        case unsubscription = "unsubscription"
    }

    public enum CodingKeys: String, CodingKey {
        case user_id
        case type
        case dates
    }

    override public init() {
        super.init()
        dates = List<Int>()
    }

    public convenience init(user_id: Int, type: StatisticsType, dates: [Int]) {
        self.init()
        self.user_id = user_id
        self.type = type.rawValue
        self.dates.append(objectsIn: dates)
    }

    required public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_id = try container.decode(Int.self, forKey: .user_id)
        self.type = try container.decode(String.self, forKey: .type)
        let datesArray = try container.decode([Int].self, forKey: .dates)
        self.dates.append(objectsIn: datesArray)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user_id, forKey: .user_id)
        try container.encode(type, forKey: .type)
        try container.encode(Array(dates), forKey: .dates)
    }
}



public struct VisitorsAndStatistics {
    public let visitors: [Visitor]
    public let statistics: [Statistics]

    public init(visitors: [Visitor], statistics: [Statistics]) {
        self.visitors = visitors
        self.statistics = statistics
    }
}
