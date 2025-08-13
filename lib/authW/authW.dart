import 'package:flutter/material.dart';
import 'package:prog_lazy_f/mainScreenW/mainScreenW.dart';

class AuthorizW extends StatefulWidget {
  const AuthorizW({super.key});
  @override
  State<AuthorizW> createState() => _AuthorizW();
}

class _AuthorizW extends State<AuthorizW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log in your account')),
      body: AuthorizBuilder(),
    );
  }
}

class AuthorizBuilder extends StatefulWidget {
  @override
  State<AuthorizBuilder> createState() => _AuthorizBuilderState();
}

class _AuthorizBuilderState extends State<AuthorizBuilder> {
  final loginTextController = TextEditingController();
  final passworldTextController = TextEditingController();
  String? errorText;

  void _auth() {
    final login = loginTextController.text;
    final passw = passworldTextController.text;
    if (login == 'admin' && passw == 'admin') {
      // bad pracktick
      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(builder: (context) => MainScreenW()));

      Navigator.of(context).pushReplacementNamed('/main'); // no back

      errorText = null;
    } else {
      errorText = 'Error in login or passworld';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Text('E-mail'),
          TextField(
            controller: loginTextController,
            decoration: InputDecoration(labelText: 'e-mail'),
          ),
          SizedBox(height: 18),
          Text('Passworld'),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'passworld'),
            controller: passworldTextController,
          ),
          SizedBox(height: 15),
          if (errorText != null) ...[
            Text('$errorText', style: TextStyle(color: Colors.red)),
            SizedBox(height: 15),
          ],

          Row(
            children: [
              ElevatedButton(
                onPressed: _auth,
                child: Text('Login'),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
              SizedBox(width: 30),
              TextButton(
                onPressed: () {},
                child: Text('Reset psssworld'),
                style: Theme.of(context).textButtonTheme.style,
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Stream or download all our movies, anytime. On any screen or device, anywhere. From cult classics to modern masterpieces. From the greatest ever directors, to the greatest new directors. Films from everywhere on earth.',
          ),
          TextButton(onPressed: () {}, child: Text('Registration')),
          SizedBox(height: 25),
          Text(
            'Read a print magazine devoted to the art and the culture of cinema. Created, prepared, and published by MUBI. Receive two beautiful issues a year. Available worldwide with a magazine subscription.',
          ),
          TextButton(onPressed: () {}, child: Text('Veryfy e-mail')),
        ],
      ),
    );
  }
}
