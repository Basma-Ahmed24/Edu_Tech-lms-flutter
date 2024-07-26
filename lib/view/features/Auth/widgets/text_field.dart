import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_current_lang.dart';
import '../../../../helpers/constants/app_images.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final bool isUser;
  final bool isbscureText;
  final bool isVisible;
  final double? widthTextField;
  final TextInputType? keyboardType;
  final bool isAutofocus;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final bool isWebOrTabletView;
  final bool isBuyCourse;
  final void Function()? onSendTap;
  final bool isDiscount;
  final bool isNoTrailling;
  final bool isDense;
  final bool enabled;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    this.isUser = false,
    this.isbscureText = false,
    this.isVisible = false,
    this.widthTextField,
    this.keyboardType,
    this.isAutofocus = false,
    required this.validator,
    this.controller,
    this.isWebOrTabletView = false,
    this.isBuyCourse = false,
    this.onSendTap,
    this.isDiscount = false,
    this.isNoTrailling = false,
    this.isDense = true,
    this.enabled = true,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTapOutside,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;

  Widget build(BuildContext context) {
    // TODO: implement build

    return TextFormField(
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapOutside: widget.onTapOutside,
      enabled: widget.enabled,
      controller: widget.controller,
      validator: ((value) => widget.validator(value)),
      autofocus: widget.isAutofocus,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? !isVisible : false,
      decoration: InputDecoration(
        fillColor: AppColorTheme.bottomNavigationBarTheme(context),
        filled:  widget.isBuyCourse,

        suffixIcon: widget.isNoTrailling
            ? null
            : widget.isPassword
            ? isVisible
            ? GestureDetector(
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: const Icon(
            Icons.visibility,
          ),
        )
            : GestureDetector(
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: const Icon(
            Icons.visibility_off,
          ),
        )
            : widget.isEmail
            ? const Icon(
          Icons.email,
        )
            : widget.isUser
            ? const Icon(
          Icons.person,
        )
            : widget.isBuyCourse
            ? SendIconWidget(onTap: widget.onSendTap)
            : const Icon(
          Icons.phone,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
        ),
        isDense: widget.isDense,
        contentPadding: AppCurrentLang.isEn(context)
            ? EdgeInsets.only(left: 10.sp, right: 5.sp)
            : widget.isDiscount
            ? EdgeInsets.only(left: 5.sp, right: 0.sp)
            : EdgeInsets.only(left: 5.sp, right: 10.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:  widget.isBuyCourse
                ? Colors.tealAccent
                : Theme.of(context).hintColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:  widget.isBuyCourse
                ? Colors.transparent
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

// class CoponIconWidget extends StatelessWidget {
//   const CoponIconWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 45.sp,
//       padding: const EdgeInsets.all(8),
//       margin: AppCurrentLang.isEn(context)
//           ? const EdgeInsets.only(right: 10)
//           : const EdgeInsets.only(left: 10),
//       decoration: BoxDecoration(
//         color: AppColors.subMainAppColor,
//         borderRadius: !AppCurrentLang.isEn(context)
//             ? const BorderRadius.only(
//           topRight: Radius.circular(8),
//           bottomRight: Radius.circular(8),
//         )
//             : const BorderRadius.only(
//           topLeft: Radius.circular(8),
//           bottomLeft: Radius.circular(8),
//         ),
//       ),
//       child: Image.asset(AppImages.coupon),
//     );
//   }
// }

class SendIconWidget extends StatelessWidget {
  final void Function()? onTap;

  const SendIconWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45.sp,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.subMainAppColor,
          borderRadius: AppCurrentLang.isEn(context)
              ? const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: Directionality(
          textDirection: AppCurrentLang.isEn(context)
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Image.asset(
            matchTextDirection: true,
            AppImages.send,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
