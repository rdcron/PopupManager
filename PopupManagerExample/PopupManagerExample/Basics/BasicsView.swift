//
//  BasicsView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI
import PopupManager

struct BasicsView: View {
    @Environment(\.adHocPopup) var adHoc
    
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Basics/BasicsView.swift**"
    
    var body: some View {
        CellView(infoText: infoText) {
            VStack {
                HStack {
                    Text("The Basics")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkText"))
                        .padding()
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 20) {

                        PopupLink(heightMultiplier: 0.85) {
                            PMPopup()
                        } label: {
                            Text("PopupManager()")
                                .linkFormat()
                        }

                        PopupLink(widthMultiplier: 0.9, heightMultiplier: 0.9) {
                            PLPopup()
                        } label: {
                            Text("PopupLink()")
                                .linkFormat()
                        } onDismiss: {
                            adHoc(0.4, 0.4, true, .fromTop, {
                                PopupView {
                                    Text("An 'onDismiss' callback can be set for all types of popups. These can do things like call an ad hoc popup (such as this one) or any other action needed when the popup is dismissed.")
                                }
                            }, {})
                        }
                        
                        Text("Presentation modes")
                            .linkFormat()
                            .popupLink {
                                PresentationModeView()
                            }
                        
                    }
                    .padding(.leading, 40)
                    
                    Spacer()
                }
            }

        }
    }
}

struct BasicsView_Previews: PreviewProvider {
    static var previews: some View {
        BasicsView()
    }
}
