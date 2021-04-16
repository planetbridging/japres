import 'dart:async';
/*import 'dart:html';
import 'dart:js';*/
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js_util;*/

//client id = 231506545774-17vs05gjmucefv4sl14i724eouvm8mfh.apps.googleusercontent.com
//client se = fzao-n11ZKjqzH7U3JJ2rCzY

/*
final authorizationEndpoint =
    Uri.parse('http://example.com/oauth2/authorization');
final tokenEndpoint = Uri.parse('http://example.com/oauth2/token');

// The authorization server will issue each client a separate client
// identifier and secret, which allows the server to tell which client
// is accessing it. Some servers may also have an anonymous
// identifier/secret pair that any client may use.
//
// Note that clients whose source code or binary executable is readily
// available may not be able to make sure the client secret is kept a
// secret. This is fine; OAuth2 servers generally won't rely on knowing
// with certainty that a client is who it claims to be.
final identifier = '231506545774-17vs05gjmucefv4sl14i724eouvm8mfh.apps.googleusercontent.com';
final secret = 'fzao-n11ZKjqzH7U3JJ2rCzY';

// This is a URL on your application's server. The authorization server
// will redirect the resource owner here once they've authorized the
// client. The redirection will include the authorization code in the
// query parameters.
final redirectUrl = Uri.parse('http://my-site.com/oauth2-redirect');

/// A file in which the users credentials are stored persistently. If the server
/// issues a refresh token allowing the client to refresh outdated credentials,
/// these may be valid indefinitely, meaning the user never has to
/// re-authenticate.
final credentialsFile = File('~/.myapp/credentials.json');

/// Either load an OAuth2 client from saved credentials or authenticate a new
/// one.
Future<oauth2.Client> createClient() async {
  var exists = await credentialsFile.exists();

  // If the OAuth2 credentials have already been saved from a previous run, we
  // just want to reload them.
  if (exists) {
    var credentials =
        oauth2.Credentials.fromJson(await credentialsFile.readAsString());
    return oauth2.Client(credentials, identifier: identifier, secret: secret);
  }

  // If we don't have OAuth2 credentials yet, we need to get the resource owner
  // to authorize us. We're assuming here that we're a command-line application.
  var grant = oauth2.AuthorizationCodeGrant(
      identifier, authorizationEndpoint, tokenEndpoint,
      secret: secret);

  // A URL on the authorization server (authorizationEndpoint with some additional
  // query parameters). Scopes and state can optionally be passed into this method.
  var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

  // Redirect the resource owner to the authorization URL. Once the resource
  // owner has authorized, they'll be redirected to `redirectUrl` with an
  // authorization code. The `redirect` should cause the browser to redirect to
  // another URL which should also have a listener.
  //
  // `redirect` and `listen` are not shown implemented here.
  await redirect(authorizationUrl);
  var responseUrl = await listen(redirectUrl);

  // Once the user is redirected to `redirectUrl`, pass the query parameters to
  // the AuthorizationCodeGrant. It will validate them and extract the
  // authorization code to create a new Client.
  return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
}

void googleLogin() async {
  var client = await createClient();

  // Once you have a Client, you can use it just like any other HTTP client.
  print(await client.read(Uri.http('google.com', 'protected-resources.txt')));
  await credentialsFile.writeAsString(client.credentials.toJson());
}

Future<void> redirect(Uri url) async {
  // Client implementation detail
}

Future<Uri> listen(Uri url) async {
  // Client implementation detail
  return Uri();
}*/

/*loginGoogle() async{
  Future(() {
    print('Running the Future');
    var getGoogle = context.callMethod('getGoogle');
    while (true) {
      if (getGoogle != null) {
        print(getGoogle);
        break;
      }
    }
  }).then((_) {
    print('Future is complete');
  });
}*/
/*const MethodChannel _channel = const MethodChannel("channel-name");

void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  print("Our background job ran!");
}

loginGoogle(){
  

  Future<void> initialize(final Function callbackDispatcher) async {
    final callback = PluginUtilities.getCallbackHandle(callbackDispatcher);
    await _channel.invokeMethod('initialize', callback.toRawHandle());
  }
}*/


Timer interval(Duration duration, func) {
  Timer function() {
    Timer timer = new Timer(duration, function);

    func(timer);

    return timer;
  }

  return new Timer(duration, function);
}

var facebookToken = "";

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);
  String tokenPassed = "";
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    //checkFacebookToken();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  /*loginFacebook() async {
    context.callMethod(
        'loginUniversal', ["facebook", Uri.base]);
    interval(new Duration(seconds: 1), (timer) {
      //print(i++);
      var getFacebook = context.callMethod('getFacebook');
      if (getFacebook != null) {
        print(getFacebook);
        tokenPassed = getFacebook;
        timer.cancel();
      }
      //if (i > 5) timer.cancel();
    });
  }

  checkFacebookToken() {
    var getFacebook = context.callMethod('getFacebook');
    if(getFacebook != null){
      tokenPassed = getFacebook;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;

    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/imgs/card_bg.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Flexible(
                  flex: 2,
                  child: Column(children: [
                    Flexible(
                      child: ScaleTransition(
                          scale: _tween.animate(CurvedAnimation(
                              parent: _controller, curve: Curves.elasticOut)),
                          child: Image(
                            image: AssetImage("assets/imgs/blue_hair_girl.png"),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 0,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Container(
                          //height: 20,
                          //margin: const EdgeInsets.only(top: 20.0),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Choose your platform" + tokenPassed,
                                style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                ),
                              ))),
                    ),
                  ])),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      //width: double.infinity / 2,
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/training');
                          setState(() {
                            //loginTwitch();
                            //loginGoogle();
                          });
                          //runtraining
                          //hiraganamutliplechoice
                        },
                        child: Text("Google login"),
                      ),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      //width: double.infinity / 2,
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                         // loginFacebook();
                          Navigator.pushNamed(context, '/showlogin',
                              arguments: "facebook"
                          );

                        },
                        child: Text("Facebook"),
                      ),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      //width: double.infinity / 2,
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/matchall');
                        },
                        child: Text("Match all"),
                      ),
                    )),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('Main menu'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/mainmenu');
                    },
                  ),
                ),
                /*Expanded(
                  child: FlatButton(
                    child: Text('Say'),
                    onPressed: () {
                      setState(() {
                        AssetsAudioPlayer.newPlayer().open(
                          Audio("assets/mp3/yo.mp3"),
                          autoStart: true,
                        );
                      });
                    },
                  ),
                ),*/
                /*Expanded(
                  child: FlatButton(
                    child: Text('Share'),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                )*/
              ],
            ),
          )
        ]);
  }
}
