import SwiftUI

struct ContentView: View {
    @State var ammount: Double?
    @State var name: String = ""
    @State var selectedBckConn: BckConnection?
    @State var filePath: URL?
    @State var keyContent: String?
    
    private var disabledSend: Bool {
        ammount == nil || selectedBckConn == nil || keyContent == nil
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Select recipient")
            PersonList(selected: $selectedBckConn)
            NameInput(name:  Binding(get: {
                name
            }, set: { newName in
                DispatchQueue.global(qos: .default).async {
                    ProximityService.shared.start(name: newName)
                }
                name = newName
            }))
            AmmountInput(
                ammount: $ammount)
            Spacer()
            
            DocumentPickerButton(
                keyContent: $keyContent)
            
            SendButton(
                disabled: disabledSend,
                action: {})
            Spacer()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
