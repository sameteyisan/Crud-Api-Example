import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Helper {
  static void showToast(String text) => EasyLoading.showToast(text,
      toastPosition: EasyLoadingToastPosition.bottom);
}

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? label;
  final String? labelText;
  final Color labelColor;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.label,
    this.labelText,
    this.labelColor = Colors.black,
    this.onChanged,
    this.controller,
    this.onTap,
    this.suffixIcon,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          label: label,
          labelText: labelText,
          labelColor: labelColor,
        ),
        TextFormField(
          readOnly: readOnly,
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 17),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class CustomLabel extends StatelessWidget {
  final Widget? label;
  final String? labelText;
  final Color labelColor;
  const CustomLabel({
    Key? key,
    this.label,
    this.labelText,
    this.labelColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          label!
        else if (labelText != null)
          Text(
            labelText!,
            style: TextStyle(
              color: labelColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        if (label != null || labelText != null) const SizedBox(height: 8),
      ],
    );
  }
}

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.radius = 16,
  }) : super(key: key);

  final Widget child;
  final void Function()? onTap;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
