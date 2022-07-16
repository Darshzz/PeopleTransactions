//
//  TransactionsViewModel.swift
//  PeopleTransactionsTests
//
//  Created by Darsh on 16/07/22.
//

import XCTest
@testable import PeopleTransactions
import RxSwift
import RxTest


class TransactionsViewModelTest: XCTestCase {
    
    var viewModel: TransactionViewModel!
    var disposeBag: DisposeBag!
    let resClient = RestClientMockTest()
    var testScheduler: TestScheduler!
    
    override func setUp() {
        
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        viewModel = TransactionViewModel(restClient: resClient)
    }
    
    func test_WithSendValidRequest() {
        
        let items: Observable<[TransactionsModel]> = resClient.apiRequest(APIRequest())
            
        items.bind(to: viewModel.items)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModel.items }
        
        XCTAssertEqual(result.events.count, 0)
        XCTAssertNotNil(viewModel.items)
    }
    
}
