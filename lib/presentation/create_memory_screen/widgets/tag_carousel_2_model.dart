import 'package:anamnesis/presentation/home_list_screen/bloc/home_list_bloc.dart';
import 'package:anamnesis/presentation/home_list_screen/models/label_item_model.dart';
import 'package:anamnesis/presentation/home_list_screen/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class TagCarousel2 extends StatefulWidget {
  final List<LabelItemModel> labels;
  final List<LabelItemModel>? selectedLabels;
  final CarouselType carouselType;
  final void Function(LabelItemModel) onLabelTap;

  TagCarousel2({
    required this.labels,
    this.selectedLabels,
    required this.carouselType,
    required this.onLabelTap,
  });

  @override
  _TagCarouselState2 createState() => _TagCarouselState2();
}

class _TagCarouselState2 extends State<TagCarousel2> {
  DateTime? startDate;
  DateTime? endDate;
  final ValueNotifier<String> datesNotifier = ValueNotifier<String>("");
  late HomeListBloc homeListBloc;

  @override
  void initState() {
    super.initState();
  }

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
