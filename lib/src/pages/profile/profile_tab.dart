import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/pages/auth/controllers/auth_controller.dart';
import 'package:app/src/pages/widgets/costom_text_field.dart';
import 'package:app/src/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

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
            onPressed: () {
              authController.signOut();
            },
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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              children: [
                CustomTextField(
                  readOnly: true,
                  icon: Icons.email,
                  label: 'Email',
                  initialValue: authController.user.email,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.person,
                  label: 'Nome',
                  initialValue: authController.user.name,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.phone,
                  label: 'Celular',
                  initialValue: authController.user.phone,
                ),
                CustomTextField(
                  readOnly: true,
                  icon: Icons.file_copy,
                  label: 'CPF',
                  isSecret: true,
                  initialValue: authController.user.cpf,
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
                      onPressed: () {
                        updatePassword();
                      },
                      child: const Text('Atualizar senha'),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: currentPasswordController,
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        controller: newPasswordController,
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar nova senha',
                        isSecret: true,
                        validator: (password) {
                          final result = passwordValidator(password);
                          if (result != null) {
                            return result;
                          }

                          if (password != newPasswordController.text) {
                            return 'As senhas não são iguais';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 45,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      authController.changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Atualizar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
