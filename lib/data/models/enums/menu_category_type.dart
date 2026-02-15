enum MenuCategoryType {
  standard("STANDARD"),
  promotion("PROMOTION"),
  combo("COMBO"),
  chefSpecial("CHEF_SPECIAL"),
  seasonal("SEASONAL"),
  kids("KIDS"),
  drinks("DRINKS"),
  dessert("DESSERT"),
  appetizer("APPETIZER"),
  breakfast("BREAKFAST"),
  lunch("LUNCH"),
  dinner("DINNER");

  final String value;

  const MenuCategoryType(this.value);
}
