String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha invalidos';
    default:
      return 'Um erro indefinido ocorreu';
  }
}
