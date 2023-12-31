//
//  LocationPopupView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct LocationPopupView: View {
    let touchLocation: CGPoint
    
    @State private var x = CGFloat.zero
    @State private var y = CGFloat.zero
    
    var body: some View {
        PopupView {
            VStack {
                Text(String(format: "X: %.2f", touchLocation.x))
                Text(String(format: "Y: %.2f", touchLocation.y))
            }
        }
        .onAppear {
            self.x = touchLocation.x
            self.y = touchLocation.y
        }
    }
}

