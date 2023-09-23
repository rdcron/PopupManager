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
            NavigationView {
                PopupManager {
                        ZStack {
                            Color("AppBackground")
                                .ignoresSafeArea()
                            VStack {
                                HStack {
                                    IntroView()
                                        .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
                                        .padding()
                                    
                                    BasicsView()
                                        .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
                                        .padding()
                                }
                                .padding()
                                
                                HStack {
                                    DismissView()
                                        .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
                                        .padding()
                                    
                                    BasicsView()
                                        .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
                                        .padding()
                                }
                                .padding()
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                .navigationTitle("PopupManager")
            }
            .navigationViewStyle(.stack)
//            .border(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
