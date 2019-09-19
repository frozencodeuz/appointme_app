import 'package:appointme/core/models/clinic.dart';

import 'package:flutter/cupertino.dart';

import '../services/api.dart';

class ClinicProvider extends ChangeNotifier {
  Api _api;

  ClinicProvider({Api api}) : _api = api;

  List<Clinic> _clinics;

  List<Clinic> get clinics => _clinics;

  fetchClinics(page) async {
    final response = await _api.fetchClinics(page);
    _clinics = response;
    notifyListeners();
  }

  fetchDoctorClinics(id) async {
    final response = await _api.fetchDoctorClinics(id);
    return response;
  }
}
