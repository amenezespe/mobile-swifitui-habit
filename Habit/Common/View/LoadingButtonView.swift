//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-06.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String
    var showProgressBar: Bool = false
    var disabled: Bool = false
    
    
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgressBar ? " " : text)
                    .foregroundColor(disabled ? Color("labelDisabledColor") : Color("labelButtonColor"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("buttonDisabledColor") : Color("buttonColor"))
                    .cornerRadius(4.0)
                
            }).disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgressBar ? 1 : 0)
        }
    }
}
    

#Preview {
    VStack {
        LoadingButtonView(action: {
            print("Ola mundo")
        }, text: "Entrar", showProgressBar: true, disabled: false)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
