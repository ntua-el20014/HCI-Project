import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/presentation/duration_picker_bottomsheet/duration_picker_bottomsheet.dart';
import 'package:anamnesis/presentation/home_list_screen/bloc/home_list_bloc.dart';
import 'package:anamnesis/presentation/home_list_screen/widgets/label_widget.dart';
import 'package:anamnesis/presentation/people_picker_bottomsheet/people_picker_bottomsheet.dart';
import 'package:anamnesis/presentation/tag_picker_bottomsheet/tag_picker_bottomsheet.dart';

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
  DateTime? startDate;
  DateTime? endDate;
  final ValueNotifier<String> datesNotifier = ValueNotifier<String>("");
  late HomeListBloc homeListBloc;

  @override
  void initState() {
    super.initState();
    homeListBloc = BlocProvider.of<HomeListBloc>(context);
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
          HomeListBloc homeListBlocInstance =
              BlocProvider.of<HomeListBloc>(context);
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
                        PeoplePickerBottomsheet(
                            homeListBloc: homeListBlocInstance)
                        .builder(context),
                  );
                } else if (model.label == 'Date') {
                  _selectDateRange(context);
                } else if (model.label == 'Duration') {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        DurationPickerBottomsheet(
                            homeListBloc: homeListBlocInstance)
                        .builder(context),
                  );
                } else if (model.label == 'Tag') {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        TagPickerBottomsheet(homeListBloc: homeListBlocInstance)
                            .builder(context),
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
  void _selectDateRange(BuildContext context) async {
    DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (selectedRange != null) {
      // Handle the selected range, update your controllers or state accordingly
      startDate = selectedRange.start;
      endDate = selectedRange.end;
      print(startDate);
      print(endDate);
      List<DateTime> date = [startDate!, endDate!];
      datesNotifier.value =
          "${startDate!.day}/${startDate!.month}/${startDate!.year} - ${endDate!.day}/${endDate!.month}/${endDate!.year}";
      HomeListState homeListState = context.read<HomeListBloc>().state;
      String existingSearchText = homeListState.existingSearchText ?? '';
      int? existingDuration = homeListState.existingDuration;
      List<PeopleItemModel> existingSelectedPeople =
          homeListState.existingSelectedPeople ?? [];
      List<int> existingSelectedTags = homeListState.existingSelectedTags ?? [];

      // Call the FilterMemoriesEvent with existing filters and selectedTag
      context.read<HomeListBloc>().add(
            FilterMemoriesEvent(
              selectedPeople: existingSelectedPeople,
              searchText: existingSearchText,
              selectedTags: existingSelectedTags,
              date: date,
              duration: existingDuration,
            ),
          );
    }
  }
}
