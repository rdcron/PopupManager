//
//  CellView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/19/23.
//

import SwiftUI
import PopupManager

struct CellView<Content : View>: View {
    var content: () -> Content
    
    var infoText: LocalizedStringKey?
    
    init(infoText: LocalizedStringKey? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.infoText = infoText
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CellBackground"))
            
            content()
                .multilineTextAlignment(.leading)
                .foregroundColor((Color("DarkText")))
                .font(.system(size: 28))
                .padding()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    if let infoText = infoText {
                        PopupLink(widthMultiplier: 0.3, heightMultiplier: 0.3) {
                            InfoPopupView {
                                Text(infoText)
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
