//
//  ContentView.swift
//  ScanTextQR
//
//  Created by Alondra García Morales on 03/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ScannerView().tabItem {
                Label("Scan Text", systemImage: "doc.text.viewfinder")
            }
            QRView().tabItem {
                Label("QR code", systemImage: "qrcode.viewfinder")
            }
        }
    }
}

