import 'package:app/src/blocs/Auth/auth_bloc.dart';
import 'package:app/src/blocs/Signup/signup_bloc.dart';
import 'package:app/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  final UserRepository _userRepository;

  SignupScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc _signupBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider<SignupBloc>(
        create: (context) => _signupBloc,
        child: SignupForm(userRepository: _userRepository),
      ),
    );
  }

  @override
  void dispose() {
    _signupBloc.close();
    super.dispose();
  }
}

class SignupForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignupForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword;
  bool _obscureConfirmPassword;

  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _signupBloc,
        listener: (BuildContext context, SignupState state) {
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registering...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            Navigator.of(context).pop();
          }
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registration Failure'),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder(
            bloc: _signupBloc,
            builder: (BuildContext context, SignupState state) {
              return Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        _createAnAccount(context),
                        _emailTextField(context, state),
                        _passwordTextField(context, state),
                        _confirmPasswordTextField(context, state),
                        _signupButton(context, state),
                        _socialMediaSignup(context)
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signupBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signupBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _signupBloc.add(
      ConfirmPasswordChanged(
          confirmPassword: _confirmPasswordController.text,
          password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signupBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Widget _createAnAccount(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      alignment: Alignment.centerLeft,
      child: Text(
        'Create an account',
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 28),
      ),
    );
  }

  Widget _emailTextField(BuildContext context, SignupState state) {
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

  Widget _passwordTextField(BuildContext context, SignupState state) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
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

  Widget _confirmPasswordTextField(BuildContext context, SignupState state) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        decoration: InputDecoration(
            labelText: 'Confirm password',
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
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
          return !state.isConfirmPasswordValid
              ? 'Password dosn\'t match'
              : null;
        },
      ),
    );
  }

  Widget _signupButton(BuildContext context, SignupState state) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
      width: 290,
      height: 55,
      child: RaisedButton(
        child: Text('SIGNUP'),
        textColor: Colors.white,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _onFormSubmitted,
      ),
    );
  }

  Widget _socialMediaSignup(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Or sign-up with',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/facebookIcon.png'),
                  iconSize: 35,
                )),
                Container(
                    child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/googleIcon.png'),
                  iconSize: 35,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
