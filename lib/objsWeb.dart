import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class objoAccount {
  String acc_type = "";
  String id = "";
  String first_name = "";
  String last_name = "";
  String picture = "";
  String email = "";
  String birthday = "";
  String saveToken = "";
  objoAccount(_acc_type, _id, _fn, _ln, _p, _e, _b) {
    this.acc_type = _acc_type;
    this.id = _id;
    this.first_name = _fn;
    this.last_name = _ln;
    this.picture = _p;
    this.email = _e;
    this.birthday = _b;
  }
  compressToSend() {
    return (
        this.id +
            ":::" +
            this.first_name +
            ":::" +
            this.last_name +
            ":::" +
            this.email +
            ":::" +
            this.birthday +
            ":::" +
            this.saveToken
    );
  }
}
class objoLogin {
  String oauth_url = "";
  String valid_url = "";
  String client_id = "";
  String redirect_url = "";
  String logout_url = "";
  //login_url = "";
  String token = "";
  String expires_in = "";
  String scope = "";
  String logged_in = "";
  String url = "";
  objoAccount oAccount = null;
  constructor(
      _oauth_url,
      _valid_url,
      _client_id,
      _redirect_url,
      _logout_url,
      //_login_url,
      _token,
      _expires_in,
      _scope,
      _logged_in,
      _url) {
    this.oauth_url = _oauth_url;
    this.valid_url = _valid_url;
    this.client_id = _client_id;
    this.redirect_url = _redirect_url;
    this.logout_url = _logout_url;
    // this.login_url = _login_url;
    this.token = _token;
    this.expires_in = _expires_in;
    this.scope = _scope;
    this.logged_in = _logged_in;
    this.url = _url;
  }

  createAccount(newId) {
    this.oAccount = new objoAccount("", newId, "", "", "", "", "");
  }

  String cleanedLinkParms(String item, String sep){
    return  item.split(sep)[1];
  }

  processLink(String linked){
    if(linked.contains("&")){
      List<String> l_split = linked.split("&");
      for(int i = 0; i<l_split.length;i++){
        if(l_split[i].contains("access_token=")){
          this.token = cleanedLinkParms(l_split[i],"access_token=");
        }else if(l_split[i].contains("expires_in=")){
          this.expires_in = cleanedLinkParms(l_split[i],"expires_in=");
        }
      }
      //print(l_split[0].split("access_token=")[1]); //token
    }
  }

  Future<http.Response> getData(String link, String path,var parms){
    return http.get(Uri.https(link, path,parms));
  }

}

class objoFacebook extends objoLogin {
  objoFacebook(_redirect_url) {
    this.oauth_url = "https://facebook.com/dialog/oauth?";
    this.valid_url =
        "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=";
    this.client_id = "461378741640304";
    this.redirect_url = _redirect_url;
    this.logout_url = "http://accounts.google.com/Logout";
    //_login_url,
    this.token = "";
    this.expires_in = "";
    this.scope = "";
    this.logged_in = "";

    this.url = this.oauth_url +
        "&client_id=" +
        this.client_id +
        "&redirect_uri=" +
        _redirect_url +
        "&response_type=token";
  }

  checkToken() async {
    final _authority = "graph.facebook.com";
    final _path = "/me";
    final _params = { "access_token" : this.token };
    //Response response = await get(Uri.https(_authority, _path, _params));
    var data = await this.getData(_authority, _path, _params);
    Map<String, dynamic> user = jsonDecode(data.body);
    try{
      this.createAccount(user['id']);
      return true;
      //print(this.oAccount.id);
    }catch(e){
      print("unable to capture id");
    }
    //print(data.body);
    return false;
  }

  getAccount() async {
    final _authority = "graph.facebook.com";
    final _path = "/" + this.oAccount.id;
    final _params = { "fields" : "birthday,first_name,last_name,picture,email", "access_token":this.token};
    //Response response = await get(Uri.https(_authority, _path, _params));
    var data = await this.getData(_authority, _path, _params);
    Map<String, dynamic> user = jsonDecode(data.body);
    try{
      //print(user['last_name']);
      this.oAccount.birthday = user['birthday'];
      this.oAccount.first_name = user['first_name'];
      this.oAccount.last_name = user['last_name'];
      this.oAccount.email = user['email'];
      try {
        this.oAccount.picture = user["picture"]["data"]["url"];
      } catch (e) {
        print("failed to grab fb pic");
      }

      return true;
      //print(this.oAccount.id);
    }catch(e){
      print("unable to capture id");
    }
    //print(data.body);
    return false;
  }

}
