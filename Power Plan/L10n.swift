import Foundation
import SwiftUI

enum L10n {
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

    static func calculateWatts() -> String { NSLocalizedString("watt.button.calculate", comment: "Calculate watts button") }
    static var enterWattPrompt: String { NSLocalizedString("watt.prompt", comment: "Prompt for watt inputs") }
    static var invalidWattInputs: String { NSLocalizedString("watt.validation", comment: "Invalid watt inputs") }
    static func realPower(_ watts: Double, _ kw: Double) -> String { String(format: NSLocalizedString("watt.result.real", comment: "Real power"), watts, kw) }
    static func assumingPF(_ pf: Double) -> String { String(format: NSLocalizedString("watt.result.pf", comment: "Assuming PF"), pf) }

    static func estimateDrop() -> String { NSLocalizedString("drop.button.estimate", comment: "Estimate drop button") }
    static var enterDropPrompt: String { NSLocalizedString("drop.prompt", comment: "Voltage drop prompt") }
    static var invalidDropInputs: String { NSLocalizedString("drop.validation", comment: "Invalid drop inputs") }
    static func dropResult(_ volts: Double) -> String { String(format: NSLocalizedString("drop.result.voltage", comment: "Voltage drop result"), volts) }
    static func dropPercent(_ percent: Double) -> String { String(format: NSLocalizedString("drop.result.percent", comment: "Voltage drop percent"), percent) }
    static func dropResistance(_ resistance: Double) -> String { String(format: NSLocalizedString("drop.result.resistance", comment: "Resistance result"), resistance) }

    static var projectsExisting: String { NSLocalizedString("projects.existing", comment: "Existing projects header") }
    static var projectsNew: String { NSLocalizedString("projects.new", comment: "New project header") }
    static var projectsEmpty: String { NSLocalizedString("projects.empty", comment: "Empty projects message") }
    static var projectsMoreActions: String { NSLocalizedString("projects.actions", comment: "More project actions label") }
    static var projectsSelectionStart: String { NSLocalizedString("projects.selection.start", comment: "Start selecting projects") }
    static var projectsSelectionDone: String { NSLocalizedString("projects.selection.done", comment: "Finish selecting projects") }
    static var projectsDeleteSelected: String { NSLocalizedString("projects.selection.delete", comment: "Delete selected projects") }
    static var projectsEditingStart: String { NSLocalizedString("projects.editing.start", comment: "Begin editing a project") }
    static var projectsEditingDone: String { NSLocalizedString("projects.editing.done", comment: "Finish editing a project") }
    static var projectName: String { NSLocalizedString("projects.name", comment: "Project name field") }
    static var projectVoltage: String { NSLocalizedString("projects.voltage", comment: "Project voltage field") }
    static var projectNotes: String { NSLocalizedString("projects.notes", comment: "Project notes field") }
    static var projectAdd: String { NSLocalizedString("projects.add", comment: "Add project button") }
    static var projectDetails: String { NSLocalizedString("projects.details", comment: "Project details header") }
    static var projectComponentHeader: String { NSLocalizedString("projects.component", comment: "Component header") }
    static var projectComponentActions: String { NSLocalizedString("projects.component.actions", comment: "Component actions label") }
    static var projectComponentEmpty: String { NSLocalizedString("projects.component.empty", comment: "No component for draft") }
    static var projectComponentProjectEmpty: String { NSLocalizedString("projects.component.empty.project", comment: "No component for saved project") }
    static var projectComponentAddTitle: String { NSLocalizedString("projects.component.add.title", comment: "Add component title") }
    static var projectComponentType: String { NSLocalizedString("projects.component.type", comment: "Component type picker") }
    static var projectComponentInfo: String { NSLocalizedString("projects.component.info", comment: "Component info field") }
    static func projectComponentQuantity(_ qty: Int) -> String { String(format: NSLocalizedString("projects.component.quantity", comment: "Quantity"), qty) }
    static var projectComponentSave: String { NSLocalizedString("projects.component.save", comment: "Save component") }
    static var componentSelectionStart: String { NSLocalizedString("projects.component.selection.start", comment: "Start selecting components") }
    static var componentSelectionDone: String { NSLocalizedString("projects.component.selection.done", comment: "Finish selecting components") }
    static var componentDeleteSelected: String { NSLocalizedString("projects.component.selection.delete", comment: "Delete selected components") }

    static var componentPlaceholder: String { NSLocalizedString("component.placeholder", comment: "Component placeholder") }
    static var componentAdd: String { NSLocalizedString("component.add", comment: "Add component button") }
    static var componentEmpty: String { NSLocalizedString("component.empty", comment: "Empty component message") }
    static var componentChecklist: String { NSLocalizedString("projects.component.checklist", comment: "Component checklist") }

    static var componentBreaker: String { NSLocalizedString("component.breaker", comment: "Breaker label") }
    static var componentBreakerAmps: String { NSLocalizedString("component.breaker.amps", comment: "Breaker amp picker") }
    static var componentBreakerCurve: String { NSLocalizedString("component.breaker.curve", comment: "Breaker curve") }
    static var componentContactor: String { NSLocalizedString("component.contactor", comment: "Contactor label") }
    static var componentContactorAmps: String { NSLocalizedString("component.contactor.amps", comment: "Contactor amps") }
    static var componentPolesLabel: String { NSLocalizedString("component.poles", comment: "Poles label") }
    static var componentThermal: String { NSLocalizedString("component.thermal", comment: "Thermal protection") }
    static var componentThermalSetting: String { NSLocalizedString("component.thermal.setting", comment: "Thermal setting") }
    static var componentTransformer: String { NSLocalizedString("component.transformer", comment: "Transformer") }
    static var componentTransformerPower: String { NSLocalizedString("component.transformer.watts", comment: "Transformer watts") }
    static var componentBoardSocket: String { NSLocalizedString("component.socket", comment: "Board socket") }
    static var componentBoardSocketOption: String { NSLocalizedString("component.socket.option", comment: "Board socket option") }
    static var componentSwitch: String { NSLocalizedString("component.switch", comment: "Switch") }
    static var componentSwitchPositions: String { NSLocalizedString("component.switch.positions", comment: "Switch positions") }
    static var componentRelay: String { NSLocalizedString("component.relay", comment: "Relay") }
    static var componentRelayVoltage: String { NSLocalizedString("component.relay.voltage", comment: "Relay voltage") }
    static var componentRelayType: String { NSLocalizedString("component.relay.type", comment: "Relay coil type") }
    static var componentTagLabel: String { NSLocalizedString("component.tag.label", comment: "Sticker tag label") }
    static var componentKwh: String { NSLocalizedString("component.kwh", comment: "kWh meter") }
    static var componentKwhOption: String { NSLocalizedString("component.kwh.option", comment: "kWh option") }
    static var componentKwhSingle: String { NSLocalizedString("component.kwh.single", comment: "Single phase") }
    static var componentKwhThree: String { NSLocalizedString("component.kwh.three", comment: "Three phase") }
    static var componentPlc: String { NSLocalizedString("component.plc", comment: "PLC cards") }
    static var componentPlcBrand: String { NSLocalizedString("component.plc.brand", comment: "PLC brand") }
    static var componentPlcType: String { NSLocalizedString("component.plc.type", comment: "PLC type") }
    static var componentTerminals: String { NSLocalizedString("component.terminals", comment: "Circuit terminals") }
    static var componentTerminalType: String { NSLocalizedString("component.terminals.type", comment: "Terminal type") }
    static var componentCustom: String { NSLocalizedString("component.custom", comment: "Custom component") }
    static var componentCustomLabel: String { NSLocalizedString("component.custom.label", comment: "Custom label") }
    static var componentOptionNote: String { NSLocalizedString("component.option.note", comment: "Option note") }
    static var componentMarkHint: String { NSLocalizedString("component.mark", comment: "Tap to mark on hand") }
    static var componentSelectionHint: String { NSLocalizedString("component.selection.hint", comment: "Tap to select for removal") }
    static func componentQuantityValue(_ qty: Int) -> String { String(format: NSLocalizedString("component.quantity", comment: "Quantity value"), qty) }
    static func componentAmpsValue(_ value: Int) -> String { String(format: NSLocalizedString("component.value.amps", comment: "Amps value"), value) }
    static func componentPolesValue(_ value: Int) -> String { String(format: NSLocalizedString("component.value.poles", comment: "Poles value"), value) }
    static func componentWattsValue(_ value: Int) -> String { String(format: NSLocalizedString("component.value.watts", comment: "Watts value"), value) }
    static func componentPositionsValue(_ value: Int) -> String { String(format: NSLocalizedString("component.value.positions", comment: "Positions value"), value) }
    static func componentVoltageValue(_ value: Int) -> String { String(format: NSLocalizedString("component.value.voltage", comment: "Voltage value"), value) }
    static func componentTagValue(_ value: String) -> String { String(format: NSLocalizedString("component.value.tag", comment: "Component tag value"), value) }

    static var delete: String { NSLocalizedString("action.delete", comment: "Delete button") }
    static var cancel: String { NSLocalizedString("action.cancel", comment: "Cancel button") }

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
