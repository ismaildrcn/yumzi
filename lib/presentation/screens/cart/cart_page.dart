import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/cart_entity.dart';
import 'package:yumzi/data/models/entity/cart_item_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';
import 'package:yumzi/presentation/providers/cart_provider.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/message_box.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController addressController = TextEditingController();

  CartEntity? cart;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final addressProvider = Provider.of<AddressProvider>(
      context,
      listen: false,
    );
    final restaurantProvider = Provider.of<RestaurantProviders>(
      context,
      listen: false,
    );
    final fetchedCartItems = await cartProvider.fetchCart();
    final defaultAddress = await addressProvider.fetchDefaultAddress();
    if (defaultAddress != null && mounted) {
      addressController.text =
          "${defaultAddress.title} (${defaultAddress.neighborhood})";
    }

    if (fetchedCartItems != null && mounted) {
      setState(() {
        cart = fetchedCartItems;
      });
      if (cart!.cartItems.isNotEmpty) {
        for (var item in cart!.cartItems) {
          final menuItemDetails = await restaurantProvider.fetchMenuItemDetails(
            item.menuItemId,
          );
          if (menuItemDetails != null && mounted) {
            setState(() {
              item.menuItemDetails = menuItemDetails;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTopBar(context),
                      const SizedBox(height: 24),
                      buildCart(context),
                    ],
                  ),
                ),
              ),
            ),
            buildPlaceOrder(context),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceOrder(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: HexColor("#FFFFFF"),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DELIVERY ADDRESS",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: HexColor("#F0F5FA"),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withAlpha(128),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              enabled: false,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontSize: 18)),
                Text(
                  "${cart?.totalAmount ?? 0} TL",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 45),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('PLACE ORDER'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyCart(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.secondary.withAlpha(200),
            ),
            const SizedBox(height: 16),
            Text(
              "Your cart is empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Start shopping now",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.home.path),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(0, 45),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Start Shopping"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCart(BuildContext context) {
    return cart != null && cart!.cartItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cart!.cartItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return buildCartItem(context, cart!.cartItems[index]);
              },
            ),
          )
        : buildEmptyCart(context);
  }

  Widget buildCartItem(BuildContext context, CartItemEntity cartItem) {
    return SizedBox(
      height: 115,
      child: Row(
        children: [
          Container(
            width: 130,
            height: 115,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    cartItem.menuItemDetails?.imageUrl ??
                        "assets/images/placeholder.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cartItem.menuItemDetails?.name ?? "N/A",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Consumer<CartProvider>(
                        builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () => {
                              provider.removeFromCart(cartItem.menuItemId).then(
                                (success) {
                                  if (!context.mounted) return;
                                  if (success) {
                                    _loadData();
                                    MessageBox.info(
                                      context,
                                      'Item removed from cart',
                                    );
                                  } else {
                                    MessageBox.error(
                                      context,
                                      'Failed to remove item from cart',
                                    );
                                  }
                                },
                              ),
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${cartItem.menuItemDetails?.price ?? 0} TL",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Consumer<CartProvider>(
                        builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () {
                              changeQuantity(
                                context,
                                provider,
                                cartItem,
                                false,
                              );
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(150),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "${cartItem.quantity}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Consumer<CartProvider>(
                        builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () {
                              changeQuantity(context, provider, cartItem, true);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(150),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeQuantity(
    BuildContext context,
    CartProvider provider,
    CartItemEntity cartItem,
    bool increment,
  ) {
    int newQuantity = increment ? cartItem.quantity + 1 : cartItem.quantity - 1;
    if (newQuantity < 1) return; // Prevent quantity from going below 1

    provider
        .updateCartItemQuantity(
          menuItemId: cartItem.menuItemId,
          newQuantity: newQuantity,
        )
        .then((success) {
          if (!context.mounted) return;
          if (success) {
            _loadData();
          } else {
            MessageBox.error(context, 'Failed to update cart');
          }
        });
  }

  Padding buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(150),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () => {Navigator.pop(context)},
              iconSize: 28,
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            "Cart",
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
