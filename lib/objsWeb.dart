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
}

class objLoginMaster{
  objoFacebook facebook = null;
}
