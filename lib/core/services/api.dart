import 'dart:convert';

import 'package:appointme/core/models/clinic.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://khadgabahadur.com.np/appointme/';
  //static const String baseUrl = 'http://10.0.2.2/appointme/public';
  final client = http.Client();

  Future<List<Doctor>> fetchDoctors(page) async {
    final response = await client.get("$baseUrl/api/doctors?page=$page");

    try {
      final parseData = json.decode(response.body);

      return parseData['data']
          .map<Doctor>((data) => Doctor.fromJson(data))
          .toList();
    } catch (err) {
      throw err;
    }
  }

  Future<List<Clinic>> fetchClinics(page) async {
    final response = await client.get("$baseUrl/api/clinics?page=$page");

    try {
      final parseData = json.decode(response.body);

      return parseData['data']
          .map<Clinic>((data) => Clinic.fromJson(data))
          .toList();
    } catch (err) {
      throw err;
    }
  }

  Future fetchDoctorClinics(id) async {
    final response = await client.get("$baseUrl/api/doctors/$id/clinics");

    try {
      final parseData = json.decode(response.body);

      return parseData['data']
          .map<Clinic>((data) => Clinic.fromJson(data))
          .toList();
    } catch (err) {
      throw err;
    }
  }

  Future fetchClinicDoctor(id) async {
    final response = await client.get("$baseUrl/api/clinics/$id/doctors");

    try {
      final parseData = json.decode(response.body);

      return parseData['data']
          .map<Doctor>((data) => Doctor.fromJson(data))
          .toList();
    } catch (err) {
      throw err;
    }
  }

  fetchSlots(doctor, clinic, date) async {
    final response = await client
        .get("$baseUrl/api/doctors/$doctor/clinics/$clinic/slots?date=$date");
    try {
      final parseData = json.decode(response.body);

      return parseData['data'].toList();
    } catch (err) {
      throw err;
    }
  }

  Future saveAppointment(data) async {
    final response = await client.post("$baseUrl/api/save-appointment",
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: jsonEncode(data));

    try {
      final parseData = json.decode(response.body);
      if (parseData['success']) {
        return {'success': true, 'appointment_id': parseData['data']['id']};
      } else {
        return {'success': false, 'msg': parseData['message']};
      }
    } catch (err) {
      throw err;
    }
  }

  Future validate(data) async {
    final response = await client.post("$baseUrl/api/validate",
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: jsonEncode(data));

    try {
      final parseData = json.decode(response.body);
      if (parseData['success']) {
        return {'success': true};
      } else {
        return {'success': false, 'msg': parseData['message']};
      }
    } catch (err) {
      throw err;
    }
  }

  check(data) async {
    final response = await client.post("$baseUrl/api/check-status",
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: jsonEncode(data));

    try {
      final parseData = json.decode(response.body);

      if (parseData['success']) {
        return {'success': true, 'data': parseData['data']};
      } else {
        return {'success': false, 'msg': parseData['message']};
      }
    } catch (err) {
      throw err;
    }
  }
}
