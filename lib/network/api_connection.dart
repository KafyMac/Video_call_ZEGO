import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kaff_video_call/models/Follow_model/follow_resp.dart';
import 'package:kaff_video_call/models/create_user_model/create_resp.dart';
import 'package:kaff_video_call/models/followers_model/followers_resp.dart';
import 'package:kaff_video_call/models/following_list_model/following_resp.dart';
import 'package:kaff_video_call/models/peopleList/peopleList_resp.dart';
import 'package:kaff_video_call/models/profile_model/profile_resp.dart';
import 'package:kaff_video_call/models/stream_model/end_stream_resp.dart';
import 'package:kaff_video_call/models/stream_model/getStreamResp.dart';
import 'package:kaff_video_call/models/streaming_notifier_model/start_notifier_resp_model.dart';
import 'package:kaff_video_call/models/unfollow_model/unfollow_resp.dart';
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

  Future<FolloweResp> followUser(req) async {
    final data = req.toJson();
    final headers = await createHeaders();

    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.apiFollowUser,
        options: Options(validateStatus: (_) => true, headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        if (response.data is String) {
          final jsonData = json.decode(response.data);
          final value = FolloweResp.fromJson(jsonData);
          return value;
        } else if (response.data is Map<String, dynamic>) {
          final value = FolloweResp.fromJson(response.data);
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

  Future<UnfolloweResp> unFollowUser(req) async {
    final data = req.toJson();
    final headers = await createHeaders();

    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.apiUnFollowUser,
        options: Options(validateStatus: (_) => true, headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        if (response.data is String) {
          final jsonData = json.decode(response.data);
          final value = UnfolloweResp.fromJson(jsonData);
          return value;
        } else if (response.data is Map<String, dynamic>) {
          final value = UnfolloweResp.fromJson(response.data);
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

  Future<GetAllStreamResp> getAllStreams() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.apiGetAllStreams,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = GetAllStreamResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to get all streams data: $e');
    }
  }

  Future<GetMyProfileResp> getMyProfile() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.apiMyProfile,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = GetMyProfileResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to get all streams data: $e');
    }
  }

  Future<StartLiveStreamingNotifierResp> startStreamingNotifier(req) async {
    final data = req.toJson();
    final headers = await createHeaders();
    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.sendStreamingNotifier,
        options: Options(validateStatus: (_) => true, headers: headers),
        data: data,
      );

      final value = StartLiveStreamingNotifierResp.fromJson(response.data);
      return value;
    } catch (error) {
      throw Exception('Failed to start streaming: $error');
    }
  }

  Future<EndStreamResp> endStreaming(req) async {
    final data = req.toJson();
    final headers = await createHeaders();
    try {
      final response = await dio.post(
        URL.baseBathUrl + UrlPath.endStream,
        options: Options(validateStatus: (_) => true, headers: headers),
        data: data,
      );

      final value = EndStreamResp.fromJson(response.data);
      return value;
    } catch (error) {
      throw Exception('Failed to end streaming: $error');
    }
  }

  Future<GetAllStreamResp> getMyStreamHistory() async {
    final headers = await createHeaders();
    try {
      final response = await dio.get(
        URL.baseBathUrl + UrlPath.getStreamHistory,
        options: Options(validateStatus: (_) => true, headers: headers),
      );
      final value = GetAllStreamResp.fromJson(response.data);
      return value;
    } catch (e) {
      throw Exception('Failed to get history streams data: $e');
    }
  }
}
