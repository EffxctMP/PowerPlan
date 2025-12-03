package com.powerplan

import androidx.compose.runtime.Composable
import com.powerplan.calculators.OhmsLawCalculatorView
import com.powerplan.calculators.PowerCalculatorView
import com.powerplan.calculators.VoltageDropView
import com.powerplan.calculators.WattCalculatorView
import com.powerplan.components.ComponentCategory
import com.powerplan.components.ComponentItem
import com.powerplan.components.ComponentRow
import com.powerplan.components.ComponentDraftForm

/**
 * Mirrors the old Swift `ImportsFile` helper for Android Studio.
 *
 * Keeping references to the primary composables in one place makes it
 * easier to drop this module into a new project without battling missing
 * symbol errors or overzealous dead-code stripping during import.
 */
@Composable
@Suppress("UNUSED_EXPRESSION", "UNUSED_PARAMETER")
fun ImportsFile() {
    // Calculator screens
    if (false) {
        OhmsLawCalculatorView()
        WattCalculatorView()
        PowerCalculatorView()
        VoltageDropView()

        // Component builder widgets
        ComponentDraftForm(onAdd = {})
        ComponentRow(
            item = ComponentItem(
                name = "Sample Component",
                tag = "T1",
                category = ComponentCategory.BREAKER,
                primary = "63A",
                secondary = "3P",
                details = "Type C",
                quantity = 1,
                acquired = false
            ),
            onToggleSelection = {},
            onToggleAcquired = {}
        )
    }
}
