import 'package:app/src/auth/components/costom_text_field.dart';
import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(
          child: Text(
            'Cadastro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 40,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(45))),
          child: Column(children: [
            const CustomTextField(
              icon: Icons.email,
              label: 'Email',
            ),
            const CustomTextField(
              icon: Icons.lock,
              label: 'Senha',
              isSecret: true,
            ),
            const CustomTextField(
              icon: Icons.person,
              label: 'Name',
            ),
            const CustomTextField(
              icon: Icons.phone,
              label: 'Celular',
            ),
            const CustomTextField(
              icon: Icons.file_copy,
              label: 'CPF',
            ),
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cadastrar usuário'),
                ))
          ]),
        )
      ]),
    );
  }
}
