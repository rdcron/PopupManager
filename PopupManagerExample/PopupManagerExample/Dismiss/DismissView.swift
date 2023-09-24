//
//  DismissView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI
import PopupManager

struct DismissView: View {
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Dismiss/DismissView.swift**"
    
    var body: some View {
        CellView(infoText: infoText) {
            VStack {
                HStack {
                    Text("Dismissing Popups")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkText"))
                        .padding()
                    Spacer()
                }
                
                Text("By default, touching outside the popup will dismiss it. Setting the 'touchOutsideDismisses' parameter in the 'PopupLink()' initializer to false will block that behavior. 'PopupManager' provides two Environment Values to allow customizing popup dismissal.")
                
                Text("popupDismiss")
                    .linkFormat()
                    .popupLink(touchOutsideDismisses: false) {
                        DismissEnvKeyView()
                    }
                
                Text("clearPopupStack")
                    .linkFormat()
                    .popupLink(widthMultiplier: 0.3, heightMultiplier: 0.9) {
                        ClearStackOne()
                    }
            }
        }
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
