//
//  Double+Addition.swift
//  PeopleTransactions
//
//  Created by Darsh on 15/07/22.
//

import Foundation

extension Double {
    
    private var gstPercentage: Double {
        return 15
    }
    //Calucate percentage based on given values
    var gst: Double {
        let val = self * gstPercentage
        return (val / 100.0).rounded(toPlaces: 2)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
