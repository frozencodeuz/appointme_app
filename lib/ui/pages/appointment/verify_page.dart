import 'package:appointme/core/constants/constants.dart';
import 'package:appointme/core/constants/route_path.dart';
import 'package:appointme/core/providers/slot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyPage extends StatefulWidget {
  final int appointmentId;

  const VerifyPage({Key key, this.appointmentId}) : super(key: key);
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _otp;

  _submitHandler() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      final validateProvider =
          Provider.of<SlotProvider>(context, listen: false);
      final response = await validateProvider
          .validate({'token': _otp, 'id': widget.appointmentId});
      setState(() {
        _isLoading = false;
      });

      if (response['success'] == true) {
        Navigator.pushReplacementNamed(
          context,
          RoutePath.main_page,
        );
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Some things went wrong"),
                content: Text(response['msg']),
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
          "Verify Appointment".toUpperCase(),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  validator: (val) => val.isEmpty ? "Enter token" : null,
                  onSaved: (val) => setState(() => _otp = val),
                  decoration: InputDecoration(
                    labelText: "Enter OTP token",
                  ),
                ),
              ),
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
