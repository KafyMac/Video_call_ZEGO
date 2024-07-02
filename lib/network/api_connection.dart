import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kaff_video_call/models/create_user_model/create_resp.dart';
import 'package:kaff_video_call/utils/constant/api.dart';
import 'package:kaff_video_call/models/login_model/login_resp.dart';
import 'package:kaff_video_call/utils/shared_preference/pref_utils.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> createHeaders() async {
    String? userToken = await PrefUtils().getUserToken();
    return {
      "Accept": 'application/json',
      'Authorization': '$userToken',
    };
  }

  Future<CreateUserResp> createUser(req) async {
    final data = req.toJson();

    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.apiLogin,
        options: Options(validateStatus: (_) => true),
        data: data,
      );
      if (response.data is String) {
        final jsonData = json.decode(response.data);
        final value = CreateUserResp.fromJson(jsonData);
        return value;
      } else {
        throw Exception('Failed to parse response data: ${response.data}');
      }
    } catch (error) {
      throw Exception('Failed to create user: $error');
    }
  }

  Future<LoginResp> loginWithEmail(req) async {
    final data = req.toJson();
    print("i'm called");

    // try {
    final response = await dio.post(
      URL.baseBathUrl + UrlPath.apiLogin,
      options: Options(validateStatus: (_) => true),
      data: data,
    );
    print(response);
    print(response.toString());
    if (response.data is String) {
      final jsonData = json.decode(response.data);
      final value = LoginResp.fromJson(jsonData);
      return value;
    } else {
      throw Exception('Failed to parse response data: ${response.data}');
    }
    // } catch (error) {
    //   throw Exception('Failed to login: $error');
    // }
  }

  // Future<OtpResp> loginWithPHNumber(req) async {
  //   final data = req.toJson();
  //   try {
  //     final response = await dio.post(
  //       URL.baseBathUrl + UrlPath.otpGeneration,
  //       options: Options(validateStatus: (_) => true),
  //       data: data,
  //     );
  //     if (response.data is String) {
  //       final jsonData = json.decode(response.data);
  //       final value = OtpResp.fromJson(jsonData);
  //       return value;
  //     } else {
  //       throw Exception('Failed to parse response data: ${response.data}');
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to login: $error');
  //   }
  // }

  // Future<LoginResp> otpValidation(req) async {
  //   final data = req.toJson();

  //   try {
  //     final response = await dio.post(
  //       URL.baseBathUrl + UrlPath.otpValidation,
  //       options: Options(validateStatus: (_) => true),
  //       data: data,
  //     );
  //     if (response.data is String) {
  //       final jsonData = json.decode(response.data);
  //       final value = LoginResp.fromJson(jsonData);
  //       return value;
  //     } else {
  //       throw Exception('Failed to parse response data: ${response.data}');
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to login: $error');
  //   }
  // }
}
