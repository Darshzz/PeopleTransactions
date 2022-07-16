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

/*
 func test_LanguageChange_UpdatesRepositories() {
     githubService.repositoriesReturnValue = .just([testRepository])

     testScheduler.createHotObservable([next(300, ())])
         .bind(to: viewModel.reload)
         .disposed(by: disposeBag)

     testScheduler.createHotObservable([next(400, "Objective-C")])
         .bind(to: viewModel.setCurrentLanguage)
         .disposed(by: disposeBag)

     let result = testScheduler.start { self.viewModel.repositories.map({ _ in true }) }
     XCTAssertEqual(result.events, [next(300, true), next(400, true)])
 }
 */
