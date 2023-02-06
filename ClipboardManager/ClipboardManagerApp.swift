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
    
    @State var currentNumber: String = "1"
    
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

    
    // Main Body
    var body: some Scene {
        /* REMOVE WINDOW
        WindowGroup {
            ContentView()
        }
        */
        var _ = print(updateVars())
        
        MenuBarExtra(currentNumber, systemImage: "arrow.up.doc.on.clipboard") {
            Group {
                Button(one1) {
                    writeToClipboard(data: one1)
                }
                .keyboardShortcut("1")
                Button(two) {
                    writeToClipboard(data: two)
                }
                .keyboardShortcut("2")
                Button(three) {
                    writeToClipboard(data: three)
                }
                .keyboardShortcut("3")
                Button(four) {
                    writeToClipboard(data: four)
                }
                .keyboardShortcut("4")
                Button(five) {
                    writeToClipboard(data: five)
                }
                .keyboardShortcut("5")
                Button(six) {
                    writeToClipboard(data: six)
                }
                .keyboardShortcut("6")
                Button(seven) {
                    writeToClipboard(data: seven)
                }
                .keyboardShortcut("7")
                Button(eight) {
                    writeToClipboard(data: eight)
                }
                .keyboardShortcut("8")
                
            }
            
            Divider()
            Button("Update Clipboard History") {
                currentNumber = String(Int.random(in: 1..<1000));
            }.keyboardShortcut("U")
            Button("Clear Clipboard History") {
                clearClipboardHistory()
            }.keyboardShortcut("C")
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("Q")
        }
        
        
        
    }
    
    func updateVars() {
        
        // Read from clipboard/pasteboard
        let pasteboard = NSPasteboard.general
                
        // Default JSON
        let json = """
                {
                    "one1": "1",
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
            """
        
        // JSON Read, Decode, Rewrite Vars
        let data = decodeJSON()
        let decoder = JSONDecoder()
        do {
            let dataDecoded = try decoder.decode(User.self, from: data ?? Data(json.utf8))
            DispatchQueue.main.async {
                ten = dataDecoded.ten
                nine = dataDecoded.nine
                eight = dataDecoded.eight
                seven = dataDecoded.seven
                six = dataDecoded.six
                five = dataDecoded.five
                four = dataDecoded.four
                three = dataDecoded.three
                two = dataDecoded.two
                one1 = dataDecoded.one1
            }
        } catch {
            print("Failed to decode JSON, did not rewrite vars")
        }
        
        // Update List
        if let read = pasteboard.pasteboardItems?.first?.string(forType: .string) {
            if read != one1 {
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
                    // Encode New JSON Values
                    encodeJSON(userData: User(one1: one1, two: two, three: three, four: four, five: five, six: six, seven: seven, eight: eight, nine: nine, ten: ten))
                }
            }
        }
        
    } // End updateVars() func
    
    // JSON Utils
    // Takes in User object and makes JSON file
    func encodeJSON(userData: User?) {
        if userData != nil {
            let encoder = JSONEncoder()
            
            do {
                let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("history.json")
                let data = try encoder.encode(userData)
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error in encoding JSON")
            }
        }
        
    }
    // Returns Data object of JSON file
    func decodeJSON() -> Data? {
        do {
            let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("history.json")
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            return data
        } catch {
            print("Unable to parse JSON file")
        }
        return nil
    }
    
    // Write New String to Clipboard
    func writeToClipboard(data: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(data, forType: NSPasteboard.PasteboardType.string)
    }
    
    // Wipes Clipboard History
    func clearClipboardHistory() {
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
        writeToClipboard(data: "")
        encodeJSON(userData: User(one1: one1, two: two, three: three, four: four, five: five, six: six, seven: seven, eight: eight, nine: nine, ten: ten))
    }
    
}
