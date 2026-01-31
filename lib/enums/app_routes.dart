enum AppRoutes {
  home("/"),
  onboarding("/onboarding"),
  login("/login"),
  register("/register"),
  user("/user"),
  userDetail("/user-detail"),
  forgotPassword("/forgot-password"),
  verification("/verification"),
  restaurant("/restaurant"),
  menuItem("/menu-item"),
  cart("/cart");

  final String path;
  const AppRoutes(this.path);
}
