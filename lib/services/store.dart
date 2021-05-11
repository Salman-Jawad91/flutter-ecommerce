import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_arabic/models/orders.dart';
import 'package:ecommerce_arabic/models/product.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreProduct {
  addProduct(Product product) {
    var url = "http://192.168.100.5:8069/web/session/authenticate";
    var url2 = "http://192.168.100.5:8069/get_patients";

    var dio = Dio();
  }

  Future<bool> addPatient(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    bool ret = false;

    // print(prefs.getString("User_Name") + ' ' + prefs.getString("Password"));
    var _client = OdooClient("http://192.168.100.5:8069");

    print('Check');

    await _client
        .authenticate(prefs.getString("User_Name").trim(),
            prefs.getString("Password").trim(), 'itadweer_db_final_2')
        .then((auth) async {
      if (auth.isSuccess) {
        print('Check 2');
        // The hr_employee Object is the one who register the attendance
        var values = {
          "name": product.pNme,
          "email_id": product.pPrice,
          "patient_name": product.pCategory,
        };
        await _client.create('hospital.patient', values).then((Result) {
          if (!Result.hasError()) {
            print('Created Succesful :' +
                Result.getSessionId().toString() +
                Result.getResult().toString());
            ret = true;
          }
        });

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
        //       if (!kwResult.hasError()) {}
        //     });
        //   }
        // });
      }
    });
    return ret;
  }

  Future<List<Product>> loadPatient() async {
    final prefs = await SharedPreferences.getInstance();
    List<Product> patients = [];
    var fields = ["id", "name", "email_id", "patient_name"];

    // print(prefs.getString("User_Name") + ' ' + prefs.getString("Password"));
    var _client = OdooClient("http://192.168.100.5:8069");

    print('Check');

    await _client
        .authenticate(prefs.getString("User_Name").trim(),
            prefs.getString("Password").trim(), 'itadweer_db_final_2')
        .then((auth) async {
      if (auth.isSuccess) {
        print('Check 2');
        // The hr_employee Object is the one who register the attendance
        // var values = {
        //   "name": product.pNme,
        //   "email_id": product.pPrice,
        //   "notes": product.pCategory,
        // };
        // await _client.create('hospital.patient', values).then((Result) {
        //   if (!Result.hasError()) {
        //     print('Created Succesful :' +
        //         Result.getSessionId().toString() +
        //         Result.getResult().toString());
        //    // ret = true;
        //   }
        // });

        await _client
            .searchRead("hospital.patient", [], fields)
            .then((eResult) {
          if (!eResult.hasError()) {
            print('The Result is');
            // eResult.getResult()["records"].toString());

            for (var doc in eResult.getResult()["records"]) {
              patients.add(Product(
                pNme: doc['name'].toString(),
                pPrice: doc['email_id'].toString(),
                pCategory: doc['patient_name'].toString(),
              ));
            }

            // var _employee = employeeResult.getResult()["records"][0]["id"];
          }
        });
      }
    });
    return patients;
  }

  Future<bool> addOrders(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    bool ret = false;

    // print(prefs.getString("User_Name") + ' ' + prefs.getString("Password"));
    var _client = OdooClient("http://192.168.100.5:8069");

    print('Check');

    await _client
        .authenticate(prefs.getString("User_Name").trim(),
            prefs.getString("Password").trim(), 'itadweer_db_final_2')
        .then((auth) async {
      if (auth.isSuccess) {
        print('Check 2');
        // The hr_employee Object is the one who register the attendance
        for (var product in products) {
          var values = {
            "name": product.pNme,
            "qty": product.pQty,
            "patient_name": product.pCategory
          };
          await _client
              .create('hospital.patient.orders', values)
              .then((Result) {
            if (!Result.hasError()) {
              print('Created Succesful :' +
                  Result.getSessionId().toString() +
                  Result.getResult().toString());
              ret = true;
            }
          });
        }
      }
    });
    return ret;
  }

  Future<List<Order>> loadPatientOrders() async {
    final prefs = await SharedPreferences.getInstance();
    List<Order> patients = [];
    var fields = ["id", "name", "qty", "patient_name"];

    // print(prefs.getString("User_Name") + ' ' + prefs.getString("Password"));
    var _client = OdooClient("http://192.168.100.5:8069");

    print('Check');

    await _client
        .authenticate(prefs.getString("User_Name").trim(),
            prefs.getString("Password").trim(), 'itadweer_db_final_2')
        .then((auth) async {
      if (auth.isSuccess) {
        print('Check 2');

        await _client
            .searchRead("hospital.patient.orders", [], fields)
            .then((eResult) {
          if (!eResult.hasError()) {
            print('The Result is');

            for (var doc in eResult.getResult()["records"]) {
              patients.add(Order(
                name: doc['name'].toString(),
                qty: doc['qty'],
                patient_name: doc['patient_name'].toString(),
              ));
            }
          }
        });
      }
    });
    return patients;
  }
}
