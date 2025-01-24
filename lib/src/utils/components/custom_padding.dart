import 'package:dogs/src/utils/exports.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({super.key, this.padding, this.child});

  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(8),
      child: child,
    );
  }
}
