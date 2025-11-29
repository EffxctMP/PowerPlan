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
    static var equipmentChecklist: String { NSLocalizedString("projects.equipment", comment: "Equipment checklist header") }
    static var equipmentPlaceholder: String { NSLocalizedString("projects.equipment.placeholder", comment: "Equipment placeholder") }
    static var equipmentEmpty: String { NSLocalizedString("projects.equipment.empty", comment: "Empty checklist state") }
    static var equipmentAdd: String { NSLocalizedString("projects.equipment.add", comment: "Add equipment button") }

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
        let name: String
        let voltage: String
        let notes: String
    }

    struct EquipmentItem: Identifiable {
        let id = UUID()
        let name: String
        var isChecked: Bool
    }

    @State private var projects: [Project] = []
    @State private var newName: String = ""
    @State private var newVoltage: String = ""
    @State private var newNotes: String = ""
    @State private var equipmentItems: [EquipmentItem] = []
    @State private var newEquipmentName: String = ""
    @AppStorage("themeColor") private var themeColor: ThemeColor = .electricBlue

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(L10n.projectsExisting)) {
                    if projects.isEmpty {
                        Text(L10n.projectsEmpty)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(projects) { project in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(project.name)
                                    .font(.headline)
                                Text(project.voltage)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                if !project.notes.isEmpty {
                                    Text(project.notes)
                                        .font(.footnote)
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
            notes: notes
        )
        projects.append(project)

        newName = ""
        newVoltage = ""
        newNotes = ""
    }

    private func addEquipmentItem() {
        let trimmedName = newEquipmentName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        equipmentItems.append(EquipmentItem(name: trimmedName, isChecked: false))
        newEquipmentName = ""
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
