import SwiftUI

struct EquipmentDraftForm: View {
    @Binding var draft: ProjectsView.EquipmentDraft
    var tint: Color
    var onAdd: (ProjectsView.EquipmentItem) -> Void

    private var breakerAmps: [Int] { Array(1...1000) }
    private var transformerOptions: [Int] { stride(from: 50, through: 1000, by: 50).map { $0 } }
    private var relayVoltages: [Int] { [12, 24, 48, 110, 120, 230] }

    var body: some View {
        DisclosureGroup(L10n.projectEquipmentAddTitle) {

            Picker(L10n.projectEquipmentType, selection: $draft.category) {
                ForEach(ProjectsView.EquipmentCategory.allCases) { c in
                    Text(c.title).tag(c)
                }
            }

            switch draft.category {
            case .breaker:
                Picker(L10n.equipmentBreakerAmps, selection: $draft.amps) {
                    ForEach(breakerAmps, id: \.self) { val in
                        Text(L10n.equipmentAmpsValue(val)).tag(val)
                    }
                }
                Picker(L10n.equipmentBreakerCurve, selection: $draft.curve) {
                    ForEach(ProjectsView.BreakerCurve.allCases) { curve in
                        Text(curve.rawValue).tag(curve)
                    }
                }

            case .contactor:
                Picker(L10n.equipmentPolesLabel, selection: $draft.poles) {
                    ForEach(1...6, id: \.self) { val in
                        Text(L10n.equipmentPolesValue(val)).tag(val)
                    }
                }
                Picker(L10n.equipmentContactorAmps, selection: $draft.amps) {
                    ForEach(breakerAmps, id: \.self) { val in
                        Text(L10n.equipmentAmpsValue(val)).tag(val)
                    }
                }

            case .thermalProtection:
                Picker(L10n.equipmentThermalSetting, selection: $draft.amps) {
                    ForEach(breakerAmps, id: \.self) { val in
                        Text(L10n.equipmentAmpsValue(val)).tag(val)
                    }
                }

            case .transformer:
                Picker(L10n.equipmentTransformerPower, selection: $draft.transformerWatts) {
                    ForEach(transformerOptions, id: \.self) { val in
                        Text(L10n.equipmentWattsValue(val)).tag(val)
                    }
                }

            case .boardSocket:
                TextField(L10n.equipmentBoardSocketOption, text: $draft.optionNote)

            case .switchPositions:
                Picker(L10n.equipmentSwitchPositions, selection: $draft.switchPositions) {
                    ForEach(2...6, id: \.self) { val in
                        Text(L10n.equipmentPositionsValue(val)).tag(val)
                    }
                }

            case .relay:
                Picker(L10n.equipmentRelayVoltage, selection: $draft.relayVoltage) {
                    ForEach(relayVoltages, id: \.self) { val in
                        Text(L10n.equipmentVoltageValue(val)).tag(val)
                    }
                }
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
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)

            case .plcCard:
                TextField(L10n.equipmentPlcBrand, text: $draft.brand)
                TextField(L10n.equipmentPlcType, text: $draft.model)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)

            case .circuitTerminal:
                TextField(L10n.equipmentTerminalType, text: $draft.terminalType)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)

            case .custom:
                TextField(L10n.equipmentCustomLabel, text: $draft.customLabel)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
            }

            Stepper(value: $draft.quantity, in: 1...500) {
                Text(L10n.projectEquipmentQuantity(draft.quantity))
            }

            TextField(L10n.projectEquipmentInfo, text: $draft.additionalInfo, axis: .vertical)
                .lineLimit(2, reservesSpace: true)

            Button(action: saveItem) {
                Label(L10n.projectEquipmentSave, systemImage: "plus")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!draft.canSave)
            .tint(tint)
        }
    }

    private func saveItem() {
        guard draft.canSave else { return }

        let item = ProjectsView.EquipmentItem(
            category: draft.category,
            primary: draft.primaryDescription,
            secondary: draft.secondaryDescription,
            details: draft.additionalInfo,
            quantity: draft.quantity,
            acquired: false
        )

        onAdd(item)
        draft.reset()
    }
}
