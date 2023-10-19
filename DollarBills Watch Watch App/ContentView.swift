//
//  ContentView.swift
//  DollarBills Watch Watch App
//
//  Created by Angelica Pinonkuan on 18/10/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var watchConnection = SessionDelegator()
    @State var message = ""
    @State var region: MKCoordinateRegion? // Store the received region here
    
    
//    func getMessageFromIphone() {
//        if let storedReceivedMessage = UserDefaults.standard.string(forKey: "message") {
//            self.message = storedReceivedMessage.description
//            print("succesffuly retrieved from watch memory")
//        }
//        else {
//            self.message = ""
//            print ("not retrieced from watch memory")
//        }
//    }
    
        func getMessageFromIphone() {
            if let storedReceivedRegion = watchConnection.receivedRegion {
                self.region = storedReceivedRegion
                print("Successfully retrieved from watch memory")
            } else {
                self.region = nil
                print("Not retrieved from watch memory")
            }
        }
    
    var body: some View {
        
        
                if let region = self.region {
                    Map(coordinateRegion: Binding(get: {
                        region
                    }, set: { newRegion in
                        self.region = newRegion
                    })) // Show the received region in a Map view
                } else {
                    Text("No region data")
                }
        
                Button(action: {
                    self.getMessageFromIphone()
                }) {
                    Text("Refresh")
                }
        
        
//        if self.message == "" {
//            Text("No message ")
//        }
//        else {
//            Text ("message received" + self.message)
//        }
//        
//        Button {
//            self.getMessageFromIphone()
//        } label: {
//            Text("Refresh")
//        }
    }
}

#Preview {
    ContentView()
}
