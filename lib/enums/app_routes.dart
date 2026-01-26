enum AppRoutes {
  home("/"),
  onboarding("/onboarding"),
  login("/login"),
  register("/register");

  final String path;
  const AppRoutes(this.path);
}
