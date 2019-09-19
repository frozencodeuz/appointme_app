import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/models/clinic.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:appointme/core/providers/doctor_provider.dart';
import 'package:appointme/ui/widgets/home/doctor_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicDetailPage extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailPage({Key key, this.clinic}) : super(key: key);
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
                                      image: NetworkImage(clinic.avatar),
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
                                        clinic.name,
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
                                              Icons.phone,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              clinic.phoneNumber,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Icon(
                                              Icons.place,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              clinic.address,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
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
              Consumer<DoctorProvider>(
                builder: (context, model, child) {
                  return FutureBuilder(
                    future: model.fetchClinicDoctor(clinic.id),
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
                                      final Doctor doctor = snap.data[i];
                                      return DoctorListItem(
                                        doctor: doctor,
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No doctor found."),
                                  ),
                          );
                        } else {
                          return Center(
                            child: Text("No doctor found."),
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
