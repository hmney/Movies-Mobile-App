import 'package:app/src/UI/Signup/signup_screen.dart';
import 'package:app/src/blocs/Auth/auth_bloc.dart';
import 'package:app/src/data/repositories/user_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/Login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserRepository get _userRepository => widget._userRepository;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login succeed'), Icon(Icons.check)],
                ),
                backgroundColor: Colors.green,
              ),
            );
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    _loginScreenLogo(context),
                    _emailTextField(context, state),
                    _passwordTextField(context, state),
                    _loginButton(context, state),
                    _socialMediaLogin(context),
                    _signup(context)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Widget _loginScreenLogo(BuildContext context) {
    return Container(
      width: 170,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 60, 0, 60),
      padding: EdgeInsets.all(0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
        ),
      ]),
      child: Image.asset('assets/images/LoginSignupLogo.png'),
    );
  }

  Widget _emailTextField(BuildContext context, LoginState state) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 0, 35, 5),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Theme.of(context).accentColor),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gapPadding: 0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gapPadding: 0),
          hintStyle: TextStyle(color: Theme.of(context).accentColor),
        ),
        validator: (_) {
          return !state.isEmailValid ? 'Invalid Email' : null;
        },
      ),
    );
  }

  Widget _passwordTextField(BuildContext context, LoginState state) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gapPadding: 0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gapPadding: 0),
            hintStyle: TextStyle(color: Theme.of(context).accentColor)),
        validator: (_) {
          return !state.isPasswordValid ? 'Invalid Password' : null;
        },
      ),
    );
  }

  Widget _loginButton(BuildContext context, LoginState state) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
      width: 290,
      height: 55,
      child: RaisedButton(
        child: Text('LOGIN'),
        textColor: Colors.white,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _onFormSubmitted,
      ),
    );
  }

  Widget _socialMediaLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Or sign-in with',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Image.asset('assets/images/facebookIcon.png'),
                    iconSize: 35,
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: IconButton(
                    highlightColor: Colors.black,
                    icon: Image.asset('assets/images/googleIcon.png'),
                    iconSize: 35,
                    onPressed: () {
                      _loginBloc.add(LoginWithGooglePressed());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Dont have an account?',
              style: TextStyle(color: Theme.of(context).accentColor)),
          TextSpan(
              text: ' SignUp',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return SignupScreen(userRepository: _userRepository);
                    }),
                  );
                })
        ]),
      ),
    );
  }
}
