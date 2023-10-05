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
                                        Text("Among other things, .onDismiss callbacks can initiate ad hoc popups(like this one).")
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

