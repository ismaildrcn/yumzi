enum AppRoutes {
  home("/"),
  onboarding("/onboarding"),
  login("/login"),
  register("/register"),
  forgotPassword("/forgot-password"),
  verification("/verification"),
  user("/user"),
  userDetail("/user-detail"),
  userEdit("/user-edit"),
  address("/address"),
  addAddress("/add-address"),
  restaurant("/restaurant"),
  menuItem("/menu-item"),
  cart("/cart");

  final String path;
  const AppRoutes(this.path);
}
