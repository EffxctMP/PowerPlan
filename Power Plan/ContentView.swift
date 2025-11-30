//
//  ContentView.swift
//  Power Plan
//
//  Created by Matisse Petereyns on 26/11/2025.
//

import SwiftUI
import Foundation

enum AppearanceMode: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    var displayName: String {
        switch self {
        case .system:
            NSLocalizedString("appearance.system", comment: "System appearance option")
        case .light:
            NSLocalizedString("appearance.light", comment: "Light appearance option")
        case .dark:
            NSLocalizedString("appearance.dark", comment: "Dark appearance option")
        }
    }
}

enum ThemeColor: String, CaseIterable, Identifiable {
    case electricBlue
    case forestGreen
    case solarOrange
    case midnightIndigo
    case violetPulse

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .electricBlue:
            Color(red: 0.15, green: 0.49, blue: 0.96)
        case .forestGreen:
            Color(red: 0.0, green: 0.6, blue: 0.35)
        case .solarOrange:
            Color(red: 0.98, green: 0.47, blue: 0.12)
        case .midnightIndigo:
            Color(red: 0.26, green: 0.27, blue: 0.6)
        case .violetPulse:
            Color(red: 0.58, green: 0.28, blue: 0.88)
        }
    }

    var displayName: String {
        switch self {
        case .electricBlue:
            NSLocalizedString("theme.blue", comment: "Blue accent")
        case .forestGreen:
            NSLocalizedString("theme.green", comment: "Green accent")
        case .solarOrange:
            NSLocalizedString("theme.orange", comment: "Orange accent")
        case .midnightIndigo:
            NSLocalizedString("theme.indigo", comment: "Indigo accent")
        case .violetPulse:
            NSLocalizedString("theme.purple", comment: "Purple accent")
        }
    }
}

enum LanguageOption: String, CaseIterable, Identifiable {
    case system
    case english = "en"
    case dutch = "nl"

    var id: String { rawValue }

    var locale: Locale? {
        switch self {
        case .system:
            return nil
        case .english, .dutch:
            return Locale(identifier: rawValue)
        }
    }

    var displayName: String {
        switch self {
        case .system:
            NSLocalizedString("language.system", comment: "Follow device language")
        case .english:
            NSLocalizedString("language.english", comment: "English language")
        case .dutch:
            NSLocalizedString("language.dutch", comment: "Dutch language")
        }
    }
}

struct ContentView: View {
    @AppStorage("appearanceMode") private var appearanceMode: AppearanceMode = .system
    @AppStorage("languagePreference") private var languagePreference: LanguageOption = .system
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    private var resolvedLocale: Locale {
        languagePreference.locale ?? .autoupdatingCurrent
    }

    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label(L10n.calculators, systemImage: "bolt.fill")
                }
            ProjectsView()
                .tabItem {
                    Label(L10n.projects, systemImage: "folder.fill")
                }
            ReferenceView()
                .tabItem {
                    Label(L10n.reference, systemImage: "book")
                }
        }
        .preferredColorScheme(appearanceMode.colorScheme)
        .environment(\.locale, resolvedLocale)
        .tint(themeColor.color)
    }
}

struct DashboardView: View {
    @AppStorage("appearanceMode") private var appearanceMode: AppearanceMode = .system
    @AppStorage("languagePreference") private var languagePreference: LanguageOption = .system
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    private var accentColor: Color { themeColor.color }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HeroHeader()
                    CalculationCard(title: L10n.ohmsTitle, subtitle: L10n.ohmsSubtitle, icon: "triangle") {
                        NavigationLink(destination: OhmsLawCalculatorView()) {
                            Text(L10n.ohmsButton)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(accentColor.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                    CalculationCard(title: L10n.powerTitle, subtitle: L10n.powerSubtitle, icon: "powerplug.fill") {
                        NavigationLink(destination: PowerCalculatorView()) {
                            Text(L10n.powerButton)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(accentColor.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    CalculationCard(title: L10n.wattTitle, subtitle: L10n.wattSubtitle, icon: "w.circle") {
                        NavigationLink(destination: WattCalculatorView()) {
                            Text(L10n.wattButton)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(accentColor.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                    CalculationCard(title: L10n.dropTitle, subtitle: L10n.dropSubtitle, icon: "arrow.down.to.line") {
                        NavigationLink(destination: VoltageDropView()) {
                            Text(L10n.dropButton)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(accentColor.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(L10n.appTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(appearanceMode: $appearanceMode, languagePreference: $languagePreference, themeColor: $themeColor)) {
                        Label(L10n.openSettings, systemImage: "gearshape")
                    }
                }
            }
        }
    }
}

struct HeroHeader: View {
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [themeColor.color.opacity(0.9), themeColor.color.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(alignment: .leading, spacing: 8) {
                Label(L10n.heroTitle, systemImage: "bolt.circle.fill")
                    .foregroundStyle(.white)
                    .font(.title2.bold())
                Text(L10n.heroSubtitle)
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Label(L10n.heroOffline, systemImage: "antenna.radiowaves.left.and.right.slash")
                    Label(L10n.heroFormulas, systemImage: "function")
                }
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.8))
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
    }
}

struct CalculationCard<Content: View>: View {
    let title: String
    let subtitle: String
    let icon: String
    let content: Content
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    init(title: String, subtitle: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(themeColor.color)
                    .frame(width: 38, height: 38)
                    .background(
                        LinearGradient(
                            colors: [themeColor.color.opacity(0.18), themeColor.color.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            content
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [themeColor.color.opacity(0.2), Color.gray.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 8)
    }
}

struct CardContainer<Content: View>: View {
    let title: String?
    let content: Content
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title)
                    .font(.headline)
            }
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 16).fill(.ultraThinMaterial))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(themeColor.color.opacity(0.15), lineWidth: 1)
        )
    }
}

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
                    Button(action: computeOhmsLaw) {
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

    private func computeOhmsLaw() {
        let v = Double(voltage)
        let i = Double(current)
        let r = Double(resistance)
        let p = Double(power)

        let knownCount = [v, i, r, p].compactMap { $0 }.count
        guard knownCount >= 2 else {
            resultMessage = L10n.enterTwo
            return
        }

        var voltageValue = v
        var currentValue = i
        var resistanceValue = r
        var powerValue = p

        if let v = voltageValue, let i = currentValue {
            resistanceValue = v / i
            powerValue = v * i
        } else if let v = voltageValue, let r = resistanceValue {
            currentValue = v / r
            powerValue = v * (currentValue ?? 0)
        } else if let v = voltageValue, let p = powerValue {
            currentValue = p / v
            resistanceValue = v / (currentValue ?? 0)
        } else if let i = currentValue, let r = resistanceValue {
            voltageValue = i * r
            powerValue = pow(i, 2) * r
        } else if let i = currentValue, let p = powerValue {
            voltageValue = p / i
            resistanceValue = (voltageValue ?? 0) / i
        } else if let r = resistanceValue, let p = powerValue {
            currentValue = sqrt(p / r)
            voltageValue = (currentValue ?? 0) * r
        }

        func format(_ value: Double?, unit: String) -> String {
            guard let value else { return "–" }
            return "\(value.rounded(toPlaces: 3)) \(unit)"
        }

        resultMessage = [
            L10n.voltage(format(voltageValue, unit: "V")),
            L10n.current(format(currentValue, unit: "A")),
            L10n.resistance(format(resistanceValue, unit: "Ω")),
            L10n.power(format(powerValue, unit: "W"))
        ].joined(separator: "\n")
    }
}

struct PowerCalculatorView: View {
    enum Phase: String, CaseIterable, Identifiable {
        case single = "Single-phase"
        case three = "Three-phase"

        var id: String { rawValue }

        var displayTitle: String {
            switch self {
            case .single:
                L10n.singlePhase
            case .three:
                L10n.threePhase
            }
        }
    }

    @State private var phase: Phase = .single
    @State private var voltage: String = "230"
    @State private var current: String = "10"
    @State private var powerFactor: Double = 0.95
    @State private var estimatedPower: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CardContainer(title: L10n.circuit) {
                    Picker(L10n.phase, selection: $phase) {
                        ForEach(Phase.allCases) { option in
                            Text(option.displayTitle).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    NumericField(title: L10n.ohmsVoltageField, value: $voltage)
                    NumericField(title: L10n.ohmsCurrentField, value: $current)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(L10n.powerFactor)
                                    .font(.subheadline)
                                Text(String(format: "%.2f", powerFactor))
                                    .foregroundStyle(.secondary)
                            }
                            Slider(value: $powerFactor, in: 0.5...1.0, step: 0.01)
                        }
                        Label(L10n.powerFactorInfo, systemImage: "info.circle")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                CardContainer {
                    Button(action: calculatePower) {
                        Label(L10n.estimatePower(), systemImage: "bolt.fill")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    if estimatedPower.isEmpty {
                        Text(L10n.enterCircuit)
                    } else {
                        Text(estimatedPower)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(L10n.powerHeader)
    }

    private func calculatePower() {
        guard let voltageValue = Double(voltage), let currentValue = Double(current) else {
            estimatedPower = L10n.invalidPowerInputs
            return
        }

        let multiplier = phase == .single ? 1.0 : sqrt(3.0)
        let powerWatts = multiplier * voltageValue * currentValue * powerFactor
        let powerKW = powerWatts / 1000
        let recommendedBreaker = (currentValue * 1.25).rounded(toPlaces: 2)

        estimatedPower = [
            L10n.powerResult(powerWatts, powerKW),
            L10n.breakerResult(recommendedBreaker),
            L10n.apparentResult(multiplier * voltageValue * currentValue)
        ].joined(separator: "\n")
    }
}

struct WattCalculatorView: View {
    @State private var voltage: String = "230"
    @State private var current: String = "10"
    @State private var powerFactor: Double = 1.0
    @State private var result: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CardContainer(title: L10n.load) {
                    NumericField(title: L10n.ohmsVoltageField, value: $voltage)
                    NumericField(title: L10n.ohmsCurrentField, value: $current)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(L10n.powerFactor)
                                    .font(.subheadline)
                                Text(String(format: "%.2f", powerFactor))
                                    .foregroundStyle(.secondary)
                            }
                            Slider(value: $powerFactor, in: 0.5...1.0, step: 0.01)
                        }
                        Label(L10n.powerFactorInfo, systemImage: "info.circle")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                CardContainer {
                    Button(action: computeWattage) {
                        Label(L10n.calculateWatts(), systemImage: "wand.and.sparkles")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    if result.isEmpty {
                        Text(L10n.enterWattPrompt)
                    } else {
                        Text(result)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(L10n.wattHeader)
    }

    private func computeWattage() {
        guard let voltageValue = Double(voltage), let currentValue = Double(current) else {
            result = L10n.invalidWattInputs
            return
        }

        let watts = voltageValue * currentValue * powerFactor
        let kilowatts = watts / 1000

        result = [
            L10n.realPower(watts, kilowatts),
            L10n.assumingPF(powerFactor)
        ].joined(separator: "\n")
    }
}

struct VoltageDropView: View {
    @State private var lengthMeters: String = "30"
    @State private var loadCurrent: String = "16"
    @State private var conductorArea: Double = 2.5
    @State private var supplyVoltage: String = "230"
    @State private var resultText: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CardContainer(title: L10n.run) {
                    NumericField(title: L10n.lengthField, value: $lengthMeters)
                    NumericField(title: L10n.loadCurrentField, value: $loadCurrent)
                    NumericField(title: L10n.supplyVoltageField, value: $supplyVoltage)
                    VStack(alignment: .leading) {
                        Text(L10n.conductorArea(conductorArea))
                        Slider(value: $conductorArea, in: 1.5...35, step: 0.5)
                    }
                }

                CardContainer {
                    Button(action: estimateDrop) {
                        Label(L10n.estimateDrop(), systemImage: "arrow.triangle.2.circlepath")
                            .frame(maxWidth: .infinity)
                    }
                }

                CardContainer(title: L10n.results) {
                    if resultText.isEmpty {
                        Text(L10n.enterDropPrompt)
                    } else {
                        Text(resultText)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(L10n.dropHeader)
    }

    private func estimateDrop() {
        guard let length = Double(lengthMeters), let current = Double(loadCurrent), let supplyV = Double(supplyVoltage) else {
            resultText = L10n.invalidDropInputs
            return
        }

        let resistivity = 0.0175 // copper Ω·mm²/m at 20°C
        let roundTripLength = length * 2
        let conductorResistance = (resistivity * roundTripLength) / conductorArea
        let voltageDrop = current * conductorResistance
        let percentDrop = (voltageDrop / supplyV) * 100

        resultText = [
            L10n.dropResult(voltageDrop),
            L10n.dropPercent(percentDrop),
            L10n.dropResistance(conductorResistance)
        ].joined(separator: "\n")
    }
}

struct ProjectsView: View {
    struct Project: Identifiable, Codable, Equatable {
        var id: UUID = UUID()
        var name: String
        var voltage: String
        var notes: String
        var equipment: [EquipmentItem]
    }

    struct EquipmentItem: Identifiable, Codable, Equatable {
        var id: UUID = UUID()
        var name: String
        var category: EquipmentCategory
        var primary: String
        var secondary: String?
        var details: String
        var quantity: Int
        var acquired: Bool

        var title: String { name }

        var detailLine: String {
            let optionText = [primary, secondary].compactMap { $0 }.joined(separator: " · ")
            if details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return optionText
            }
            if optionText.isEmpty {
                return details
            }
            return "\(optionText) — \(details)"
        }
    }

    enum EquipmentCategory: String, CaseIterable, Identifiable, Codable, Equatable {
        case breaker
        case contactor
        case thermalProtection
        case transformer
        case boardSocket
        case switchPositions
        case relay
        case kwhMeter
        case plcCard
        case circuitTerminal
        case custom

        var id: String { rawValue }

        var title: String {
            switch self {
            case .breaker:
                return L10n.equipmentBreaker
            case .contactor:
                return L10n.equipmentContactor
            case .thermalProtection:
                return L10n.equipmentThermal
            case .transformer:
                return L10n.equipmentTransformer
            case .boardSocket:
                return L10n.equipmentBoardSocket
            case .switchPositions:
                return L10n.equipmentSwitch
            case .relay:
                return L10n.equipmentRelay
            case .kwhMeter:
                return L10n.equipmentKwh
            case .plcCard:
                return L10n.equipmentPlc
            case .circuitTerminal:
                return L10n.equipmentTerminals
            case .custom:
                return L10n.equipmentCustom
            }
        }
    }

    enum BreakerCurve: String, CaseIterable, Identifiable, Codable, Equatable {
        case b = "B"
        case c = "C"
        case d = "D"
        case k = "K"
        case z = "Z"

        var id: String { rawValue }
    }

    enum RelayCoilType: String, CaseIterable, Identifiable, Codable, Equatable {
        case ac = "AC"
        case dc = "DC"

        var id: String { rawValue }
    }

    struct EquipmentDraft: Codable {
        var category: EquipmentCategory = .breaker
        var amps: Int = 63
        var curve: BreakerCurve = .c
        var poles: Int = 3
        var transformerWatts: Int = 400
        var switchPositions: Int = 2
        var relayVoltage: Int = 24
        var relayCoil: RelayCoilType = .ac
        var kwhConfiguration: Int = 1
        var quantity: Int = 1
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
                return optionNote.trimmingCharacters(in: .whitespacesAndNewlines)
            case .switchPositions:
                return L10n.equipmentPositionsValue(switchPositions)
            case .relay:
                return L10n.equipmentVoltageValue(relayVoltage)
            case .kwhMeter:
                return kwhConfiguration == 1 ? L10n.equipmentKwhSingle : L10n.equipmentKwhThree
            case .plcCard:
                let brandComponent = brand.trimmingCharacters(in: .whitespacesAndNewlines)
                let modelComponent = model.trimmingCharacters(in: .whitespacesAndNewlines)
                return [brandComponent, modelComponent].filter { !$0.isEmpty }.joined(separator: " · ")
            case .circuitTerminal:
                return terminalType.trimmingCharacters(in: .whitespacesAndNewlines)
            case .custom:
                return customLabel.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        var secondaryDescription: String? {
            switch category {
            case .breaker:
                return curve.rawValue
            case .contactor:
                return nil
            case .thermalProtection:
                return nil
            case .transformer:
                return nil
            case .boardSocket:
                return nil
            case .switchPositions:
                return nil
            case .relay:
                return relayCoil.rawValue
            case .kwhMeter:
                return optionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : optionNote
            case .plcCard:
                return optionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : optionNote
            case .circuitTerminal:
                return optionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : optionNote
            case .custom:
                return optionNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : optionNote
            }
        }

        var canSave: Bool {
            let primaryValue = primaryDescription.trimmingCharacters(in: .whitespacesAndNewlines)
            switch category {
            case .plcCard:
                return !brand.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !model.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            case .circuitTerminal, .custom:
                return !primaryValue.isEmpty
            default:
                return !primaryValue.isEmpty
            }
        }

        mutating func reset() { self = EquipmentDraft() }
    }

    @AppStorage("storedProjects") private var storedProjectsData: Data = Data()
    @State private var projects: [Project] = []
    @State private var newName: String = ""
    @State private var newVoltage: String = ""
    @State private var newNotes: String = ""
    @State private var equipmentItems: [EquipmentItem] = []
    @State private var equipmentDraft = EquipmentDraft()
    @State private var projectDrafts: [Project.ID: EquipmentDraft] = [:]
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue
    @State private var isPresentingAddProject = false

    var body: some View {
        NavigationStack {
            Form {
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

                equipmentChecklistSection

            }
            .navigationTitle(L10n.projectsHeader)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresentingAddProject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel(L10n.projectAdd)
                }
            }
            .sheet(isPresented: $isPresentingAddProject) {
                NavigationStack {
                    Form {
                        Section(header: Text(L10n.projectsNew)) {
                            TextField(L10n.projectName, text: $newName)
                            TextField(L10n.projectVoltage, text: $newVoltage)
                                .textInputAutocapitalization(.never)
                            TextField(L10n.projectNotes, text: $newNotes, axis: .vertical)
                                .lineLimit(2, reservesSpace: true)

                            EquipmentDraftSection(equipmentItems: $equipmentItems, draft: $equipmentDraft, tint: themeColor.color)

                            Button(action: addProjectAndDismiss) {
                                Label(L10n.projectAdd, systemImage: "plus")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .buttonStyle(.borderedProminent)
                            .clipShape(Capsule())
                            .tint(themeColor.color)
                            .disabled(newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                    .presentationDetents([.medium, .large])
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(L10n.cancel) { isPresentingAddProject = false }
                        }
                    }
                }
            }
            .onAppear(perform: loadProjects)
            .persistProjectsOnChange(projects) {
                persistProjects()
            }
        }
    }

    @ViewBuilder
    private var equipmentChecklistSection: some View {
        EquipmentDraftSection(
            equipmentItems: $equipmentItems,
            draft: $equipmentDraft,
            tint: themeColor.color
        )
    }

    private func addProject() {
        let trimmedName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedVoltage = newVoltage.trimmingCharacters(in: .whitespacesAndNewlines)
        let notes = newNotes.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else { return }

        let project = Project(
            name: trimmedName,
            voltage: trimmedVoltage.isEmpty ? "" : trimmedVoltage,
            notes: notes,
            equipment: equipmentItems
        )
        projects.append(project)

        newName = ""
        newVoltage = ""
        newNotes = ""
        equipmentItems.removeAll()
        equipmentDraft.reset()
    }

    private func addProjectAndDismiss() {
        guard !newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        addProject()
        isPresentingAddProject = false
    }

    private func bindingForProjectDraft(_ projectID: Project.ID) -> Binding<EquipmentDraft> {
        Binding(
            get: { projectDrafts[projectID] ?? EquipmentDraft() },
            set: { projectDrafts[projectID] = $0 }
        )
    }

    private func loadProjects() {
        guard !storedProjectsData.isEmpty,
              let decoded = try? JSONDecoder().decode([Project].self, from: storedProjectsData) else {
            return
        }
        projects = decoded
    }

    private func persistProjects() {
        guard let encoded = try? JSONEncoder().encode(projects) else { return }
        storedProjectsData = encoded
    }
}

private extension View {
    @ViewBuilder
    func persistProjectsOnChange(_ projects: [ProjectsView.Project], action: @escaping () -> Void) -> some View {
        if #available(iOS 17, *) {
            onChange(of: projects, initial: false) { _, _ in
                action()
            }
        } else {
            onChange(of: projects) { _ in
                action()
            }
        }
    }
}

struct EquipmentDraftSection: View {
    @Binding var equipmentItems: [ProjectsView.EquipmentItem]
    @Binding var draft: ProjectsView.EquipmentDraft
    var tint: Color

    var body: some View {
        Section(header: Text(L10n.projectEquipmentHeader)) {
            if equipmentItems.isEmpty {
                Text(L10n.projectEquipmentEmpty)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(Array($equipmentItems.enumerated()), id: \.element.id) { index, $item in
                    EquipmentRow(item: $item, tint: tint)
                        .swipeActions {
                            Button(role: .destructive) {
                                equipmentItems.remove(at: index)
                            } label: {
                                Label(L10n.delete, systemImage: "trash")
                            }
                        }
                }

                Divider()
            }
            EquipmentDraftForm(draft: $draft, tint: tint) { item in
                equipmentItems.append(item)
            }
        }
    }
}
private extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

#Preview {
    ContentView()
}
