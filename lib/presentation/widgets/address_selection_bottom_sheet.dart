import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';

class AddressSelectionBottomSheet extends StatefulWidget {
  final String currentAddressTitle;
  final Function(String) onAddressSelected;

  const AddressSelectionBottomSheet({
    super.key,
    required this.currentAddressTitle,
    required this.onAddressSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required String currentAddressTitle,
    required Function(String) onAddressSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => AddressSelectionBottomSheet(
        currentAddressTitle: currentAddressTitle,
        onAddressSelected: onAddressSelected,
      ),
    );
  }

  @override
  State<AddressSelectionBottomSheet> createState() =>
      _AddressSelectionBottomSheetState();
}

class _AddressSelectionBottomSheetState
    extends State<AddressSelectionBottomSheet> {
  late String _selectedAddressTitle;

  @override
  void initState() {
    super.initState();
    _selectedAddressTitle = widget.currentAddressTitle;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Select an Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<AddressProvider>(
                  context,
                  listen: false,
                ).fetchAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading addresses"));
                  } else if (!snapshot.hasData ||
                      (snapshot.data as List).isEmpty) {
                    return const Center(child: Text("No addresses found"));
                  }

                  final addresses = snapshot.data as List<dynamic>;
                  return ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    itemCount: addresses.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          address.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "${address.addressLine1}, ${address.district}/${address.province}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: _selectedAddressTitle == address.title
                            ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        onTap: () {
                          address.isDefault = true;
                          Provider.of<AddressProvider>(
                            context,
                            listen: false,
                          ).updateAddress(address).then((status) {
                            if (status == 200 && mounted) {
                              setState(() {
                                _selectedAddressTitle = address.title;
                              });
                              widget.onAddressSelected(address.title);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
