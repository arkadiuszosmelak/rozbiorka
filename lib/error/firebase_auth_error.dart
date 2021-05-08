class FirebaseAuthError {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Ten adres email jest już używany. Spróbuj użyć innego adresu email.';

      case 'user-not-found':
        return 'Nie znaleziono użytkownika o danym adresie email.';

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'Ten adres e-mail jest już zarejestrowany. Spróbuj użyć innego adresu e-mail.';

      case 'wrong-password':
        return 'Adres email, bądź hasło jest nieprawidłowe.';

      case 'too-many-requests':
        return 'Zbyt dużo nieudanych prób! Spróbuj ponownie później.';

      default:
        return 'Nastąpił nieoczekiwany błąd. Sprawdź połączenie sieciowe lub spróbuj ponownie później.';
    }
  }
}
