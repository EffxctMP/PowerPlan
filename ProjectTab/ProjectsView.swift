import SwiftUI

struct ProjectsView: View {

    // MARK: - MODELS

    struct Project: Identifiable {
        let id = UUID()
        var name: String
        var voltage: String
        var notes: String
        var equipment: [EquipmentItem]
    }

    struct EquipmentItem: Identifiable {
        let id = UUID()
        var name: String
        var category: EquipmentCategory
        var tag: String?
        var primary: String
        var secondary: String?
        var details: String
        var quantity: Int
        var acquired: Bool

        var title: String { name }

        var detailLine: String {
            let optionText = [primary, secondary].compactMap { $0 }.joined(separator: " · ")
            let cleanedDetails = details.trimmingCharacters(in: .whitespacesAndNewlines)
            let tagText = tag?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            var parts: [String] = []

            if !tagText.isEmpty {
                parts.append(L10n.equipmentTagValue(tagText))
            }

            if !optionText.isEmpty {
                parts.append(optionText)
            }

            if !cleanedDetails.isEmpty {
                parts.append(cleanedDetails)
            }

            return parts.joined(separator: " — ")
        }
    }

    enum EquipmentCategory: String, CaseIterable, Identifiable {
        case breaker, contactor, thermalProtection, transformer
        case boardSocket, switchPositions, relay, kwhMeter
        case plcCard, circuitTerminal, custom

        var id: String { rawValue }

        var title: String {
            switch self {
            case .breaker: return L10n.equipmentBreaker
            case .contactor: return L10n.equipmentContactor
            case .thermalProtection: return L10n.equipmentThermal
            case .transformer: return L10n.equipmentTransformer
            case .boardSocket: return L10n.equipmentBoardSocket
            case .switchPositions: return L10n.equipmentSwitch
            case .relay: return L10n.equipmentRelay
            case .kwhMeter: return L10n.equipmentKwh
            case .plcCard: return L10n.equipmentPlc
            case .circuitTerminal: return L10n.equipmentTerminals
            case .custom: return L10n.equipmentCustom
            }
        }
    }

    enum BreakerCurve: String, CaseIterable, Identifiable {
        case b = "B", c = "C", d = "D", k = "K", z = "Z"
        var id: String { rawValue }
    }

    enum RelayCoilType: String, CaseIterable, Identifiable {
        case ac = "AC", dc = "DC"
        var id: String { rawValue }
    }

    // MARK: - DRAFT

    struct EquipmentDraft {
        var category: EquipmentCategory = .breaker
        var amps: Int = 63
        var curve: BreakerCurve = .c
        var poles: Int = 3
        var transformerWatts: Int = 100
        var switchPositions: Int = 2
        var relayVoltage: Int = 24
        var relayCoil: RelayCoilType = .ac
        var kwhConfiguration: Int = 1
        var quantity: Int = 1
        var tag: String = ""
        var additionalInfo: String = ""
        var customLabel: String = ""
        var optionNote: String = ""
        var brand: String = ""
        var model: String = ""
        var terminalType: String = ""

        var displayName: String {
            let custom = customLabel.trimmingCharacters(in: .whitespacesAndNewlines)
            switch category {
            case .custom:
                return custom.isEmpty ? category.title : custom
            default:
                return category.title
            }
        }

        var primaryDescription: String {
            switch category {
            case .breaker:
                return L10n.equipmentAmpsValue(amps)
            case .contactor:
                return [L10n.equipmentPolesValue(poles), L10n.equipmentAmpsValue(amps)].joined(separator: " · ")
            case .thermalProtection:
                return L10n.equipmentAmpsValue(amps)
            case .transformer:
                return L10n.equipmentWattsValue(transformerWatts)
            case .boardSocket:
                return optionNote
            case .switchPositions:
                return L10n.equipmentPositionsValue(switchPositions)
            case .relay:
                return L10n.equipmentVoltageValue(relayVoltage)
            case .kwhMeter:
                return kwhConfiguration == 1 ? L10n.equipmentKwhSingle : L10n.equipmentKwhThree
            case .plcCard:
                return [brand, model].filter { !$0.isEmpty }.joined(separator: " · ")
            case .circuitTerminal:
                return terminalType
            case .custom:
                return customLabel
            }
        }

        var secondaryDescription: String? {
            switch category {
            case .breaker:
                return curve.rawValue
            case .relay:
                return relayCoil.rawValue
            default:
                return optionNote.trimmingCharacters(in: .whitespaces)
            }
        }

        var canSave: Bool {
            !primaryDescription.trimmingCharacters(in: .whitespaces).isEmpty
        }

        mutating func reset() {
            self = EquipmentDraft()
        }
    }

    // MARK: - STATE

    @State private var projects: [Project] = []
    @State private var newName: String = ""
    @State private var newVoltage: String = ""
    @State private var newNotes: String = ""

    @State private var equipmentItems: [EquipmentItem] = []
    @State private var equipmentDraft = EquipmentDraft()
    @State private var projectDrafts: [UUID: EquipmentDraft] = [:]

    @State private var newEquipmentName: String = ""
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    // MARK: - BODY

    var body: some View {
        NavigationStack {
            Form {    // ← **DIT IS NU 100% GELDIG**
                existingProjectsSection
                newProjectSection
                equipmentChecklistSection
            }
            .navigationTitle(L10n.projectsHeader)
        }
    }

    // MARK: - SECTIONS

    private var existingProjectsSection: some View {
        Section(header: Text(L10n.projectsExisting)) {
            if projects.isEmpty {
                Text(L10n.projectsEmpty)
                    .foregroundStyle(.secondary)
            } else {
                ForEach($projects) { $project in
                    ProjectDisclosureRow(
                        project: $project,
                        draft: bindingForProjectDraft(project.id),
                        tint: themeColor.color
                    )
                }
            }
        }
    }

    private var newProjectSection: some View {
        Section(header: Text(L10n.projectsNew)) {
            TextField(L10n.projectName, text: $newName)
            TextField(L10n.projectVoltage, text: $newVoltage)
            TextField(L10n.projectNotes, text: $newNotes, axis: .vertical)

            EquipmentDraftSection(
                equipmentItems: $equipmentItems,
                draft: $equipmentDraft,
                tint: themeColor.color
            )

            Button(action: addProject) {
                Label(L10n.projectAdd, systemImage: "plus")
                    .frame(maxWidth: .infinity)
            }
            .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    private var equipmentChecklistSection: some View {
        Section(header: Text("Checklist")) {
            if equipmentItems.isEmpty {
                Text("No items")
                    .foregroundStyle(.secondary)
            } else {
                ForEach($equipmentItems) { $item in
                    Toggle(isOn: $item.acquired) {
                        Text(item.primary)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: themeColor.color))
                }
            }

            HStack {
                TextField("Add custom item", text: $newEquipmentName)
                Button(action: addEquipmentItem) {
                    Label("Add", systemImage: "plus")
                }
                .disabled(newEquipmentName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }

    // MARK: - ACTIONS

    private func addProject() {
        let p = Project(
            name: newName.trimmingCharacters(in: .whitespaces),
            voltage: newVoltage.trimmingCharacters(in: .whitespaces),
            notes: newNotes.trimmingCharacters(in: .whitespaces),
            equipment: equipmentItems
        )

        projects.append(p)

        newName = ""
        newVoltage = ""
        newNotes = ""
        equipmentItems.removeAll()
        equipmentDraft.reset()
    }

    private func addEquipmentItem() {
        let trimmed = newEquipmentName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        equipmentItems.append(.init(
            name: trimmed,
            category: .custom,
            tag: nil,
            primary: trimmed,
            secondary: nil,
            details: "",
            quantity: 1,
            acquired: false
        ))

        newEquipmentName = ""
    }

    private func bindingForProjectDraft(_ id: UUID) -> Binding<EquipmentDraft> {
        Binding(
            get: { projectDrafts[id] ?? EquipmentDraft() },
            set: { projectDrafts[id] = $0 }
        )
    }
}
