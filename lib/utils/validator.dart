bool validateEmail(String email) {
  // Regular expression untuk validasi email
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
    multiLine: false,
  );

  // Daftar domain email yang valid
  final validDomains = [
    'gmail.com',
    'yahoo.com',
    'yahoo.co.id',
    'hotmail.com',
    'outlook.com',
    'live.com',
    'aol.com',
    'icloud.com',
    'mail.com',
    'protonmail.com',
    'zoho.com',
    'yandex.com',
  ];

  // Validasi dasar menggunakan regex
  if (!emailRegex.hasMatch(email)) {
    return false;
  }

  try {
    // Validasi tambahan
    // Periksa panjang email
    if (email.length > 254) {
      return false;
    }

    // Periksa bagian local (sebelum @) tidak lebih dari 64 karakter
    final localPart = email.split('@')[0];
    if (localPart.length > 64) {
      return false;
    }

    // Periksa tidak ada double dots
    if (email.contains('..')) {
      return false;
    }

    // Periksa karakter pertama dan terakhir bukan titik
    if (email.startsWith('.') || email.endsWith('.')) {
      return false;
    }

    // Validasi domain
    final domain = email.split('@')[1].toLowerCase();
    if (!validDomains.contains(domain)) {
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}
