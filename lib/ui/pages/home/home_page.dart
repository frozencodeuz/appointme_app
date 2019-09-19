import 'package:appointme/core/constants/app_colors.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:appointme/core/providers/doctor_provider.dart';
import 'package:appointme/ui/widgets/home/doctor_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Doctor> _doctors = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future didChangeDependencies() async {
    super.didChangeDependencies();
    await fetchDoctors();
  }

  fetchDoctors() async {
    _isLoading = true;
    final DoctorProvider doctorProvider = Provider.of(context, listen: false);
    await doctorProvider.fetchDoctors(_currentPage);
    setState(() {
      _doctors = doctorProvider.doctors;
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
          "Doctors".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _doctors.length,
              itemBuilder: (context, i) {
                final Doctor doctor=_doctors[i];
                return DoctorListItem(doctor:doctor);
              },
            ),
    );
  }
}
