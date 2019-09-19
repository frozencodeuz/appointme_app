import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/models/clinic.dart';
import 'package:appointme/core/providers/clinic_provider.dart';
import 'package:appointme/ui/widgets/clinic/clinic_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicPage extends StatefulWidget {
  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  bool _isLoading = false;
  List<Clinic> _clinics = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future didChangeDependencies() async {
    super.didChangeDependencies();
    await fetchClinics();
  }

  fetchClinics() async {
    _isLoading = true;
    final ClinicProvider clinicProvider = Provider.of(context, listen: false);
    await clinicProvider.fetchClinics(_currentPage);
    setState(() {
      _clinics = clinicProvider.clinics;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Clinics".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _clinics.length,
              itemBuilder: (context, i) {
                final Clinic clinic=_clinics[i];
                return ClinicListItem(clinic:clinic);
              },
            ),
    );
  }
}
