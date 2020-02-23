import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/InstanceStorage.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Accounts.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Registration.dart';
import 'package:fedi/Pleroma/Foundation/Requests/captcha.dart'
    as CaptchaRequest;
import 'package:fedi/Pleroma/Models/ClientSettings.dart';
import 'package:fedi/Pleroma/Models/captcha.dart';
import 'package:fedi/Views/Alert.dart';
import 'package:fedi/Views/ProgressDialog.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc implements Disposable {
  ProgressDialog _pr;
  final _captcha = BehaviorSubject<Captcha>.seeded(null);
  final _username = BehaviorSubject<String>.seeded("");
  final _email = BehaviorSubject<String>.seeded("");
  final _password = BehaviorSubject<String>.seeded("");
  final _confirmPassword = BehaviorSubject<String>.seeded("");
  final _userCatpchaValue = BehaviorSubject<String>.seeded("");
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username == "") {
      return;
    }
    if (username.length > 0) {
      sink.add(username);
    } else {
      sink.addError('Enter a valid username');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email == "") {
      return;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password == "") {
      return;
    }
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 4 characters');
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password == "") {
      return;
    }
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 4 characters');
    }
  });

  final validatePasswordMatch = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password != null) {
      sink.add(password);
    } else {
      sink.addError('Password and confirm password must match');
    }
  });

  // validate email
  Stream<String> get username => _username.stream.transform(validateUsername);
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get confirmPassword => _confirmPassword.stream;
  Stream<String> get passwordsMatch =>
      CombineLatestStream.combine2(password, confirmPassword,
          (String passwordValue, String confirmPasswordValue) {
        if (passwordValue == confirmPasswordValue) {
          return confirmPasswordValue;
        } else {
          return null;
        }
      }).transform(validatePasswordMatch);

  Stream<Captcha> get captcha => _captcha.stream;

  // once validation passes allow registration
  Stream<bool> get register =>
      CombineLatestStream([username, email, passwordsMatch, captcha, _userCatpchaValue], (values) {
        return true;
      });

  // Change data
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmpassword => _confirmPassword.sink.add;
  Function(String) get changeCaptch => _userCatpchaValue.sink.add;


  fetchCaptcha() {
    _captcha.add(null);
    String path = CaptchaRequest.Captcha.getNewCaptcha();
    CurrentInstance.newInstance.currentClient = Client(baseURL: "fedi.app");
    CurrentInstance.newInstance.currentClient
        .run(
      path: path,
      method: HTTPMethod.GET,
    )
        .then((response) {
      if (response.statusCode == 200) {
        Captcha resopsneCaptcha = Captcha.fromJson(jsonDecode(response.body));
        _captcha.sink.add(resopsneCaptcha);
      } else {
        _captcha.sink.addError('Password must be at least 4 characters');
      }
    }).catchError((error) {
      print(error);
    });
  }

  submit(BuildContext context) {
    final validUsername = _username.value;
    final validEmail = _email.value;
    final validPassword = _password.value;
    final captcha = _captcha.value;
    final userCaptcha = _userCatpchaValue.value;
    print(validUsername);
    print(validEmail);
    print(validPassword);
    CurrentInstance.newInstance.currentClient = Client(baseURL: "fedi.app");

    CurrentInstance.newInstance.currentClient.register().then((response) {
      if (response.statusCode != 200) {
        print(response.statusCode);
        var alert = Alert(
            context,
            AppLocalizations.of(context).tr("login.check.error.alert.title"),
            AppLocalizations.of(context).tr("login.check.error.alert.content"),
            () => {});
        alert.showAlert();
      } else {
        var bodyJson = json.decode(response.body);
        var client = new ClientSettings.fromJson(bodyJson);

        CurrentInstance.newInstance.currentClient.clientSettings = client;
        CurrentInstance.newInstance.currentClient
            .getAppAuthToken()
            .then((appResponse) {
          print("hey ${appResponse.body}");
          var appJson = json.decode(appResponse.body);
          print("THE AuTH RESPONSE  $appJson");
          print(appJson["access_token"]);
          Map<String, dynamic> params = {
            "username": validUsername,
            "email": validEmail,
            "password": validPassword,
            "agreement": true,
            "locale": "fr",
            "captcha_token": captcha.token,
            "captcha_solution": userCaptcha
          };
          print(params);
          String path = Accounts.register();

          CurrentInstance.newInstance.currentClient
              .run(
                  path: path,
                  method: HTTPMethod.POST,
                  params: params,
                  overrideAccessToken: appJson["access_token"])
              .then((registerResopnse) {
            print("respone::: ${registerResopnse.body}");
          }).catchError((error) {
            print(error);
          });
        }).catchError((error) {
          print(error);
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  static SignUpBloc of(BuildContext context) =>
      Provider.of<SignUpBloc>(context);

  dispose() {
    _username.close();
    _email.close();
    _password.close();
    _confirmPassword.close();
    _captcha.close();
    _userCatpchaValue.close();
  }
}
