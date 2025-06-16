import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// Application Name
  ///
  /// In nl, this message translates to:
  /// **'LGMU'**
  String get appName;

  /// No description provided for @common_cancel.
  ///
  /// In nl, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @we_are_purebred_cats.
  ///
  /// In nl, this message translates to:
  /// **'Wij Zijn Raszuivere Katten'**
  String get we_are_purebred_cats;

  /// No description provided for @sign_up.
  ///
  /// In nl, this message translates to:
  /// **'Aanmelden'**
  String get sign_up;

  /// No description provided for @email_hint.
  ///
  /// In nl, this message translates to:
  /// **'bijv. Abc@gmail.com'**
  String get email_hint;

  /// No description provided for @email_label.
  ///
  /// In nl, this message translates to:
  /// **'E-mail *'**
  String get email_label;

  /// No description provided for @password_hint.
  ///
  /// In nl, this message translates to:
  /// **'*****'**
  String get password_hint;

  /// No description provided for @password_label.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord *'**
  String get password_label;

  /// No description provided for @i_agree_to.
  ///
  /// In nl, this message translates to:
  /// **'Ik ga akkoord met de '**
  String get i_agree_to;

  /// No description provided for @terms_and_conditions.
  ///
  /// In nl, this message translates to:
  /// **'Algemene voorwaarden'**
  String get terms_and_conditions;

  /// No description provided for @and.
  ///
  /// In nl, this message translates to:
  /// **' en '**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In nl, this message translates to:
  /// **'Privacybeleid.'**
  String get privacy_policy;

  /// No description provided for @already_have_account.
  ///
  /// In nl, this message translates to:
  /// **'Heb je al een account?'**
  String get already_have_account;

  /// No description provided for @log_in.
  ///
  /// In nl, this message translates to:
  /// **'Inloggen'**
  String get log_in;

  /// No description provided for @verification.
  ///
  /// In nl, this message translates to:
  /// **'Verificatie'**
  String get verification;

  /// No description provided for @we_have_sent_you_an_email.
  ///
  /// In nl, this message translates to:
  /// **'We hebben je een e-mail gestuurd met de verificatiecode. Voer de code in om je e-mailadres te verifiëren.'**
  String get we_have_sent_you_an_email;

  /// No description provided for @verification_code.
  ///
  /// In nl, this message translates to:
  /// **'Verificatiecode'**
  String get verification_code;

  /// No description provided for @submit.
  ///
  /// In nl, this message translates to:
  /// **'Verzenden'**
  String get submit;

  /// No description provided for @have_not_received.
  ///
  /// In nl, this message translates to:
  /// **'Code niet ontvangen?'**
  String get have_not_received;

  /// No description provided for @resend.
  ///
  /// In nl, this message translates to:
  /// **'Opnieuw verzenden'**
  String get resend;

  /// No description provided for @or.
  ///
  /// In nl, this message translates to:
  /// **'Of'**
  String get or;

  /// No description provided for @signup_with_google.
  ///
  /// In nl, this message translates to:
  /// **'Aanmelden met Google'**
  String get signup_with_google;

  /// No description provided for @password_must_contain.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord moet bevatten:'**
  String get password_must_contain;

  /// No description provided for @atleast_6_character.
  ///
  /// In nl, this message translates to:
  /// **'Minimaal 6 tekens'**
  String get atleast_6_character;

  /// No description provided for @atleast_1_upper.
  ///
  /// In nl, this message translates to:
  /// **'Minimaal 1 hoofdletter (A-Z)'**
  String get atleast_1_upper;

  /// No description provided for @atleast_1_lower.
  ///
  /// In nl, this message translates to:
  /// **'Minimaal 1 kleine letter (a-z)'**
  String get atleast_1_lower;

  /// No description provided for @atleast_1_number.
  ///
  /// In nl, this message translates to:
  /// **'Minimaal 1 cijfer (0-9)'**
  String get atleast_1_number;

  /// No description provided for @password_must_be_6_characters.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord moet minimaal 6 tekens lang zijn'**
  String get password_must_be_6_characters;

  /// No description provided for @password_must_contain_6_upper.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord moet minimaal één hoofdletter bevatten'**
  String get password_must_contain_6_upper;

  /// No description provided for @password_must_contain_6_lower.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord moet minimaal één kleine letter bevatten'**
  String get password_must_contain_6_lower;

  /// No description provided for @password_must_contain_1_number.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord moet minimaal één cijfer bevatten'**
  String get password_must_contain_1_number;

  /// No description provided for @login.
  ///
  /// In nl, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgot_your_password.
  ///
  /// In nl, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_your_password;

  /// No description provided for @not_registered_yet.
  ///
  /// In nl, this message translates to:
  /// **'Not Registered Yet?'**
  String get not_registered_yet;

  /// No description provided for @login_with_google.
  ///
  /// In nl, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @back.
  ///
  /// In nl, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @please_enter_the_email.
  ///
  /// In nl, this message translates to:
  /// **'Please enter the email you have signed up with. We will send you a link to reset your password'**
  String get please_enter_the_email;

  /// No description provided for @onboarding_title_1.
  ///
  /// In nl, this message translates to:
  /// **'Level up your breeding journey'**
  String get onboarding_title_1;

  /// No description provided for @an_ultimate_space.
  ///
  /// In nl, this message translates to:
  /// **'An ultimate space for certified breeders to '**
  String get an_ultimate_space;

  /// No description provided for @breed.
  ///
  /// In nl, this message translates to:
  /// **'Breed'**
  String get breed;

  /// No description provided for @comma_space.
  ///
  /// In nl, this message translates to:
  /// **', '**
  String get comma_space;

  /// No description provided for @record.
  ///
  /// In nl, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @rehome.
  ///
  /// In nl, this message translates to:
  /// **'Re-home'**
  String get rehome;

  /// No description provided for @rehomed.
  ///
  /// In nl, this message translates to:
  /// **'Re-homed'**
  String get rehomed;

  /// No description provided for @deceased.
  ///
  /// In nl, this message translates to:
  /// **'Deceased'**
  String get deceased;

  /// No description provided for @in_one_place.
  ///
  /// In nl, this message translates to:
  /// **' in one place'**
  String get in_one_place;

  /// No description provided for @onboarding_title_2.
  ///
  /// In nl, this message translates to:
  /// **'Say goodbye to papers & excel sheets'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_subtitle_2.
  ///
  /// In nl, this message translates to:
  /// **'Collect all your cats data in one app'**
  String get onboarding_subtitle_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In nl, this message translates to:
  /// **'Re-home your cats globally'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_subtitle_3.
  ///
  /// In nl, this message translates to:
  /// **'Efficient & fast process to reach every cat lover on the planet'**
  String get onboarding_subtitle_3;

  /// No description provided for @next.
  ///
  /// In nl, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In nl, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @skip.
  ///
  /// In nl, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @save.
  ///
  /// In nl, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @name.
  ///
  /// In nl, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In nl, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @litter.
  ///
  /// In nl, this message translates to:
  /// **'Litter'**
  String get litter;

  /// No description provided for @sire_name.
  ///
  /// In nl, this message translates to:
  /// **'Sire Name'**
  String get sire_name;

  /// No description provided for @dam_name.
  ///
  /// In nl, this message translates to:
  /// **'Dam Name'**
  String get dam_name;

  /// No description provided for @input_name.
  ///
  /// In nl, this message translates to:
  /// **'Input Name'**
  String get input_name;

  /// No description provided for @basic_information.
  ///
  /// In nl, this message translates to:
  /// **'Basic Information'**
  String get basic_information;

  /// No description provided for @main_cat.
  ///
  /// In nl, this message translates to:
  /// **'Main Cat'**
  String get main_cat;

  /// No description provided for @kitten.
  ///
  /// In nl, this message translates to:
  /// **'Kitten'**
  String get kitten;

  /// No description provided for @please_try_again_with_a_password.
  ///
  /// In nl, this message translates to:
  /// **'Please try again with a password that meets all these requirements.'**
  String get please_try_again_with_a_password;

  /// No description provided for @please_setup_a_password.
  ///
  /// In nl, this message translates to:
  /// **'Please setup a password first'**
  String get please_setup_a_password;

  /// No description provided for @please_check_your_email_for_verification_link.
  ///
  /// In nl, this message translates to:
  /// **'Please check your email for the verification link. If you don\'t see it in your inbox, be sure to check your spam or junk folder as well.'**
  String get please_check_your_email_for_verification_link;

  /// No description provided for @a_password_reset_email_has_been_sent.
  ///
  /// In nl, this message translates to:
  /// **'A password reset email has been sent successfully. If you don’t see it in your inbox, please check your spam or junk folder.'**
  String get a_password_reset_email_has_been_sent;

  /// No description provided for @congratulations.
  ///
  /// In nl, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @you_have_successfully.
  ///
  /// In nl, this message translates to:
  /// **'You have successfully Signed up on '**
  String get you_have_successfully;

  /// No description provided for @igmu.
  ///
  /// In nl, this message translates to:
  /// **'IGMU'**
  String get igmu;

  /// No description provided for @continue_text.
  ///
  /// In nl, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @birth_date.
  ///
  /// In nl, this message translates to:
  /// **'Birth-Date'**
  String get birth_date;

  /// No description provided for @dd_mm_yyyy_hint.
  ///
  /// In nl, this message translates to:
  /// **'DD/MM/YYYY'**
  String get dd_mm_yyyy_hint;

  /// No description provided for @birth_time.
  ///
  /// In nl, this message translates to:
  /// **'Birth-Time'**
  String get birth_time;

  /// No description provided for @aa_pm_hint.
  ///
  /// In nl, this message translates to:
  /// **'12:30 AM'**
  String get aa_pm_hint;

  /// No description provided for @input.
  ///
  /// In nl, this message translates to:
  /// **'Input'**
  String get input;

  /// No description provided for @primary_color.
  ///
  /// In nl, this message translates to:
  /// **'Primary Color'**
  String get primary_color;

  /// No description provided for @color_description.
  ///
  /// In nl, this message translates to:
  /// **'Color Description'**
  String get color_description;

  /// No description provided for @shade_pattern.
  ///
  /// In nl, this message translates to:
  /// **'Shade/ Pattern'**
  String get shade_pattern;

  /// No description provided for @genotype.
  ///
  /// In nl, this message translates to:
  /// **'Genotype'**
  String get genotype;

  /// No description provided for @polydactyl.
  ///
  /// In nl, this message translates to:
  /// **'Polydactyl'**
  String get polydactyl;

  /// No description provided for @dam_breed.
  ///
  /// In nl, this message translates to:
  /// **'Dam Breed'**
  String get dam_breed;

  /// No description provided for @dam_ems_code.
  ///
  /// In nl, this message translates to:
  /// **'Dam EMS Code'**
  String get dam_ems_code;

  /// No description provided for @sire_breed.
  ///
  /// In nl, this message translates to:
  /// **'Sire Breed'**
  String get sire_breed;

  /// No description provided for @sire_ems_code.
  ///
  /// In nl, this message translates to:
  /// **'Sire EMS Code'**
  String get sire_ems_code;

  /// No description provided for @show_organizer.
  ///
  /// In nl, this message translates to:
  /// **'Show organizer'**
  String get show_organizer;

  /// No description provided for @award.
  ///
  /// In nl, this message translates to:
  /// **'Award'**
  String get award;

  /// No description provided for @date.
  ///
  /// In nl, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @trophies.
  ///
  /// In nl, this message translates to:
  /// **'Trophies'**
  String get trophies;

  /// No description provided for @full_name.
  ///
  /// In nl, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @phone_number.
  ///
  /// In nl, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @address.
  ///
  /// In nl, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @final_price.
  ///
  /// In nl, this message translates to:
  /// **'Final Price'**
  String get final_price;

  /// No description provided for @date_of_sales.
  ///
  /// In nl, this message translates to:
  /// **'Date of Sales'**
  String get date_of_sales;

  /// No description provided for @organization.
  ///
  /// In nl, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @upload_file.
  ///
  /// In nl, this message translates to:
  /// **'Upload File'**
  String get upload_file;

  /// No description provided for @welcome_to_igmu.
  ///
  /// In nl, this message translates to:
  /// **'Welcome to IGMU!'**
  String get welcome_to_igmu;

  /// No description provided for @your_14_day_trial.
  ///
  /// In nl, this message translates to:
  /// **'Your {noOfDays}-day free trial starts today. \nEnjoy exploring all our features!'**
  String your_14_day_trial(String noOfDays);

  /// No description provided for @i_understand.
  ///
  /// In nl, this message translates to:
  /// **'I understand'**
  String get i_understand;

  /// No description provided for @continue_with_google.
  ///
  /// In nl, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @death_type.
  ///
  /// In nl, this message translates to:
  /// **'Death Type'**
  String get death_type;

  /// No description provided for @date_is_required.
  ///
  /// In nl, this message translates to:
  /// **'Date is required'**
  String get date_is_required;

  /// No description provided for @reason.
  ///
  /// In nl, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @reason_is_required.
  ///
  /// In nl, this message translates to:
  /// **'Reason is required'**
  String get reason_is_required;

  /// No description provided for @date_of_death.
  ///
  /// In nl, this message translates to:
  /// **'Date of Death'**
  String get date_of_death;

  /// No description provided for @veterinarian_who_performed_it.
  ///
  /// In nl, this message translates to:
  /// **'Veterinarian who performed it'**
  String get veterinarian_who_performed_it;

  /// No description provided for @veterinarian_name_is_required.
  ///
  /// In nl, this message translates to:
  /// **'Veterinarian Name is required'**
  String get veterinarian_name_is_required;

  /// No description provided for @deceased_cat_record.
  ///
  /// In nl, this message translates to:
  /// **'Deceased Cat Record'**
  String get deceased_cat_record;

  /// No description provided for @add_weight.
  ///
  /// In nl, this message translates to:
  /// **'Add Weight'**
  String get add_weight;

  /// No description provided for @weight.
  ///
  /// In nl, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @weight_is_required.
  ///
  /// In nl, this message translates to:
  /// **'Weight is required'**
  String get weight_is_required;

  /// No description provided for @update.
  ///
  /// In nl, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @main_cats.
  ///
  /// In nl, this message translates to:
  /// **'Main cats'**
  String get main_cats;

  /// No description provided for @kittens.
  ///
  /// In nl, this message translates to:
  /// **'Kittens'**
  String get kittens;

  /// No description provided for @date_hint.
  ///
  /// In nl, this message translates to:
  /// **'DD/MM/YYYY'**
  String get date_hint;

  /// No description provided for @content_creator.
  ///
  /// In nl, this message translates to:
  /// **'Content Creators'**
  String get content_creator;

  /// No description provided for @share_local_knowledge.
  ///
  /// In nl, this message translates to:
  /// **'Share Local Knowledge'**
  String get share_local_knowledge;

  /// No description provided for @help_travellers.
  ///
  /// In nl, this message translates to:
  /// **'Help Travellers'**
  String get help_travellers;

  /// No description provided for @get_paid.
  ///
  /// In nl, this message translates to:
  /// **'Get Paid'**
  String get get_paid;

  /// No description provided for @travellers.
  ///
  /// In nl, this message translates to:
  /// **'Travellers'**
  String get travellers;

  /// No description provided for @find_ready_trip_plans.
  ///
  /// In nl, this message translates to:
  /// **'Find Ready Trip Plans'**
  String get find_ready_trip_plans;

  /// No description provided for @order_bespoke_plans.
  ///
  /// In nl, this message translates to:
  /// **'Order Bespoke Plans'**
  String get order_bespoke_plans;

  /// No description provided for @made_by_human_guides.
  ///
  /// In nl, this message translates to:
  /// **'Made By Human Guides'**
  String get made_by_human_guides;

  /// No description provided for @get_started.
  ///
  /// In nl, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @continue_with_apple.
  ///
  /// In nl, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @continue_with_facebook.
  ///
  /// In nl, this message translates to:
  /// **'Continue with Facebook'**
  String get continue_with_facebook;

  /// No description provided for @sign_up_text.
  ///
  /// In nl, this message translates to:
  /// **'By Signing up to Travel Hero, means you agree to our Privacy Policy and Terms of Service'**
  String get sign_up_text;

  /// No description provided for @login_register_text.
  ///
  /// In nl, this message translates to:
  /// **'Login / Register Using'**
  String get login_register_text;

  /// No description provided for @wants_to_access_your_data_on.
  ///
  /// In nl, this message translates to:
  /// **'Wants to access your data on'**
  String get wants_to_access_your_data_on;

  /// No description provided for @sign_in_text.
  ///
  /// In nl, this message translates to:
  /// **'By signing in to Travel Hero, you agree to our Privacy Policy and Terms of Service.'**
  String get sign_in_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'nl': return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
