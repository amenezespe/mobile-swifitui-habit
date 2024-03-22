//
//  GenderSelectorView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-21.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let title: String
    let genders: [Gender]
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                
                List(genders, id: \.id) {item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        if (selectedGender == item ){
                            Image(systemName: "checkmark")
                                .foregroundColor(selectedGender == item ? .blue : .white)
                        }
                        
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { //evento de toque na tela
                       
                        if !(selectedGender ==  item) {
                            selectedGender = item
                        }
                        
                        print(selectedGender)
                    }
                   
                }
            } //Section
        }//Form
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(.female), title: "Teste", genders: Gender.allCases)
}
