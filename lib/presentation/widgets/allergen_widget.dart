import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/utils/yumzi_app_icons.dart';

class AllergenWidget extends StatelessWidget {
  final Allergens allergens;
  const AllergenWidget({super.key, required this.allergens});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Allergens", style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        SizedBox(
          height: 35, // ListView'ın yüksekliğini sınırlandırdık
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (allergens.eggs == true) buildAllergen(context, Icons.egg),
              if (allergens.gluten == true)
                buildAllergen(context, YumziAllergenIcons.gluten),
              if (allergens.soy == true)
                buildAllergen(context, YumziAllergenIcons.soy_bean),
              if (allergens.peanuts == true)
                buildAllergen(context, YumziAllergenIcons.nuts),
              if (allergens.treeNuts == true)
                buildAllergen(context, YumziAllergenIcons.cashew),
              if (allergens.dairy == true)
                buildAllergen(context, YumziAllergenIcons.milk),
              if (allergens.fish == true)
                buildAllergen(context, YumziAllergenIcons.fish),
              if (allergens.shellfish == true)
                buildAllergen(context, YumziAllergenIcons.abalone),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAllergen(BuildContext context, IconData icon) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.only(
        right: 10,
      ), // İkonlar arasına ufak boşluk ekledik
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(32),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
    );
  }
}
