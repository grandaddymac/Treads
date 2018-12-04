//
//  Extensions.swift
//  Treads
//
//  Created by gdm on 12/4/18.
//  Copyright © 2018 gdm. All rights reserved.
//

import Foundation

extension Double {
    func metersToMiles(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}
