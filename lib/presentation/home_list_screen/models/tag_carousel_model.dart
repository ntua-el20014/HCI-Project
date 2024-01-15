import 'package:anamnesis/presentation/date_picker_bottomsheet/date_picker_bottomsheet.dart';
import 'package:anamnesis/presentation/home_list_screen/widgets/label_widget.dart';
import 'package:anamnesis/presentation/people_picker_bottomsheet/people_picker_bottomsheet.dart';

import 'label_item_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class TagCarousel extends StatefulWidget {
  final List<LabelItemModel> labels;
  final List<LabelItemModel>? selectedLabels;
  final CarouselType carouselType;
  final void Function(LabelItemModel) onLabelTap;

  TagCarousel({
    required this.labels,
    this.selectedLabels,
    required this.carouselType,
    required this.onLabelTap,
  });

  @override
  _TagCarouselState createState() => _TagCarouselState();
}

class _TagCarouselState extends State<TagCarousel> {
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
        itemCount: widget.labels.length,
        itemBuilder: (context, index) {
          LabelItemModel model = widget.labels[index];
          return GestureDetector(
            onTap: () {
              if (widget.carouselType == CarouselType.TagPicker) {
                // Tag Picker behavior
                model.isSelected = !model.isSelected;
                widget.onLabelTap(model);

                // Update the state of TagCarousel directly
                setState(() {});
              } else if (widget.carouselType == CarouselType.FilterEditor) {
                // Filter Editor behavior
                // Implement the filter editor logic or show a dialog, etc.
                // For now, just print the label when tapped
                print('Filter Editor Tapped: ${model.label}');

                if (model.label == 'People') {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        PeoplePickerBottomsheet.builder(context),
                  );
                } else if (model.label == 'Date') {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        DatePickerBottomsheet.builder(context),
                  );
                }
              }
            },
            child: LabelWidget(
              hasShadow: widget.carouselType == CarouselType.TagPicker &&
                  (widget.selectedLabels != null ? model.isSelected : false),
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
