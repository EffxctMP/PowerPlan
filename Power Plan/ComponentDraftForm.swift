import SwiftUI

struct ComponentDraftForm: View {
    @Binding var draft: ProjectsView.ComponentDraft
    var tint: Color
    var onAdd: (ProjectsView.ComponentItem) -> Void

    private var breakerAmps: [Int] { Array(1...1000) }
    private var transformerOptions: [Int] { stride(from: 50, through: 1000, by: 50).map { $0 } + stride(from: 1200, through: 5000, by: 200).map { $0 } }
    private var relayVoltages: [Int] { [12, 24, 48, 110, 120, 230] }

    var body: some View {
        DisclosureGroup(L10n.projectComponentAddTitle) {
            VStack(alignment: .leading, spacing: 12) {
                Picker(L10n.projectComponentType, selection: $draft.category) {
                    ForEach(ProjectsView.ComponentCategory.allCases) { category in
                        Text(category.title).tag(category)
                    }
                }

                Divider()

                componentOptions

                Divider()

                TextField(L10n.componentTagLabel, text: $draft.tag)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text(L10n.projectComponentQuantity(draft.quantity))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 12) {
                        TextField("", value: $draft.quantity, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 80)
                        Stepper("", value: $draft.quantity, in: 1...500)
                            .labelsHidden()
                    }
                }
                .onChange(of: draft.quantity) { value in
                    draft.quantity = min(max(value, 1), 500)
                }

                Divider()

                TextField(L10n.projectComponentInfo, text: $draft.additionalInfo, axis: .vertical)
                    .lineLimit(2, reservesSpace: true)

                Button(action: saveItem) {
                    Label(L10n.projectComponentSave, systemImage: "plus")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .tint(tint)
                .disabled(!draft.canSave)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .pickerStyle(.menu)
        }
    }

    @ViewBuilder
    private var componentOptions: some View {
        switch draft.category {
        case .breaker:
            Picker(L10n.componentBreakerAmps, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.componentAmpsValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Picker(L10n.componentBreakerCurve, selection: $draft.curve) {
                ForEach(ProjectsView.BreakerCurve.allCases) { curve in
                    Text(curve.rawValue).tag(curve)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .contactor:
            Picker(L10n.componentPolesLabel, selection: $draft.poles) {
                ForEach(1...6, id: \.self) { value in
                    Text(L10n.componentPolesValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Picker(L10n.componentContactorAmps, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.componentAmpsValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .thermalProtection:
            Picker(L10n.componentThermalSetting, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.componentAmpsValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .transformer:
            Picker(L10n.componentTransformerPower, selection: $draft.transformerWatts) {
                ForEach(transformerOptions, id: \.self) { value in
                    Text(L10n.componentWattsValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .boardSocket:
            TextField(L10n.componentBoardSocketOption, text: $draft.optionNote)
                .textInputAutocapitalization(.never)
        case .switchPositions:
            Picker(L10n.componentSwitchPositions, selection: $draft.switchPositions) {
                ForEach(2...6, id: \.self) { value in
                    Text(L10n.componentPositionsValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .relay:
            Picker(L10n.componentRelayVoltage, selection: $draft.relayVoltage) {
                ForEach(relayVoltages, id: \.self) { value in
                    Text(L10n.componentVoltageValue(value)).tag(value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Picker(L10n.componentRelayType, selection: $draft.relayCoil) {
                ForEach(ProjectsView.RelayCoilType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        case .kwhMeter:
            Picker(L10n.componentKwhOption, selection: $draft.kwhConfiguration) {
                Text(L10n.componentKwhSingle).tag(1)
                Text(L10n.componentKwhThree).tag(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            TextField(L10n.componentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.never)
        case .plcCard:
            TextField(L10n.componentPlcBrand, text: $draft.brand)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.componentPlcType, text: $draft.model)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.componentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        case .circuitTerminal:
            TextField(L10n.componentTerminalType, text: $draft.terminalType)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.componentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        case .custom:
            TextField(L10n.componentCustomLabel, text: $draft.customLabel)
                .textInputAutocapitalization(.sentences)
            Divider()
            TextField(L10n.componentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        }
    }

    private func saveItem() {
        guard draft.canSave else { return }

        let item = ProjectsView.ComponentItem(
            name: draft.displayName,
            tag: {
                let cleaned = draft.tag.trimmingCharacters(in: .whitespacesAndNewlines)
                return cleaned.isEmpty ? nil : cleaned
            }(),
            category: draft.category,
            primary: draft.primaryDescription,
            secondary: draft.secondaryDescription,
            details: draft.additionalInfo.trimmingCharacters(in: .whitespacesAndNewlines),
            quantity: draft.quantity,
            acquired: false
        )

        onAdd(item)
        draft.reset()
    }
}
