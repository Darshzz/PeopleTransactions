//
//  TransactionsModel.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation
import RxSwift

struct TransactionsModel: Decodable {
    let id: Int
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit: Double
}
