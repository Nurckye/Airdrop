//
//  SendButton.swift
//  Airdrop-Blockchain
//
//  Created by Radu Nitescu on 18.01.2023.
//

import SwiftUI

struct SendButton: View {
    var disabled: Bool
    var action: () -> Void
    
    private var color: Color {
        disabled ? .gray : .green
    }
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                Text("Send")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                Spacer()
            }
        }
        .background(color)
        .frame(maxWidth: .infinity)
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton(disabled: false, action: {})
    }
}
