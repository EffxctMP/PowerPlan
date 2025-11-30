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
    static var projectEquipmentHeader: String { NSLocalizedString("projects.equipment", comment: "Equipment header") }
    static var projectEquipmentEmpty: String { NSLocalizedString("projects.equipment.empty", comment: "No equipment for draft") }
    static var projectEquipmentProjectEmpty: String { NSLocalizedString("projects.equipment.empty.project", comment: "No equipment for saved project") }
    static var projectEquipmentAddTitle: String { NSLocalizedString("projects.equipment.add.title", comment: "Add equipment title") }
    static var projectEquipmentType: String { NSLocalizedString("projects.equipment.type", comment: "Equipment type picker") }
    static var projectEquipmentInfo: String { NSLocalizedString("projects.equipment.info", comment: "Equipment info field") }
    static func projectEquipmentQuantity(_ qty: Int) -> String { String(format: NSLocalizedString("projects.equipment.quantity", comment: "Quantity"), qty) }
    static var projectEquipmentSave: String { NSLocalizedString("projects.equipment.save", comment: "Save equipment") }

    static var equipmentPlaceholder: String { NSLocalizedString("equipment.placeholder", comment: "Equipment placeholder") }
    static var equipmentAdd: String { NSLocalizedString("equipment.add", comment: "Add equipment button") }
    static var equipmentEmpty: String { NSLocalizedString("equipment.empty", comment: "Empty equipment message") }
    static var equipmentChecklist: String { NSLocalizedString("projects.equipment.checklist", comment: "Equipment checklist") }

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
    static var equipmentTagLabel: String { NSLocalizedString("equipment.tag.label", comment: "Sticker tag label") }
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
    static func equipmentTagValue(_ value: String) -> String { String(format: NSLocalizedString("equipment.value.tag", comment: "Equipment tag value"), value) }

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
