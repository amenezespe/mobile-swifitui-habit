//
//  ImageView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    let imageLoader = ImageLoader()
     let url: String
    
    init(url: String) {
        self.url = url
    }
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
            .onAppear {
                // somente chama se não houver nenhuma imagem carregada anteriormente
                if image.cgImage == nil {
                    // faz a chamada da imagem sempre que esse componente aparecer durante a rolagem
                    imageLoader.load(url: url)
                }
            }
    }
}


class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        //didSet essa chave quer dixer que toda vex que eu atribuir um valor a essa variavel ele vai executar 
        // esse bloco de codigo
        didSet {
            didChange.send(data)
        }
    }
    
    func load(url: String) {
          guard let url = URL(string: url) else { return }
          
          let task = URLSession.shared.dataTask(with: url) {data, response, error in
              
              guard let data = data else { return }
              DispatchQueue.main.async {
                  print("Data", data)
                  self.data = data
              }
          }
          //para excutar o bloco
          task.resume()
      }
}

#Preview {
    ImageView(url: "https://via.placeholder.com/150")
}
