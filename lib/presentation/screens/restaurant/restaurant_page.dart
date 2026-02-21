import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/presentation/providers/restaurant_providers.dart';
import 'package:yumzi/presentation/widgets/menu_item_card.dart';
import 'package:yumzi/presentation/widgets/restaurant_meta_info.dart';

class RestaurantPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantPage({super.key, required this.restaurantId});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  RestaurantEntity? restaurant;
  List<MenuItemEntity>? menuItems;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _onTabChanged() async {
    if (_tabController != null && restaurant != null) {
      final provider = Provider.of<RestaurantProviders>(context, listen: false);
      final currentIndex = _tabController!.index;
      final currentCategory = restaurant!.menuCategories![currentIndex];

      final fetchedMenuItems = await provider.fetchMenuItemsWithCategory(
        widget.restaurantId,
        currentCategory.uniqueId!,
      );
      setState(() {
        menuItems = fetchedMenuItems;
      });
    }
  }

  void _loadData() async {
    final provider = Provider.of<RestaurantProviders>(context, listen: false);
    final restaurantDetails = await provider.fetchRestaurantDetails(
      widget.restaurantId,
    );

    if (restaurantDetails != null && mounted) {
      // TabController'ı restaurant yüklendikten sonra oluştur
      _tabController = TabController(
        length: restaurantDetails.menuCategories!.length,
        vsync: this,
      );

      _tabController!.addListener(_onTabChanged);

      // İlk kategorinin menü itemlarını çek
      List<MenuItemEntity>? firstCategoryItems = [];
      if (restaurantDetails.menuCategories!.isNotEmpty) {
        firstCategoryItems = await provider.fetchMenuItemsWithCategory(
          widget.restaurantId,
          restaurantDetails.menuCategories!.first.uniqueId!,
        );
      }

      setState(() {
        restaurant = restaurantDetails;
        menuItems = firstCategoryItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: restaurant == null || _tabController == null
          ? Center(child: CircularProgressIndicator())
          : NestedScrollView(
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
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary.withAlpha(150),
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
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary.withAlpha(150),
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
                    child: menuItems != null && menuItems!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ButtonsTabBar(
                              controller: _tabController,
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  width: 1.5,
                                ),
                              ),
                              tabs: [
                                for (var category
                                    in restaurant!.menuCategories!)
                                  Tab(text: category.name),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: menuItems == null
                    ? Center(child: CircularProgressIndicator())
                    : menuItems!.isEmpty
                    ? Center(child: Text("No menu items available"))
                    : GridView.builder(
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.only(bottom: 24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 155 / 150,
                        ),
                        itemBuilder: (context, index) {
                          return MenuItemCard(menuItem: menuItems![index]);
                        },
                        itemCount: menuItems!.length,
                      ),
              ),
            ),
    );
  }
}
