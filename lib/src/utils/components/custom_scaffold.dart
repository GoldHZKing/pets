import 'package:dogs/src/utils/exports.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.body, this.title});

  final Widget? body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: title != null
            ? CustomText(
                title!,
                fontSize: 20,
              )
            : null,
        centerTitle: true,
      ),
      body: CustomPadding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: body,
      ),
    );
  }
}
