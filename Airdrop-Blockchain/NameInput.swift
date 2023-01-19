import SwiftUI

struct NameInput: View {
    @Binding var name: String
    
    var body: some View {
        TextField(
            "Public display name",
            text: $name)
            .padding()
            .cornerRadius(24)
            .border(.gray)
    }
}

struct NameInput_Previews: PreviewProvider {
    static var previews: some View {
        NameInput(name: .constant("10"))
    }
}
