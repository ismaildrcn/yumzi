import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/recent_search_entity.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/search_provider.dart';
import 'package:yumzi/presentation/widgets/auto_complete_controller.dart';
import 'package:yumzi/utils/debouncer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  AutocompleteController searchController = AutocompleteController();
  Debouncer debouncer = Debouncer(milliseconds: 200);
  FocusNode searchFocusNode = FocusNode();
  List<RecentSearchEntity> _recentSearches = [];

  List<RecentSearchEntity> get recentSearches => _recentSearches;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
      _loadData();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  void _loadData() async {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final fetchedRecentSearches = await searchProvider.fetchRecentSearches();
    setState(() {
      _recentSearches = fetchedRecentSearches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondary.withAlpha(150),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            iconSize: 28,
                            icon: Icon(Icons.chevron_left_sharp),
                            onPressed: () {
                              context.push(AppRoutes.home.path);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Text("Search", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withAlpha(150),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        onPressed: () => {
                          // TODO: Implement Cart
                        },
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      autofocus: true,
                      focusNode: searchFocusNode,
                      onChanged: (value) async => debouncer.run(
                        () => onSearchChanged(value, searchProvider),
                      ),
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search dishes, restaurants',
                        // prefixIcon: Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            debugPrint(
                              "Search submitted: ${searchController.text}",
                            );
                          },
                          child: Icon(
                            Icons.search,
                            color: searchController.text.length > 2
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              buildRecentSearch(),
              const SizedBox(height: 24),
              buildSuggestedRestaurants(),
              const SizedBox(height: 24),
              buildPopularDishes(),
            ],
          ),
        ),
      ),
    );
  }

  void onSearchChanged(String keyword, SearchProvider provider) async {
    if (keyword.isEmpty || keyword.length < 3) {
      searchController.suggestion = "";
      return;
    }
    RecentSearchEntity? result = await provider.autoComplete(keyword);
    debugPrint("Auto-complete result: ${result?.keyword}");
    searchController.suggestion = result?.keyword ?? "";
  }

  Widget buildPopularDishes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Popular Dishes", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.fastfood,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                ),
                title: Text("Dish ${index + 1}"),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("4.5"),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 2),
            itemCount: 4,
          ),
        ],
      ),
    );
  }

  Widget buildSuggestedRestaurants() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Suggested Restaurants", style: TextStyle(fontSize: 20)),

          SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                ),
                title: Text("Restaurant ${index + 1}"),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("4.7"),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 2),
            itemCount: 4,
          ),
        ],
      ),
    );
  }

  Widget buildRecentSearch() {
    return recentSearches.isEmpty
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Recent Searches", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // TODO: Implement search action for recent search item
                        },
                        child: Chip(
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          label: Text(recentSearches[index].keyword!),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                  ),
                ),
              ),
            ],
          );
  }
}
