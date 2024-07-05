import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kaff_video_call/models/create_user_model/create_resp.dart';
import 'package:kaff_video_call/models/followers_model/followers_resp.dart';
import 'package:kaff_video_call/models/following_list_model/following_resp.dart';
import 'package:kaff_video_call/models/peopleList/peopleList_resp.dart';
import 'package:kaff_video_call/utils/constant/api.dart';
import 'package:kaff_video_call/models/login_model/login_resp.dart';
import 'package:kaff_video_call/utils/shared_preference/pref_utils.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> createHeaders() async {
    String? userToken = await PrefUtils().getUserToken();
    print("user Token: ${userToken}");
    return {
      "Accept": 'application/json',
      'Authorization': '$userToken',
    };
  }

  Future<CreateUserResp> createUser(req) async {
    final data = req.toJson();

    final response = await dio.post(
      URL.baseBathUrl + UrlPath.apiSignUp,
      options: Options(validateStatus: (_) => true),
      data: data,
    );

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        final value = CreateUserResp.fromJson(response.data);
        return value;
      } else if (response.data is String) {
        final jsonData = json.decode(response.data);
        final value = CreateUserResp.fromJson(jsonData);
        return value;
      } else {
        throw Exception('Invalid response data type');
      }
    } else {
      throw Exception('Failed to parse response data: ${response.data}');
    }
  }

  Future<LoginResp> loginWithEmail(req) async {
    final data = req.toJson();

    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.apiLogin,
        options: Options(validateStatus: (_) => true),
        data: data,
      );

      if (response.statusCode == 200) {
        if (response.data is String) {
          final jsonData = json.decode(response.data);
          final value = LoginResp.fromJson(jsonData);
          return value;
        } else if (response.data is Map<String, dynamic>) {
          final value = LoginResp.fromJson(response.data);
          return value;
        } else {
          throw Exception('Invalid response data type');
        }
      } else {
        throw Exception('Failed to parse response data: ${response.data}');
      }
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  Future<FollowingListResp> followingList() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.apiFollowingList,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = FollowingListResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to parse response data: $e');
    }
  }

  Future<PeopleListResp> peopleList() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.apiPeopleList,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = PeopleListResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to parse response data: $e');
    }
  }

  Future<FollowersListResp> followersList() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.apiFollowersList,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = FollowersListResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to parse response data: $e');
    }
  }
}
