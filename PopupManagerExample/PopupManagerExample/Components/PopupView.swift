//
//  PopupView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/19/23.
//

import SwiftUI
import PopupManager

struct PopupView<Content : View>: View {
    let content: () -> Content
    
    var infoText: LocalizedStringKey?
    
    init(infoText: LocalizedStringKey? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.infoText = infoText
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("PopupBackground"))
                .overlay(
                    RoundedRectangle(cornerRadius: 21)
                        .stroke(Color("PopupBorder")))
         
            content()
                .foregroundColor(Color("AppBackground"))
                .font(.system(size: 28))
                .minimumScaleFactor(0.75)
                .padding()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    if let infoText = infoText {
                        PopupLink(widthMultiplier: 0.3, heightMultiplier: 0.3) {
                            InfoPopupView {
                                Group {
                                    Text(infoText)
                                }
                            }
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .foregroundColor(Color("LinkYellow"))
                                .frame(maxWidth: 30, maxHeight: 30)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

