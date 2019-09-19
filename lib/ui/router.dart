import 'package:appointme/core/constants/route_path.dart';
import 'package:appointme/core/models/clinic.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:appointme/ui/pages/appointment/appointment_create_page.dart';
import 'package:appointme/ui/pages/appointment/verify_page.dart';
import 'package:appointme/ui/pages/clinic/clinic_detail_page.dart';
import 'package:appointme/ui/pages/home/doctor_detail_page.dart';
import 'package:appointme/ui/pages/main_page.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.doctor_detail:
        final Doctor doctor = settings.arguments as Doctor;
        return MaterialPageRoute(
          builder: (context) => DoctorDetailPage(
            doctor: doctor,
          ),
        );
      case RoutePath.clinic_detail:
        final Clinic clinic = settings.arguments as Clinic;
        return MaterialPageRoute(
          builder: (context) => ClinicDetailPage(
            clinic: clinic,
          ),
        );
      case RoutePath.appointment_create:
        final data = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => AppointmentCreatePage(data: data),
        );
      case RoutePath.verify:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => VerifyPage(
            appointmentId: id,
          ),
        );
      case RoutePath.main_page:
        return MaterialPageRoute(
          builder: (context) => MainPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
