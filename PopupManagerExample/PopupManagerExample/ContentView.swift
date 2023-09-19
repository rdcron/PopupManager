//
//  ContentView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/17/23.
//

import PopupManager
import MarkdownUI
import SwiftUI


struct ContentView: View {
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                PopupManager {
                        ZStack {
                            Color("AppBackground")
                                .ignoresSafeArea()
                            VStack {
                                IntroView()
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)
                                
                                
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                .navigationTitle("PopupManager")
            }
//            .border(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
