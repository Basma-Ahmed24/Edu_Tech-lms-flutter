import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/utils/handel_user_data_.dart';

import '../../../widgets/custom_text.dart';
import '../logic/cubit/auth_cubit.dart';
import '../logic/cubit/auth_state.dart';

class CustomDropDownBtn extends StatefulWidget {
  final String hint;
  final String selectedOption;
  final List<String> listOptions;
  final bool isFromEdit;
  final bool isYear;
  final bool isCity;
  final bool isSpecialization;
  final TextEditingController controller;

  const CustomDropDownBtn({
    Key? key,
    required this.hint,
    required this.listOptions,
    required this.selectedOption,
    this.isFromEdit = false,
    this.isYear = false,
    this.isSpecialization = false,
    this.isCity = false,
    required this.controller
  }) : super(key: key);

  @override
  State<CustomDropDownBtn> createState() => _CustomDropDownBtnState();
}

class _CustomDropDownBtnState extends State<CustomDropDownBtn> {
  String? selectedValue;
  String? theValue;

  bool isOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        customButton: Container(
          alignment: Alignment.center,
          height: 45.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).hintColor,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   AppIcon.city,
                    //   height: 18,
                    //   color: Colors.grey,
                    // ),
                    const SizedBox(width: 10),
                    BlocBuilder<AuthCubit, AuthStates>(
                      builder: (context, state) {
                        var cubit = AuthCubit.get(context);
                        return CustomText(
                          text: theValue ?? widget.hint,
                          color: theValue != null
                              ? Colors.black
                              : theValue == null && cubit.checkIfChosen
                              ? Colors.red
                              : Colors.grey,
                          fontSize: 12.sp,
                        );
                      },
                    ),
                  ],
                ),
                isOpened
                    ? Icon(Icons.arrow_drop_down_outlined, size: 20.sp)
                    : Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 12.sp,
                ),
              ],
            ),
          ),
        ),
        onMenuStateChange: (isOpen) {
          setState(() {
            isOpened = isOpen;
          });
        },
        items: widget.listOptions
            .map(
              (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              widget.isYear
                  ? GetUserYear.get(context, item)
                  : widget.isSpecialization
                  ? GetUserSpecialization.get(context, item)
                  : item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),
        value: selectedValue,
        onChanged: (value) async {
          if (widget.isYear) {
            setState(() {
              theValue = GetUserYear.get(context, value!);
            });
          } else if (widget.isSpecialization) {
            setState(() {
              theValue = GetUserSpecialization.get(context, value!);
            });
          } else {
            setState(() {
              theValue = value;
            });
          }
          if (!widget.isFromEdit) {
            var cubit = AuthCubit.get(context);
            cubit.getOptionValue(value: value!,selectedOption: widget.selectedOption,controller:widget.controller);
          } else {
            var cubit = AuthCubit.get(context);
            cubit.getOptionValue(value:value!,selectedOption: widget.selectedOption,controller:widget.controller);
          }
        },
      ),
    );
  }
}