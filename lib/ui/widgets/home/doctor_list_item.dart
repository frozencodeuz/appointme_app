import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/constants/route_path.dart';
import 'package:appointme/core/models/doctor.dart';
import 'package:flutter/material.dart';

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorListItem({Key key, this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutePath.doctor_detail,
          arguments: doctor),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        margin: EdgeInsets.only(top: 3, left: 5, right: 5, bottom: 3),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.5, 0.5),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(doctor.avatar),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    doctor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.business,
                          size: 15,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          doctor.department,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black54,
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
                          Icons.library_books,
                          size: 15,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          doctor.education,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
