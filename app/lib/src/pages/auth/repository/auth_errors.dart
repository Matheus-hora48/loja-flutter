String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha invalidos';

    case 'Invalid session token':
      return 'Token Invalido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido';

    default:
      return 'Um erro indefinido ocorreu';
  }
}
