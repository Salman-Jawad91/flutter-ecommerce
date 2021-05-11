import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_arabic/constants.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';

class Auth {
  var _client = OdooClient("http://192.168.100.5:8069");
  var url = "http://192.168.8.107:8069/web/session/authenticate";

  Future<bool> signup(String email, String password) async {
    bool ret = false;
    var fields = ["id", "name"];
    var model = 'res.users';
    var method = 'create';
    var url = "http://192.168.43.144:8069/web/session/authenticate";
    var url_signup = "http://192.168.43.144:8069/web/signup";

    try {
      var json_body = {
        "jsonrpc": "2.0",
        "params": {
          "login": "admin",
          "password": "P@ssw0rd@123",
          "db": "itadweer_db_final_2",
        }
      };

      var signup_data = {
        //  "jsonrpc": "2.0",
        "params": {
          "confirm_password": "123",
          "redirect": "",
          "name": "test2",
          "token": "",
          "login": "test2",
          "password": "123"
        }
      };

      var response = await new Dio().post(url_signup,
          data: signup_data,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      print("GGGGGGGGGGGGGGGGGGGGGGGGGGGG");
      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Successful');
        print(response.statusCode.toString());
        ret = true;
      }
    } catch (e) {
      print(e.response);
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    // _client
    //     .authenticate("admin", "P@ssw0rd@123", "itadweer_db_final_2")
    //     .then((auth) async {
    //   if (auth.isSuccess) {
    //     Map<String, dynamic> json_body = {
    //       "jsonrpc": "2.0",
    //       "params": {"login": email, "password": password, "name": email}
    //     };

    //     _client
    //         .callRequest(Config.url + Config.signupURL, json_body)
    //         .then((OdooResponse result) {
    //       if (!result.hasError()) {
    //         print('Successful 2');
    //         print(result.getResult()['records'].toString());
    //       } else {
    //         print(result.getError());
    //         print("FAILD");
    //       }
    //     });
    //   } else {
    //     print("Login failed");
    //   }
    // });

    return ret;
  }

  Future<bool> signin(String email, String password) async {
    var ret = false;

    try {
      var json_body = {
        "jsonrpc": "2.0",
        "params": {
          "login": email.trim(),
          "password": password.trim(),
          "db": "itadweer_db_final_2",
        }
      };

      var response = await new Dio().post(url,
          data: json_body,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Successful');
        print(response.statusCode.toString());
        print(response.toString());
        ret = true;
      }
    } catch (e) {
      print(e.response);
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<bool> sign2(String email, String pass) async {
    // final prefs = await SharedPreferences.getInstance();
    var ret;

    await _client.authenticate(email, pass, 'itadweer_db_final_2').then((auth) {
      if (auth.isSuccess) {
        print('Sucessful');
        ret = true;
        // The hr_employee Object is the one who register the attendance
        // _client.searchRead("hr.employee", [
        //   ["user_id", "=", auth.getUser().uid]
        // ], [
        //   "id"
        // ]).then((employeeResult) {
        //   if (!employeeResult.hasError()) {
        //     var _employee = employeeResult.getResult()["records"][0]["id"];
        //     // Call the attendance_manual method that will do the rest in server side
        //     _client.callKW("hr.employee", "attendance_manual", [
        //       _employee,
        //       "hr_attendance.hr_attendance_action_my_attendances"
        //     ]).then((kwResult) {
        //       if (!kwResult.hasError()) {
        //       }
        //     });
        //   }
        // });
      } else {
        ret = false;
      }
    });
    return ret;
  }
}
