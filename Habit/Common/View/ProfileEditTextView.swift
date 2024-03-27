//
//  ProfileEditTextView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-26.
//

import Foundation
import SwiftUI

struct ProfileEditTextView: View {
    
    
    @Binding var text: String
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none

    
    
    var body: some View {
        VStack {
            
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocapitalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    //& - passa o valor por referencia para permitir mudar o valor dentro do metodo chamado
                    //###.###.###-##
                    
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                } //onChange
        } .padding(.bottom, 10)//Vstack
        
    }
}


#Preview {
    VStack {
        ProfileEditTextView(text: .constant("Texto"),
                            placeholder: "Email")
        
    }
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
}
