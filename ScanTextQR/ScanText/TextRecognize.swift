//
//  TextRecognize.swift
//  ScanTextQR
//
//  Created by Alondra García Morales on 03/04/24.
//

import Foundation
import Vision
import VisionKit

class TextRecognize {
    
    let cameraScan : VNDocumentCameraScan
    
    init(cameraScan : VNDocumentCameraScan){
        self.cameraScan = cameraScan
    }
    
    func recognizeText(completitionHandler: @escaping ([String]) -> Void ){
        
        DispatchQueue.main.async {
            //sacando el numero de imagenes que podemos tener en una imagen
            let image = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at:$0).cgImage
            })
            
            let imageRequest = image.map({
                (image: $0, request: VNRecognizeTextRequest())
            })
            //texto por pagina
            let textPage = imageRequest.map{ image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                
                do{
                    try handler.perform([request])
                    guard let observations = request.results else {return ""}
                    //traeme lo que entendiste de la imagen
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                }catch let error as NSError{
                    print("Error al reconocer el texto", error.localizedDescription)
                    return ""
                }
            }
            completitionHandler(textPage)
        }
    }
}
