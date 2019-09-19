import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/models/clinic.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:appointme/core/providers/clinic_provider.dart';
import 'package:appointme/ui/widgets/home/doctor_clinic_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailPage({Key key, this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: <BoxShadow>[],
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(doctor.avatar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        doctor.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.business,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              doctor.department,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Icon(
                                              Icons.library_books,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150),
                                            child: Text(
                                              doctor.education,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: BackButton(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Consumer<ClinicProvider>(
                builder: (context, model, child) {
                  return FutureBuilder(
                    future: model.fetchDoctorClinics(doctor.id),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.primaryColor),
                          ),
                        );
                      } else {
                        if (snap.hasData) {
                          return Container(
                            height: MediaQuery.of(context).size.height - 150,
                            child: snap.data.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snap.data.length,
                                    itemBuilder: (context, i) {
                                      final Clinic clinic = snap.data[i];
                                      return DoctorlinicListItem(
                                        clinic: clinic,
                                        doctor: doctor.id,
                                      );
                                    },
                                  )
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No clinic found."),
                                    ),
                                  ),
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No clinc found."),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
