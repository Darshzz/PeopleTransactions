//
//  TransactionTableCell.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import UIKit

class TransactionTableCell: UITableViewCell {

    // MARK:- Properties
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblGSTNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureData(model: TransactionsModel) {
        lblDate.text = model.transactionDate.mmddyyyy
        lblSummary.text = model.summary
        
        let value = model.debit == 0 ? model.credit : model.debit
        lblAmount.text = model.debit == 0 ? "+$\(value)" : "-$\(value)"
        lblAmount.textColor = model.debit == 0 ? .green : .red
        
        lblGSTNote.text = "Transaction includes 15% GST $\(value.gst)"
    }
}
