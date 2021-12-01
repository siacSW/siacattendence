// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:siacattendence/Screens/Login/components/background.dart';
import 'package:siacattendence/components/rounded_button.dart';
import 'package:siacattendence/components/rounded_input_field.dart';
import 'package:siacattendence/logic/models/mysql.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String HrCode = '';
    String NationalID = '';
    String ArabicName = '';
    var db = new MySQL();

    void methodToCallOnHRCode(data) {
      HrCode = data;
    }

    void methodToCallOnNationalID(data) {
      NationalID = data;
    }

    void LoginChecking() {
      ArabicName = '';
      db.getConnection().then((conn) {
        String sql =
            'select code from employees where code = $HrCode and national_id = $NationalID ;';
        conn.query(sql).then((results) {
          for (var row in results) {
            ArabicName = row[0];
            print(row[0]);
          }
        });

        conn.close();
      });
    }

    // void LoginChecking() {
    //   db.getConnection().then((value) => null);
    // }

    return Background(
      //key: null,
      //key: scaffoldKey,

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIAC EVENTS ATTENDENCE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/siac.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your HR Code",
              onChanged: (value) => methodToCallOnHRCode(value),
            ),
            RoundedInputField(
              hintText: "Your National ID",
              onChanged: (value) => methodToCallOnNationalID(value),
            ),
            RoundedButton(
              text: "Register",
              press: () {
                //print(HrCode);
                LoginChecking();
              },
              key: null,
            ),
            SizedBox(height: size.height * 0.03),
            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
