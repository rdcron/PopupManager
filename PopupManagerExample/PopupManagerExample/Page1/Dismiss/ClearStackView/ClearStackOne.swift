//
//  ClearStackOne.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI
import PopupManager

struct ClearStackOne: View {
    var body: some View {
        PopupView {
            Text("(Open this one)")
                .linkFormat()
                .popupLink(widthMultiplier: 0.7, heightMultiplier: 0.8, touchOutsideDismisses: false) {
                    ClearStackTwo()
                }
        }
    }
}

struct ClearStackOne_Previews: PreviewProvider {
    static var previews: some View {
        ClearStackOne()
    }
}
