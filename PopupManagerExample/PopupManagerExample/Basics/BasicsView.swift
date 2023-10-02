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
                        
                        Text("Ad Hoc Popups")
                            .linkFormat()
                            .popupLink {
                                AdHocView()
                            }
                        
                        Text("Presentation modes")
                            .linkFormat()
                            .popupLink {
                                PresentationModeView()
                            }
                        
                        Text("On dismiss callback")
                            .linkFormat()
                            .popupLink(widthMultiplier: 0.4, heightMultiplier: 0.4) {
                                OnDismissView()
                            } onDismiss: {
                                adHoc(0.3, 0.3, true, .fromTop, {
                                    PopupView {
                                        Text(".onDismiss callbacks can initiate ad hoc popups(like this one).")
                                    }
                                }, {})
                            }
                        
                    }
                    .padding(.leading, 40)
                    
                    Spacer()
                }
            }

        }
    }
}

