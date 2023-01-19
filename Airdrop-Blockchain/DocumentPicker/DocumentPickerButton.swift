import SwiftUI

struct DocumentPickerButton: View {
    @Binding var keyContent: String?
    @State private var filePath: URL?
    @State private var sheetOpened: Bool = false
    var body: some View {
        Button(action: {
            sheetOpened = true
        }) {
            Text(
                keyContent == nil
                ? "Pick key"
                : "Pick another key"
            )
                .foregroundColor(.white)
                .padding()
        }
        .background(.blue)
        .cornerRadius(24)
        .sheet(isPresented: $sheetOpened) {
            DocumentPicker(filePath: Binding(
                get: {
                    filePath
                },
                set: {
                    filePath = $0
                    guard let urlPath = $0 else {
                        return
                    }
                    
                    guard let keyContent = try? String(contentsOf: urlPath) else {
                        return
                    }
                    
                    self.keyContent = keyContent
                }))
        }
    }
}

struct DocumentPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPickerButton(keyContent: .constant(nil))
    }
}
