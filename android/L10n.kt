package com.powerplan

import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource

/**
 * Android Studio counterpart to the original Swift `L10n.swift` helper.
 *
 * Provides composable accessors for all localized strings so Jetpack Compose
 * screens can mirror the iOS implementation without hardcoded literals.
 */
object L10n {
    val calculators: String
        @Composable get() = stringResource(R.string.tab_calculators)
    val reference: String
        @Composable get() = stringResource(R.string.tab_reference)
    val projects: String
        @Composable get() = stringResource(R.string.tab_projects)
    val appTitle: String
        @Composable get() = stringResource(R.string.nav_title)

    val heroTitle: String
        @Composable get() = stringResource(R.string.hero_title)
    val heroSubtitle: String
        @Composable get() = stringResource(R.string.hero_subtitle)
    val heroOffline: String
        @Composable get() = stringResource(R.string.hero_offline)
    val heroFormulas: String
        @Composable get() = stringResource(R.string.hero_formulas)

    val ohmsTitle: String
        @Composable get() = stringResource(R.string.card_ohms_title)
    val ohmsSubtitle: String
        @Composable get() = stringResource(R.string.card_ohms_subtitle)
    val ohmsButton: String
        @Composable get() = stringResource(R.string.card_ohms_button)

    val powerTitle: String
        @Composable get() = stringResource(R.string.card_power_title)
    val powerSubtitle: String
        @Composable get() = stringResource(R.string.card_power_subtitle)
    val powerButton: String
        @Composable get() = stringResource(R.string.card_power_button)

    val wattTitle: String
        @Composable get() = stringResource(R.string.card_watt_title)
    val wattSubtitle: String
        @Composable get() = stringResource(R.string.card_watt_subtitle)
    val wattButton: String
        @Composable get() = stringResource(R.string.card_watt_button)

    val dropTitle: String
        @Composable get() = stringResource(R.string.card_drop_title)
    val dropSubtitle: String
        @Composable get() = stringResource(R.string.card_drop_subtitle)
    val dropButton: String
        @Composable get() = stringResource(R.string.card_drop_button)

    val inputs: String
        @Composable get() = stringResource(R.string.section_inputs)
    val results: String
        @Composable get() = stringResource(R.string.section_results)
    val circuit: String
        @Composable get() = stringResource(R.string.section_circuit)
    val load: String
        @Composable get() = stringResource(R.string.section_load)
    val run: String
        @Composable get() = stringResource(R.string.section_run)
    val appearance: String
        @Composable get() = stringResource(R.string.section_appearance)
    val language: String
        @Composable get() = stringResource(R.string.section_language)

    val ohmsHeader: String
        @Composable get() = stringResource(R.string.nav_ohms)
    val powerHeader: String
        @Composable get() = stringResource(R.string.nav_power)
    val wattHeader: String
        @Composable get() = stringResource(R.string.nav_watt)
    val dropHeader: String
        @Composable get() = stringResource(R.string.nav_drop)
    val referenceHeader: String
        @Composable get() = stringResource(R.string.nav_reference)
    val settingsHeader: String
        @Composable get() = stringResource(R.string.nav_settings)
    val projectsHeader: String
        @Composable get() = stringResource(R.string.nav_projects)

    val provideTwo: String
        @Composable get() = stringResource(R.string.ohms_prompt)
    val enterTwo: String
        @Composable get() = stringResource(R.string.ohms_validation)

    @Composable
    fun voltage(value: String): String = stringResource(R.string.ohms_result_voltage, value)

    @Composable
    fun current(value: String): String = stringResource(R.string.ohms_result_current, value)

    @Composable
    fun resistance(value: String): String = stringResource(R.string.ohms_result_resistance, value)

    @Composable
    fun power(value: String): String = stringResource(R.string.ohms_result_power, value)

    @Composable
    fun ohmsCalculateButton(): String = stringResource(R.string.ohms_button_calculate)

    val phase: String
        @Composable get() = stringResource(R.string.power_phase)
    val singlePhase: String
        @Composable get() = stringResource(R.string.power_single_phase)
    val threePhase: String
        @Composable get() = stringResource(R.string.power_three_phase)
    val powerFactor: String
        @Composable get() = stringResource(R.string.power_factor)
    val powerFactorInfo: String
        @Composable get() = stringResource(R.string.power_factor_info)

    @Composable
    fun estimatePower(): String = stringResource(R.string.power_button_estimate)

    val enterCircuit: String
        @Composable get() = stringResource(R.string.power_prompt)
    val invalidPowerInputs: String
        @Composable get() = stringResource(R.string.power_validation)

    @Composable
    fun powerResult(watts: Double, kw: Double): String =
        stringResource(R.string.power_result_power, watts, kw)

    @Composable
    fun breakerResult(amps: Double): String =
        stringResource(R.string.power_result_breaker, amps)

    @Composable
    fun apparentResult(va: Double): String =
        stringResource(R.string.power_result_apparent, va)

    @Composable
    fun calculateWatts(): String = stringResource(R.string.watt_button_calculate)

    val enterWattPrompt: String
        @Composable get() = stringResource(R.string.watt_prompt)
    val invalidWattInputs: String
        @Composable get() = stringResource(R.string.watt_validation)

    @Composable
    fun realPower(watts: Double, kw: Double): String =
        stringResource(R.string.watt_result_real, watts, kw)

    @Composable
    fun assumingPF(pf: Double): String = stringResource(R.string.watt_result_pf, pf)

    @Composable
    fun estimateDrop(): String = stringResource(R.string.drop_button_estimate)

    val enterDropPrompt: String
        @Composable get() = stringResource(R.string.drop_prompt)
    val invalidDropInputs: String
        @Composable get() = stringResource(R.string.drop_validation)

    @Composable
    fun dropResult(volts: Double): String = stringResource(R.string.drop_result_voltage, volts)

    @Composable
    fun dropPercent(percent: Double): String = stringResource(R.string.drop_result_percent, percent)

    @Composable
    fun dropResistance(resistance: Double): String =
        stringResource(R.string.drop_result_resistance, resistance)

    val projectsExisting: String
        @Composable get() = stringResource(R.string.projects_existing)
    val projectsNew: String
        @Composable get() = stringResource(R.string.projects_new)
    val projectsEmpty: String
        @Composable get() = stringResource(R.string.projects_empty)
    val projectsMoreActions: String
        @Composable get() = stringResource(R.string.projects_actions)
    val projectsSelectionStart: String
        @Composable get() = stringResource(R.string.projects_selection_start)
    val projectsSelectionDone: String
        @Composable get() = stringResource(R.string.projects_selection_done)
    val projectsDeleteSelected: String
        @Composable get() = stringResource(R.string.projects_selection_delete)
    val projectsEditingStart: String
        @Composable get() = stringResource(R.string.projects_editing_start)
    val projectsEditingDone: String
        @Composable get() = stringResource(R.string.projects_editing_done)
    val projectName: String
        @Composable get() = stringResource(R.string.projects_name)
    val projectVoltage: String
        @Composable get() = stringResource(R.string.projects_voltage)
    val projectNotes: String
        @Composable get() = stringResource(R.string.projects_notes)
    val projectAdd: String
        @Composable get() = stringResource(R.string.projects_add)
    val projectDetails: String
        @Composable get() = stringResource(R.string.projects_details)
    val projectComponentHeader: String
        @Composable get() = stringResource(R.string.projects_component)
    val projectComponentActions: String
        @Composable get() = stringResource(R.string.projects_component_actions)
    val projectComponentEmpty: String
        @Composable get() = stringResource(R.string.projects_component_empty)
    val projectComponentProjectEmpty: String
        @Composable get() = stringResource(R.string.projects_component_empty_project)
    val projectComponentAddTitle: String
        @Composable get() = stringResource(R.string.projects_component_add_title)
    val projectComponentType: String
        @Composable get() = stringResource(R.string.projects_component_type)
    val projectComponentInfo: String
        @Composable get() = stringResource(R.string.projects_component_info)

    @Composable
    fun projectComponentQuantity(qty: Int): String =
        stringResource(R.string.projects_component_quantity, qty)

    val projectComponentSave: String
        @Composable get() = stringResource(R.string.projects_component_save)
    val componentSelectionStart: String
        @Composable get() = stringResource(R.string.projects_component_selection_start)
    val componentSelectionDone: String
        @Composable get() = stringResource(R.string.projects_component_selection_done)
    val componentDeleteSelected: String
        @Composable get() = stringResource(R.string.projects_component_selection_delete)

    val componentPlaceholder: String
        @Composable get() = stringResource(R.string.component_placeholder)
    val componentAdd: String
        @Composable get() = stringResource(R.string.component_add)
    val componentEmpty: String
        @Composable get() = stringResource(R.string.component_empty)
    val componentChecklist: String
        @Composable get() = stringResource(R.string.projects_component_checklist)

    val componentBreaker: String
        @Composable get() = stringResource(R.string.component_breaker)
    val componentBreakerAmps: String
        @Composable get() = stringResource(R.string.component_breaker_amps)
    val componentBreakerCurve: String
        @Composable get() = stringResource(R.string.component_breaker_curve)
    val componentContactor: String
        @Composable get() = stringResource(R.string.component_contactor)
    val componentContactorAmps: String
        @Composable get() = stringResource(R.string.component_contactor_amps)
    val componentPolesLabel: String
        @Composable get() = stringResource(R.string.component_poles)
    val componentThermal: String
        @Composable get() = stringResource(R.string.component_thermal)
    val componentThermalSetting: String
        @Composable get() = stringResource(R.string.component_thermal_setting)
    val componentTransformer: String
        @Composable get() = stringResource(R.string.component_transformer)
    val componentTransformerPower: String
        @Composable get() = stringResource(R.string.component_transformer_watts)
    val componentBoardSocket: String
        @Composable get() = stringResource(R.string.component_socket)
    val componentBoardSocketOption: String
        @Composable get() = stringResource(R.string.component_socket_option)
    val componentSwitch: String
        @Composable get() = stringResource(R.string.component_switch)
    val componentSwitchPositions: String
        @Composable get() = stringResource(R.string.component_switch_positions)
    val componentRelay: String
        @Composable get() = stringResource(R.string.component_relay)
    val componentRelayVoltage: String
        @Composable get() = stringResource(R.string.component_relay_voltage)
    val componentRelayType: String
        @Composable get() = stringResource(R.string.component_relay_type)
    val componentTagLabel: String
        @Composable get() = stringResource(R.string.component_tag_label)
    val componentKwh: String
        @Composable get() = stringResource(R.string.component_kwh)
    val componentKwhOption: String
        @Composable get() = stringResource(R.string.component_kwh_option)
    val componentKwhSingle: String
        @Composable get() = stringResource(R.string.component_kwh_single)
    val componentKwhThree: String
        @Composable get() = stringResource(R.string.component_kwh_three)
    val componentPlc: String
        @Composable get() = stringResource(R.string.component_plc)
    val componentPlcBrand: String
        @Composable get() = stringResource(R.string.component_plc_brand)
    val componentPlcType: String
        @Composable get() = stringResource(R.string.component_plc_type)
    val componentTerminals: String
        @Composable get() = stringResource(R.string.component_terminals)
    val componentTerminalType: String
        @Composable get() = stringResource(R.string.component_terminals_type)
    val componentCustom: String
        @Composable get() = stringResource(R.string.component_custom)
    val componentCustomLabel: String
        @Composable get() = stringResource(R.string.component_custom_label)
    val componentOptionNote: String
        @Composable get() = stringResource(R.string.component_option_note)
    val componentMarkHint: String
        @Composable get() = stringResource(R.string.component_mark)
    val componentSelectionHint: String
        @Composable get() = stringResource(R.string.component_selection_hint)

    @Composable
    fun componentQuantityValue(qty: Int): String =
        stringResource(R.string.component_quantity, qty)

    @Composable
    fun componentAmpsValue(value: Int): String =
        stringResource(R.string.component_value_amps, value)

    @Composable
    fun componentPolesValue(value: Int): String =
        stringResource(R.string.component_value_poles, value)

    @Composable
    fun componentWattsValue(value: Int): String =
        stringResource(R.string.component_value_watts, value)

    @Composable
    fun componentPositionsValue(value: Int): String =
        stringResource(R.string.component_value_positions, value)

    @Composable
    fun componentVoltageValue(value: Int): String =
        stringResource(R.string.component_value_voltage, value)

    @Composable
    fun componentTagValue(value: String): String =
        stringResource(R.string.component_value_tag, value)

    val delete: String
        @Composable get() = stringResource(R.string.action_delete)
    val cancel: String
        @Composable get() = stringResource(R.string.action_cancel)

    val offlineReady: String
        @Composable get() = stringResource(R.string.badge_offline)
    val proFormulas: String
        @Composable get() = stringResource(R.string.badge_formulas)

    val openSettings: String
        @Composable get() = stringResource(R.string.nav_settings_button)
    val settingsThemeDescription: String
        @Composable get() = stringResource(R.string.settings_theme_description)
    val settingsThemeLabel: String
        @Composable get() = stringResource(R.string.settings_theme_label)
    val settingsThemeColorLabel: String
        @Composable get() = stringResource(R.string.settings_theme_color_label)
    val settingsThemeColorDescription: String
        @Composable get() = stringResource(R.string.settings_theme_color_description)
    val languageLabel: String
        @Composable get() = stringResource(R.string.settings_language_label)
    val languageDescription: String
        @Composable get() = stringResource(R.string.settings_language_description)

    val copperResistivity: String
        @Composable get() = stringResource(R.string.reference_copper)
    val pfRange: String
        @Composable get() = stringResource(R.string.reference_pf_range)
    val threePhaseMultiplier: String
        @Composable get() = stringResource(R.string.reference_multiplier)
    val quickConstants: String
        @Composable get() = stringResource(R.string.reference_quick)
    val tipsHeader: String
        @Composable get() = stringResource(R.string.reference_tips)
    val tipOhms: String
        @Composable get() = stringResource(R.string.reference_tip_ohms)
    val tipBreaker: String
        @Composable get() = stringResource(R.string.reference_tip_breaker)
    val tipDrop: String
        @Composable get() = stringResource(R.string.reference_tip_drop)

    val ohmsVoltageField: String
        @Composable get() = stringResource(R.string.field_voltage)
    val ohmsCurrentField: String
        @Composable get() = stringResource(R.string.field_current)
    val resistanceField: String
        @Composable get() = stringResource(R.string.field_resistance)
    val powerField: String
        @Composable get() = stringResource(R.string.field_power)
    val lengthField: String
        @Composable get() = stringResource(R.string.field_length)
    val loadCurrentField: String
        @Composable get() = stringResource(R.string.field_load_current)
    val supplyVoltageField: String
        @Composable get() = stringResource(R.string.field_supply_voltage)

    @Composable
    fun conductorArea(value: Double): String = stringResource(R.string.field_conductor_area, value)
}
