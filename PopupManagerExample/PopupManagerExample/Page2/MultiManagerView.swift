//
//  MultiManagerView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI
import PopupManager

struct MultiManagerView: View {
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Page2/MultiManagerView.swift**"
    
    var body: some View {
        CellView(infoText: infoText) {
            VStack {
                HStack {
                    Text("Multiple PopupManagers")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkText"))
                        .padding()
                    Spacer()
                }
                
                Text("Because 'PopupManager' maintains it's own stack and named coordinate space, more than one 'PopupManager()' can be set up in the same app. Separate navigation pages can have their own 'PopupManager', and more than one 'PopupManager' can be present on the same page. Opening a popup in one manager will only gray-out the content of that view, the rest of the screen remains interactive.")
                    .padding(.leading, 30)
                
                Text("Take a look!")
                    .linkFormat()
                    .popupLink(widthMultiplier: 0.3, heightMultiplier: 0.3) {
                        PopupView {
                            Text("The lower half of the screen is still interactive.")
                        }
                    }
                
                Text("While 'PopupManagers' can be placed inside 'NavigationStacks', they cannot be nested inside each other.")
                    .padding()
            }
        }
    }
}

struct MultiManagerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiManagerView()
    }
}
