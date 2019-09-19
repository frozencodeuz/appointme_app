import 'package:appointme/core/models/doctor.dart';
import 'package:flutter/cupertino.dart';

import '../services/api.dart';

class DoctorProvider extends ChangeNotifier {
  Api _api;

  DoctorProvider({Api api}) : _api = api;

  List<Doctor> _doctors;

  List<Doctor> get doctors => _doctors;

  fetchDoctors(page) async {
    final response = await _api.fetchDoctors(page);
    _doctors = response;
    notifyListeners();
  }

  fetchClinicDoctor(id) async {
    final response = await _api.fetchClinicDoctor(id);
    return response;
  }
}
