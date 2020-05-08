//
//  QrCodeGeneratorView.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-04.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeGeneratorView: View {
    
    @State private var website = "www.google.ca"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack{
            TextField("URL", text: $website)
                .textContentType(.URL)
                .font(.headline)
                .padding(.horizontal)
            
            Image(uiImage: generateQRCode(from: website))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Spacer()
        }
        
        .navigationBarTitle("QR Code Generator")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QrCodeGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeGeneratorView()
    }
}
