//
//  PopupContainer.swift
//  WTSynth1
//
//  Created by Richard Cron on 9/5/23.
//

import SwiftUI

#if os(iOS)
internal class PopupContainer: Identifiable, Equatable, ObservableObject {
    let id = UUID()
    let popup: AnyView
    var widthMultiplier: CGFloat
    var heightMultiplier: CGFloat
    var touchOutsideDismisses: Bool
    var source: CGPoint?
    var onDismiss: () -> ()
    
    init(popup: AnyView, widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, source: CGPoint? = nil, onDismiss: @escaping () -> () = {}) {
        self.popup = popup
        self.widthMultiplier = widthMultiplier.clamped(to: 0.1...1.0)
        self.heightMultiplier = heightMultiplier.clamped(to: 0.1...1.0)
        self.touchOutsideDismisses = touchOutsideDismisses
        self.source = source
        self.onDismiss = onDismiss
    }
    
    static func ==(lhs: PopupContainer, rhs: PopupContainer) -> Bool {
        return lhs.id == rhs.id
    }
}
#endif
