//
//  Coordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) -> Void {
        childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) -> Void {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator })
    }
}
