package com.powerplan.util

import java.math.BigDecimal
import java.math.RoundingMode

/**
 * Utility extensions that mirror the rounding helpers used in the iOS codebase.
 * These can be dropped into an Android Studio project to keep number formatting
 * behavior consistent across platforms.
 */

/**
 * Round the [Double] to a fixed number of decimal [places].
 *
 * This replicates the Swift `rounded(toPlaces:)` helper. It uses
 * [RoundingMode.HALF_UP] to match Double.rounded() on positive numbers.
 */
fun Double.roundedToPlaces(places: Int): Double {
    require(places >= 0) { "Decimal places must be non-negative" }
    return BigDecimal(this)
        .setScale(places, RoundingMode.HALF_UP)
        .toDouble()
}

/**
 * Format a [Double] with a unit label, rounding to the provided [places].
 *
 * Example: `5.678.formatWithUnit("V", 2)` returns `"5.68 V"`.
 */
fun Double.formatWithUnit(unit: String, places: Int = 3): String {
    return "${this.roundedToPlaces(places)} $unit"
}
