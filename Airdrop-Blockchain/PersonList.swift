import SwiftUI
import Combine
struct PersonList: View {
    @ObservedObject var proximityService = ProximityService()

    @State private var cancellable: AnyCancellable?
    @State private var bcks = [BckConnection]()
    @Binding var selected: BckConnection?
    
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            HStack {
                ForEach(bcks, id: \.name) { bck in
                    Button(action: {
                        selected = bck
                    }) {
                        PersonView(
                            name: bck.name,
                            selected: bck == selected
                        )
                    }
                    
                }
            }
        }.onAppear {
            cancellable = ProximityService.shared.subject.sink {
                    bcks = $0
                }
        }
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList(selected: .constant(nil))
    }
}
