//
//  StorageService.swift
//  BusinessLogicFramework
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation
import RealmSwift
import RxSwift

public class StorageService {
    private let realm: Realm
    private let disposeBag = DisposeBag()

    public init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm initialization failed: \(error.localizedDescription)")
        }
    }

    public func save(data: BusinessLogicFramework.VisitorsAndStatistics) {
        do {
            try realm.write {
                realm.add(data.statistics, update: .modified)
                realm.add(data.visitors, update: .modified)
            }
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    public func getCachedData() -> Observable<BusinessLogicFramework.VisitorsAndStatistics?> {
        return Observable.create { observer in
            let visitors = Array(self.realm.objects(BusinessLogicFramework.Visitor.self))
            let statistics = Array(self.realm.objects(BusinessLogicFramework.Statistics.self))
            if !visitors.isEmpty || !statistics.isEmpty {
                let result = BusinessLogicFramework.VisitorsAndStatistics(visitors: visitors, statistics: statistics)
                print("Cache found: \(result), type: \(type(of: result))")
                observer.onNext(result)
            } else {
                print("No cache found, sending nil, type: \(type(of: Optional<BusinessLogicFramework.VisitorsAndStatistics>.none))")
                observer.onNext(nil)
            }
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe(on: MainScheduler.instance)
    }

    public func clearAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to clear Realm: \(error.localizedDescription)")
        }
    }
}
