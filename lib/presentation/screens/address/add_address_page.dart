import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yumzi/data/models/entity/address_entity.dart';
import 'package:yumzi/data/models/enums/address_type.dart';
import 'package:yumzi/presentation/providers/address_provider.dart';
import 'package:yumzi/presentation/screens/address/map_widget.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressTypeController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final MapController mapController = MapController();
  LatLng? selectedPoint;
  AddressType selectedAddressType = AddressType.home;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(context, listen: false).fetchProvinces();
    });
  }

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    _neighborhoodController.dispose();
    _titleController.dispose();
    _addressTypeController.dispose();
    _recipientNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AddressProvider>(
          builder: (context, addressProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: MapWidget(
                        initialPosition: LatLng(36.894267, 30.697291),
                        onLocationSelected: (LatLng location) {
                          setState(() {
                            selectedPoint = location;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addressInfoWidgets(context, addressProvider),

                            const SizedBox(height: 32),

                            contactInfoWidgets(context, addressProvider),
                            const SizedBox(height: 32),

                            Consumer<AddressProvider>(
                              builder: (context, addressProvider, child) {
                                return ElevatedButton(
                                  onPressed: () =>
                                      onSaveButtonTap(addressProvider),
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
                                  child: const Text('Save'),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget contactInfoWidgets(
    BuildContext context,
    AddressProvider addressProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Information",
          style: TextStyle(
            fontSize: 17,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipient Name',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _recipientNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Recipient Name is required';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withAlpha(32),
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
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneNumberController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "+90 5XX XXX XX XX",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withAlpha(32),
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget addressInfoWidgets(
    BuildContext context,
    AddressProvider addressProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address Information",
          style: TextStyle(
            fontSize: 17,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address Line 1',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressLine1Controller,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Address Line 1 is required';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withAlpha(32),
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
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Province',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Province is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary.withAlpha(32),
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
                    ),
                    borderRadius: BorderRadius.circular(12),
                    menuMaxHeight: 250,
                    items: addressProvider.provinces.map((province) {
                      return DropdownMenuItem(
                        value: province,
                        child: Text(province ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) => onProvinceTap(addressProvider, value),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'District',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'District is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary.withAlpha(32),
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
                    ),
                    borderRadius: BorderRadius.circular(12),
                    menuMaxHeight: 250,
                    items: addressProvider.districts.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _districtController.text = value ?? '';
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Neighborhood',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _neighborhoodController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Neighborhood is required';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withAlpha(32),
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
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withAlpha(32),
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
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedAddressType = AddressType.home;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 45),
                      backgroundColor: selectedAddressType == AddressType.home
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Home'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedAddressType = AddressType.work;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 45),
                      backgroundColor: selectedAddressType == AddressType.work
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Work'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedAddressType = AddressType.other;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 45),
                      backgroundColor: selectedAddressType == AddressType.other
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Other'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void onSaveButtonTap(AddressProvider addressProvider) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    AddressEntity newAddress = AddressEntity(
      title: _titleController.text.trim(),
      addressLine1: _addressLine1Controller.text.trim(),
      neighborhood: _neighborhoodController.text.trim(),
      district: _districtController.text.trim(),
      province: _provinceController.text.trim(),
      country: "Turkey",
      recipientName: _recipientNameController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      addressType: selectedAddressType,
      latitude: selectedPoint?.latitude.toString() ?? '',
      longitude: selectedPoint?.longitude.toString() ?? '',
      isDefault: false,
    );

    addressProvider.saveAddress(newAddress).then((status) {
      if (status == 200) {
        if (!mounted) return;
        successMessage('Address saved successfully.');
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        errorMessage(addressProvider.errorMessage ?? 'Failed to save address.');
      }
    });
  }

  void onProvinceTap(AddressProvider addressProvider, String? value) {
    _provinceController.text = value ?? '';
    addressProvider.fetchDistricts(value!);
  }

  void errorMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

  void successMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  }
}
