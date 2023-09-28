//
//  File.swift
//  WTSynth1
//
//  Created by Richard Cron on 9/5/23.
//

import SwiftUI

#if os(iOS)



@MainActor
/// Maintains an array of active popup views and some layout info. Manages animating pushing and popping of popup views. Acts as the model for PopupManagers.
internal class PopupStack: ObservableObject {
    
    /// UUID used as the name for a PopupManager's named coordinateSpace, allows using multiple PopupManagers
    let coordinateNamespace = UUID()
    
    /// Array of active popups
    @Published private(set) var items = [PopupContainer]()
    
    /// CGPoint location where popup animates from when presented, and animates to when dismissed
    @Published private(set) var topSource: CGPoint?
    
    func peek() -> PopupContainer? {
        guard let topElement = items.first else { return nil }
        return topElement
    }
    
    func pop()  {
        withAnimation(.easeIn(duration: 0.2)) {
            if !items.isEmpty {
                let item = items.removeFirst()
                item.onDismiss()
            }
        }
        if let newTop = items.first {
            topSource = newTop.source
        } else {
            topSource = nil
        }
    }
    
    func push(_ element: PopupContainer) {
        topSource = element.source
        withAnimation(.easeOut(duration: 0.2)) {
            items.insert(element, at: 0)
        }
    }
    
    func clear() {
        for _ in 0..<items.count {
            pop()
        }
        
        
//        withAnimation(.easeIn(duration: 0.2)) {
//            items.removeAll()
//        }
    }
}
#endif
