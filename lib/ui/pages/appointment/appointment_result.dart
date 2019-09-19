import 'package:appointme/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppointmentResultView extends StatefulWidget {
  final data;
  AppointmentResultView({this.data});
  @override
  _AppointmentResultViewState createState() => _AppointmentResultViewState();
}

class _AppointmentResultViewState extends State<AppointmentResultView> {
  String status;
  Color color = Colors.white;
  @override
  void initState() {
    super.initState();
    if (int.parse(widget.data['status']) == 0) {
      color = Colors.yellowAccent;
      status = "Pending";
    }
    if (int.parse(widget.data['status']) == 1) {
      color = Colors.green;
      status = "Confirmed";
    }
    if (int.parse(widget.data['status']) == 2) {
      color = Colors.red;
      status = "Rejected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Status of ${widget.data['appointment_key']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text("Appointment Key"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text(
                                  widget.data['appointment_key'],
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text("Name"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text(
                                  widget.data['name'],
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Contact number"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.data['contact'].toString()),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Clinic"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    widget.data['clinic']['name'].toString()),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Doctor"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    widget.data['doctor']['name'].toString()),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Date"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.data['date'].toString()),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Time Slot"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.data['timing'].toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: color.withOpacity(0.3),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
