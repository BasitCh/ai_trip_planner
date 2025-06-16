
class SettingsState {
  final bool isPublicProfile;
  final bool notificationsEnabled;
  final bool emailsEnabled;
  final double tripRate;

  SettingsState({
    this.isPublicProfile = false,
    this.notificationsEnabled = true,
    this.emailsEnabled = false,
    this.tripRate = 200.0,
  });

  SettingsState copyWith({
    bool? isPublicProfile,
    bool? notificationsEnabled,
    bool? emailsEnabled,
    double? tripRate,
  }) {
    return SettingsState(
      isPublicProfile: isPublicProfile ?? this.isPublicProfile,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailsEnabled: emailsEnabled ?? this.emailsEnabled,
      tripRate: tripRate ?? this.tripRate,
    );
  }
}