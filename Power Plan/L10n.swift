import Foundation
import SwiftUI

enum L10n {
    static var calculators: String { NSLocalizedString("tab.calculators", comment: "") }
    static var reference: String { NSLocalizedString("tab.reference", comment: "") }
    static var projects: String { NSLocalizedString("tab.projects", comment: "") }
    static var appTitle: String { NSLocalizedString("nav.title", comment: "") }

    static var heroTitle: String { NSLocalizedString("hero.title", comment: "") }
    static var heroSubtitle: String { NSLocalizedString("hero.subtitle", comment: "") }
    static var heroOffline: String { NSLocalizedString("hero.offline", comment: "") }
    static var heroFormulas: String { NSLocalizedString("hero.formulas", comment: "") }

    static var ohmsTitle: String { NSLocalizedString("card.ohms.title", comment: "") }
    static var ohmsSubtitle: String { NSLocalizedString("card.ohms.subtitle", comment: "") }
    static var ohmsButton: String { NSLocalizedString("card.ohms.button", comment: "") }

    static var powerTitle: String { NSLocalizedString("card.power.title", comment: "") }
    static var powerSubtitle: String { NSLocalizedString("card.power.subtitle", comment: "") }
    static var powerButton: String { NSLocalizedString("card.power.button", comment: "") }

    static var wattTitle: String { NSLocalizedString("card.watt.title", comment: "") }
    static var wattSubtitle: String { NSLocalizedString("card.watt.subtitle", comment: "") }
    static var wattButton: String { NSLocalizedString("card.watt.button", comment: "") }

    static var dropTitle: String { NSLocalizedString("card.drop.title", comment: "") }
    static var dropSubtitle: String { NSLocalizedString("card.drop.subtitle", comment: "") }
    static var dropButton: String { NSLocalizedString("card.drop.button", comment: "") }

    static var inputs: String { NSLocalizedString("section.inputs", comment: "") }
    static var results: String { NSLocalizedString("section.results", comment: "") }
    static var circuit: String { NSLocalizedString("section.circuit", comment: "") }
    static var load: String { NSLocalizedString("section.load", comment: "") }
    static var run: String { NSLocalizedString("section.run", comment: "") }

    static var appearance: String { NSLocalizedString("section.appearance", comment: "") }
    static var language: String { NSLocalizedString("section.language", comment: "") }

    static var ohmsHeader: String { NSLocalizedString("nav.ohms", comment: "") }
    static var powerHeader: String { NSLocalizedString("nav.power", comment: "") }
    static var wattHeader: String { NSLocalizedString("nav.watt", comment: "") }
    static var dropHeader: String { NSLocalizedString("nav.drop", comment: "") }
    static var referenceHeader: String { NSLocalizedString("nav.reference", comment: "") }
    static var settingsHeader: String { NSLocalizedString("nav.settings", comment: "") }
    static var projectsHeader: String { NSLocalizedString("nav.projects", comment: "") }

    static var projectsExisting: String { NSLocalizedString("projects.existing", comment: "") }
    static var projectsNew: String { NSLocalizedString("projects.new", comment: "") }
    static var projectsEmpty: String { NSLocalizedString("projects.empty", comment: "") }

    static var projectName: String { NSLocalizedString("projects.name", comment: "") }
    static var projectVoltage: String { NSLocalizedString("projects.voltage", comment: "") }
    static var projectNotes: String { NSLocalizedString("projects.notes", comment: "") }
    static var projectAdd: String { NSLocalizedString("projects.add", comment: "") }

    static var projectEquipmentHeader: String { NSLocalizedString("projects.equipment", comment: "") }
    static var projectEquipmentEmpty: String { NSLocalizedString("projects.equipment.empty", comment: "") }
    static var projectEquipmentProjectEmpty: String { NSLocalizedString("projects.equipment.empty.project", comment: "") }
    static var projectEquipmentAddTitle: String { NSLocalizedString("projects.equipment.add.title", comment: "") }

    static var projectEquipmentType: String { NSLocalizedString("projects.equipment.type", comment: "") }
    static var equipmentBreaker: String { NSLocalizedString("equipment.breaker", comment: "") }
    static var equipmentContactor: String { NSLocalizedString("equipment.contactor", comment: "") }
    static var equipmentThermal: String { NSLocalizedString("equipment.thermal", comment: "") }
    static var equipmentTransformer: String { NSLocalizedString("equipment.transformer", comment: "") }
    static var equipmentBoardSocket: String { NSLocalizedString("equipment.socket", comment: "") }
    static var equipmentSwitch: String { NSLocalizedString("equipment.switch.positions", comment: "") }
    static var equipmentRelay: String { NSLocalizedString("equipment.relay", comment: "") }
    static var equipmentKwh: String { NSLocalizedString("equipment.kwh", comment: "") }
    static var equipmentPlc: String { NSLocalizedString("equipment.plc", comment: "") }
    static var equipmentTerminals: String { NSLocalizedString("equipment.terminals", comment: "") }
    static var equipmentCustom: String { NSLocalizedString("equipment.custom", comment: "") }

    static var equipmentPlaceholder: String { NSLocalizedString("equipment.placeholder", comment: "") }
    static var equipmentAdd: String { NSLocalizedString("equipment.add", comment: "") }
    static var equipmentEmpty: String { NSLocalizedString("equipment.empty", comment: "") }

    static var equipmentBreakerAmps: String { NSLocalizedString("equipment.breaker.amps", comment: "") }
    static var equipmentBreakerCurve: String { NSLocalizedString("equipment.breaker.curve", comment: "") }

    static var equipmentContactorAmps: String { NSLocalizedString("equipment.contactor.amps", comment: "") }
    static var equipmentPolesLabel: String { NSLocalizedString("equipment.poles", comment: "") }

    static var equipmentThermalSetting: String { NSLocalizedString("equipment.thermal.setting", comment: "") }
    static var equipmentTransformerPower: String { NSLocalizedString("equipment.transformer.watts", comment: "") }
    static var equipmentBoardSocketOption: String { NSLocalizedString("equipment.socket.option", comment: "") }

    static var equipmentSwitchPositions: String { NSLocalizedString("equipment.switch.positions", comment: "") }
    static var equipmentRelayVoltage: String { NSLocalizedString("equipment.relay.voltage", comment: "") }
    static var equipmentRelayType: String { NSLocalizedString("equipment.relay.type", comment: "") }
    static var equipmentKwhOption: String { NSLocalizedString("equipment.kwh.option", comment: "") }
    static var equipmentPlcBrand: String { NSLocalizedString("equipment.plc.brand", comment: "") }
    static var equipmentPlcType: String { NSLocalizedString("equipment.plc.type", comment: "") }
    static var equipmentTerminalType: String { NSLocalizedString("equipment.terminals.type", comment: "") }
    static var equipmentCustomLabel: String { NSLocalizedString("equipment.custom.label", comment: "") }
    static var equipmentOptionNote: String { NSLocalizedString("equipment.option.note", comment: "") }

    static func equipmentQuantityValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.quantity", comment: ""), v)
    }

    static func equipmentAmpsValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.value.amps", comment: ""), v)
    }

    static func equipmentPolesValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.value.poles", comment: ""), v)
    }

    static func equipmentWattsValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.value.watts", comment: ""), v)
    }

    static func equipmentPositionsValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.value.positions", comment: ""), v)
    }

    static func equipmentVoltageValue(_ v: Int) -> String {
        String(format: NSLocalizedString("equipment.value.voltage", comment: ""), v)
    }

    static var delete: String { NSLocalizedString("action.delete", comment: "") }
}
