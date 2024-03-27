//
//  EditTextView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-06.
//

import SwiftUI

struct EditTextView: View {
    @Binding var text: String
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none

    
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autocapitalization)
                    .textFieldStyle(CustomTextFieldStyle())
                    .onChange(of: text) { value in
                        //& - passa o valor por referencia para permitir mudar o valor dentro do metodo chamado
                        //###.###.###-##
                        
                        if let mask = mask {
                            Mask.mask(mask: mask, value: value, text: &text)
                        }
                    }
 
            }
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        } .padding(.bottom, 10)//Vstack
       
    }
}

//#Preview {
//    ForEach (ColorScheme.allCases, id: \.self) {
//        VStack {
//            EditTextView(text: .constant("Texto"),
//                    placeholder: "Email")
//        }
//        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
//        .previewDevice("iPhone 15")
//        .preferredColorScheme($0)
//    
//    }
//   
//}

#Preview {
    VStack {
        EditTextView(text: .constant("Texto"),
        placeholder: "Email",
        error: "Campo Invalido",
        failure: "a@a".count < 3 )
        
        }
           .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
}

