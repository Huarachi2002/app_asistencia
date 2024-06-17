import 'package:app_asistencia/config/api/apiServicio.dart';
import 'package:app_asistencia/config/theme/paletaColors.dart';
import 'package:app_asistencia/provider/user_provider.dart';
import 'package:app_asistencia/widget/custom_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String correo_text = '';
  String errorMessage = '';
  String errorPassword = '';
  String password_text = '';

  Future<void> loginUser(BuildContext context) async{
    context.go('/home');
    // try {
    //   print('$correo_text $password_text');
    //   final response = await dio.post(
    //     '/auth/login',
    //     data: { 
    //       'username': correo_text,
    //       'password': password_text,
    //     },
    //   );
    //   print(response.data);
    //   final idUser = response.data['id'];
    //   final tokenUser = response.data['token'];
    //   context.read<UserProvider>().changeUserEmail(newUserEmail: correo_text, newId: idUser.toString(), newToken: tokenUser );
    //   context.go('/home');

    // }on DioException catch (e) {
    //     print('data: ${e.response!.data}');
    //     print('headers: ${e.response!.headers}');
    //     print('requestOptions: ${e.response!.requestOptions}');
    //     if(e.response != null){
    //       setState(() {
    //       });
    //     }
    // } 
  }

  String? validatorCorreo (String? value){
    if(value == null || value.isEmpty || value.trim().isEmpty ) return 'Campo requerido';
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    if(!emailRegExp.hasMatch(value)) return 'No tiene formato de correo';
    return null;
  }

  String? validatorPassword (String? value){
    if(value == null || value.isEmpty || value.trim().isEmpty ) return 'Campo requerido';
    return null;
  }

  void onChangedCorreo (String value)  {
    correo_text = value;
  }
  void onChangedPassword (String value)  {
    password_text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DOCENTECHECK', 
              style: TextStyle(
                fontFamily: AutofillHints.email,
                color: Colors.white,
                fontSize: 29,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            const Text(
              'INICIAR SESIÓN', 
              style: TextStyle(
                fontFamily: AutofillHints.email,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CustomFormField(
              errorMessage: errorMessage, 
              label: 'Correo Electronico', 
              hint: 'example@gmail.com',
              icon: const Icon(Icons.email_outlined, size: 25,), 
              onChanged: onChangedCorreo,
              validator: validatorCorreo,
              obscureText: false,
            ),
            const SizedBox(height: 30,),
            CustomFormField(
              errorMessage: errorPassword, 
              label: 'Contaseña', 
              hint: '',
              icon: const Icon(Icons.vpn_key_rounded, size: 25,),
              onChanged: onChangedPassword,
              validator: validatorPassword,
              obscureText: true,
            ),
            
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if(!isValid) return;
                loginUser(context);
              }, 
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
              ),
              child: const Text(
                'Ingresar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              )
            ),
            SizedBox(width: MediaQuery.of(context).size.height * 0.1,),
          ],
        ),
      ),
    );
  }
}