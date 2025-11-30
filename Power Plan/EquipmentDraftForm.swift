import SwiftUI

struct EquipmentDraftForm: View {
    @Binding var draft: ProjectsView.EquipmentDraft
    var tint: Color
    var onAdd: (ProjectsView.EquipmentItem) -> Void

    private var breakerAmps: [Int] { Array(1...1000) }
    private var transformerOptions: [Int] { stride(from: 50, through: 1000, by: 50).map { $0 } + stride(from: 1200, through: 5000, by: 200).map { $0 } }
    private var relayVoltages: [Int] { [12, 24, 48, 110, 120, 230] }

    var body: some View {
        DisclosureGroup(L10n.projectEquipmentAddTitle) {
            VStack(spacing: 12) {
                Picker(L10n.projectEquipmentType, selection: $draft.category) {
                    ForEach(ProjectsView.EquipmentCategory.allCases) { category in
                        Text(category.title).tag(category)
                    }
                }

                Divider()

                equipmentOptions

                Divider()

                TextField(L10n.equipmentTagLabel, text: $draft.tag)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()

                Divider()

                Stepper(value: $draft.quantity, in: 1...500) {
                    Text(L10n.projectEquipmentQuantity(draft.quantity))
                }

                Divider()

                TextField(L10n.projectEquipmentInfo, text: $draft.additionalInfo, axis: .vertical)
                    .lineLimit(2, reservesSpace: true)

                Button(action: saveItem) {
                    Label(L10n.projectEquipmentSave, systemImage: "plus")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .tint(tint)
                .disabled(!draft.canSave)
            }
        }
    }

    @ViewBuilder
    private var equipmentOptions: some View {
        switch draft.category {
        case .breaker:
            Picker(L10n.equipmentBreakerAmps, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.equipmentAmpsValue(value)).tag(value)
                }
            }
            Divider()
            Picker(L10n.equipmentBreakerCurve, selection: $draft.curve) {
                ForEach(ProjectsView.BreakerCurve.allCases) { curve in
                    Text(curve.rawValue).tag(curve)
                }
            }
        case .contactor:
            Picker(L10n.equipmentPolesLabel, selection: $draft.poles) {
                ForEach(1...6, id: \.self) { value in
                    Text(L10n.equipmentPolesValue(value)).tag(value)
                }
            }
            Divider()
            Picker(L10n.equipmentContactorAmps, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.equipmentAmpsValue(value)).tag(value)
                }
            }
        case .thermalProtection:
            Picker(L10n.equipmentThermalSetting, selection: $draft.amps) {
                ForEach(breakerAmps, id: \.self) { value in
                    Text(L10n.equipmentAmpsValue(value)).tag(value)
                }
            }
        case .transformer:
            Picker(L10n.equipmentTransformerPower, selection: $draft.transformerWatts) {
                ForEach(transformerOptions, id: \.self) { value in
                    Text(L10n.equipmentWattsValue(value)).tag(value)
                }
            }
        case .boardSocket:
            TextField(L10n.equipmentBoardSocketOption, text: $draft.optionNote)
                .textInputAutocapitalization(.never)
        case .switchPositions:
            Picker(L10n.equipmentSwitchPositions, selection: $draft.switchPositions) {
                ForEach(2...6, id: \.self) { value in
                    Text(L10n.equipmentPositionsValue(value)).tag(value)
                }
            }
        case .relay:
            Picker(L10n.equipmentRelayVoltage, selection: $draft.relayVoltage) {
                ForEach(relayVoltages, id: \.self) { value in
                    Text(L10n.equipmentVoltageValue(value)).tag(value)
                }
            }
            Divider()
            Picker(L10n.equipmentRelayType, selection: $draft.relayCoil) {
                ForEach(ProjectsView.RelayCoilType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
        case .kwhMeter:
            Picker(L10n.equipmentKwhOption, selection: $draft.kwhConfiguration) {
                Text(L10n.equipmentKwhSingle).tag(1)
                Text(L10n.equipmentKwhThree).tag(3)
            }
            Divider()
            TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.never)
        case .plcCard:
            TextField(L10n.equipmentPlcBrand, text: $draft.brand)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.equipmentPlcType, text: $draft.model)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        case .circuitTerminal:
            TextField(L10n.equipmentTerminalType, text: $draft.terminalType)
                .textInputAutocapitalization(.words)
            Divider()
            TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        case .custom:
            TextField(L10n.equipmentCustomLabel, text: $draft.customLabel)
                .textInputAutocapitalization(.sentences)
            Divider()
            TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                .textInputAutocapitalization(.sentences)
        }
    }

    private func saveItem() {
        guard draft.canSave else { return }

        let item = ProjectsView.EquipmentItem(
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
