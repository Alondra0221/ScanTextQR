//
//  QRView.swift
//  ScanTextQR
//
//  Created by Alondra García Morales on 03/04/24.
//

import SwiftUI
import CodeScanner
struct QRView: View {
    
    @State private var showScanner = false
    @State private var qrtext = ""
    
    func scan(result: Result<ScanResult, ScanError>){
        showScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "")
            qrtext = details[0]
        case .failure(let error):
            print("Fallo el escaneo", error.localizedDescription)
        }
    }
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text(qrtext)
            }.navigationTitle("Escanear QR")
                .toolbar{
                    Button{
                        showScanner = true
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                    }.sheet(isPresented: $showScanner){
                        CodeScannerView(codeTypes: [.qr], completion: scan)
                    }
                }
        }
    }
}


