//
//  FromLocationAnimationView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI
import PopupManager

struct FromLocationAnimationView: View {
    @State private var currentTouch = CGPoint.zero
    
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Page2/FromLocationAnimationView.swift**"
    
    var body: some View {
        PopupLink(widthMultiplier: 0.3, heightMultiplier: 0.3, presentaionMode: .fromPoint()) {
            LocationPopupView(touchLocation: currentTouch)
        } label: {
            CellView(infoText: infoText) {
                Text("This entire cell is a 'PopupLink' label. In the initializer for the link, presentationMode was set to .fromPoint. This means that the popup will animate from the tap location. This cell uses the .adHocTouchTracker modifier to track the most recent touch in relation to the root PopupManager.")
            }
        }
        .adHocTouchTracker(touchLocation: $currentTouch)
    }
}

