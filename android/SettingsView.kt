package com.powerplan

import androidx.annotation.StringRes
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

/**
 * Jetpack Compose recreation of the SwiftUI `SettingsView` screen.
 *
 * The view exposes state and callbacks for appearance mode, language
 * preference, and accent color to make wiring into your Android Studio
 * project straightforward.
 */
@Composable
fun SettingsView(
    appearanceMode: AppearanceMode,
    onAppearanceModeChange: (AppearanceMode) -> Unit,
    languagePreference: LanguageOption,
    onLanguagePreferenceChange: (LanguageOption) -> Unit,
    themeColor: ThemeColor,
    onThemeColorChange: (ThemeColor) -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = stringResource(id = R.string.nav_settings),
            style = MaterialTheme.typography.headlineSmall
        )

        SettingsSection(title = stringResource(id = R.string.section_appearance)) {
            OptionGroup(
                label = stringResource(id = R.string.settings_theme_label),
                helper = stringResource(id = R.string.settings_theme_description)
            ) {
                AppearanceMode.entries.forEach { mode ->
                    RadioOptionRow(
                        text = stringResource(id = mode.labelRes),
                        selected = mode == appearanceMode,
                        onClick = { onAppearanceModeChange(mode) }
                    )
                }
            }

            Spacer(modifier = Modifier.height(12.dp))

            OptionGroup(
                label = stringResource(id = R.string.settings_theme_color_label),
                helper = stringResource(id = R.string.settings_theme_color_description)
            ) {
                ThemeColor.entries.forEach { color ->
                    RadioOptionRow(
                        text = stringResource(id = color.labelRes),
                        selected = color == themeColor,
                        onClick = { onThemeColorChange(color) },
                        leading = {
                            Box(
                                modifier = Modifier
                                    .size(28.dp)
                                    .clip(CircleShape)
                                    .background(color.preview)
                            )
                        }
                    )
                }
            }
        }

        SettingsSection(title = stringResource(id = R.string.section_language)) {
            OptionGroup(
                label = stringResource(id = R.string.settings_language_label),
                helper = stringResource(id = R.string.settings_language_description)
            ) {
                LanguageOption.entries.forEach { option ->
                    RadioOptionRow(
                        text = stringResource(id = option.labelRes),
                        selected = option == languagePreference,
                        onClick = { onLanguagePreferenceChange(option) }
                    )
                }
            }
        }
    }
}

@Composable
private fun SettingsSection(
    title: String,
    content: @Composable ColumnScope.() -> Unit
) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text(title, style = MaterialTheme.typography.titleMedium)
            content()
        }
    }
}

@Composable
private fun OptionGroup(
    label: String,
    helper: String,
    content: @Composable ColumnScope.() -> Unit
) {
    Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
        Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
            Text(label, style = MaterialTheme.typography.labelLarge)
            Text(
                text = helper,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        content()
    }
}

@Composable
private fun RadioOptionRow(
    text: String,
    selected: Boolean,
    onClick: () -> Unit,
    leading: @Composable (() -> Unit)? = null
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        if (leading != null) {
            leading()
        }

        Column(modifier = Modifier.weight(1f)) {
            Text(text, style = MaterialTheme.typography.bodyLarge)
        }

        RadioButton(selected = selected, onClick = onClick)
    }
}

enum class AppearanceMode(@StringRes val labelRes: Int) {
    SYSTEM(R.string.appearance_system),
    LIGHT(R.string.appearance_light),
    DARK(R.string.appearance_dark)
}

enum class LanguageOption(@StringRes val labelRes: Int) {
    SYSTEM(R.string.language_system),
    ENGLISH(R.string.language_english),
    DUTCH(R.string.language_dutch)
}

enum class ThemeColor(@StringRes val labelRes: Int, val preview: Color) {
    BLUE(R.string.theme_blue, Color(0xFF1E88E5)),
    GREEN(R.string.theme_green, Color(0xFF43A047)),
    ORANGE(R.string.theme_orange, Color(0xFFFB8C00)),
    INDIGO(R.string.theme_indigo, Color(0xFF3949AB)),
    PURPLE(R.string.theme_purple, Color(0xFF8E24AA)),
    PINK(R.string.theme_pink, Color(0xFFD81B60)),
    RED(R.string.theme_red, Color(0xFFE53935))
}

@Preview(showBackground = true)
@Composable
private fun SettingsViewPreview() {
    val appearance = remember { mutableStateOf(AppearanceMode.SYSTEM) }
    val language = remember { mutableStateOf(LanguageOption.ENGLISH) }
    val themeColor = remember { mutableStateOf(ThemeColor.BLUE) }

    SettingsView(
        appearanceMode = appearance.value,
        onAppearanceModeChange = { appearance.value = it },
        languagePreference = language.value,
        onLanguagePreferenceChange = { language.value = it },
        themeColor = themeColor.value,
        onThemeColorChange = { themeColor.value = it }
    )
}
