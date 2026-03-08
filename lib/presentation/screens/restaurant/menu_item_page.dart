import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/cart_provider.dart';
import 'package:yumzi/presentation/providers/favorites_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/allergen_widget.dart';
import 'package:yumzi/presentation/widgets/message_box.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class MenuItemPage extends StatefulWidget {
  final String menuItemId;
  const MenuItemPage({super.key, required this.menuItemId});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  int _quantity = 1;
  int cartItemCount = 0;
  bool isFavorite = false;
  MenuItemEntity? menuItem;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    final restaurantProvider = Provider.of<RestaurantProviders>(
      context,
      listen: false,
    );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final fetchedMenuItem = await restaurantProvider.fetchMenuItemDetails(
      widget.menuItemId,
    );
    if (fetchedMenuItem != null && mounted) {
      setState(() {
        menuItem = fetchedMenuItem;
        isFavorite = menuItem!.favorite == true;
      });
    }

    final cart = await cartProvider.fetchCart();
    if (cart != null && mounted) {
      cartItemCount = cart.cartItems.fold(
        0,
        (sum, item) => sum + item.quantity,
      );
    }

    _updateCartItemCount(cartProvider, 0);
  }

  void _changeQuantity(int delta) {
    setState(() {
      _quantity += delta;
      if (_quantity < 1) _quantity = 1;
    });
  }

  void _updateCartItemCount(CartProvider cartProvider, int quantity) {
    final cart = cartProvider.cartItems;
    setState(() {
      cartItemCount =
          cart.fold(0, (sum, item) => sum + item.quantity) + quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = menuItem;
    if (currentItem == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTopBar(context),
                      SizedBox(height: 24),
                      buildItemImageContainer(currentItem, context),

                      SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(32),
                          ),
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.secondary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(16),
                              blurRadius: 12,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.restaurant),
                            SizedBox(width: 12),
                            Text(
                              currentItem.restaurant?.name ?? "N/A",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentItem.name ?? "N/A",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.05,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            currentItem.description ?? "N/A",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(128),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (currentItem.restaurant != null)
                            RestaurantMetaInfo(
                              restaurant: currentItem.restaurant!,
                            ),
                        ],
                      ),

                      SizedBox(height: 24),
                      AllergenWidget(allergens: currentItem.allergens!),
                    ],
                  ),
                ),
              ),

              buildAddToCart(currentItem, context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildAddToCart(MenuItemEntity currentItem, BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: HexColor("F0F5FA"),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(24),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentItem.price != null
                      ? "${currentItem.price} ${currentItem.currency?.symbol ?? ''}"
                      : "N/A",
                  style: TextStyle(fontSize: 28),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => _changeQuantity(-1),
                        iconSize: 20,
                        icon: Icon(Icons.remove, color: Colors.white60),
                      ),
                      SizedBox(width: 8),
                      Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _changeQuantity(1),
                        iconSize: 20,
                        icon: Icon(Icons.add, color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ElevatedButton(
                  onPressed: () => _addToCart(context, cartProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      SizedBox(width: 8),
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildItemImageContainer(
    MenuItemEntity currentItem,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(currentItem.imageUrl ?? ''),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: GestureDetector(
            onTap: () => onTapFavorite(
              context,
              Provider.of<FavoritesProvider>(context, listen: false),
            ),
            child: Container(
              width: 38,
              height: 38,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildTopBar(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            onPressed: () => {Navigator.pop(context)},
            iconSize: 28,
            icon: Icon(Icons.keyboard_arrow_left),
          ),
        ),
        SizedBox(width: 16),
        Text("Details", style: TextStyle(fontSize: 17)),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            onPressed: () => context.push(AppRoutes.cart.path),
            icon: cartItemCount > 0
                ? Badge.count(
                    count: cartItemCount,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha(200),
                    child: Icon(Icons.shopping_bag_outlined),
                  )
                : Icon(Icons.shopping_bag_outlined),
          ),
        ),
      ],
    );
  }

  void _addToCart(BuildContext context, CartProvider cartProvider) async {
    final currentItem = menuItem;
    if (currentItem == null) return;

    final success = await cartProvider.addToCart(
      menuItemId: currentItem.uniqueId ?? '',
      quantity: _quantity,
    );
    if (!context.mounted) return;
    if (success) {
      _updateCartItemCount(cartProvider, _quantity);
    } else {
      MessageBox.error(context, 'Failed to add item to cart');
    }
  }

  void onTapFavorite(
    BuildContext context,
    FavoritesProvider favoritesProvider,
  ) {
    final currentItem = menuItem;
    if (currentItem?.uniqueId == null) return;

    favoritesProvider
        .toggleFavoriteMenuItem(currentItem!.uniqueId!, !isFavorite)
        .then((fav) {
          setState(() {
            if (fav != null) {
              isFavorite = fav;
            }
          });
        });
  }
}
