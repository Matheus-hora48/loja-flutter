String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha invalidos';

    case 'Invalid session token':
      return 'Token Invalido';
    default:
      return 'Um erro indefinido ocorreu';
  }
}
