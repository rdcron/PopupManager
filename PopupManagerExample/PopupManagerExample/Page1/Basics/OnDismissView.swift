//
//  OnDismissView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 10/1/23.
//

import SwiftUI

struct OnDismissView: View {
    
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Basics/OnDismissView.swift**"
    
    var body: some View {
        PopupView(infoText: infoText) {
            VStack {
                Text("An onDismiss callback can be set for popups(through links or ad hoc) that will be called when the popup is dismissed.")
            }
        }
    }
}

