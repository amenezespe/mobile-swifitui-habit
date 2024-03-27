//
//  ImagePickerView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-26.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, imageData: $imageData, isPresented: $isPresented)
    }
    
    //UIImagePickerController responsavel por abrir o ap nativo de camera
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        
        //responsavel por coordenador dos eventos
        pickerController.delegate = context.coordinator
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}
//classe responsavel por escultar a imagem que vai retornar
class ImagePickerViewCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    
    init(image: Binding<Image?>, imageData: Binding<Data?>, isPresented: Binding<Bool>) {
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    }
    
    //quando a escolha da imagem for concluida
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //calculo para redimensionar a imagem propocional
            let width: CGFloat = 420.0
            let canvas = CGSize(width: width, height: CGFloat(ceil(width / image.size.width * image.size.height)))
            let imageResized = UIGraphicsImageRenderer(size: canvas, format: image.imageRendererFormat).image {_ in
                image.draw(in: CGRect(origin: .zero, size: canvas))
                
            }
            //armazena a imagem redimensionada
            self.image = Image(uiImage: imageResized)
           
            
            //0.5 serve para comprimir a photo, pode ser alterado
            self.imageData = image.jpegData(compressionQuality: 0.2)
        }
        
        self.isPresented = false
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
