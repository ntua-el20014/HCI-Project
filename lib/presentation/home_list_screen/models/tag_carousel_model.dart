import 'package:anamnesis/presentation/home_list_screen/widgets/label_widget.dart';

import 'label_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class TagCarousel extends StatelessWidget {
  final List<LabelItemModel> labels;
  final CarouselType carouselType;
  final void Function(LabelItemModel) onLabelTap;

  TagCarousel({
    required this.labels,
    required this.carouselType,
    required this.onLabelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.v,
      padding: EdgeInsets.only(top: 6.v),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 13.h);
        },
        itemCount: labels.length,
        itemBuilder: (context, index) {
          LabelItemModel model = labels[index];
          return GestureDetector(
            onTap: () {
              if (carouselType == CarouselType.TagPicker) {
                // Tag Picker behavior
                model.isSelected = !model.isSelected;
                onLabelTap(model);
              } else if (carouselType == CarouselType.FilterEditor) {
                // Filter Editor behavior
                // Implement the filter editor logic or show a dialog, etc.
                // For now, just print the label when tapped
                print('Filter Editor Tapped: ${model.label}');
              }
            },
            child: LabelWidget(
              hasShadow:
                  carouselType == CarouselType.TagPicker && model.isSelected,
              imagePath: model.iconPath,
              labelText: model.label,
              value: model.value,
            ),
          );
        },
      ),
    );
  }
}
