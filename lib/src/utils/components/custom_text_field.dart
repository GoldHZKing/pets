import 'package:dogs/src/utils/exports.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label, {
    this.hint,
    this.controller,
    super.key,
    this.validator,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        CustomText(label),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade50,
              border: customBorder(),
              enabledBorder: customBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              focusedBorder: customBorder(borderColor: AppData.primaryColor)),
        ),
      ],
    );
  }
}

OutlineInputBorder customBorder({Color? borderColor, double? radius}) =>
    OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(radius ?? 30));
