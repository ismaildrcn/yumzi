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
  deliveryLocation("/delivery-location"),
  saveAddress("/save-address"),
  restaurant("/restaurant"),
  restaurantList("/restaurant-list"),
  restaurantCategories("/restaurant-categories"),
  menuItem("/menu-item"),
  cart("/cart"),
  search("/search");

  final String path;
  const AppRoutes(this.path);
}
