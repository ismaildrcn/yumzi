import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:yumzi/enums/app_routes.dart';
import 'package:yumzi/presentation/screens/address/map_widget.dart';

class DeliveryLocationPage extends StatefulWidget {
  const DeliveryLocationPage({super.key});

  @override
  State<DeliveryLocationPage> createState() => _DeliveryLocationPageState();
}

class _DeliveryLocationPageState extends State<DeliveryLocationPage> {
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                            "Select Delivery Location",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.65,
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
                      SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(200),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Make sure you select the building entrance correctly on the map. Incorrect building entrance selection may result in delivery issues.",
                              ),
                            ),
                          ],
                        ),
                      ),
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
                onPressed: () => {
                  if (selectedPoint != null)
                    {
                      context.push(
                        AppRoutes.addAddress.path,
                        extra: selectedPoint,
                      ),
                    },
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 56),
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Use This Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
