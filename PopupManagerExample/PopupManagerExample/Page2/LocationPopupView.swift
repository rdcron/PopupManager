//
//  LocationPopupView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct LocationPopupView: View {
    @Environment(\.popupTouchLocation) var touchLocation
    
    var body: some View {
        PopupView {
            VStack {
                Text(String(format: "X: %.2f", touchLocation.x))
                Text(String(format: "Y: %.2f", touchLocation.y))
            }
        }
    }
}

struct LocationPopupView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPopupView()
    }
}
