String? emailValidator(email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email';
  }
  if (!email.isEmail) return 'Email invalido';

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }

  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres';
  }

  return null;
}

String? nameValidator(name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }

  final names = name.split(' ');

  if (names.length == 1) return 'Digite seu nome completo';
  return null;
}

String? phoneValidator(phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular';
  }

  if (!phone.isPhoneNumber) return 'Digite um número válido';
  return null;
}

String? cpfValidator(cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um cpf';
  }

  if (!cpf.isCpf) return 'Digite um cpf valido';

  return null;
}
