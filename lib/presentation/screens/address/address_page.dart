import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/address_entity.dart';
import 'package:yumzi/data/models/enums/address_type.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<AddressEntity> addresses = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    final addressProvider = Provider.of<AddressProvider>(
      context,
      listen: false,
    );
    final fetchedAddresses = await addressProvider.fetchAddresses() ?? [];
    setState(() {
      addresses = fetchedAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AddressProvider>(
          builder: (context, addressProvider, child) {
            if (addressProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
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
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  "My Address",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            addressCards(context, addressProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16,
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRoutes.addAddress.path),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          MediaQuery.of(context).size.width,
                          56,
                        ),
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Add New Address'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget addressCards(BuildContext context, AddressProvider addressProvider) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          addressCard(context, addressProvider.addresses[index]),
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: addressProvider.addresses.length,
    );
  }

  Widget addressCard(BuildContext context, AddressEntity address) {
    final addressType = address.addressType;
    Icon icon;

    if (addressType == AddressType.home) {
      icon = Icon(Icons.home_outlined, color: Colors.blue, size: 24);
    } else if (addressType == AddressType.work) {
      icon = Icon(Icons.work_outline, color: Colors.orange, size: 24);
    } else {
      icon = Icon(Icons.location_on_outlined, color: Colors.grey, size: 24);
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(16),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(16),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        border: address.isDefault
            ? Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(128),
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: icon,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Edit address action
                            debugPrint("Edit address tapped");
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            // Delete address action
                            debugPrint("Delete address tapped");
                          },
                          child: Icon(
                            Icons.delete_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${address.addressLine1}, ${address.addressLine2 ?? ''} ${address.neighborhood}, ${address.district}/${address.province}, ${address.country}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.color!.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
