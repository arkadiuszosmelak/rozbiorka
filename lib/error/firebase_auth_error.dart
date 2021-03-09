class FirebaseAuthError {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Ten adres email jest już używany. Spróbuj użyć innego adresu email.';

      case 'user-not-found':
        return 'Nie znaleziono użytkownika o danym adresie email.';

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.';

      case 'wrong-password':
        return 'Adres email, bądź hasło jest nieprawidłowe.';

      case 'too-many-requests':
        return 'Zbyt dużo nieudanych prób! Spróbuj ponownie później.';

      default:
        return 'Nastąpił nieoczekiwany błąd. Spróbuj ponownie później.';
    }
  }
}
