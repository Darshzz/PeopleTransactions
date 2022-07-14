//
//  BaseCoordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation
import UIKit
import RxSwift

class BaseCoordinator<ResultType> {
    
    typealias CoordinationResult = ResultType
    let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                print("-------- Free Coordinator - \(coordinator) --------")
                self?.free(coordinator: coordinator)
            })
    }

    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}
