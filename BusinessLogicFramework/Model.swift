//
//  Model.swift
//  BusinessLogicFramework
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation
import RxSwift
import RealmSwift

public class Model {
    private let network: NetworkService
    private let storage: StorageService
    private let disposeBag = DisposeBag()

    public init(network: NetworkService, storage: StorageService) {
        self.network = network
        self.storage = storage
    }

    public func loadData(dateInterval: DateInterval.TypeView) -> Observable<BusinessLogicFramework.VisitorsAndStatistics> {
        return Observable.create { observer in
            self.storage.getCachedData()
                .subscribe(on: MainScheduler.instance)
                .subscribe(onNext: { (cachedData: BusinessLogicFramework.VisitorsAndStatistics?) in
                    if let data = cachedData {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        self.network.fetchAllData()
                            .observe(on: MainScheduler.instance)
                            .subscribe(onNext: { data in
                                self.storage.save(data: data)
                                observer.onNext(data)
                                observer.onCompleted()
                            }, onError: { error in
                                observer.onError(error)
                            })
                            .disposed(by: self.disposeBag)
                    }
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }

    public func refreshData() -> Observable<BusinessLogicFramework.VisitorsAndStatistics> {
        return network.fetchAllData()
            .observe(on: MainScheduler.instance)
            .do(onNext: { data in
                self.storage.clearAllData()
                self.storage.save(data: data)
            })
    }}
