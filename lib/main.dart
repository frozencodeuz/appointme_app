import 'package:appointme/core/providers/clinic_provider.dart';
import 'package:appointme/core/providers/doctor_provider.dart';
import 'package:appointme/core/providers/slot_provider.dart';
import 'package:appointme/core/services/api.dart';
import 'package:appointme/ui/pages/main_page.dart';
import 'package:appointme/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DoctorProvider(
            api: Api(),
          ),
        ),
        ChangeNotifierProvider.value(
          value: ClinicProvider(
            api: Api(),
          ),
        ),
        ChangeNotifierProvider.value(
          value: SlotProvider(
            api: Api(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Appointme',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Manjari'),
        home: MainPage(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
