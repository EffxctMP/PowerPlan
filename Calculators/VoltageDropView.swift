import SwiftUI

struct VoltageDropView: View {
    @State private var length = "30"
    @State private var load = "16"
    @State private var area: Double = 2.5
    @State private var supply = "230"
    @State private var result = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                CardContainer(title: L10n.run) {
                    NumericField(title: L10n.lengthField, value: $length)
                    NumericField(title: L10n.loadCurrentField, value: $load)
                    NumericField(title: L10n.supplyVoltageField, value: $supply)

                    VStack(alignment: .leading) {
                        Text(L10n.conductorArea(area))
                        Slider(value: $area, in: 1.5...35, step: 0.5)
                    }
                }

                CardContainer {
                    Button(action: calc) {
                        Label(L10n.estimateDrop, systemImage: "arrow.triangle.2.circlepath")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    Text(result.isEmpty ? L10n.enterDropPrompt : result)
                }
            }
            .padding()
        }
        .navigationTitle(L10n.dropHeader)
    }

    private func calc() {
        guard let l = Double(length),
              let i = Double(load),
              let v = Double(supply) else {
            result = L10n.invalidDropInputs
            return
        }

        let ρ = 0.0175
        let rt = l * 2
        let r = (ρ * rt) / area
        let dropV = i * r
        let pct = (dropV / v) * 100

        result = [
            L10n.dropResult(dropV),
            L10n.dropPercent(pct),
            L10n.dropResistance(r)
        ].joined(separator: "\n")
    }
}
