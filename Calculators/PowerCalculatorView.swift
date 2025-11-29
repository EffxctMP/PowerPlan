import SwiftUI

struct PowerCalculatorView: View {

    enum Phase: String, CaseIterable, Identifiable {
        case single = "single"
        case three = "three"

        var id: String { rawValue }

        var title: String {
            switch self {
            case .single: return L10n.singlePhase
            case .three: return L10n.threePhase
            }
        }
    }

    @State private var phase: Phase = .single
    @State private var voltage: String = "230"
    @State private var current: String = "10"
    @State private var pf: Double = 0.95
    @State private var result: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                CardContainer(title: L10n.circuit) {
                    Picker(L10n.phase, selection: $phase) {
                        ForEach(Phase.allCases) { p in
                            Text(p.title).tag(p)
                        }
                    }.pickerStyle(.segmented)

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
                        Label(L10n.estimatePower(), systemImage: "bolt.fill")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    Text(result.isEmpty ? L10n.enterCircuit : result)
                }
            }
            .padding()
        }
        .navigationTitle(L10n.powerHeader)
    }

    private func calc() {
        guard let v = Double(voltage), let i = Double(current) else {
            result = L10n.invalidPowerInputs
            return
        }

        let multip = phase == .single ? 1.0 : sqrt(3.0)
        let watts = multip * v * i * pf
        let kw = watts / 1000
        let breaker = (i * 1.25).rounded(toPlaces: 2)

        result = [
            L10n.powerResult(watts, kw),
            L10n.breakerResult(breaker),
            L10n.apparentResult(multip * v * i)
        ].joined(separator: "\n")
    }
}
