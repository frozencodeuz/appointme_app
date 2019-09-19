import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/constants/route_path.dart';
import 'package:appointme/core/models/clinic.dart';
import 'package:flutter/material.dart';

class ClinicListItem extends StatelessWidget {
  final Clinic clinic;

  const ClinicListItem({Key key, this.clinic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutePath.clinic_detail,
          arguments: clinic),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 5, right: 5, top: 4),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.3, 0.4),
                blurRadius: 1.0,
                spreadRadius: 0.6,
              ),
            ],
          ),
          child: ListTile(
            isThreeLine: true,
            title: Text(
              clinic.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                color: AppColors.primaryColor,
              ),
            ),
            leading: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(clinic.avatar),
                  alignment: Alignment.center,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.place,
                        size: 15,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        clinic.address,
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
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.phone,
                        size: 15,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        clinic.phoneNumber,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
