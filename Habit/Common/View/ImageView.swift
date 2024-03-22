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
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
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
    
    init(url: String) {
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
