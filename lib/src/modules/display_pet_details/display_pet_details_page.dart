
import 'package:dogs/src/utils/exports.dart';

class DisplayPetDetailsPage extends StatelessWidget {
  const DisplayPetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayPetDetailsProvider provider =
        Provider.of<DisplayPetDetailsProvider>(context);
    return CustomScaffold(
      body: CustomPadding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Selector(
                shouldRebuild: (p, n) => true,
                selector: (context, DisplayPetDetailsProvider p) =>
                    p.petDetailsModel?.data,
                builder: (context, v, child) {
                  return v == null
                      ? Center(
                          child: CircularProgressIndicator(
                          color: AppData.primaryColor,  strokeWidth: 2,
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              v.isEmpty ? EmptyWidget() : DataCard(v),
                            ],
                          ),
                        );
                },
              ),
            ),
            SubmitButtonWithIcon(
              label: 'Add New Pet',
              icon: Icons.add_box_rounded,
              onPressed: provider.onTapAddNewPet,
            )
          ],
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 5,
        children: [
          Image.asset('assets/png/empty.png'),
          CustomText('Opps! your pet list is empty'),
        ],
      ),
    );
  }
}

class SubmitButtonWithIcon extends StatelessWidget {
  const SubmitButtonWithIcon({
    required this.label,
    this.icon,
    this.onPressed,
    super.key,
  });

//final DisplayPetDetailsProvider provider;
  final String label;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton.icon(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStatePropertyAll(
            AppData.primaryColor,
          ),
        ),
        label: CustomText(
          label,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        onPressed: onPressed,
        icon: icon == null
            ? null
            : Icon(
                // Icons.add_box_rounded,
                icon,
                color: AppData.textColorPrimary,
              ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard(
    this.dataList, {
    super.key,
  });

  final List<Datum> dataList;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, Orientation orientation) {
      return GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
        children: List.generate(dataList.length, (int i) {
          Datum data = dataList[i];
          return Container(
            padding: EdgeInsets.all(5),
            height: 168,
            width: 168,
            child: Card(
                margin: EdgeInsets.all(2),
                elevation: 0.5,
                child: CustomPadding(
                  child: Column(
                    spacing: 1,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageWidget(data: data),
                      NameAndLocationWidget(data: data)
                    ],
                  ),
                )),
          );
        }),
      );
    });
  }
}

class NameAndLocationWidget extends StatelessWidget {
  const NameAndLocationWidget({
    super.key,
    required this.data,
  });

  final Datum data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          data.petName!,
          overflow:  TextOverflow.ellipsis,
        ),
        Row(
          spacing: 5,
          children: [
            Icon(Icons.location_on_outlined,size: 18,),
            CustomText(
              data.location!, overflow:  TextOverflow.ellipsis,
              color: AppData.textColorHint,
              fontSize: 13,
            ),
          ],
        )
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.data,
  });

  final Datum data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          child: CachedNetworkImage(
              imageUrl: data.image!,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: CustomIconButton(Icons.favorite),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CustomIconButton(
              data.gender?.toLowerCase() == 'male' ? Icons.male : Icons.female,
              iconColor: data.gender?.toLowerCase() == 'male' ? Colors.pink : Colors.blue,
              bgColor: data.gender?.toLowerCase() == 'male'
                  ? Colors.pink.shade50
                  : Colors.blue.shade50,
            ))
      ],
    ));
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
    this.icon, {
    this.bgColor,
    this.iconColor,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final Color? bgColor, iconColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      padding: EdgeInsets.all(4),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor ?? Colors.white,
      ),
      iconSize: 16,
      style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStatePropertyAll(Size(0, 0)),
          backgroundColor:
              WidgetStatePropertyAll(bgColor ?? Colors.grey.shade300)),
    );
  }
}
