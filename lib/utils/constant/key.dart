import 'dart:math' as math;

const int APP_ID = 222557723;
const String APP_SIGN_KEY =
    "e3f6ce4fe421a8706e783cdf9b65acf0e0dd5196f571326a282d263efef71103";

const int streamingAPPID = 131205167;
const String streamingAPPSignKey =
    '1ab1548fbcde83c124bff4bb7642d4b8d58dfdc461fe8aa64682bc3a89534265';

/// Note that the userID needs to be globally unique,
final String localUserID = math.Random().nextInt(10000).toString();
