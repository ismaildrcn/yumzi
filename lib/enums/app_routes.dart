enum AppRoutes {
  home("/"),
  onboarding("/onboarding"),
  login("/login"),
  register("/register"),
  forgotPassword("/forgot-password"),
  verification("/verification"),
  restaurant("/restaurant"),
  menuItem("/menu-item"),
  cart("/cart");

  final String path;
  const AppRoutes(this.path);
}
