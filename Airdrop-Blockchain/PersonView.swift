import SwiftUI

struct PersonView: View {
    var name: String
    var selected: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(32)
        }
        .background(selected ? .blue: .gray)
        .cornerRadius(32)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(
            name: "Jodsasd adsdashn Doe",
            selected: false
        )
    }
}
