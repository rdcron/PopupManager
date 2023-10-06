//
//  ContentView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/17/23.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            Page1View()
                .tabItem {
                    Label("Page 1", systemImage: "1.circle")
                }
            Page2View()
                .tabItem {
                    Label("Page 2", systemImage: "2.circle")
                }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
