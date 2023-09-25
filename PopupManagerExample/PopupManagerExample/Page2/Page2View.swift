//
//  Page2View.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI
import PopupManager

struct Page2View: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("AppBackground")
                    .ignoresSafeArea()
                VStack {
                    PopupManager {
                        MultiManagerView()
                            .padding()
                    }
                    
                    PopupManager {
                        FromLocationAnimationView()
                            .padding()
                        
                    }
                }
                .padding()
            }
        }
    }
}

struct Page2View_Previews: PreviewProvider {
    static var previews: some View {
        Page2View()
    }
}
