//
//  File.swift
//  
//
//  Created by Richard Cron on 9/15/23.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
