enum AppRoutes {
  home("/"),
  onboarding("/onboarding"),
  login("/login"),
  register("/register"),
  forgotPassword("/forgot-password"),
  verification("/verification");

  final String path;
  const AppRoutes(this.path);
}
