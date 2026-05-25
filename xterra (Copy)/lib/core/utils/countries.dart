class Country {
  final String name;
  final String flag;
  final String dialCode;
  final String code;
  final int minLength; // minimum digits expected for a valid local number

  const Country({
    required this.name,
    required this.flag,
    required this.dialCode,
    required this.code,
    this.minLength = 7,
  });
}

const Country kDefaultCountry = Country(
  name: 'India',
  flag: '🇮🇳',
  dialCode: '+91',
  code: 'IN',
  minLength: 10,
);

const List<Country> kCountries = [
  // ── Asia ──────────────────────────────────────────────────────────────────
  Country(name: 'India',        flag: '🇮🇳', dialCode: '+91',  code: 'IN', minLength: 10),
  Country(name: 'Pakistan',     flag: '🇵🇰', dialCode: '+92',  code: 'PK', minLength: 10),
  Country(name: 'Bangladesh',   flag: '🇧🇩', dialCode: '+880', code: 'BD', minLength: 10),
  Country(name: 'Sri Lanka',    flag: '🇱🇰', dialCode: '+94',  code: 'LK', minLength: 9),
  Country(name: 'Nepal',        flag: '🇳🇵', dialCode: '+977', code: 'NP', minLength: 10),
  Country(name: 'Singapore',    flag: '🇸🇬', dialCode: '+65',  code: 'SG', minLength: 8),
  Country(name: 'Malaysia',     flag: '🇲🇾', dialCode: '+60',  code: 'MY', minLength: 9),
  Country(name: 'Indonesia',    flag: '🇮🇩', dialCode: '+62',  code: 'ID', minLength: 9),
  Country(name: 'Philippines',  flag: '🇵🇭', dialCode: '+63',  code: 'PH', minLength: 10),
  Country(name: 'Thailand',     flag: '🇹🇭', dialCode: '+66',  code: 'TH', minLength: 9),
  Country(name: 'Vietnam',      flag: '🇻🇳', dialCode: '+84',  code: 'VN', minLength: 9),
  Country(name: 'China',        flag: '🇨🇳', dialCode: '+86',  code: 'CN', minLength: 11),
  Country(name: 'Japan',        flag: '🇯🇵', dialCode: '+81',  code: 'JP', minLength: 10),
  Country(name: 'South Korea',  flag: '🇰🇷', dialCode: '+82',  code: 'KR', minLength: 10),
  Country(name: 'Hong Kong',    flag: '🇭🇰', dialCode: '+852', code: 'HK', minLength: 8),

  // ── Middle East ───────────────────────────────────────────────────────────
  Country(name: 'UAE',          flag: '🇦🇪', dialCode: '+971', code: 'AE', minLength: 9),
  Country(name: 'Saudi Arabia', flag: '🇸🇦', dialCode: '+966', code: 'SA', minLength: 9),
  Country(name: 'Qatar',        flag: '🇶🇦', dialCode: '+974', code: 'QA', minLength: 8),
  Country(name: 'Kuwait',       flag: '🇰🇼', dialCode: '+965', code: 'KW', minLength: 8),
  Country(name: 'Bahrain',      flag: '🇧🇭', dialCode: '+973', code: 'BH', minLength: 8),
  Country(name: 'Oman',         flag: '🇴🇲', dialCode: '+968', code: 'OM', minLength: 8),
  Country(name: 'Jordan',       flag: '🇯🇴', dialCode: '+962', code: 'JO', minLength: 9),
  Country(name: 'Lebanon',      flag: '🇱🇧', dialCode: '+961', code: 'LB', minLength: 8),
  Country(name: 'Israel',       flag: '🇮🇱', dialCode: '+972', code: 'IL', minLength: 9),
  Country(name: 'Turkey',       flag: '🇹🇷', dialCode: '+90',  code: 'TR', minLength: 10),

  // ── Europe ────────────────────────────────────────────────────────────────
  Country(name: 'United Kingdom',  flag: '🇬🇧', dialCode: '+44',  code: 'GB', minLength: 10),
  Country(name: 'Germany',         flag: '🇩🇪', dialCode: '+49',  code: 'DE', minLength: 10),
  Country(name: 'France',          flag: '🇫🇷', dialCode: '+33',  code: 'FR', minLength: 9),
  Country(name: 'Italy',           flag: '🇮🇹', dialCode: '+39',  code: 'IT', minLength: 10),
  Country(name: 'Spain',           flag: '🇪🇸', dialCode: '+34',  code: 'ES', minLength: 9),
  Country(name: 'Netherlands',     flag: '🇳🇱', dialCode: '+31',  code: 'NL', minLength: 9),
  Country(name: 'Belgium',         flag: '🇧🇪', dialCode: '+32',  code: 'BE', minLength: 9),
  Country(name: 'Switzerland',     flag: '🇨🇭', dialCode: '+41',  code: 'CH', minLength: 9),
  Country(name: 'Austria',         flag: '🇦🇹', dialCode: '+43',  code: 'AT', minLength: 10),
  Country(name: 'Sweden',          flag: '🇸🇪', dialCode: '+46',  code: 'SE', minLength: 9),
  Country(name: 'Norway',          flag: '🇳🇴', dialCode: '+47',  code: 'NO', minLength: 8),
  Country(name: 'Denmark',         flag: '🇩🇰', dialCode: '+45',  code: 'DK', minLength: 8),
  Country(name: 'Finland',         flag: '🇫🇮', dialCode: '+358', code: 'FI', minLength: 9),
  Country(name: 'Portugal',        flag: '🇵🇹', dialCode: '+351', code: 'PT', minLength: 9),
  Country(name: 'Poland',          flag: '🇵🇱', dialCode: '+48',  code: 'PL', minLength: 9),
  Country(name: 'Russia',          flag: '🇷🇺', dialCode: '+7',   code: 'RU', minLength: 10),
  Country(name: 'Ukraine',         flag: '🇺🇦', dialCode: '+380', code: 'UA', minLength: 9),
  Country(name: 'Romania',         flag: '🇷🇴', dialCode: '+40',  code: 'RO', minLength: 9),
  Country(name: 'Czech Republic',  flag: '🇨🇿', dialCode: '+420', code: 'CZ', minLength: 9),
  Country(name: 'Hungary',         flag: '🇭🇺', dialCode: '+36',  code: 'HU', minLength: 9),
  Country(name: 'Greece',          flag: '🇬🇷', dialCode: '+30',  code: 'GR', minLength: 10),
  Country(name: 'Ireland',         flag: '🇮🇪', dialCode: '+353', code: 'IE', minLength: 9),

  // ── Americas ──────────────────────────────────────────────────────────────
  Country(name: 'United States', flag: '🇺🇸', dialCode: '+1',  code: 'US', minLength: 10),
  Country(name: 'Canada',        flag: '🇨🇦', dialCode: '+1',  code: 'CA', minLength: 10),
  Country(name: 'Brazil',        flag: '🇧🇷', dialCode: '+55', code: 'BR', minLength: 11),
  Country(name: 'Mexico',        flag: '🇲🇽', dialCode: '+52', code: 'MX', minLength: 10),
  Country(name: 'Argentina',     flag: '🇦🇷', dialCode: '+54', code: 'AR', minLength: 10),
  Country(name: 'Colombia',      flag: '🇨🇴', dialCode: '+57', code: 'CO', minLength: 10),
  Country(name: 'Chile',         flag: '🇨🇱', dialCode: '+56', code: 'CL', minLength: 9),

  // ── Africa ────────────────────────────────────────────────────────────────
  Country(name: 'South Africa', flag: '🇿🇦', dialCode: '+27',  code: 'ZA', minLength: 9),
  Country(name: 'Nigeria',      flag: '🇳🇬', dialCode: '+234', code: 'NG', minLength: 10),
  Country(name: 'Kenya',        flag: '🇰🇪', dialCode: '+254', code: 'KE', minLength: 9),
  Country(name: 'Ghana',        flag: '🇬🇭', dialCode: '+233', code: 'GH', minLength: 9),
  Country(name: 'Ethiopia',     flag: '🇪🇹', dialCode: '+251', code: 'ET', minLength: 9),
  Country(name: 'Egypt',        flag: '🇪🇬', dialCode: '+20',  code: 'EG', minLength: 10),
  Country(name: 'Tanzania',     flag: '🇹🇿', dialCode: '+255', code: 'TZ', minLength: 9),
  Country(name: 'Uganda',       flag: '🇺🇬', dialCode: '+256', code: 'UG', minLength: 9),
  Country(name: 'Zimbabwe',     flag: '🇿🇼', dialCode: '+263', code: 'ZW', minLength: 9),

  // ── Oceania ───────────────────────────────────────────────────────────────
  Country(name: 'Australia',   flag: '🇦🇺', dialCode: '+61', code: 'AU', minLength: 9),
  Country(name: 'New Zealand', flag: '🇳🇿', dialCode: '+64', code: 'NZ', minLength: 9),
];
