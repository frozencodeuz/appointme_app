import 'dart:io';

import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/ui/pages/appointment/appointment_page.dart';
import 'package:appointme/ui/pages/clinic/clinic_page.dart';
import 'package:appointme/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;

  List<Widget> _pages = <Widget>[
    HomePage(),
    ClinicPage(),
    AppointmentPage(),
  ];

  void _changePage(int i) {
    setState(() {
      _currentPage = i;
    });
  }

  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: _changePage,
      elevation: 5,
      selectedItemColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Images.doctor_image,
            height: 20,
            width: 20,
            color: AppColors.primaryColor,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Doctors",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Images.clinic_image,
            height: 20,
            width: 20,
            color: AppColors.primaryColor,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Clinics",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Images.appointment_image,
            height: 20,
            width: 20,
            color: AppColors.primaryColor,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Appointment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(),
      body: FutureBuilder(
        future: check(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),
            );
          } else {
            if (snap.data == true) {
              return _pages[_currentPage];
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  centerTitle: true,
                  title: Text(
                    "Appointme".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: Center(
                  child: Text("No internet connection"),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
