//
//  DetailsViewController.swift
//  PeopleTransactions
//
//  Created by Darsh on 14/07/22.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private let _cancel = PublishSubject<Void>()
    var didCancel: Observable<Void> { return _cancel.asObservable() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
            cancelButton.rx.tap
                .bind(to: _cancel)
                .disposed(by: disposeBag)
        }
}
