import SwiftUI

struct AmmountInput: View {
    @Binding var ammount: Double?
    @State private var ammountStr: String = ""
    var body: some View {
        TextField(
            "Ammount to be transfered",
            text: Binding(
                get: {
                    ammountStr
                },
                set: {
                    ammountStr = $0
                    ammount = Double($0) ?? nil
                }))
            .keyboardType(.numberPad)
            .padding()
            .cornerRadius(24)
            .border(.gray)
    }
}

struct AmmountInput_Previews: PreviewProvider {
    static var previews: some View {
        AmmountInput(ammount: .constant(10))
    }
}
