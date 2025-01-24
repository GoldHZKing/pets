
import 'src/utils/exports.dart';

void main() {
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey =   GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => DisplayPetDetailsProvider())
      ],
      child: MaterialApp( navigatorKey: navigatorKey, debugShowCheckedModeBanner: false,
        title:AppData.appName,
        theme: ThemeData( cardTheme: CardTheme(color: Colors.white, ),
          primaryColor: AppData.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppData.primaryColor),
          useMaterial3: true,
        ),
        home: DisplayPetDetailsPage(),
      ),
    );
  }
}
