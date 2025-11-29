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

private enum L10n {
    static var calculators: String { NSLocalizedString("tab.calculators", comment: "Calculators tab title") }
    static var reference: String { NSLocalizedString("tab.reference", comment: "Reference tab title") }
    static var projects: String { NSLocalizedString("tab.projects", comment: "Projects tab title") }
    static var appTitle: String { NSLocalizedString("nav.title", comment: "Main navigation title") }

    static var heroTitle: String { NSLocalizedString("hero.title", comment: "Hero title") }
    static var heroSubtitle: String { NSLocalizedString("hero.subtitle", comment: "Hero subtitle") }
    static var heroOffline: String { NSLocalizedString("hero.offline", comment: "Offline badge") }
    static var heroFormulas: String { NSLocalizedString("hero.formulas", comment: "Pro formulas badge") }

    static var ohmsTitle: String { NSLocalizedString("card.ohms.title", comment: "Ohm's law card title") }
    static var ohmsSubtitle: String { NSLocalizedString("card.ohms.subtitle", comment: "Ohm's law card subtitle") }
    static var ohmsButton: String { NSLocalizedString("card.ohms.button", comment: "Open ohms calculator") }

    static var powerTitle: String { NSLocalizedString("card.power.title", comment: "Power card title") }
    static var powerSubtitle: String { NSLocalizedString("card.power.subtitle", comment: "Power card subtitle") }
    static var powerButton: String { NSLocalizedString("card.power.button", comment: "Open power calculator") }

    static var wattTitle: String { NSLocalizedString("card.watt.title", comment: "Watt card title") }
    static var wattSubtitle: String { NSLocalizedString("card.watt.subtitle", comment: "Watt card subtitle") }
    static var wattButton: String { NSLocalizedString("card.watt.button", comment: "Open watt calculator") }

    static var dropTitle: String { NSLocalizedString("card.drop.title", comment: "Voltage drop title") }
    static var dropSubtitle: String { NSLocalizedString("card.drop.subtitle", comment: "Voltage drop subtitle") }
    static var dropButton: String { NSLocalizedString("card.drop.button", comment: "Open voltage drop") }

    static var inputs: String { NSLocalizedString("section.inputs", comment: "Inputs section") }
    static var results: String { NSLocalizedString("section.results", comment: "Results section") }
    static var circuit: String { NSLocalizedString("section.circuit", comment: "Circuit section title") }
    static var load: String { NSLocalizedString("section.load", comment: "Load section title") }
    static var run: String { NSLocalizedString("section.run", comment: "Run section title") }
    static var appearance: String { NSLocalizedString("section.appearance", comment: "Appearance section title") }
    static var language: String { NSLocalizedString("section.language", comment: "Language section title") }

    static var ohmsHeader: String { NSLocalizedString("nav.ohms", comment: "Ohm's law navigation title") }
    static var powerHeader: String { NSLocalizedString("nav.power", comment: "Power calculator title") }
    static var wattHeader: String { NSLocalizedString("nav.watt", comment: "Watt calculator title") }
    static var dropHeader: String { NSLocalizedString("nav.drop", comment: "Voltage drop title") }
    static var referenceHeader: String { NSLocalizedString("nav.reference", comment: "Reference title") }
    static var settingsHeader: String { NSLocalizedString("nav.settings", comment: "Settings title") }
    static var projectsHeader: String { NSLocalizedString("nav.projects", comment: "Projects title") }

    static var provideTwo: String { NSLocalizedString("ohms.prompt", comment: "Prompt for Ohm's law inputs") }
    static var enterTwo: String { NSLocalizedString("ohms.validation", comment: "Validation for two values") }
    static func voltage(_ value: String) -> String { String(format: NSLocalizedString("ohms.result.voltage", comment: "Voltage result"), value) }
    static func current(_ value: String) -> String { String(format: NSLocalizedString("ohms.result.current", comment: "Current result"), value) }
    static func resistance(_ value: String) -> String { String(format: NSLocalizedString("ohms.result.resistance", comment: "Resistance result"), value) }
    static func power(_ value: String) -> String { String(format: NSLocalizedString("ohms.result.power", comment: "Power result"), value) }
    static func ohmsCalculateButton() -> String { NSLocalizedString("ohms.button.calculate", comment: "Calculate button label") }

    static var phase: String { NSLocalizedString("power.phase", comment: "Phase label") }
    static var singlePhase: String { NSLocalizedString("power.singlePhase", comment: "Single phase option") }
    static var threePhase: String { NSLocalizedString("power.threePhase", comment: "Three phase option") }
    static var powerFactor: String { NSLocalizedString("power.factor", comment: "Power factor label") }
    static var powerFactorInfo: String { NSLocalizedString("power.factor.info", comment: "Power factor info description") }
    static func estimatePower() -> String { NSLocalizedString("power.button.estimate", comment: "Estimate power button") }
    static var enterCircuit: String { NSLocalizedString("power.prompt", comment: "Prompt for circuit inputs") }
    static var invalidPowerInputs: String { NSLocalizedString("power.validation", comment: "Invalid power inputs message") }
    static func powerResult(_ watts: Double, _ kw: Double) -> String { String(format: NSLocalizedString("power.result.power", comment: "Power result"), watts, kw) }
    static func breakerResult(_ amps: Double) -> String { String(format: NSLocalizedString("power.result.breaker", comment: "Breaker sizing"), amps) }
    static func apparentResult(_ va: Double) -> String { String(format: NSLocalizedString("power.result.apparent", comment: "Apparent power"), va) }

    static var calculateWatts: String { NSLocalizedString("watt.button.calculate", comment: "Calculate watts button") }
    static var enterWattPrompt: String { NSLocalizedString("watt.prompt", comment: "Prompt for watt inputs") }
    static var invalidWattInputs: String { NSLocalizedString("watt.validation", comment: "Invalid watt inputs") }
    static func realPower(_ watts: Double, _ kw: Double) -> String { String(format: NSLocalizedString("watt.result.real", comment: "Real power"), watts, kw) }
    static func assumingPF(_ pf: Double) -> String { String(format: NSLocalizedString("watt.result.pf", comment: "Assuming power factor"), pf) }

    static var estimateDrop: String { NSLocalizedString("drop.button.estimate", comment: "Estimate drop button") }
    static var enterDropPrompt: String { NSLocalizedString("drop.prompt", comment: "Prompt for drop inputs") }
    static var invalidDropInputs: String { NSLocalizedString("drop.validation", comment: "Invalid drop inputs") }
    static func dropResult(_ volts: Double) -> String { String(format: NSLocalizedString("drop.result.voltage", comment: "Voltage drop result"), volts) }
    static func dropPercent(_ percent: Double) -> String { String(format: NSLocalizedString("drop.result.percent", comment: "Percent drop"), percent) }
    static func dropResistance(_ resistance: Double) -> String { String(format: NSLocalizedString("drop.result.resistance", comment: "Loop resistance"), resistance) }

    static var projectsExisting: String { NSLocalizedString("projects.existing", comment: "Existing projects header") }
    static var projectsNew: String { NSLocalizedString("projects.new", comment: "New project header") }
    static var projectsEmpty: String { NSLocalizedString("projects.empty", comment: "No projects message") }
    static var projectName: String { NSLocalizedString("projects.name", comment: "Project name field") }
    static var projectVoltage: String { NSLocalizedString("projects.voltage", comment: "Project voltage field") }
    static var projectNotes: String { NSLocalizedString("projects.notes", comment: "Project notes field") }
    static var projectAdd: String { NSLocalizedString("projects.add", comment: "Add project button") }
    static var projectEquipmentHeader: String { NSLocalizedString("projects.equipment", comment: "Equipment header") }
    static var projectEquipmentEmpty: String { NSLocalizedString("projects.equipment.empty", comment: "No equipment for draft") }
    static var projectEquipmentProjectEmpty: String { NSLocalizedString("projects.equipment.empty.project", comment: "No equipment for saved project") }
    static var projectEquipmentAddTitle: String { NSLocalizedString("projects.equipment.add.title", comment: "Add equipment title") }
    static var projectEquipmentType: String { NSLocalizedString("projects.equipment.type", comment: "Equipment type picker") }
    static var projectEquipmentInfo: String { NSLocalizedString("projects.equipment.info", comment: "Equipment info field") }
    static func projectEquipmentQuantity(_ qty: Int) -> String { String(format: NSLocalizedString("projects.equipment.quantity", comment: "Quantity"), qty) }
    static var projectEquipmentSave: String { NSLocalizedString("projects.equipment.save", comment: "Save equipment") }

    static var equipmentBreaker: String { NSLocalizedString("equipment.breaker", comment: "Breaker label") }
    static var equipmentBreakerAmps: String { NSLocalizedString("equipment.breaker.amps", comment: "Breaker amp picker") }
    static var equipmentBreakerCurve: String { NSLocalizedString("equipment.breaker.curve", comment: "Breaker curve") }
    static var equipmentContactor: String { NSLocalizedString("equipment.contactor", comment: "Contactor label") }
    static var equipmentContactorAmps: String { NSLocalizedString("equipment.contactor.amps", comment: "Contactor amps") }
    static var equipmentPolesLabel: String { NSLocalizedString("equipment.poles", comment: "Poles label") }
    static var equipmentThermal: String { NSLocalizedString("equipment.thermal", comment: "Thermal protection") }
    static var equipmentThermalSetting: String { NSLocalizedString("equipment.thermal.setting", comment: "Thermal setting") }
    static var equipmentTransformer: String { NSLocalizedString("equipment.transformer", comment: "Transformer") }
    static var equipmentTransformerPower: String { NSLocalizedString("equipment.transformer.watts", comment: "Transformer watts") }
    static var equipmentBoardSocket: String { NSLocalizedString("equipment.socket", comment: "Board socket") }
    static var equipmentBoardSocketOption: String { NSLocalizedString("equipment.socket.option", comment: "Board socket option") }
    static var equipmentSwitch: String { NSLocalizedString("equipment.switch", comment: "Switch") }
    static var equipmentSwitchPositions: String { NSLocalizedString("equipment.switch.positions", comment: "Switch positions") }
    static var equipmentRelay: String { NSLocalizedString("equipment.relay", comment: "Relay") }
    static var equipmentRelayVoltage: String { NSLocalizedString("equipment.relay.voltage", comment: "Relay voltage") }
    static var equipmentRelayType: String { NSLocalizedString("equipment.relay.type", comment: "Relay coil type") }
    static var equipmentKwh: String { NSLocalizedString("equipment.kwh", comment: "kWh meter") }
    static var equipmentKwhOption: String { NSLocalizedString("equipment.kwh.option", comment: "kWh option") }
    static var equipmentKwhSingle: String { NSLocalizedString("equipment.kwh.single", comment: "Single phase") }
    static var equipmentKwhThree: String { NSLocalizedString("equipment.kwh.three", comment: "Three phase") }
    static var equipmentPlc: String { NSLocalizedString("equipment.plc", comment: "PLC cards") }
    static var equipmentPlcBrand: String { NSLocalizedString("equipment.plc.brand", comment: "PLC brand") }
    static var equipmentPlcType: String { NSLocalizedString("equipment.plc.type", comment: "PLC type") }
    static var equipmentTerminals: String { NSLocalizedString("equipment.terminals", comment: "Circuit terminals") }
    static var equipmentTerminalType: String { NSLocalizedString("equipment.terminals.type", comment: "Terminal type") }
    static var equipmentCustom: String { NSLocalizedString("equipment.custom", comment: "Custom equipment") }
    static var equipmentCustomLabel: String { NSLocalizedString("equipment.custom.label", comment: "Custom label") }
    static var equipmentOptionNote: String { NSLocalizedString("equipment.option.note", comment: "Option note") }
    static var equipmentMarkHint: String { NSLocalizedString("equipment.mark", comment: "Tap to mark on hand") }
    static func equipmentQuantityValue(_ qty: Int) -> String { String(format: NSLocalizedString("equipment.quantity", comment: "Quantity value"), qty) }
    static func equipmentAmpsValue(_ value: Int) -> String { String(format: NSLocalizedString("equipment.value.amps", comment: "Amps value"), value) }
    static func equipmentPolesValue(_ value: Int) -> String { String(format: NSLocalizedString("equipment.value.poles", comment: "Poles value"), value) }
    static func equipmentWattsValue(_ value: Int) -> String { String(format: NSLocalizedString("equipment.value.watts", comment: "Watts value"), value) }
    static func equipmentPositionsValue(_ value: Int) -> String { String(format: NSLocalizedString("equipment.value.positions", comment: "Positions value"), value) }
    static func equipmentVoltageValue(_ value: Int) -> String { String(format: NSLocalizedString("equipment.value.voltage", comment: "Voltage value"), value) }

    static var delete: String { NSLocalizedString("action.delete", comment: "Delete button") }

    static var offlineReady: String { NSLocalizedString("badge.offline", comment: "Offline badge") }
    static var proFormulas: String { NSLocalizedString("badge.formulas", comment: "Pro formulas badge") }

    static var openSettings: String { NSLocalizedString("nav.settings.button", comment: "Open settings label") }
    static var settingsThemeDescription: String { NSLocalizedString("settings.theme.description", comment: "Theme description") }
    static var settingsThemeLabel: String { NSLocalizedString("settings.theme.label", comment: "Theme picker label") }
    static var settingsThemeColorLabel: String { NSLocalizedString("settings.theme.color.label", comment: "Theme color picker label") }
    static var settingsThemeColorDescription: String { NSLocalizedString("settings.theme.color.description", comment: "Theme color description") }
    static var languageLabel: String { NSLocalizedString("settings.language.label", comment: "Language picker label") }
    static var languageDescription: String { NSLocalizedString("settings.language.description", comment: "Language description") }

    static var copperResistivity: String { NSLocalizedString("reference.copper", comment: "Copper resistivity") }
    static var pfRange: String { NSLocalizedString("reference.pfRange", comment: "Power factor range") }
    static var threePhaseMultiplier: String { NSLocalizedString("reference.multiplier", comment: "Three phase multiplier") }
    static var quickConstants: String { NSLocalizedString("reference.quick", comment: "Quick constants header") }
    static var tipsHeader: String { NSLocalizedString("reference.tips", comment: "Usage tips header") }
    static var tipOhms: String { NSLocalizedString("reference.tip.ohms", comment: "Ohms tip") }
    static var tipBreaker: String { NSLocalizedString("reference.tip.breaker", comment: "Breaker tip") }
    static var tipDrop: String { NSLocalizedString("reference.tip.drop", comment: "Voltage drop tip") }

    static var ohmsVoltageField: String { NSLocalizedString("field.voltage", comment: "Voltage field label") }
    static var ohmsCurrentField: String { NSLocalizedString("field.current", comment: "Current field label") }
    static var resistanceField: String { NSLocalizedString("field.resistance", comment: "Resistance field label") }
    static var powerField: String { NSLocalizedString("field.power", comment: "Power field label") }
    static var lengthField: String { NSLocalizedString("field.length", comment: "Length field label") }
    static var loadCurrentField: String { NSLocalizedString("field.loadCurrent", comment: "Load current field label") }
    static var supplyVoltageField: String { NSLocalizedString("field.supplyVoltage", comment: "Supply voltage field label") }
    static func conductorArea(_ value: Double) -> String { String(format: NSLocalizedString("field.conductorArea", comment: "Conductor area slider"), value) }
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
                        Label(L10n.calculateWatts, systemImage: "wand.and.sparkles")
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
                        Label(L10n.estimateDrop, systemImage: "arrow.triangle.2.circlepath")
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

struct ProjectsView: View {
    struct Project: Identifiable {
        let id = UUID()
        var name: String
        var voltage: String
        var notes: String
        var equipment: [EquipmentItem]
    }

    struct EquipmentItem: Identifiable {
        let id = UUID()
        var category: EquipmentCategory
        var primary: String
        var secondary: String?
        var details: String
        var quantity: Int
        var acquired: Bool

        var title: String { category.title }

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

    enum EquipmentCategory: String, CaseIterable, Identifiable {
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

    enum BreakerCurve: String, CaseIterable, Identifiable {
        case b = "B"
        case c = "C"
        case d = "D"
        case k = "K"
        case z = "Z"

        var id: String { rawValue }
    }

    enum RelayCoilType: String, CaseIterable, Identifiable {
        case ac = "AC"
        case dc = "DC"

        var id: String { rawValue }
    }

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
        var additionalInfo: String = ""
        var customLabel: String = ""
        var optionNote: String = ""
        var brand: String = ""
        var model: String = ""
        var terminalType: String = ""

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

        mutating func reset() {
            category = .breaker
            amps = 63
            curve = .c
            poles = 3
            transformerWatts = 100
            switchPositions = 2
            relayVoltage = 24
            relayCoil = .ac
            kwhConfiguration = 1
            quantity = 1
            additionalInfo = ""
            customLabel = ""
            optionNote = ""
            brand = ""
            model = ""
            terminalType = ""
        }
    }

    @State private var projects: [Project] = []
    @State private var newName: String = ""
    @State private var newVoltage: String = ""
    @State private var newNotes: String = ""
    @State private var equipmentItems: [EquipmentItem] = []
    @State private var equipmentDraft = EquipmentDraft()
    @State private var projectDrafts: [Project.ID: EquipmentDraft] = [:]
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(L10n.projectsExisting)) {
                    if projects.isEmpty {
                        Text(L10n.projectsEmpty)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach($projects) { $project in
                            let projectValue = project.wrappedValue

                            DisclosureGroup {
                                VStack(alignment: .leading, spacing: 8) {
                                    if !projectValue.voltage.isEmpty {
                                        Label(projectValue.voltage, systemImage: "bolt")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    if !projectValue.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        Text(projectValue.notes)
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }
                                    Section(header: Text(L10n.projectEquipmentHeader)) {
                                        if project.equipment.wrappedValue.isEmpty {
                                            Text(L10n.projectEquipmentProjectEmpty)
                                                .foregroundStyle(.secondary)
                                        } else {
                                            ForEach(project.equipment.wrappedValue.indices, id: \.self) { index in
                                                EquipmentRow(item: $project.equipment[index], tint: themeColor.color)
                                                    .swipeActions {
                                                        project.equipment.wrappedValue.remove(at: index)
                                                    }
                                            }
                                        }
                                    }

                                    EquipmentDraftForm(
                                        draft: bindingForProjectDraft(projectValue.id),
                                        tint: themeColor.color
                                    ) { newItem in
                                        project.equipment.wrappedValue.append(newItem)
                                    }
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(projectValue.name)
                                        .font(.headline)
                                    if !projectValue.voltage.isEmpty {
                                        Text(projectValue.voltage)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                }

                Section(header: Text(L10n.projectsNew)) {
                    TextField(L10n.projectName, text: $newName)
                    TextField(L10n.projectVoltage, text: $newVoltage)
                        .textInputAutocapitalization(.never)
                    TextField(L10n.projectNotes, text: $newNotes, axis: .vertical)
                        .lineLimit(2, reservesSpace: true)

                    EquipmentDraftSection(equipmentItems: $equipmentItems, draft: $equipmentDraft, tint: themeColor.color)

                    Button(action: addProject) {
                        Label(L10n.projectAdd, systemImage: "plus")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                Section(header: Text(L10n.equipmentChecklist)) {
                    if equipmentItems.isEmpty {
                        Text(L10n.equipmentEmpty)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach($equipmentItems) { $item in
                            Toggle(isOn: $item.isChecked) {
                                Text(item.name)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: themeColor.color))
                        }
                    }

                    HStack {
                        TextField(L10n.equipmentPlaceholder, text: $newEquipmentName)
                        Button(action: addEquipmentItem) {
                            Label(L10n.equipmentAdd, systemImage: "plus")
                        }
                        .disabled(newEquipmentName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
            }
            .navigationTitle(L10n.projectsHeader)
        }
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

    private func bindingForProjectDraft(_ projectID: Project.ID) -> Binding<EquipmentDraft> {
        Binding(
            get: { projectDrafts[projectID] ?? EquipmentDraft() },
            set: { projectDrafts[projectID] = $0 }
        )
    }
}

struct EquipmentRow: View {
    @Binding var item: ProjectsView.EquipmentItem
    var tint: Color

    var body: some View {
        Button(action: { item.acquired.toggle() }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: item.acquired ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.acquired ? tint : Color.secondary)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.body)
                    if !item.detailLine.isEmpty {
                        Text(item.detailLine)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Text(L10n.equipmentQuantityValue(item.quantity))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.title)
        .accessibilityHint(L10n.equipmentMarkHint)
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
                ForEach(equipmentItems) { item in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(tint)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                            if !item.detailLine.isEmpty {
                                Text(item.detailLine)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        Text(L10n.equipmentQuantityValue(item.quantity))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .swipeActions {
                        if let index = equipmentItems.firstIndex(where: { $0.id == item.id }) {
                            Button(role: .destructive) {
                                equipmentItems.remove(at: index)
                            } label: {
                                Label(L10n.delete, systemImage: "trash")
                            }
                        }
                    }
                }
            }
            EquipmentDraftForm(draft: $draft, tint: tint) { item in
                equipmentItems.append(item)
            }
        }
    }
}

struct EquipmentDraftForm: View {
    @Binding var draft: ProjectsView.EquipmentDraft
    var tint: Color
    var onAdd: (ProjectsView.EquipmentItem) -> Void

    private var breakerAmps: [Int] { Array(1...1000) }
    private var transformerOptions: [Int] { stride(from: 50, through: 1000, by: 50).map { $0 } + stride(from: 1200, through: 5000, by: 200).map { $0 } }
    private var relayVoltages: [Int] { [12, 24, 48, 110, 120, 230] }

    var body: some View {
        DisclosureGroup(L10n.projectEquipmentAddTitle) {
            Picker(L10n.projectEquipmentType, selection: $draft.category) {
                ForEach(ProjectsView.EquipmentCategory.allCases) { category in
                    Text(category.title).tag(category)
                }
            }

            switch draft.category {
            case .breaker:
                Picker(L10n.equipmentBreakerAmps, selection: $draft.amps) {
                    ForEach(breakerAmps, id: \.self) { value in
                        Text(L10n.equipmentAmpsValue(value)).tag(value)
                    }
                }
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
                    .textInputAutocapitalization(.never)
            case .plcCard:
                TextField(L10n.equipmentPlcBrand, text: $draft.brand)
                    .textInputAutocapitalization(.words)
                TextField(L10n.equipmentPlcType, text: $draft.model)
                    .textInputAutocapitalization(.words)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                    .textInputAutocapitalization(.sentences)
            case .circuitTerminal:
                TextField(L10n.equipmentTerminalType, text: $draft.terminalType)
                    .textInputAutocapitalization(.words)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                    .textInputAutocapitalization(.sentences)
            case .custom:
                TextField(L10n.equipmentCustomLabel, text: $draft.customLabel)
                    .textInputAutocapitalization(.sentences)
                TextField(L10n.equipmentOptionNote, text: $draft.optionNote)
                    .textInputAutocapitalization(.sentences)
            }

            Stepper(value: $draft.quantity, in: 1...500) {
                Text(L10n.projectEquipmentQuantity(draft.quantity))
            }

            TextField(L10n.projectEquipmentInfo, text: $draft.additionalInfo, axis: .vertical)
                .lineLimit(2, reservesSpace: true)

            Button(action: addItem) {
                Label(L10n.projectEquipmentSave, systemImage: "plus")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(!draft.canSave)
            .tint(tint)
        }
    }

    private func addItem() {
        guard draft.canSave else { return }
        let item = ProjectsView.EquipmentItem(
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

struct SettingsView: View {
    @Binding var appearanceMode: AppearanceMode
    @Binding var languagePreference: LanguageOption
    @Binding var themeColor: ThemeColor

    var body: some View {
        Form {
            Section(header: Text(L10n.appearance)) {
                NavigationLink(destination: AppearanceSettingsView(appearanceMode: $appearanceMode, themeColor: $themeColor)) {
                    Label(L10n.appearance, systemImage: "paintbrush")
                }
            }

            Section(header: Text(L10n.language)) {
                Picker(L10n.languageLabel, selection: $languagePreference) {
                    ForEach(LanguageOption.allCases) { option in
                        Text(option.displayName).tag(option)
                    }
                }
                Text(L10n.languageDescription)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(L10n.settingsHeader)
    }
}

private struct AppearanceSettingsView: View {
    @Binding var appearanceMode: AppearanceMode
    @Binding var themeColor: ThemeColor

    var body: some View {
        Form {
            AppearanceSettingsSection(appearanceMode: $appearanceMode, themeColor: $themeColor)
        }
        .navigationTitle(L10n.appearance)
    }
}

private struct AppearanceSettingsSection: View {
    @Binding var appearanceMode: AppearanceMode
    @Binding var themeColor: ThemeColor

    var body: some View {
        Section(header: Text(L10n.appearance)) {
            Picker(L10n.settingsThemeLabel, selection: $appearanceMode) {
                ForEach(AppearanceMode.allCases) { mode in
                    Text(mode.displayName).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            Text(L10n.settingsThemeDescription)
                .font(.footnote)
                .foregroundStyle(.secondary)

            Picker(L10n.settingsThemeColorLabel, selection: $themeColor) {
                ForEach(ThemeColor.allCases) { theme in
                    HStack(spacing: 12) {
                        Capsule()
                            .fill(theme.color.gradient)
                            .frame(width: 42, height: 18)
                        Text(theme.displayName)
                    }
                    .tag(theme)
                }
            }
            Text(L10n.settingsThemeColorDescription)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

struct NumericField: View {
    let title: String
    @Binding var value: String

    var body: some View {
        TextField(title, text: $value)
            .keyboardType(.decimalPad)
            .textInputAutocapitalization(.never)
            .textFieldStyle(FilledRoundedTextFieldStyle())
    }
}

struct FilledRoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
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
