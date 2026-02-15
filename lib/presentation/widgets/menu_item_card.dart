import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/enums/app_routes.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItemEntity menuItem;
  const MenuItemCard({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
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
                    image: menuItem.imageUrl != null
                        ? DecorationImage(
                            image: AssetImage(menuItem.imageUrl!),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                ),
              ),
              // Menü öğeleri buraya eklenecek
              SizedBox(height: 12),
              Text(
                menuItem.name ?? 'N/A',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${menuItem.price?.toStringAsFixed(2) ?? 'N/A'} TL',
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
