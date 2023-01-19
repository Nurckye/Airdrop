import Foundation
import MultipeerConnectivity
import Combine

struct BckConnection: Equatable {
    let name: String
    let addr: String
}

class ProximityService: NSObject, ObservableObject {
    public static let shared = ProximityService()
    @Published var names: [MCPeerID] = []
    // 1
    private var session: MCSession?
    // 2
    private var myPeerId: MCPeerID!
    private static var service = "bckair"
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser?
    private var nearbyServiceBrowser: MCNearbyServiceBrowser?

    let subject = CurrentValueSubject<[BckConnection], Never>([])
    
    func start(name: String) {
        guard !name.isEmpty else { return }
        nearbyServiceAdvertiser?.stopAdvertisingPeer()
        nearbyServiceBrowser?.stopBrowsingForPeers()
        myPeerId = MCPeerID(displayName: name)
        session = MCSession(
            peer: myPeerId,
            securityIdentity: nil,
            encryptionPreference: .none)

        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
          peer: myPeerId,
          discoveryInfo: nil,
          serviceType: Self.service)
        
        nearbyServiceBrowser = MCNearbyServiceBrowser(
          peer: myPeerId,
          serviceType: Self.service)

        nearbyServiceAdvertiser?.delegate = self
        nearbyServiceBrowser?.delegate = self
        nearbyServiceAdvertiser?.startAdvertisingPeer()
        nearbyServiceBrowser?.startBrowsingForPeers()
    }
    
    
}

extension ProximityService: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
      ) {
          invitationHandler(true, self.session)
      }
}

extension ProximityService: MCNearbyServiceBrowserDelegate {
  func browser(
    _ browser: MCNearbyServiceBrowser,
    foundPeer peerID: MCPeerID,
    withDiscoveryInfo info: [String: String]?
  ) {
    // 1
      let bck = BckConnection(name: peerID.displayName, addr: "123")
      let current = subject.value
      if !current.map(\.name).contains(bck.name) {
          subject.send(subject.value + [bck])
      }
  }

  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
      let current = subject.value
      let new = current.filter { $0.name != peerID.displayName }
      subject.send(new)
//      guard let index = names.firstIndex(of: peerID) else { return }
//    // 2
//      names.remove(at: index)
  }
}
