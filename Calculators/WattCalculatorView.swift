import SwiftUI

struct WattCalculatorView: View {
    @State private var voltage = "230"
    @State private var current = "10"
    @State private var pf: Double = 1.0
    @State private var result = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                CardContainer(title: L10n.load) {
                    NumericField(title: L10n.ohmsVoltageField, value: $voltage)
                    NumericField(title: L10n.ohmsCurrentField, value: $current)

                    VStack(alignment: .leading) {
                        HStack {
                            Text(L10n.powerFactor)
                            Spacer()
                            Text(String(format: "%.2f", pf))
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $pf, in: 0.5...1.0, step: 0.01)
                        Text(L10n.powerFactorInfo)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                CardContainer {
                    Button(action: calc) {
                        Label(L10n.calculateWatts(), systemImage: "wand.and.sparkles")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    Text(result.isEmpty ? L10n.enterWattPrompt : result)
                }
            }
            .padding()
        }
        .navigationTitle(L10n.wattHeader)
    }

    private func calc() {
        guard let v = Double(voltage), let i = Double(current) else {
            result = L10n.invalidWattInputs
            return
        }

        let w = v * i * pf
        let kw = w / 1000

        result = [
            L10n.realPower(w, kw),
            L10n.assumingPF(pf)
        ].joined(separator: "\n")
    }
}
