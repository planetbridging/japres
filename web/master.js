function navigationJS(path) {
  //window.location.href = path;
  window.location.replace(
    "https://facebook.com/dialog/oauth?client_id=461378741640304&redirect_uri=http://localhost:5616&response_type=token"
  );
}

class objoLogin {
  oauth_url = "";
  valid_url = "";
  client_id = "";
  redirect_url = "";
  logout_url = "";
  //login_url = "";
  token = "";
  expires_in = "";
  scope = "";
  logged_in = "";
  url = "";
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
    _url
  ) {
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

  login() {
    window.location.href = this.url;
    /*var win = window.open(this.url, "Login", "width=800,height=600");
    var timer = setInterval(function () {
      //console.log(win.location.href);
      var windowUrl = win.document.URL;
      if (win.document.URL.indexOf(this.url) != -1) {
        console.log(windowUrl);
        win.close();
      }

      if (win.closed) {
        clearInterval(timer);

        console.log(windowUrl + " closed");
      }
    }, 500);*/
  }

  processUrl(url) {
    //console.log("URL:::" + url);
    this.token = this.gup(url, "access_token");
    this.token = this.gup(url, "expires_in");
  }

  gup(url, name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regexS = "[\\#&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(url);
    if (results == null) return "";
    else return results[1];
  }
}

class objoGoogle extends objoLogin {
  constructor(_redirect_url) {
    super(
      "https://accounts.google.com/o/oauth2/auth?",
      "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=",
      "231506545774-17vs05gjmucefv4sl14i724eouvm8mfh.apps.googleusercontent.com",
      _redirect_url,
      "http://accounts.google.com/Logout",
      //_login_url,
      "",
      "",
      "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email",
      ""
    );
    this.url =
      this.oauth_url +
      "scope=" +
      this.scope +
      "&client_id=" +
      this.client_id +
      "&redirect_uri=" +
      _redirect_url +
      "&response_type=token";
    console.log(this.url);
  }

  validateToken(token) {
    $.ajax({
      url: VALIDURL + token,
      data: null,
      success: function (responseText) {
        getUserInfo();
        loggedIn = true;
        $("#loginText").hide();
        $("#logoutText").show();
      },
      dataType: "jsonp",
    });
  }

  getUserInfo() {
    $.ajax({
      url:
        "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + acToken,
      data: null,
      success: function (resp) {
        user = resp;
        console.log(user);
        $("#uName").text("Welcome " + user.name);
        $("#imgHolder").attr("src", user.picture);
      },
      dataType: "jsonp",
    });
  }
}

class objoFacebook extends objoLogin {
  constructor(_redirect_url) {
    super(
      "https://facebook.com/dialog/oauth?",
      "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=",
      "461378741640304",
      _redirect_url,
      "http://accounts.google.com/Logout",
      //_login_url,
      "",
      "",
      "",
      ""
    );
    this.url =
      this.oauth_url +
      "&client_id=" +
      this.client_id +
      "&redirect_uri=" +
      _redirect_url +
      "&response_type=token";
  }

  processUrl(url) {
    //console.log("URL:::" + url);
    this.token = this.gup(url, "access_token");
    this.token = this.gup(url, "expires_in");
  }

  validateToken(token) {
    $.ajax({
      url: VALIDURL + token,
      data: null,
      success: function (responseText) {
        getUserInfo();
        loggedIn = true;
        $("#loginText").hide();
        $("#logoutText").show();
      },
      dataType: "jsonp",
    });
  }

  getUserInfo() {
    $.ajax({
      url:
        "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + acToken,
      data: null,
      success: function (resp) {
        user = resp;
        console.log(user);
        $("#uName").text("Welcome " + user.name);
        $("#imgHolder").attr("src", user.picture);
      },
      dataType: "jsonp",
    });
  }
}

var oGoogle = null;
var oFacebook = null;

function loginUniversal(type, redirect) {
  if (type == "google") {
    oGoogle = new objoGoogle(redirect);
    oGoogle.login();
    /*objoGoogle.processUrl(
      "http://localhost/complete.html#access_token=ya29.a0AfH6SMDeFTXZsUEvOCT0M3E6gQfFXyBwGAV9MiEEZyoN-Mygz74aOapxwB5fefTIdIkB6SPBkShldjbtO57l7CHhexEPpBIm6hp35ecKaUgpIo9yDRKBe02EvHtkw9YCgBB1bSMrh_pPtdH62385fznSdwt1&token_type=Bearer&expires_in=3598&scope=email%20profile%20https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile%20openid&authuser=0&prompt=none"
    );*/
  } else if (type == "facebook") {
    oFacebook = new objoFacebook(redirect);
    oFacebook.login();
  }
}

function getGoogle() {
  return oGoogle;
}

function getFacebook() {
  return new oFacebook("http://pressback.space");
}

$(document).ready(function () {
  var url = window.document.URL;
  var token = "";
  if (url.includes("access_token")) {
    token = process_gup(url, "access_token");
    print(token);
    print("YAYY");
  }
});

function process_gup(url, name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regexS = "[\\#&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(url);
  if (results == null) return "";
  else return results[1];
}
