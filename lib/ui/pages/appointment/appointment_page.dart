import 'package:appointme/core/constants/app_colors.dart';
import 'package:appointme/core/providers/slot_provider.dart';
import 'package:appointme/ui/pages/appointment/appointment_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _isLoading = false;
  String _key;
  final _formKey = GlobalKey<FormState>();
  Future _submitHandler() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      final slotProvider = Provider.of<SlotProvider>(context);
      final response = await slotProvider.check({'appointment_key': _key});
      setState(() {
        _isLoading = false;
      });

      if (response['success'] == true) {
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AppointmentResultView(
            data: response['data'],
          );
        }));
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Some thing went wrong"),
                content: Text("The appointment key is not valid.Try again."),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Appointment".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (val) => setState(() => _key = val),
                validator: (val) =>
                    val.isEmpty ? "Enter appointment key" : null,
                decoration: InputDecoration(
                  labelText: "Appointment Key",
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        onPressed: _submitHandler,
                        color: AppColors.secondaryColor,
                        child: Text(
                          "Submit".toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
