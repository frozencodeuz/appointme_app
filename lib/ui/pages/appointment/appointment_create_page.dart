import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/constants/route_path.dart';
import 'package:appointme/core/providers/slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentCreatePage extends StatefulWidget {
  final Map data;

  const AppointmentCreatePage({Key key, this.data}) : super(key: key);

  @override
  _AppointmentCreatePageState createState() => _AppointmentCreatePageState();
}

class _AppointmentCreatePageState extends State<AppointmentCreatePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _name;
  String _email;
  String _phone;

  String _time = '';
  List slots = [];

  changeTime(time) {
    setState(() {
      _time = time;
    });
  }

  String _date;
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _date = DateFormat('yyyy-MM-dd').format(picked));
      var slotsFromServer = await fetchSlots();
      setState(() {
        slots = slotsFromServer;
      });
    }
  }

  _submitHandler() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      final SlotProvider slotProvider =
          Provider.of<SlotProvider>(context, listen: false);
      Map _data = {
        'name': _name,
        'email': _email,
        'contact': _phone,
        'date': _date,
        'timing': _time,
        'doctor_id': widget.data['doctor_id'],
        'clinic_id': widget.data['clinic_id']
      };
      final response = await slotProvider.saveAppointment(_data);
      setState(() {
        _isLoading = false;
      });
      if (response['success'] == true) {
        return Navigator.popAndPushNamed(
          context,
          RoutePath.verify,
          arguments: response['appointment_id'],
        );
      }
    }
  }

  fetchSlots() async {
    final SlotProvider slotProvider =
        Provider.of<SlotProvider>(context, listen: false);
    return await slotProvider.fetchSlots(
        widget.data['doctor_id'], widget.data['clinic_id'], _date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "New Appointment".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter full name." : null,
                  onSaved: (val) => setState(() => _name = val),
                  decoration: InputDecoration(
                    labelText: "Full name",
                    hintText: "Eg.Khadga Bahadur Shrestha",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (val) => setState(() => _email = val),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter email address";
                    }
                    if (!val.contains("@")) {
                      return "Enter valid email address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email address",
                    hintText: "Eg.khadgalovecoding2016@gmail.com",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (val) => setState(() => _phone = val),
                  keyboardType: TextInputType.phone,
                  validator: (val) => val.isEmpty ? "Enter phone number" : null,
                  decoration: InputDecoration(
                    labelText: "Contact number",
                    hintText: "Eg.9811013594",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white24,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: "Date",
                      ),
                      child: Text(_date == null ? "Not selected" : _date),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: slots.length > 0
                      ? _buildSlot(slots, changeTime, _time)
                      : Text("Not avaiable"),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: _isLoading == false
                        ? RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            color: AppColors.secondaryColor,
                            textColor: Colors.white,
                            onPressed: _submitHandler,
                            child: Text(
                              "Submit".toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlot(slots, changeTime, time) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: slots.map<Widget>((data) {
          return InkWell(
            onTap: () => changeTime(data),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: data == time ? Colors.red : AppColors.primaryColor,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  data,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
