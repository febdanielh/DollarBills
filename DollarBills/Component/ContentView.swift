//
//  ContentView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    @State private var watchActivated = false
    
    @State private var watchMessage = "Sent"
    @ObservedObject var locationManager = LocationManager()
    
    var watchConnection = SessionDelegator()
    
    //Data Format
//    func sendMessageToWatch() {
//        if self.watchConnection.session.isReachable {
//            print("WatchOS- watch is available")
//            self.watchActivated = true
//            
//            self.watchConnection.session.sendMessageData(dataToShare, replyHandler: nil) { (error) in
//                print ("Error sending message - " + error.localizedDescription)
//            }
//            
//            
//            //Encode MKCoordinateRegion into Data
//            if let regionData = try? NSKeyedArchiver.archivedData(withRootObject: locationManager.region, requiringSecureCoding: false) {
//                self.watchConnection.session.sendMessageData(regionData, replyHandler: nil) { (error) in
//                    print("Error sending message - " + error.localizedDescription)
//                }
//            } else {
//                print("Error encoding MKCoordinateRegion to Data")
//            }
//            
//        }
//        else {
//            print("WatchOS - watch is unavailable. Make sure apple watch is unlocked")
//            self.watchActivated = false
//        }
//    }
    
    func sendMessageToWatch() {
        if self.watchConnection.session.isReachable {
            print("WatchOS- watch is available")
            self.watchActivated = true
            
            do {
                let dataToShare = try JSONEncoder().encode(LocationManager())
                
                self.watchConnection.session.sendMessageData(dataToShare, replyHandler: nil) { (error) in
                    print("Error sending message - " + error.localizedDescription)
                }
            } catch {
                print("Error encoding LocationManager: \(error)")
            }
            
            
        } else {
            print("WatchOS - watch is unavailable. Make sure Apple Watch is unlocked")
            self.watchActivated = false
        }
    }
    
    //    func activateWatch() {
    //        if self.watchConnection.session.isReachable {
    //            print("Watch is available")
    //            self.watchActivated = true
    //
    //        }
    //        else {
    //            print("Watch is unavailable")
    //            self.watchActivated = false
    //        }
    //    }
    
    
    //String Format
    //    func sendMessageToWatch() {
    //        if self.watchConnection.session.isReachable {
    //            print("WatchOS- watch is available")
    //            self.watchActivated = true
    //
    //            self.watchConnection.session.sendMessage(["message" : String(self.watchMessage)], replyHandler: nil) { (error) in
    //                print ("Error sending message - " + error.localizedDescription)
    //            }
    //        }
    //        else {
    //            print("WatchOS - watch is unavailable. Make sure apple watch is unlocked")
    //            self.watchActivated = false
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            MapView(
                selectedAnnotation: $vm.selectedAnnotation)
        }
        .onAppear(perform: {
            vm.serviceAvailabilityCheck()
            sendMessageToWatch()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
