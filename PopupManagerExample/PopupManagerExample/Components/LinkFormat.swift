//
//  LinkFormat.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI

struct LinkFormat: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("LinkYellow"))
            .underline()
    }
}

extension Text {
    func linkFormat() -> some View {
        modifier(LinkFormat())
    }
}
