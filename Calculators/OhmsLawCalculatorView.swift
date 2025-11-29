import SwiftUI

struct OhmsLawCalculatorView: View {
    @State private var voltage: String = ""
    @State private var current: String = ""
    @State private var resistance: String = ""
    @State private var power: String = ""
    @State private var resultMessage: String = L10n.provideTwo

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                CardContainer(title: L10n.inputs) {
                    NumericField(title: L10n.ohmsVoltageField, value: $voltage)
                    NumericField(title: L10n.ohmsCurrentField, value: $current)
                    NumericField(title: L10n.resistanceField, value: $resistance)
                    NumericField(title: L10n.powerField, value: $power)
                }

                CardContainer {
                    Button(action: compute) {
                        Label(L10n.ohmsCalculateButton(), systemImage: "equal")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    Text(resultMessage)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle(L10n.ohmsHeader)
    }

    private func compute() {
        let v = Double(voltage)
        let i = Double(current)
        let r = Double(resistance)
        let p = Double(power)

        let count = [v,i,r,p].compactMap({$0}).count
        guard count >= 2 else {
            resultMessage = L10n.enterTwo
            return
        }

        var V=v, I=i, R=r, P=p

        if let v = V, let i = I {
            R = v / i
            P = v * i
        } else if let v = V, let r = R {
            I = v / r
            P = v * (I ?? 0)
        } else if let v = V, let p = P {
            I = p / v
            R = v / (I ?? 0)
        } else if let i = I, let r = R {
            V = i * r
            P = (V ?? 0) * i
        } else if let i = I, let p = P {
            V = p / i
            R = (V ?? 0) / i
        } else if let r = R, let p = P {
            I = sqrt(p / r)
            V = (I ?? 0) * r
        }

        func f(_ v: Double?, unit: String) -> String {
            guard let v else { return "-" }
            return "\(v.rounded(toPlaces: 3)) \(unit)"
        }

        resultMessage = [
            L10n.voltage(f(V,"V")),
            L10n.current(f(I,"A")),
            L10n.resistance(f(R,"Ω")),
            L10n.power(f(P,"W"))
        ].joined(separator: "\n")
    }
}
