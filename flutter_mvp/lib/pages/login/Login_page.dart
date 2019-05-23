import 'package:flutter/material.dart';
import 'package:flutter_mvp/data/database_helper.dart';
import 'package:flutter_mvp/models/user.dart';
import 'package:flutter_mvp/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract{

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState(){
    _presenter = new LoginPagePresenter(this);
  }

  void _submit(){
    final form = formKey.currentState;
    if(form.validate()){
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }


  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginButton = new RaisedButton(
      onPressed: _submit,
      child: new Text("login"),
      color: Colors.green,
    );
    var loginForm = new Column(
       crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text("lalala", textScaleFactor: 2.0),
        new Form(
          key: formKey ,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(labelText: "username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "password"),
                ),
              )
            ],
          ),
        ),
        loginButton
      ],
     
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text("Login Page"),
      
      ),
            key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),

    );
    
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() async {
      _isLoading = false;
      
    });
    

  }

  @override
  Future onLoginSucess(User user) async {
    // TODO: implement onLoginSucess
    _showSnackBar(user.toString());
    setState(() async {
      _isLoading = false;
      
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}