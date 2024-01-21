import 'package:anamnesis/presentation/create_memory_screen/models/people_list.dart';
import 'package:anamnesis/presentation/home_list_screen/bloc/home_list_bloc.dart';
import 'package:flutter/services.dart';
import 'bloc/duration_picker_bloc.dart';
import 'models/duration_picker_model.dart';
import 'package:flutter/material.dart';
import 'package:anamnesis/core/app_export.dart';

class DurationPickerBottomsheet extends StatefulWidget {
  final void Function(List<PeopleItemModel>)? onPeopleSelected;
  const DurationPickerBottomsheet({this.onPeopleSelected, Key? key})
      : super(key: key);

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DurationPickerBloc>(
          create: (context) => DurationPickerBloc(DurationPickerState(
            DurationPickerModelObj: DurationPickerModel(),
          ))
            ..add(DurationPickerInitialEvent()),
        ),
        BlocProvider<HomeListBloc>(
          create: (context) => HomeListBloc(HomeListState()),
        ),
      ],
      child: DurationPickerBottomsheet(
        onPeopleSelected: ((List<PeopleItemModel> newSelectedPeople) {}),
      ),
    );
  }

  @override
  _DurationPickerBottomsheetState createState() =>
      _DurationPickerBottomsheetState();
}

class _DurationPickerBottomsheetState extends State<DurationPickerBottomsheet> {
  IntegerInput integerInput = IntegerInput();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: 363.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL28,
      ),
      child: Column(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              height: 4.v,
              width: 32.h,
              decoration: BoxDecoration(
                color: appTheme.gray600.withOpacity(0.49),
                borderRadius: BorderRadius.circular(
                  2.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 17.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: Text(
                "Select duration range".tr,
                style: CustomTextStyles.titleLargeBold,
              ),
            ),
          ),
          SizedBox(height: 66.v),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Memory lasts up to",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10.v),
              integerInput,
              SizedBox(height: 20.v),
              Text(
                "days",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          SizedBox(height: 66.v),
          ElevatedButton(
            onPressed: () {
              // Nick, this is yours
              print("Selected a duration of up to ... days");
              print(
                  "in '...' there should be the value of the integer input, but I couldn't figure out how to get it and I am already late");
            },
            child: Text("Submit"),
          ),
        ],
      ),
    ));
  }
}

class IntegerInput extends StatefulWidget {
  @override
  _IntegerInputState createState() => _IntegerInputState();
}

class _IntegerInputState extends State<IntegerInput> {
  TextEditingController controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            int? currentValue = int.tryParse(controller.text);
            controller.text = (currentValue != null && currentValue > 0
                    ? currentValue - 1
                    : 0)
                .toString();
          },
        ),
        Container(
          width: 50,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            controller: controller,
            keyboardType:
                TextInputType.numberWithOptions(decimal: false, signed: false),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            int? currentValue = int.tryParse(controller.text);
            controller.text =
                (currentValue != null ? currentValue + 1 : 1).toString();
          },
        ),
      ],
    );
  }
}
