package com.powerplan.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.outlined.RadioButtonUnchecked
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp

/**
 * Jetpack Compose port of the SwiftUI `ComponentRow`.
 *
 * Drop this into an Android Studio project to render a component list row that
 * mirrors the iOS experience, including acquisition toggling and multi-select
 * support. The caller owns the state mutation by reacting to the callbacks.
 */
@Composable
fun ComponentRow(
    item: ComponentItem,
    modifier: Modifier = Modifier,
    tint: Color = MaterialTheme.colorScheme.primary,
    isSelecting: Boolean = false,
    isSelected: Boolean = false,
    onToggleSelection: () -> Unit = {},
    onToggleAcquired: (ComponentItem) -> Unit = {}
) {
    val iconTint = leadingTint(isSelecting, isSelected, item.acquired, tint)
    Row(
        modifier = modifier
            .fillMaxWidth()
            .clickable {
                if (isSelecting) {
                    onToggleSelection()
                } else {
                    onToggleAcquired(item.copy(acquired = !item.acquired))
                }
            }
            .padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Icon(
            imageVector = leadingIcon(isSelecting, isSelected, item.acquired),
            contentDescription = null,
            tint = iconTint,
            modifier = Modifier.size(if (isSelecting) 28.dp else 22.dp)
        )

        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(
                text = item.name,
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onSurface,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )
            val detailLine = detailLine(item)
            if (detailLine.isNotEmpty()) {
                Text(
                    text = detailLine,
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    maxLines = 2,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }

        Spacer(modifier = Modifier.weight(1f))

        Text(
            text = "×${item.quantity}",
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
        Spacer(modifier = Modifier.width(4.dp))
    }
}

private fun leadingIcon(
    isSelecting: Boolean,
    isSelected: Boolean,
    acquired: Boolean
) = when {
    isSelecting && isSelected -> Icons.Filled.CheckCircle
    isSelecting -> Icons.Outlined.RadioButtonUnchecked
    acquired -> Icons.Filled.CheckCircle
    else -> Icons.Outlined.RadioButtonUnchecked
}

private fun leadingTint(
    isSelecting: Boolean,
    isSelected: Boolean,
    acquired: Boolean,
    tint: Color
): Color {
    if (isSelecting) return if (isSelected) tint else MaterialTheme.colorScheme.onSurfaceVariant
    return if (acquired) tint else MaterialTheme.colorScheme.onSurfaceVariant
}

private fun detailLine(item: ComponentItem): String {
    return listOfNotNull(
        item.primary.takeIf { it.isNotBlank() },
        item.secondary?.takeIf { it.isNotBlank() },
        item.tag?.takeIf { it.isNotBlank() },
        item.details.takeIf { it.isNotBlank() }
    ).joinToString(" · ")
}
