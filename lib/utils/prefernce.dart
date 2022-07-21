import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences  {
  AppPreferences();

  static const USERID = "USERID";
  static const  IS_DEVICE_REGISTERED = "IS_THIS_REGISTERED";
  static const  AUTHTOKEN = "TOKEN";
  static const  PARENTNAME = "PARENTNAME";
  static const  EMAIL = "EMAIL";
  static const  MOBILENO = "MOBILENO";
  static const FCMTOKEN="FCMTOKEN";
  static const PROFILE_COMPLETE="PROFILE_COMPLETE";
  static const PIC="PIC";
  static const LOGIN="LOGIN";
  static const DEVICEID="DEVICEID";


  setAuthToken(String authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTHTOKEN, authToken);
  }
  getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(AUTHTOKEN);
    return stringValue;
  }
  setPic(String pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PIC, pic);
  }
  getPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(PIC);
    return stringValue;
  }
  setParentName(String parentname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PARENTNAME, parentname);
  }
  getParentName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(PARENTNAME);
    return stringValue;
  }

  setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, email);
  }
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(EMAIL);
    return stringValue;
  }
  setDeviceid(String deviceid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DEVICEID, deviceid);
  }
  getDeviceid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(DEVICEID);
    return stringValue;
  }
  setFCMToken(String fcmtoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FCMTOKEN, fcmtoken);
    return  prefs.setString(FCMTOKEN, fcmtoken);
  }
  getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(FCMTOKEN);
    return stringValue;
  }
  setuserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(USERID, userId);
  }
  getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(USERID);
    return intValue;
  }
  setMobileno(int mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(MOBILENO, mobile);
  }
  getMobileno() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(MOBILENO);
    return intValue;
  }
  setIsRegistered(bool isregistered) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DEVICE_REGISTERED, isregistered);
  }
  getIsRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(IS_DEVICE_REGISTERED);
    return boolValue;
  }
  setLogin(bool login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGIN, login);
  }
  isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(LOGIN);
    return boolValue;
  }
  setProfileComplete(bool isyes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PROFILE_COMPLETE, isyes);
  }
  getProfileComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(PROFILE_COMPLETE);
    return boolValue;
  }
  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(AUTHTOKEN);
    prefs.remove(IS_DEVICE_REGISTERED);
    prefs.remove(USERID);
    prefs.remove(EMAIL);
    prefs.remove(PARENTNAME);
    prefs.remove(EMAIL);
    prefs.remove(LOGIN);
    prefs.remove(USERID);

  }



}