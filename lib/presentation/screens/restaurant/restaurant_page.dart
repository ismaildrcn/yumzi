import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class RestaurantPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantPage({super.key, required this.restaurantId});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  RestaurantEntity? restaurant;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadData() async {
    final provider = Provider.of<RestaurantProviders>(context, listen: false);
    final restaurantDetails = await provider.fetchRestaurantDetails(
      widget.restaurantId,
    );

    if (restaurantDetails != null && mounted) {
      setState(() {
        restaurant = restaurantDetails;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: restaurant == null
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 320,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(restaurant!.coverImageUrl!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withAlpha(150),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: IconButton(
                                        iconSize: 38,
                                        icon: Icon(Icons.chevron_left_sharp),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withAlpha(150),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: IconButton(
                                        iconSize: 28,
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_border),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      restaurant?.category != null
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withAlpha(200),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                restaurant?.category?.name ??
                                                    "N/A",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      SizedBox(height: 4),
                                      restaurant?.cuisine != null
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withAlpha(200),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                restaurant?.cuisine?.name ??
                                                    "N/A",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 26),
                            RestaurantMetaInfo(
                              rating: restaurant?.rating ?? 0,
                              deliveryFee: restaurant?.deliveryFee ?? 0,
                              deliveryTime: restaurant?.deliveryTimeRange ?? "",
                            ),
                            SizedBox(height: 16),
                            Text(
                              restaurant?.name ?? "N/A",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              restaurant?.description ?? "N/A",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(128),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ButtonsTabBar(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withAlpha(200),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          unselectedDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 1.5,
                            ),
                          ),
                          tabs: [
                            Tab(text: "Menu"),
                            Tab(text: "Drinks"),
                            Tab(text: "Desserts"),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16)),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TabBarView(
                    clipBehavior: Clip.none,
                    children: [
                      GridView.builder(
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.only(bottom: 24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 155 / 150,
                        ),
                        itemBuilder: (context, index) {
                          return menuItemCard();
                        },
                        itemCount: 20,
                      ),
                      ListView(
                        padding: EdgeInsets.only(bottom: 16),
                        children: [
                          Text('Drinks Content'),
                          // Drinks buraya eklenecek
                        ],
                      ),
                      ListView(
                        padding: EdgeInsets.only(bottom: 16),
                        children: [
                          Text('Desserts Content'),
                          // Desserts buraya eklenecek
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container menuItemCard() {
    return Container(
      width: 155,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.menuItem.path);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 114,
                  height: 75,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/pizza-1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Menü öğeleri buraya eklenecek
              SizedBox(height: 12),
              Text(
                'Pepperoni Pizza',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$12.99',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
