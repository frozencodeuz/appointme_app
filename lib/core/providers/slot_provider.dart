import 'package:flutter/cupertino.dart';

import '../services/api.dart';

class SlotProvider extends ChangeNotifier {
  Api _api;

  SlotProvider({Api api}) : _api = api;

  fetchSlots(doctor, clinic, date) async {
    final response = await _api.fetchSlots(doctor, clinic, date);
    return response;
  }

  saveAppointment(data) async {
    return await _api.saveAppointment(data);
  }

  validate(data) async {
    return await _api.validate(data);
  }

  check(data) async {
    return await _api.check(data);
  }
}
