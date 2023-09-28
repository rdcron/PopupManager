//
//  ParamDetailsView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI

struct ParamDetailsView: View {
    var body: some View {
        PopupView {
            Text("'widthMultiplier' and 'heightMultiplier' have been covered. 'touchOutsideDismisses' is a Bool which sets the behavior for dismissing by tapping outside the popup. 'presentaionMode' is an enum that sets whether the popup animates from the center of the label or from the tap location within the label( .fromRect, .fromPoint). 'popup' is a closure defining the popup, and 'label' is a closure defining the label. 'onDismiss' is a callback closure that will be called when the popup view is dismissed.")
        }
    }
}

