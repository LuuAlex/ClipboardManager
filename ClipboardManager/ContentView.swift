//
//  ContentView.swift
//  ClipboardManager
//
//  Created by Alex Luu on 2/5/23.
//

import SwiftUI

struct ContentView: View {
    let lightGrey = Color(red: 210,green: 210,blue: 210)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Clipboard Manager")
                .font(.title)
                .foregroundColor(.black)
        }
        .background(Rectangle()).foregroundColor(lightGrey)
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
