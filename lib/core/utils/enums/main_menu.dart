/// [MainMenu] is an enum that contains the different main menu items that can be accessed.<br>
///
/// [home] is the home menu item. <br>
/// [alertCreate] is the alert create menu item. <br>
/// [alertList] is the alert list menu item. <br>
/// [feedback] is the feedback menu item. <br>
/// [settings] is the settings menu item. <br>
/// [subscription] is the subscription menu item. <br>
/// [privacyPolicy] is the privacy policy menu item. <br>
/// [invite] is the invite menu item. <br>
/// [version] is the version menu item. <br>
///
/// All things are in navigation bar menu
enum MainMenu {
  home('home', 'Home'),
  // community('citizen', 'Citizen'),
  // police('police', 'Police'),
  // fireService('fire_service', 'Fire Service'),
  // ambulance('ambulance', 'Ambulance'),
  alertCreate('create', 'Alert Create'),
  alertList('alert', 'Alert'),
  feedback('feedback', 'Feedback'),
  settings('settings', 'Settings'),
  subscription('subscription', 'Subscription'),
  privacyPolicy('privacy_policy', 'Privacy Policy'),
  invite('invite', 'Invite'),
  version('version', 'Version');

  final String value;
  final String title;

  const MainMenu(this.value, this.title);
}
