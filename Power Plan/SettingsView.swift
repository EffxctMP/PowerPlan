import SwiftUI

struct SettingsView: View {
    @Binding var appearanceMode: AppearanceMode
    @Binding var languagePreference: LanguageOption
    @Binding var themeColor: ThemeColor

    var body: some View {
        Form {
            Section(header: Text(L10n.appearance)) {
                NavigationLink(destination:
                    AppearanceSettingsView(appearanceMode: $appearanceMode,
                                           themeColor: $themeColor)
                ) {
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
            Section(header: Text(L10n.appearance)) {
                Picker(L10n.settingsThemeLabel, selection: $appearanceMode) {
                    ForEach(AppearanceMode.allCases) { m in
                        Text(m.displayName).tag(m)
                    }
                }
                .pickerStyle(.segmented)

                Text(L10n.settingsThemeDescription)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Picker(L10n.settingsThemeColorLabel, selection: $themeColor) {
                    ForEach(ThemeColor.allCases) { theme in
                        HStack {
                            Capsule()
                                .fill(theme.color.gradient)
                                .frame(width: 40, height: 18)
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
        .navigationTitle(L10n.appearance)
    }
}
