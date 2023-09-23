//
//  InfoPopupView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/22/23.
//

import SwiftUI

struct InfoPopupView<Content: View>: View {
    let content: () -> Content
    
    var infoText: LocalizedStringKey?
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("InfoPopupBackground"))
     
        content()
            .foregroundColor(Color("DarkText"))
            .font(.system(size: 28))
            .padding()
    }
}

