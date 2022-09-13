import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/widgets/costom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app/src/config/app_data.dart' as app_data;

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Olá ${app_data.user.name}.'),
          // ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              children: [
                CustomTextField(
                  readOnly: true,
                  icon: Icons.email,
                  label: 'Email',
                  initialValue: app_data.user.email,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.person,
                  label: 'Nome',
                  initialValue: app_data.user.name,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.phone,
                  label: 'Celular',
                  initialValue: app_data.user.phone,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.file_copy,
                  label: 'CPF',
                  isSecret: true,
                  initialValue: app_data.user.cpf,
                ),
                SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: CustomColors.customSwatchColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {},
                      child: const Text('Atualizar senha'),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
