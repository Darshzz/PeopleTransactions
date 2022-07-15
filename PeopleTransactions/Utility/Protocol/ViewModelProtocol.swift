//
//  ViewModelProtocol.swift
//  PeopleTransactions
//
//  Created by Darsh on 15/07/22.
//

import Foundation

public protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input, outputHandler: @escaping (_ output: Output) -> Void)
}
