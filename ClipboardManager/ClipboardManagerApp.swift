//
//  ClipboardManagerApp.swift
//  ClipboardManager
//
//  Created by Alex Luu on 2/5/23.
//

import SwiftUI

@main
struct ClipboardManagerApp: App {
    
    // Variables
    @State var ten: String
    @State var nine: String
    @State var eight: String
    @State var seven: String
    @State var six: String
    @State var five: String
    @State var four: String
    @State var three: String
    @State var two: String
    @State var one1: String
    
    init() {
        ten = ""
        nine = ""
        eight = ""
        seven = ""
        six = ""
        five = ""
        four = ""
        three = ""
        two = ""
        one1 = ""
    }

    
    // Main Body
    var body: some Scene {
        /* REMOVE WINDOW
        WindowGroup {
            ContentView()
        }
        */
        var _ = print(updateVars())
        
        var currentNumber: String = "1"
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            Button(one1) {
                currentNumber = "1"
            }
            .keyboardShortcut("1")
            Button(two) {
                currentNumber = "2"
            }
            .keyboardShortcut("2")
            Button(three) {
                currentNumber = "3"
            }
            .keyboardShortcut("3")
            Divider()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }.keyboardShortcut("Q")
        }
    }
    
    func updateVars() {
        // struct For JSON
        struct User: Codable {
            var one1: String
            var two: String
            var three: String
            var four: String
            var five: String
            var six: String
            var seven: String
            var eight: String
            var nine: String
            var ten: String
        }
        
        // Read from clipboard/pasteboard
        var pasteboard = NSPasteboard.general
        
        var json = """
        [
            {
                "one1": "Paul",
                "two": "2",
                "three": "3",
                "four": "4",
                "five": "5",
                "six": "6",
                "seven": "7",
                "eight": "8",
                "nine": "9",
                "ten": "10"
            }
        ]
        """

        // JSON Read, Decode, Rewrite Vars
        var data = Data(json.utf8)
        var decoder = JSONDecoder()
        do {
            var dataDecoded = try decoder.decode([User].self, from: data)
            DispatchQueue.main.async {
                ten = dataDecoded[0].ten
                nine = dataDecoded[0].nine
                eight = dataDecoded[0].eight
                seven = dataDecoded[0].seven
                six = dataDecoded[0].six
                five = dataDecoded[0].five
                four = dataDecoded[0].four
                three = dataDecoded[0].three
                two = dataDecoded[0].two
                one1 = dataDecoded[0].one1
            }
        } catch {
            print("Failed to decode JSON, did not rewrite vars")
        }
        
        // Update List
        if var read = pasteboard.pasteboardItems?.first?.string(forType: .string) {
            DispatchQueue.main.async {
                ten = nine
                nine = eight
                eight = seven
                seven = six
                six = five
                five = four
                four = three
                three = two
                two = one1
                one1 = read
            }
        }
    }
    
}
