import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../model/session.dart';
import '../model/user.dart';
import '../ui/alert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String? _userId = '';
  String? _password = '';

  @override
  Widget build(BuildContext context) {
    final zeusRepository = context.read<ZeusRepository>();
    final session = context.read<Session>();

    return Scaffold(
        appBar: AppBar(title: Text('Autenticação')),
        body: Center(
            child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.all(32),
                  children: [
                    buildUserIdField(),
                    SizedBox(height: 24),
                    buildPasswordField(),
                    SizedBox(height: 24),
                    buildSubmitButton(zeusRepository, session)
                  ],
                ))));
  }

  Widget buildUserIdField() => TextFormField(
        key: Key('useridTextField'),
        decoration: InputDecoration(labelText: 'Identificador', prefixIcon: Icon(Icons.email)),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        onSaved: (value) => setState(() => _userId = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor preencha o identificador';
          } else {
            return null;
          }
        },
      );

  Widget buildPasswordField() => TextFormField(
        key: Key('passwordTextField'),
        decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.password)),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        obscureText: true,
        onSaved: (value) => setState(() => _password = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor preencha a password';
          } else {
            return null;
          }
        },
      );

  Widget buildSubmitButton(ZeusRepository zeusRepository, Session session) => ElevatedButton(
        key: Key('signInButton'),
        onPressed: () {
          AuthenticationException e;
          FocusManager.instance.primaryFocus?.unfocus(); // hide keyboard
          final isValid = formKey.currentState?.validate() ?? true;
          if (isValid) {
            formKey.currentState?.save();

            final user = User(userid: _userId!, password: _password!);

            // call search api only to check if the password is valid
            zeusRepository.searchPatients(user, 'teste').then((_) {
              session.user = user;
            }).onError((error, _) {
              if (error is AuthenticationException) {
                showAlertDialog(context, "Erro", "Credenciais inválidas");
              } else {
                showAlertDialog(context, "Erro", "Erro na comunicação com o servidor");
              }
            });
          }
        },
        child: Text('Entrar'),
      );
}
