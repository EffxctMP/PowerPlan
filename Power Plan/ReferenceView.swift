import SwiftUI

struct ReferenceView: View {
    var body: some View {
        List {
            Section(header: Text(L10n.quickConstants)) {
                Label(L10n.copperResistivity, systemImage: "atom")
                Label(L10n.pfRange, systemImage: "bolt.horizontal.circle")
                Label(L10n.threePhaseMultiplier, systemImage: "function")
            }

            Section(header: Text(L10n.tipsHeader)) {
                Text(L10n.tipOhms)
                Text(L10n.tipBreaker)
                Text(L10n.tipDrop)
            }
        }
        .navigationTitle(L10n.referenceHeader)
    }
}
