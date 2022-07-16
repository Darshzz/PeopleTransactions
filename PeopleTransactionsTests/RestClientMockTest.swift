//
//  RestClientMockTest.swift
//  PeopleTransactionsTests
//
//  Created by Darsh on 16/07/22.
//

import Foundation

@testable import PeopleTransactions
import RxSwift

class RestClientMockTest: RestClient {

    // Mock Data of TransactionsModel
    let mockTransactions: [TransactionsModel] = [TransactionsModel(id: 1, transactionDate: "2021-08-31T15:47:10", summary: "Hackett, Stamm and Kuhn", debit: 9379, credit: 0), TransactionsModel(id: 2, transactionDate: "2022-02-17T10:44:35", summary: "Hettinger, Wilkinson and Kshlerin", debit: 0, credit: 5000)]
    
    override func apiRequest<T>(_ apiRequest: APIRequest) -> Observable<T> where T : Decodable {
        return Observable.create({ [weak self] observer in
            observer.onNext(self?.mockTransactions as! T)
            
            return Disposables.create { }
        })
    }
}
