//
//  DetailsViewController.swift
//  PeopleTransactions
//
//  Created by Darsh on 14/07/22.
//

import UIKit
import RxSwift
import RxCocoa

/// Show details of Transactions
class DetailsViewController: ViewController<DetailsViewModel>, Storyboarded {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
            
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        configureData()
    }
    
    private func configureData() {
        lblDate.text = viewModel.model.transactionDate.mmddyyyy
        lblSummary.text = viewModel.model.summary
        
        let value = viewModel.model.debit == 0 ? viewModel.model.credit : viewModel.model.debit
        lblAmount.text = viewModel.model.debit == 0 ? "+$\(value)" : "-$\(value)"
        lblAmount.textColor = viewModel.model.debit == 0 ? .green : .red
        
        lblNote.text = "Transaction includes 15% GST $\(value.gst)"
    }
    
    // View Controller UI actions to the View Model
    private func setupBindings() {
        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }
}
