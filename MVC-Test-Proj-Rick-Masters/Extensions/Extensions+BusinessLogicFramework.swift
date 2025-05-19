//
//  Extensions+BusinessLogicFramework.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 19.05.2025.
//

import Foundation
import BusinessLogicFramework

extension BusinessLogicFramework.File {
    func toUIModel() -> MVC_Test_Proj_Rick_Masters.File {
        return MVC_Test_Proj_Rick_Masters.File(
            id: self.id,
            url: self.url,
            type: .avatar
        )
    }
}

extension BusinessLogicFramework.Visitor {
    func toUIModel() -> MVC_Test_Proj_Rick_Masters.Visitor {
        let uiFiles = self.files.map { $0.toUIModel() }
        let sex: MVC_Test_Proj_Rick_Masters.Visitor.Sex = self.sex == "M" ? .M : .F
        return MVC_Test_Proj_Rick_Masters.Visitor(
            userName: self.userName,
            id: self.id,
            sex: sex,
            age: self.age,
            isOnline: self.isOnline,
            files: [File(id: self.id, url: self.files.first!.url, type: .avatar)]
        )
    }
}

extension BusinessLogicFramework.Statistics {
    func toUIModel() -> MVC_Test_Proj_Rick_Masters.Statistics {
        let uiType: MVC_Test_Proj_Rick_Masters.Statistics.StatisticsType
        switch self.type {
        case "view":
            uiType = .view
        case "subscription":
            uiType = .subscription
        case "unsubscription":
            uiType = .unsubscription
        default:
            uiType = .view
        }
        return MVC_Test_Proj_Rick_Masters.Statistics(
            user_id: self.user_id,
            type: uiType,
            dates: Array(self.dates)
        )
    }
}

extension BusinessLogicFramework.VisitorsAndStatistics {
    func toUIModel() -> MVC_Test_Proj_Rick_Masters.VisitorsAndStatistics {
        let uiVisitors = self.visitors.map { $0.toUIModel() }
        let uiStatistics = self.statistics.map { $0.toUIModel() }
        return MVC_Test_Proj_Rick_Masters.VisitorsAndStatistics(
            visitors: uiVisitors,
            statistics: uiStatistics
        )
    }
}
