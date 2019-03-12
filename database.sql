-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2019 at 03:38 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pixelphoto`
--

-- --------------------------------------------------------

--
-- Table structure for table `pxp_activities`
--

CREATE TABLE `pxp_activities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `post_id` int(11) NOT NULL DEFAULT '0',
  `following_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(100) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_blacklist`
--

CREATE TABLE `pxp_blacklist` (
  `id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_blocks`
--

CREATE TABLE `pxp_blocks` (
  `id` int(11) NOT NULL,
  `user_id` int(15) NOT NULL DEFAULT '0',
  `profile_id` int(15) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_chats`
--

CREATE TABLE `pxp_chats` (
  `id` int(11) NOT NULL,
  `from_id` int(15) NOT NULL DEFAULT '0',
  `to_id` int(15) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_config`
--

CREATE TABLE `pxp_config` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` varchar(1000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pxp_config`
--

INSERT INTO `pxp_config` (`id`, `name`, `value`) VALUES
(1, 'site_url', 'http://localhost/pixelphoto'),
(2, 'site_name', 'Pixelphoto'),
(3, 'theme', 'default'),
(4, 'validation', 'off'),
(5, 'ffmpeg_sys', 'off'),
(6, 'ffmpeg_binary', '/usr/bin/ffmpeg'),
(7, 'max_video_duration', '50'),
(8, 'yt_api', 'AIzaSyB3Lc0LpuqDCcv3F5qEMRVwYmfK37Tc9p0'),
(9, 'giphy_api', 'EEoFiCosGuyEIWlXnRuw4McTLxfjCrl1'),
(10, 'upload_images', 'on'),
(11, 'upload_videos', 'on'),
(12, 'import_videos', 'on'),
(13, 'import_images', 'on'),
(14, 'story_system', 'on'),
(15, 'signup_system', 'on'),
(16, 'delete_account', 'on'),
(17, 'recaptcha', 'on'),
(18, 'recaptcha_key', ''),
(19, 'site_desc', 'PixelPhoto is a PHP Media Sharing Script, PixelPhoto is the best way to start your own media sharing script!'),
(20, 'site_email', 'info@pixelphoto.com'),
(21, 'meta_keywords', 'social, pixelphoto, social site'),
(22, 'obscene', ''),
(23, 'max_upload', '1000000000'),
(24, 'caption_len', '500'),
(25, 'comment_len', '500'),
(27, 'language', 'english'),
(28, 'smtp_or_mail', 'mail'),
(29, 'smtp_host', ''),
(30, 'smtp_username', ''),
(31, 'smtp_password', ''),
(32, 'smtp_port', '587'),
(33, 'smtp_encryption', 'tls'),
(34, 'fb_login', 'off'),
(35, 'tw_login', 'off'),
(36, 'gl_login', 'off'),
(37, 'facebook_app_id', ''),
(38, 'facebook_app_key', ''),
(39, 'twitter_app_id', ''),
(40, 'twitter_app_key', ''),
(41, 'google_app_id', ''),
(42, 'google_app_key', ''),
(43, 'site_docs', ''),
(44, 'last_created_sitemap', '0000-00-00'),
(45, 'last_backup', '2018-03-07 06:13:18'),
(46, 'story_duration', '10'),
(47, 'last_clean_db', '1547390054'),
(48, 'email_validation', 'off'),
(49, 'amazone_s3', '0'),
(50, 'bucket_name', ''),
(51, 'amazone_s3_key', ''),
(52, 'amazone_s3_s_key', ''),
(53, 'region', ''),
(54, 'ad1', ''),
(55, 'ad2', ''),
(56, 'ad3', ''),
(57, 'google_analytics', ''),
(58, 'ftp_upload', '0'),
(59, 'ftp_host', ''),
(60, 'ftp_username', ''),
(61, 'ftp_password', ''),
(62, 'ftp_port', ''),
(63, 'ftp_endpoint', ''),
(64, 'app_api_id', '8a076706af1097d5fe1e2aaf006ff188'),
(65, 'app_api_key', 'f861392afd2bf004e994d9fd2a0a58f1'),
(66, 'wowonder_app_ID', ''),
(67, 'wowonder_app_key', ''),
(68, 'wowonder_domain_uri', ''),
(69, 'wowonder_login', 'off'),
(70, 'last_run', ''),
(71, 'config_run', '-'),
(72, 'wowonder_domain_icon', ''),
(73, 'server_key', '1539874186'),
(74, 'playtube_url', 'https://playtubescript.com'),
(75, 'recaptcha_site_key', ''),
(76, 'recaptcha_secret_key', ''),
(77, 'watermark', 'off'),
(78, 'watermark_link', 'media/img/icon.png'),
(79, 'mp4_links', 'on'),
(80, 'playtube_links', 'off'),
(81, 'face_filter', 'on'),
(82, 'push', '1'),
(83, 'push_id', ''),
(84, 'push_key', '');

-- --------------------------------------------------------

--
-- Table structure for table `pxp_connectivities`
--

CREATE TABLE `pxp_connectivities` (
  `id` int(11) NOT NULL,
  `follower_id` int(25) NOT NULL DEFAULT '0',
  `following_id` int(25) NOT NULL DEFAULT '0',
  `active` int(5) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_hashtags`
--

CREATE TABLE `pxp_hashtags` (
  `id` int(11) NOT NULL,
  `hash` varchar(35) NOT NULL DEFAULT '',
  `tag` varchar(200) NOT NULL DEFAULT '',
  `last_trend_time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_langs`
--

CREATE TABLE `pxp_langs` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) DEFAULT NULL,
  `english` text,
  `arabic` text,
  `dutch` text,
  `french` text,
  `german` text,
  `russian` text,
  `spanish` text,
  `turkish` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pxp_langs`
--

INSERT INTO `pxp_langs` (`id`, `lang_key`, `english`, `arabic`, `dutch`, `french`, `german`, `russian`, `spanish`, `turkish`) VALUES
(1, 'uname_or_email', 'Username or E-mail', 'اسم المستخدم أو البريد الالكتروني', 'Gebruikersnaam of email', 'Nom dutilisateur ou email', 'Benutzername oder E-Mail-Adresse', 'Имя пользователя или адрес электронной почты', 'Nombre de usuario o correo electrónico', 'Kullanıcı adı ya da email'),
(2, 'ur_password', 'Your Password', 'كلمة السر خاصتك', 'Je wachtwoord', 'Votre mot de passe', 'Ihr Passwort', 'Ваш пароль', 'Tu contraseña', 'Şifreniz'),
(3, 'forgot_ur_passwd', 'Forgot your password?', 'نسيت رقمك السري؟', 'Je wachtwoord vergeten?', 'Mot de passe oublié?', 'Haben Sie Ihr Passwort vergessen?', 'Забыли пароль?', '¿Olvidaste tu contraseña?', 'Parolanızı mı unuttunuz?'),
(4, 'login', 'Login', 'تسجيل الدخول', 'Log in', 'Sidentifier', 'Anmeldung', 'Авторизоваться', 'Iniciar sesión', 'Oturum aç'),
(5, 'new_here', 'New here?', 'جديد هنا؟', 'Nieuw hier?', 'Nouveau ici?', 'Neu hier?', 'Новенький тут?', '¿Nuevo aquí?', 'Burada yeni?'),
(6, 'signup_now', 'Sign up now!', 'أفتح حساب الأن!', 'Meld je nu aan!', 'Sinscrire maintenant!', 'Jetzt registrieren!', 'Зарегистрироваться сейчас!', '¡Regístrate ahora!', 'Şimdi kayıt ol!'),
(7, 'enter_ur_n_and_p', 'Please enter your username and password!', 'الرجاء إدخال اسم المستخدم وكلمة المرور الخاصة بك!', 'Voer je gebruikersnaam en wachtwoord in!', 'Veuillez sil vous plaît entrer votre nom dutilisateur et votre mot de passe!', 'Bitte gib deinen Benutzernamen und dein Passwort ein!', 'Пожалуйста введите свой логин и пароль!', '¡Porfavor introduzca su nombre de usuario y contraseña!', 'Lütfen kullanıcı adınızı ve şifrenizi giriniz!'),
(8, 'invalid_un_or_passwd', 'Invalid username or password!', 'خطأ في اسم المستخدم أو كلمة مرور!', 'Ongeldige gebruikersnaam of wachtwoord!', 'Nom dutilisateur ou mot de passe invalide!', 'Ungültiger Benutzername oder Passwort!', 'Неправильное имя пользователя или пароль!', '¡Usuario o contraseña invalido!', 'Geçersiz kullanıcı adı veya şifre!'),
(9, 'email_addr', 'E-mail address', 'عنوان البريد الإلكتروني', 'E-mailadres', 'Adresse e-mail', 'E-Mail-Addresse', 'Адрес электронной почты', 'Dirección de correo electrónico', 'E'),
(10, 'username', 'Username', 'اسم المستخدم', 'Gebruikersnaam', 'Nom dutilisateur', 'Nutzername', 'имя пользователя', 'Nombre de usuario', 'Kullanıcı adı'),
(11, 'password', 'Password', 'كلمه السر', 'Wachtwoord', 'Mot de passe', 'Passwort', 'пароль', 'Contraseña', 'Parola'),
(12, 'confirm_passwd', 'Confirm Password', 'تأكيد كلمة المرور', 'bevestig wachtwoord', 'Confirmez le mot de passe', 'Bestätige das Passwort', 'Подтвердите Пароль', 'Confirmar contraseña', 'Şifreyi Onayla'),
(13, 'male', 'Male', 'الذكر', 'Mannetje', 'Mâle', 'Männlich', 'мужчина', 'Masculino', 'Erkek'),
(14, 'female', 'Female', 'إناثا', 'Vrouw', 'Femelle', 'Weiblich', 'женский', 'Hembra', 'Kadın'),
(15, 'signup', 'Sign up', 'سجل', 'Aanmelden', 'Sinscrire', 'Anmelden', 'зарегистрироваться', 'Regístrate', 'Kaydol'),
(16, 'please_fill_fields', 'Please fill in all required fields', 'يرجى ملء جميع الحقول المطلوبة', 'Vul alle verplichte velden in', 'Veuillez remplir tous les champs requis', 'Bitte füllen Sie alle geforderten Felder aus', 'Пожалуйста, заполните все обязательные поля', 'Por favor, rellene todos los campos obligatorios', 'Lütfen tüm zorunlu alanları doldurun'),
(17, 'username_is_taken', 'That username is already taken', 'هذا الاسم مستخدم من قبل', 'Die gebruikersnaam is al in gebruik', 'Ce nom dutilisateur est déjà pris', 'Dieser Benutzername ist bereits vergeben', 'Имя пользователя уже используется', 'Ese nombre de usuario ya se encuentra en uso', 'Bu kullanıcı adı önceden alınmış'),
(18, 'email_exists', 'That email is already exists', 'هذا البريد الإلكتروني موجود بالفعل', 'Die e-mail bestaat al', 'Cet email existe déjà', 'Diese E-Mail ist bereits vorhanden', 'Это письмо уже существует', 'Ese correo electrónico ya existe', 'Bu e-posta zaten mevcut'),
(19, 'username_characters_length', 'Username must be between 4 and 16 characters', 'يجب أن يكون اسم المستخدم بين 4 و 16 حرفًا', 'Gebruikersnaam moet tussen 4 en 16 tekens lang zijn', 'Le nom dutilisateur doit comporter entre 4 et 16 caractères', 'Der Benutzername muss zwischen 4 und 16 Zeichen lang sein', 'Имя пользователя должно быть от 4 до 16 символов.', 'El nombre de usuario debe tener entre 4 y 16 caracteres', 'Kullanıcı adı 4 ile 16 karakter arasında olmalıdır'),
(20, 'username_invalid_characters', 'Username contains invalid characters', 'اسم المستخدم فيه أحرف غير صالحة', 'Gebruikersnaam bevat ongeldige tekens', 'Nom dutilisateur contient des caractères non valides', 'Benutzername beinhaltet ungültige Zeichen', 'Имя пользователя содержит недопустимые символы', 'Nombre de usuario contiene caracteres inválidos', 'Kullanıcı adı geçersiz karakterler içeriyor'),
(21, 'email_invalid_characters', 'E-mail contains invalid characters', 'يحتوي البريد الإلكتروني على أحرف غير صالحة', 'E-mail bevat ongeldige tekens', 'E-mail contient des caractères non valides', 'E-Mail enthält ungültige Zeichen', 'E-mail содержит недопустимые символы', 'El correo electrónico contiene caracteres no válidos', 'E-posta geçersiz karakterler içeriyor'),
(22, 'password_not_match', 'Password does not match', 'كلمة السر غير متطابقة', 'Wachtwoord komt niet overeen', 'Le mot de passe ne correspond pas', 'Passwort stimmt nicht überein', 'Пароль не подходит', 'Las contraseñas no coinciden', 'Parola eşleşmiyor'),
(23, 'password_is_short', 'Password is too short', 'كلمة المرور قصيرة جدا', 'Wachtwoord is te kort', 'Le mot de passe est trop court', 'Das Passwort ist zu kurz', 'Пароль слишком короткий', 'La contraseña es demasiado corta', 'Şifre çok kısa'),
(24, 'successfully_joined_desc', 'You have successfully joined. Please wait..', 'لقد انضممت بنجاح. أرجو الإنتظار..', 'Je bent succesvol toegetreden. Even geduld aub..', 'Vous avez rejoint avec succès. Sil vous plaît, attendez..', 'Sie sind erfolgreich beigetreten. Warten Sie mal..', 'Вы успешно присоединились. Пожалуйста, подождите..', 'Te has unido exitosamente Por favor espera..', 'Başarıyla katıldı. Lütfen bekle..'),
(25, 'notifications', 'Notifications', 'إخطارات', 'meldingen', 'Notifications', 'Benachrichtigungen', 'Уведомления', 'Notificaciones', 'Bildirimler'),
(26, 'search', 'Search', 'بحث', 'Zoeken', 'Chercher', 'Suche', 'Поиск', 'Buscar', 'Arama'),
(27, 'u_dont_have_notif', 'You do not have any notifications', 'ليس لديك أي إخطارات', 'Je hebt geen meldingen', 'Vous navez aucune notification', 'Sie haben keine Benachrichtigungen', 'У вас нет уведомлений', 'Usted no tiene ninguna notificación', 'Bildiriminiz yok'),
(28, 'featured_posts', 'Featured posts', 'المشاركات مميزة', 'Aanbevolen berichten', 'Postes en vedette', 'Beliebte Beiträge', 'Популярные сообщения', 'Publicaciones destacadas', 'Öne çıkan gönderiler'),
(29, 'stories', 'Stories', 'قصص', 'verhalen', 'Histoires', 'Geschichten', 'Истории', 'Cuentos', 'Hikayeler'),
(30, 'stories_from_people', 'Here will be stories from people you follow.', 'سوف تكون هناك قصص من أشخاص تتابعهم.', 'Hier zullen verhalen zijn van mensen die je volgt.', 'Voici des histoires de personnes que vous suivez.', 'Hier werden Geschichten von Leuten sein, denen du folgst.', 'Здесь будут рассказы от людей, которых вы придерживаетесь.', 'Aquí habrá historias de personas a las que sigues.', 'İzlediğiniz kişilerin hikayeleri burada olacak.'),
(31, 'terms', 'Terms', 'شروط', 'Voorwaarden', 'termes', 'Begriffe', 'сроки', 'Condiciones', 'şartlar'),
(32, 'privacy_and_policy', 'Privacy & Policy', 'الخصوصية & amp؛ سياسات', 'Privacy & amp; Het beleid', 'Confidentialité et ampère Politique', 'Datenschutz & amp; Politik', 'Конфиденциальность и amp; политика', 'Privacidad y amp; Política', 'Gizlilik ve amp; Politika'),
(33, 'language', 'Language', 'لغة', 'Taal', 'La langue', 'Sprache', 'язык', 'Idioma', 'Dil'),
(34, 'about', 'About', 'حول', 'Over', 'Sur', 'Über', 'Около', 'Acerca de', 'hakkında'),
(35, 'select_file', 'Select File', 'حدد ملف', 'Selecteer bestand', 'Choisir le dossier', 'Datei aussuchen', 'Выберите файл', 'Seleccione Archivo', 'Dosya Seç'),
(36, 'choose_up210img', 'Choose up to 10 images', 'اختر حتى 10 صور', 'Kies maximaal 10 afbeeldingen', 'Choisissez jusquà 10 images', 'Wählen Sie bis zu 10 Bilder', 'Выберите до 10 изображений', 'Elige hasta 10 imágenes', 'En fazla 10 görüntü seçin'),
(37, 'add_post_caption', 'Add post caption, #hashtag.. @mention?', 'إضافة تعليق آخر ، #hashtag ..mention؟', 'Ondertiteling toevoegen, #hashtag .. @mention?', 'Ajouter une légende de message, #hashtag .. @mention?', 'Fügen Sie die Untertitel, #hashtag .. @mention hinzu?', 'Добавить подпись, #hashtag .. @mention?', 'Agregar título de publicación, #hashtag .. @mention?', 'Gönderi ekle, #hashtag .. @mention?'),
(38, 'publish', 'Publish', 'نشر', 'Publiceren', 'Publier', 'Veröffentlichen', 'Публиковать', 'Publicar', 'Yayınla'),
(39, 'close', 'Close', 'قريب', 'Dichtbij', 'Fermer', 'Schließen', 'Закрыть', 'Cerca', 'Kapat'),
(40, 'do_not_attach', 'Do not attach', 'لا ترفق', 'Niet bevestigen', 'Nattachez pas', 'Nicht anhängen', 'Не прикреплять', 'No adjuntar', 'Ekleme'),
(41, 'unknown_error', 'An unknown error occurred. Please try again later!', 'حدث خطأ غير معروف. الرجاء معاودة المحاولة في وقت لاحق!', 'Een onbekende fout is opgetreden. Probeer het later opnieuw!', 'Une erreur inconnue est survenue. Veuillez réessayer plus tard!', 'Ein unbekannter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut!', 'Произошла неизвестная ошибка. Пожалуйста, повторите попытку позже!', 'Un error desconocido ocurrió. ¡Por favor, inténtelo de nuevo más tarde!', 'Bilinmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz!'),
(42, 'max_upload_limit', 'Your post exceeds the maximum upload size for this site. Maximum upload size: {{size}}', 'تتجاوز مشاركتك الحد الأقصى لحجم التحميل لهذا الموقع. الحد الأقصى لحجم التحميل: {{size}}', 'Je bericht overschrijdt de maximale uploadgrootte voor deze site. Maximale uploadgrootte: {{size}}', 'Votre message dépasse la taille de téléchargement maximale pour ce site. Taille de téléchargement maximale: {{size}}', 'Dein Beitrag überschreitet die maximale Uploadgröße für diese Website. Maximale Uploadgröße: {{size}}', 'Ваше сообщение превышает максимальный размер загрузки для этого сайта. Максимальный размер загружаемого файла: {{size}}', 'Su publicación excede el tamaño máximo de carga para este sitio. Tamaño máximo de carga: {{size}}', 'Yayınınız bu sitenin maksimum yükleme boyutunu aşıyor. Maksimum yükleme boyutu: {{size}}'),
(43, 'post_published', 'Your post has been published successfully', 'تم نشر مشاركتك بنجاح', 'Uw bericht is met succes gepubliceerd', 'Votre message a été publié avec succès', 'Dein Beitrag wurde erfolgreich veröffentlicht', 'Ваше сообщение успешно опубликовано', 'Tu publicación ha sido publicada con éxito', 'Yayınınız başarıyla yayınlandı'),
(44, 'no_file_choosen', 'No file choosen', 'لم يتم اختيار ملف', 'Geen bestand gekozen', 'Aucun fichier choisi', 'Keine Datei ausgewählt', 'Файл не выбран', 'Sin archivo elegido', 'Hiçbir dosya seçilmedi'),
(45, 'search_gifs', 'Search for gifs..', 'ابحث عن صور ..', 'Zoeken naar gifs ..', 'Rechercher des gifs ..', 'Nach Gifs suchen ..', 'Поиск gifs ..', 'Buscar gifs ...', 'Gifleri Arayın ..'),
(46, 'delete_post', 'Delete post', 'حذف آخر', 'Verwijder gepost bericht', 'Supprimer le message', 'Beitrag entfernen', 'Удалить сообщение', 'Eliminar mensaje', 'Gönderiyi sil'),
(47, 'edit_post', 'Edit post', 'تعديل المنشور', 'Bericht bewerken', 'Modifier le post', 'Beitrag bearbeiten', 'Редактировать сообщение', 'Editar post', 'Gönderiyi düzenle'),
(48, 'report_post', 'Report this post', 'أبلغ عن هذا المنصب', 'Meld deze post', 'Signaler ce message', 'Diesen Post melden', 'Сообщить об этом сообщении', 'Reportar esta publicación', 'Bu gönderiyi şikayet et'),
(49, 'cancel_report', 'Cancel report', 'إلغاء التقرير', 'Annuleer rapport', 'Annuler le rapport', 'Bericht abbrechen', 'Отменить отчет', 'Cancelar informe', 'Raporu iptal et'),
(50, 'go2post', 'Go to post', 'الذهاب إلى آخر', 'Ga naar bericht', 'Aller à la publication', 'Gehe zum Post', 'Перейти к сообщению', 'Ir a la publicación', 'Gönderiye git'),
(51, 'likes', 'Likes', 'الإعجابات', 'sympathieën', 'Aime', 'Likes', 'Нравится', 'Gustos', 'Seviyor'),
(52, 'comments', 'Comments', 'تعليقات', 'Comments', 'commentaires', 'Bemerkungen', 'Комментарии', 'Comentarios', 'Yorumlar'),
(53, 'write_comment', 'Write a comment', 'أكتب تعليقا', 'Schrijf een reactie', 'Écrire un commentaire', 'Schreibe einen Kommentar', 'Написать комментарий', 'Escribir un comentario', 'Bir yorum Yaz'),
(54, 'follow_suggestions', 'Suggestions For You', 'اقتراحات لك', 'Suggesties voor jou', 'Des suggestions pour vous', 'Vorschläge für dich', 'Предложения для вас', 'Sugerencias para ti', 'Sizin için öneriler'),
(55, 'see_all', 'See all', 'اظهار الكل', 'Alles zien', 'Voir tout', 'Alles sehen', 'Увидеть все', 'Ver todo', 'Hepsini gör'),
(56, 'follow', 'Follow', 'إتبع', 'Volgen', 'Suivre', 'Folgen', 'следить', 'Seguir', 'Takip et'),
(57, 'following', 'Following', 'التالية', 'Als vervolg op', 'Suivant', 'Folgend', 'Следующий', 'Siguiendo', 'Takip etme'),
(58, 'suggested_people', 'Suggested people to follow', 'اقترح على الناس لمتابعة', 'Voorgestelde mensen om te volgen', 'Suggestions de personnes à suivre', 'Vorschläge für weitere Personen', 'Рекомендуемые люди', 'Gente sugerida a seguir', 'Önerilen kişiler takip edecek'),
(59, 'last_seen', 'Last seen', 'اخر ظهور', 'Laatst gezien', 'Dernière vue', 'Zuletzt gesehen', 'Последние просмотренные', 'Ultima vez visto', 'Son görülen'),
(60, 'followers', 'Followers', 'متابعون', 'Volgers', 'Suiveurs', 'Anhänger', 'Читают', 'Seguidores', 'İzleyiciler'),
(61, 'posts', 'Posts', 'المشاركات', 'berichten', 'Des postes', 'Beiträge', 'Сообщений', 'Publicaciones', 'Mesajlar'),
(62, 'save_post', 'Save posts', 'حفظ المشاركات', 'Bewaar berichten', 'Enregistrer les messages', 'Beiträge speichern', 'Сохранить записи', 'Guardar publicaciones', 'Gönderiyi kaydet'),
(63, 'unsave_post', 'Unsave posts', 'جارٍ حفظ المشاركات', 'Posten herstellen', 'Posts Unsave', 'Beiträge werden nicht gespeichert', 'Небезопасные сообщения', 'Publicaciones no guardadas', 'Gönderimsiz yayınlar'),
(64, 'confirm_del_post', 'Are you sure you want to delete this post? this action can not be undo', 'هل أنت متأكد أنك تريد حذف هذه المشاركة؟ هذا الإجراء لا يمكن التراجع', 'Weet je zeker dat je dit bericht wilt verwijderen? deze actie kan niet ongedaan worden gemaakt', 'Es-tu sur de vouloir supprimer cette annonce? cette action ne peut pas être annulée', 'Möchten Sie diesen Beitrag wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden', 'Вы уверены, что хотите удалить эту запись? это действие не может быть отменено', '¿Seguro que quieres eliminar esta publicación? esta acción no puede deshacerse', 'Bu gönderiyi silmek istediğinizden emin misiniz? bu işlem geri alınamaz'),
(65, 'cancel', 'Cancel', 'إلغاء', 'Annuleer', 'Annuler', 'Stornieren', 'Отмена', 'Cancelar', 'İptal etmek'),
(66, 'ok', 'Okey', 'حسنا', 'in orde', 'Bien', 'Okey', 'исправный', 'Bueno', 'tamam mı'),
(67, 'delete_comment', 'Delete comment', 'حذف تعليق', 'Reactie verwijderen', 'Supprimer le commentaire', 'Kommentar löschen', 'Удалить комментарий', 'Eliminar comentario', 'Yorumu sil'),
(68, 'confirm_del_comment', 'Are you sure you want to delete this comment?', 'هل أنت متأكد أنك تريد حذف هذا التعليق؟', 'Weet je zeker dat je deze reactie wilt verwijderen?', 'êtes-vous sûr de vouloir supprimer ce commentaire?', 'Möchtest du diesen Kommentar wirklich löschen?', 'Вы уверенны, что хотите удалить этот комментарий?', '¿Seguro que quieres eliminar este comentario?', 'Bu yorumu silmek istediğinizden emin misiniz?'),
(69, 'post_added2fav', 'Post added to your favourites list', 'إضافة إلى قائمة المفضلة لديك', 'Post toegevoegd aan uw favorietenlijst', 'Message ajouté à votre liste de favoris', 'Beitrag wurde zu Ihrer Favoritenliste hinzugefügt', 'Сообщение добавлено в ваш список избранных', 'Mensaje agregado a tu lista de favoritos', 'Gönderi favori listenize eklendi'),
(70, 'post_rem_from_fav', 'Post removed from your favourites list', 'تمت إزالة المشاركة من قائمة المفضلة لديك', 'Post verwijderd van uw favorietenlijst', 'Message retiré de votre liste de favoris', 'Beitrag wurde aus Ihrer Favoritenliste entfernt', 'Сообщение удалено из списка избранных', 'Mensaje eliminado de tu lista de favoritos', 'Gönderi favori listenizden kaldırıldı'),
(71, 'report_sent', 'Your report has been sent!', 'تم إرسال تقريرك', 'Uw rapport is verzonden!', 'Votre rapport a été envoyé!', 'Ihr Bericht wurde gesendet!', 'Ваш отчет отправлен!', '¡Tu reporte ha sido enviado!', 'Raporunuz gönderildi!'),
(72, 'report_canceled', 'Your report has been canceled!', 'لقد تم إلغاء تقريرك!', 'Uw rapport is geannuleerd!', 'Votre rapport a été annulé!', 'Ihr Bericht wurde storniert!', 'Ваш отчет отменен!', '¡Su informe ha sido cancelado!', 'Raporunuz iptal edildi!'),
(73, 'changes_saved', 'Your changes has been successfully saved!', 'تم حفظ تغييراتك بنجاح!', 'Uw wijzigingen zijn succesvol opgeslagen!', 'Vos modifications ont été enregistrées avec succès!', 'Ihre Änderungen wurden erfolgreich gespeichert!', 'Ваши изменения были успешно сохранены!', '¡Tus cambios se han guardado con éxito!', 'Değişiklikleriniz başarıyla kaydedildi!'),
(74, 'explore_posts', 'Explore posts', 'استكشاف المشاركات', 'Verken berichten', 'Explorez les posts', 'Erkunden Sie Beiträge', 'Исследуйте сообщения', 'Explorar publicaciones', 'Mesajları keşfedin'),
(75, 'explore_posts_desc', 'Explore {{site_name}} photos and videos', 'استكشف {{site_name}} الصور ومقاطع الفيديو', 'Verken {{site_name}} fotos en videos', 'Explorer les {{site_name}} photos et vidéos', 'Erkunden Sie {{site_name}} Fotos und Videos', 'Исследуйте {{site_name}} фотографии и видеоролики', 'Explore {{site_name}} fotos y videos', 'Fotoğrafları ve videoları {{site_name}} keşfedin'),
(76, 'messages', 'Messages', 'رسائل', 'berichten', 'messages', 'Mitteilungen', 'Сообщения', 'Mensajes', 'Mesajlar'),
(77, 'type_message', 'Type a message and hit Enter', 'اكتب رسالة واضغط على Enter', 'Typ een bericht en druk op Enter', 'Tapez un message et appuyez sur Entrée', 'Geben Sie eine Nachricht ein und drücken Sie die Eingabetaste', 'Введите сообщение и нажмите Enter.', 'Escriba un mensaje y presione Enter', 'Bir mesaj yazıp Enter tuşuna basın'),
(78, 'select_chat', 'Please select a chat to start messaging', 'يرجى تحديد دردشة لبدء المراسلة', 'Selecteer een chat om berichten te verzenden', 'Veuillez sélectionner une conversation pour démarrer la messagerie', 'Bitte wähle einen Chat um die Nachrichten zu starten', 'Выберите чат, чтобы начать обмен сообщениями', 'Seleccione un chat para comenzar a enviar mensajes', 'Lütfen mesajlaşmaya başlamak için bir sohbet seçin'),
(79, 'clear_messages', 'Clear messages', 'مسح الرسائل', 'Duidelijke berichten', 'Effacer les messages', 'Nachrichten löschen', 'Очистить сообщения', 'Borrar mensajes', 'Mesajları temizle'),
(80, 'confirm_clear_messages', 'Are you sure you want to delete this conversation?', 'هل أنت متأكد من أنك تريد حذف هذه المحادثة؟', 'Weet je zeker dat je dit gesprek wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette conversation?', 'Möchten Sie diese Unterhaltung wirklich löschen?', 'Вы действительно хотите удалить этот разговор?', '¿Seguro que quieres eliminar esta conversación?', 'Bu sohbeti silmek istediğinizden emin misiniz?'),
(81, 'conversation_deleted', 'Conversation has been deleted succesfully!', 'تم حذف المحادثة بنجاح!', 'Gesprek is succesvol verwijderd!', 'La conversation a été supprimée avec succès!', 'Konversation wurde erfolgreich gelöscht!', 'Разговор удалён успешно!', '¡La conversación ha sido eliminada exitosamente!', 'Konuşma başarıyla silindi!'),
(82, 'delete_chat', 'Delete chat', 'حذف الدردشة', 'Verwijder chat', 'Supprimer le chat', 'Chat löschen', 'Удалить чат', 'Eliminar chat', 'Sohbeti sil'),
(83, 'privacy_settings', 'Privacy settings', 'إعدادات الخصوصية', 'Privacy instellingen', 'Paramètres de confidentialité', 'Datenschutzeinstellungen', 'Настройки конфиденциальности', 'La configuración de privacidad', 'Gizlilik ayarları'),
(84, 'confirm_del_chat', 'Are you sure you want to delete this chat? all your conversation will be deleted', 'هل أنت متأكد من أنك تريد حذف هذه الدردشة؟ سيتم حذف كل محادثتك', 'Weet je zeker dat je deze chat wilt verwijderen? al je gesprekken worden verwijderd', 'Êtes-vous sûr de vouloir supprimer ce chat? toute votre conversation sera supprimée', 'Möchtest du diesen Chat wirklich löschen? Alle Ihre Konversationen werden gelöscht', 'Вы действительно хотите удалить этот чат? весь ваш разговор будет удален', '¿Seguro que quieres eliminar este chat? toda tu conversación será eliminada', 'Bu sohbeti silmek istediğinizden emin misiniz? tüm konuşmalarınız silinecek'),
(85, 'delete_messages', 'Delete messages', 'حذف الرسائل', 'Verwijder berichten', 'Supprimer les messages', 'Nachrichten löschen', 'Удалить сообщения', 'Eliminar mensajes', 'Mesajları sil'),
(86, 'delete_selected', 'Delete selected', 'احذف المختار', 'Verwijder geselecteerde', 'Supprimer sélectionnée', 'Ausgewählte löschen', 'Удалить выбранное', 'Eliminar seleccionado', 'Silme seçildi'),
(87, 'confirm_del_messages', 'Are you sure you want to delete this messages? confirm to continue', 'هل أنت متأكد أنك تريد حذف هذه الرسائل؟ تأكيد للمتابعة', 'Weet je zeker dat je deze berichten wilt verwijderen? bevestigen om door te gaan', 'Êtes-vous sûr de vouloir supprimer ce message? confirmer pour continuer', 'Möchten Sie diese Nachrichten wirklich löschen? Bestätigen Sie, um fortzufahren', 'Вы действительно хотите удалить это сообщение? подтвердить, чтобы продолжить', '¿Seguro que quieres borrar estos mensajes? confirmar para continuar', 'Bu mesajları silmek istediğinizden emin misiniz? devam etmek için onaylayın'),
(88, 'profile_settings', 'Profile settings', 'إعدادات الملف الشخصي', 'Profielinstellingen', 'Paramètres de profil', 'Profileinstellungen', 'Настройки профиля', 'Configuración de perfil', 'Profil ayarları'),
(89, 'unblock', 'Unblock', 'رفع الحظر', 'deblokkeren', 'Débloquer', 'Entsperren', 'открыть', 'Desatascar', 'engeli kaldırmak'),
(90, 'favourites', 'Favourites', 'المفضلة', 'favorieten', 'Favoris', 'Favoriten', 'Избранные', 'Favoritos', 'Favoriler'),
(91, 'message', 'Message', 'رسالة', 'Bericht', 'Message', 'Botschaft', 'Сообщение', 'Mensaje', 'Mesaj'),
(92, 'u_blocked_zis_usr', 'You have blocked this user', 'لقد حظرت هذا المستخدم', 'Je hebt deze gebruiker geblokkeerd', 'Vous avez bloqué cet utilisateur', 'Sie haben diesen Benutzer blockiert', 'Вы заблокировали этого пользователя', 'Has bloqueado a este usuario', 'Bu kullanıcıyı engellediniz'),
(93, 'unblock2see_profile', 'Unblock to see their photos and videos.', 'يمكنك إلغاء الحظر لمشاهدة الصور ومقاطع الفيديو.', 'Deblokkeer de blokkering van hun fotos en videos.', 'Débloquer pour voir leurs photos et vidéos', 'Entsperren, um ihre Fotos und Videos zu sehen.', 'Разблокируйте, чтобы увидеть их фотографии и видео.', 'Desbloquear para ver sus fotos y videos.', 'Fotoğraflarını ve videolarını görmek için engellemeyi kaldır.'),
(94, 'profile_is_private', 'This profile is private', 'هذا الملف الشخصي خاص', 'Dit profiel is privé', 'Ce profil est privé', 'Dieses Profil ist privat', 'Этот профиль закрыт', 'Este perfil es privado', 'Bu profil gizli'),
(95, 'follow2see_profile', 'Follow to see their photos & videos!e', 'اتبع لرؤية صورهم & amp؛ أشرطة الفيديو! ه', 'Volgen om hun fotos &  videos! e', 'Suivez pour voir leurs photos & amp; vidéos! e', 'Folgen Sie, um ihre Fotos zu sehen & amp; Videos! e', 'Следуйте за их фотографиями и amp; видео! е', 'Siga para ver sus fotos y amp; videos! e', 'Fotoğraflarını görmek için izleyin & amp; videolar! e'),
(96, 'profile_privacy', 'Profile privacy', 'الملف الخصوصية', 'Profiel privacy', 'Confidentialité du profil', 'Profil Datenschutz', 'Конфиденциальность профиля', 'Privacidad del perfil', 'Profil gizliliği'),
(97, 'logout', 'Logout', 'الخروج', 'Uitloggen', 'Connectez - Out', 'Ausloggen', 'Выйти', 'Cerrar sesión', 'Çıkış Yap'),
(98, 'admin_panel', 'Admin panel', 'لوحة الادارة', 'Administratie Paneel', 'Panneau dadministration', 'Administrationsmenü', 'Панель администратора', 'Panel de administrador', 'Admin Paneli'),
(99, 'report_user', 'Report this user', 'الإبلاغ عن هذا المستخدم', 'Rapporteer deze gebruiker', 'Signaler cet utilisateur', 'Diesen Nutzer melden', 'Сообщить об этом пользователе', 'Reportar a este usuario', 'Bu kullanıcıyı rapor et'),
(100, 'block_user', 'Block this user', 'منع هذا المستخدم', 'Blokkeer deze gebruiker', 'Bloquer cet utilisateur', 'Diesen Benutzer sperren', 'Заблокировать этого пользователя', 'Bloquee este usuario', 'Bu kullanıcıyı engelle'),
(101, 'unblock_user', 'Unblock this user', 'إلغاء حظر هذا المستخدم', 'Deblokkeer deze gebruiker', 'Débloquer cet utilisateur', 'Entsperren Sie diesen Benutzer', 'Разблокировать этого пользователя', 'Desbloquear a este usuario', 'Bu kullanıcının engellemesini kaldır'),
(102, 'confirm_block_user', 'Are you sure you want to block this user? They will not be able to see your profile, posts or story', 'هل أنت متأكد أنك تريد حظر هذا المستخدم؟ لن يتمكنوا من رؤية ملفك الشخصي أو مشاركاتك أو قصتك', 'Weet je zeker dat je deze gebruiker wilt blokkeren? Ze kunnen je profiel, berichten of verhaal niet zien', 'Êtes vous sûr de vouloir bloquer cet utilisateur? Ils ne pourront pas voir votre profil, vos publications ou votre histoire', 'Sind Sie sicher, dass Sie diesen Benutzer blockieren möchten? Sie können Ihr Profil, Ihre Beiträge oder Ihre Geschichte nicht sehen', 'Вы действительно хотите заблокировать этого пользователя? Они не смогут видеть ваш профиль, сообщения или историю', '¿Estás seguro de que quieres bloquear a este usuario? No podrán ver tu perfil, publicaciones o historia', 'Bu kullanıcıyı engellemek istediğinizden emin misiniz? Profilinizi, yayınlarınızı veya hikayenizi göremezler.'),
(103, 'user_blocked', 'This profile has been blocked, You can unblock them anytime from their profile.', 'تم حظر هذا الملف الشخصي ، ويمكنك إلغاء حظره في أي وقت من ملفه الشخصي.', 'Dit profiel is geblokkeerd. Je kunt ze op elk gewenst moment uit hun profiel deblokkeren.', 'Ce profil a été bloqué. Vous pouvez les débloquer à tout moment depuis leur profil.', 'Dieses Profil wurde gesperrt. Sie können sie jederzeit in ihrem Profil entsperren.', 'Этот профиль заблокирован, вы можете разблокировать их в любое время из своего профиля.', 'Este perfil ha sido bloqueado, puedes desbloquearlo en cualquier momento desde su perfil.', 'Bu profil engellendi, Profillerinden istedikleri zaman engelini kaldırabilirsiniz.'),
(104, 'user_unblocked', 'This profile has been unblocked, You can block them anytime from their profile.', 'تم إلغاء حظر هذا الملف الشخصي ، ويمكنك حظره في أي وقت من ملفه الشخصي.', 'Dit profiel is gedeblokkeerd, je kunt ze op elk moment uit hun profiel blokkeren.', 'Ce profil a été débloqué, vous pouvez les bloquer à tout moment depuis leur profil.', 'Dieses Profil wurde entsperrt. Sie können sie jederzeit von ihrem Profil aus blockieren.', 'Этот профиль разблокирован, вы можете заблокировать их в любое время из своего профиля.', 'Este perfil ha sido desbloqueado, puedes bloquearlos en cualquier momento desde su perfil.', 'Bu profil engellemeyi kaldırdı, dilediğiniz zaman profillerinden engelleyebilirsiniz.'),
(105, 'confirm_unblock_user', 'Are you sure you want to unblock this user? They will now be able to follow you or see your posts', 'هل أنت متأكد من أنك تريد إلغاء حظر هذا المستخدم؟ سيتمكنون الآن من متابعتك أو مشاهدة مشاركاتك', 'Weet je zeker dat je deze gebruiker wilt deblokkeren? Ze kunnen je nu volgen of je berichten bekijken', 'Êtes-vous sûr de vouloir débloquer cet utilisateur? Ils seront désormais en mesure de vous suivre ou de voir vos messages', 'Möchten Sie diesen Benutzer wirklich entsperren? Sie können Ihnen jetzt folgen oder Ihre Posts sehen', 'Вы действительно хотите разблокировать этого пользователя? Теперь они смогут следить за вами или видеть ваши сообщения', '¿Seguro que quieres desbloquear a este usuario? Ahora podrán seguirte o ver tus publicaciones', 'Bu kullanıcının engellemesini kaldırmak istediğinizden emin misiniz? Artık sizi takip edebilir veya gönderilerinizi görebilirler.'),
(106, 'report_t1', 'Account hacking', 'اختراق الحساب', 'Account hacken', 'Piratage de compte', 'Konto hacken', 'Взлом учетной записи', 'Piratería de cuenta', 'Hesap kesmek'),
(107, 'report_t2', 'Impersonation Accounts', 'حسابات انتحال الهوية', 'Imitatie-accounts', 'Comptes dusurpation didentité', 'Identitätswechselkonten', 'Аккаунты олицетворения', 'Cuentas de suplantación', 'Kimliğe bürünme hesapları'),
(108, 'report_t3', 'Violent threats', 'تهديدات عنيفة', 'Gewelddadige bedreigingen', 'Menaces violentes', 'Gewalttätige Bedrohungen', 'Насильственные угрозы', 'Amenazas violentas', 'Şiddetli tehditler'),
(109, 'report_t4', 'Sexual content', 'محتوى جنسي', 'Seksuele inhoud', 'Contenu sexuel', 'Sexueller Inhalt', 'Сексуальный контент', 'Contenido sexual', 'Cinsel içerik'),
(110, 'report_t5', 'Children who have not reached the required age', 'الأطفال الذين لم يبلغوا السن المطلوبة', 'Kinderen die de vereiste leeftijd niet hebben bereikt', 'Enfants qui nont pas atteint lâge requis', 'Kinder, die das erforderliche Alter nicht erreicht haben', 'Дети, не достигшие требуемого возраста', 'Niños que no han alcanzado la edad requerida', 'Gerekli yaşta ulaşmamış çocuklar'),
(111, 'report_t6', 'Accounts expressing hatred', 'حسابات تعبر عن الكراهية', 'Accounts die haat uitdrukt', 'Comptes exprimant la haine', 'Konten zum Ausdruck bringen Hass', 'Счета, выражающие ненависть', 'Cuentas que expresan odio', 'Nefreti ifade eden hesaplar'),
(112, 'report_t7', 'Spam or Advertizing', 'البريد المزعج أو الإعلان', 'Spam of adverteren', 'Spam ou publicité', 'Spam oder Werbung', 'Спам или реклама', 'Spam o publicidad', 'Spam veya Reklamcılık'),
(113, 'report_t8', 'Copyrighted material', 'مواد محفوظة الحقوق', 'Auteursrechtelijk beschermd materiaal', 'Matériel protégé par le droit dauteur', 'Urheberrechtlich geschütztes Material', 'Защищенный авторскими правами', 'Material con copyright', 'Telif hakkıyla korunan materyal'),
(114, 'no_posted_yet', 'There are no posts yet.', 'لا توجد مشاركات حتى الآن.', 'Er zijn nog geen berichten.', 'Il ny a pas encore de publications.', 'Es gibt noch keine Beiträge.', 'Нет сообщений.', 'No hay publicaciones todavía', 'Henüz hiç ileti yok.'),
(115, 'home_page', 'Home page', 'الصفحة الرئيسية', 'Startpagina', 'Page daccueil', 'Startseite', 'Главная страница', 'Página de inicio', 'Ana sayfa'),
(116, 'explore_people', 'Explore people', 'استكشاف الناس', 'Verken mensen', 'Explorer les gens', 'Erkunden Sie Menschen', 'Исследуйте людей', 'Explora personas', 'İnsanları keşfedin'),
(117, 'explore_tags', 'Explore tags', 'استكشاف العلامات', 'Verken tags', 'Explorer les tags', 'Tags durchsuchen', 'Исследуйте теги', 'Explore las etiquetas', 'Etiketleri keşfedin'),
(118, 'general', 'General', 'جنرال لواء', 'Algemeen', 'Général', 'Allgemeines', 'Генеральная', 'General', 'Genel'),
(119, 'privacy', 'Privacy', 'الإجمالية', 'Privacy', 'Intimité', 'Privatsphäre', 'Конфиденциальность', 'Intimidad', 'Gizlilik'),
(120, 'blocked_users', 'Blocked users', 'مستخدمين محجوبين', 'Geblokkeerde gebruikers', 'Utilisateurs bloqués', 'Blockierte Benutzer', 'Заблокированные пользователи', 'Usuarios bloqueados', 'Engellenmiş kullanıcılar'),
(121, 'delete_account', 'Delete account', 'حذف الحساب', 'Account verwijderen', 'Supprimer le compte', 'Konto löschen', 'Удалить аккаунт', 'Borrar cuenta', 'Hesabı sil'),
(122, 'change_avatar', 'Change Profile Avatar', 'تغيير الملف الشخصي الصورة الرمزية', 'Profielprofiel wijzigen', 'Changer le profil Avatar', 'Profil-Avatar ändern', 'Изменить профиль Аватар', 'Cambiar perfil Avatar', 'Profili değiştir Avatar'),
(123, 'fname', 'First name', 'الاسم الاول', 'Voornaam', 'Prénom', 'Vorname', 'Имя', 'Nombre de pila', 'İsim'),
(124, 'lname', 'Last name', 'الكنية', 'Achternaam', 'Nom de famille', 'Familienname, Nachname', 'Фамилия', 'Apellido', 'Soyadı'),
(125, 'email', 'E-mail', 'البريد الإلكتروني', 'E-mail', 'Email', 'Email', 'Эл. почта', 'Email', 'E-mail'),
(126, 'gender', 'Gender', 'جنس', 'Geslacht', 'Le genre', 'Geschlecht', 'Пол', 'Género', 'Cinsiyet'),
(127, 'country', 'Country', 'بلد', 'land', 'Pays', 'Land', 'Страна', 'País', 'ülke'),
(128, 'user_not_exist', 'User does not exist!', 'المستخدم غير موجود!', 'Gebruiker bestaat niet!', 'Lutilisateur nexiste pas!', 'Benutzer existiert nicht!', 'Пользователь не существует!', '¡El usuario no existe!', 'Kullanıcı yok!'),
(129, 'please_check_details', 'Please check your details!', 'الرجاء مراجعة التفاصيل الخاصة بك!', 'Check alsjeblieft je gegevens!', 'Sil vous plaît vérifier vos informations!', 'Bitte überprüfe deine Details!', 'Пожалуйста, проверьте свои данные!', '¡Por favor comprueba tus detalles!', 'Lütfen detaylarınızı kontrol edin!'),
(130, 'ur_fname', 'Your first name', 'اسمك الأول', 'Jouw voornaam', 'Ton prénom', 'Ihr Vorname', 'Твое имя', 'Su nombre', 'Senin adın'),
(131, 'ur_lname', 'Your last name', 'اسمك الاخير', 'Je achternaam', 'Votre nom de famille', 'Ihr Nachname', 'Ваша фамилия', 'Tu apellido', 'Soy adınız'),
(132, 'ur_email', 'Your email address', 'عنوان بريدك  الإلكتروني', 'jouw e-mailadres', 'Votre adresse email', 'deine Emailadresse', 'Ваш адрес электронной почты', 'Tu correo electrónico', 'e'),
(133, 'change_passwd', 'Change my password', 'تغيير كلمة المرور الخاصة بي', 'Verander mijn wachtwoord', 'Changer mon mot de passe', 'Ändere mein Passwort', 'Изменить пароль', 'Cambiar mi contraseña', 'Şifremi Değiştir'),
(134, 'old_passwd', 'Old password', 'كلمة المرور القديمة', 'Oud Wachtwoord', 'Ancien mot de passe', 'Altes Passwort', 'Старый пароль', 'Contraseña anterior', 'Eski şifre'),
(135, 'ur_curr_passwd', 'Your current password', 'كلمة السر الحالية الخاصة بك', 'je huidige wachtwoord', 'Votre mot de passe actuel', 'dein aktuelles Passwort', 'ваш текущий пароль', 'tu contraseña actual', 'mevcut şifreniz'),
(136, 'new_passwd', 'New password', 'كلمة السر الجديدة', 'Nieuw paswoord', 'Nouveau mot de passe', 'Neues Kennwort', 'Новый пароль', 'Nueva contraseña', 'Yeni Şifre'),
(137, 'ur_new_passwd', 'Your new password', 'كلمة سرك الجديدة', 'uw nieuwe wachtwoord', 'Votre nouveau mot de passe', 'Dein neues Passwort', 'ваш новый пароль', 'Tu nueva contraseña', 'Yeni parolanız'),
(138, 'conf_new_passwd', 'Confirm new password', 'تأكيد كلمة المرور الجديدة', 'Bevestig nieuw wachtwoord', 'Confirmer le nouveau mot de passe', 'Bestätige neues Passwort', 'Подтвердите новый пароль', 'Confirmar nueva contraseña', 'Yeni şifreyi onayla'),
(139, 'conf_ur_new_passwd', 'Confirm your new password', 'قم بتأكيد كلمة المرور الجديدة', 'Bevestig uw nieuwe wachtwoord', 'Confirmez votre nouveau mot de passe', 'Bestätigen Sie Ihr neues Passwort', 'Подтвердите свой новый пароль', 'Confirma tu nueva contraseña', 'Yeni şifrenizi onaylayın'),
(140, 'save_changes', 'Save changes', 'حفظ التغييرات', 'Wijzigingen opslaan', 'Sauvegarder les modifications', 'Änderungen speichern', 'Сохранить изменения', 'Guardar cambios', 'Değişiklikleri Kaydet'),
(141, 'acc_privacy_settings', 'Account privacy settings', 'إعدادات خصوصية الحساب', 'Account privacy-instellingen', 'Paramètres de confidentialité du compte', 'Konto Datenschutzeinstellungen', 'Настройки конфиденциальности учетной записи', 'Configuración de privacidad de la cuenta', 'Hesap gizliliği ayarları'),
(142, 'p_privacy', 'Who can view your profile', 'من يمكنه مشاهدة ملفك الشخصي', 'Wie kan jouw profiel bekijken', 'Qui peut voir votre profil', 'Wer kann dein Profil sehen?', 'Кто может просматривать ваш профиль', 'Quién puede ver tu perfil', 'Kimler profilinizi görüntüleyebilir?'),
(143, 'c_privacy', 'Who can direct message you', 'من يستطيع توجيه رسالة لك', 'Wie kan je een bericht sturen?', 'Qui peut vous adresser un message', 'Wer kann dir eine Nachricht schicken?', 'Кто может направить вам сообщение', 'Quién puede enviarte un mensaje directo', 'Mesajı kim yönlendirebilir?'),
(144, 'everyone', 'Everyone', 'كل واحد', 'Iedereen', 'Toutes les personnes', 'Jeder', 'Все', 'Todo el mundo', 'Herkes'),
(145, 'nobody', 'Nobody', 'لا أحد', 'Niemand', 'Personne', 'Niemand', 'Никто', 'Nadie', 'Kimse'),
(146, 'people_i_follow', 'People i follow', 'الناس أتابع', 'Mensen die ik volg', 'Les gens que je suis', 'Leute, denen ich folge', 'Люди, которых я следую', 'Gente que sigo', 'Takip ettiğim kişiler'),
(147, 'notif_settings', 'Notification settings', 'إعدادات الإشعار', 'Notificatie instellingen', 'Paramètres de notification', 'Benachrichtigungseinstellungen', 'Настройки уведомлений', 'Configuración de las notificaciones', 'Bildirim ayarları'),
(148, 'receive_notif_when', 'Receive notifications when some one', 'تلقي الإخطارات عندما واحد', 'Ontvang meldingen wanneer iemand', 'Recevoir des notifications quand quelquun', 'Erhalten Sie Benachrichtigungen wenn jemand', 'Получать уведомления, когда кто-то', 'Recibir notificaciones cuando alguien', 'Bazılarında bildirim al'),
(149, 'liked_my_post', 'Liked my post', 'اعجبتني', 'Vond mijn bericht leuk', 'Jai aimé mon message', 'Mir hat mein Post gefallen', 'Понравился мой пост', 'Me gustó mi publicación', 'Gönderiyi beğendi'),
(150, 'commented_my_post', 'Commented on my post', 'وعلق على منصبي', 'Gereageerd op mijn bericht', 'Jai commenté mon message', 'Hat meinen Beitrag kommentiert', 'Прокомментировал мой пост', 'Comentó en mi publicación', 'Gönderi hakkında yorum yaptı'),
(151, 'followed_me', 'Followed me', 'تابعني', 'Volgde mij', 'Ma suivi', 'Folgte mir', 'Следовал за мной', 'Sigueme', 'Beni takip etti'),
(152, 'mentioned_me', 'Mentioned me', 'ذكرني', 'Noemde me', 'Ma mentionné', 'Erwähnte mich', 'Упоминал меня', 'Me mencionó', 'Bana bahsetti'),
(153, 'followed_u', 'is now following you', 'هو الآن يتبعك', 'volgt je nu', 'est maintenant en train de te suivre', 'folgt dir jetzt', 'теперь следует вам', 'ahora te está siguiendo', 'seni takip ediyor'),
(154, 'liked_ur_post', 'liked your post', 'أعجبني مشاركتك', 'vond je bericht leuk', 'aimé votre message', 'hat deinen Beitrag gefallen', 'понравилось ваше сообщение', 'me gustó tu publicación', 'yayınınızı beğendi'),
(155, 'commented_ur_post', 'commneted on your post', 'كلف على رسالتك', 'verbonden op uw post', 'commneted sur votre message', 'kommentared auf Ihrem Post', 'Записан', 'commneted en su publicación', 'yayınınızda toplandı'),
(156, 'mentioned_u_in_comment', 'mentioned you in a comment', 'ذكرك في تعليق', 'vermeldde U in een opmerking', 'vous a mentionné dans un commentaire', 'dich in einem Kommentar erwähnt', 'упомянул вас в комментарии', 'Te mencioné en un comentario', 'Bir yorumda sizden bahsetti'),
(157, 'mentioned_u_in_post', 'mentioned you in a post', 'ذكرت لك في وظيفة', 'heeft je in een bericht genoemd', 'vous a mentionné dans un message', 'Sie in einem Beitrag erwähnt', 'упомянул вас в сообщении', 'te mencionó en una publicación', 'senden bir mesajda bahsetti'),
(158, 'manage_blocked_users', 'Manage users that you have blocked', 'إدارة المستخدمين الذين قمت بحظرهم', 'Beheer gebruikers die u hebt geblokkeerd', 'Gérer les utilisateurs que vous avez bloqués', 'Verwalten Sie Benutzer, die Sie blockiert haben', 'Управление заблокированными пользователями', 'Administrar usuarios que has bloqueado', 'Engellediğiniz kullanıcıları yönetin'),
(159, 'no_blocked_users', 'No blocked users found', 'لم يتم العثور على مستخدمين محظورين', 'Geen geblokkeerde gebruikers gevonden', 'Aucun utilisateur bloqué trouvé', 'Keine blockierten Benutzer gefunden', 'Не обнаружены заблокированные пользователи', 'No se encontraron usuarios bloqueados', 'Engellenen kullanıcı bulunamadı'),
(160, 'confirm_del_account', 'Are you sure you want to delete your account? All content including published posts,will be permanetly removed!', 'هل انت متأكد انك تريد حذف حسابك؟ جميع المحتويات بما في ذلك المنشورات المنشورة ، سيتم إزالتها نهائيا!', 'Weet je zeker dat je je account wilt verwijderen? Alle inhoud inclusief gepubliceerde berichten, zal permanent worden verwijderd!', 'Êtes-vous sûr de vouloir supprimer votre compte? Tout le contenu, y compris les articles publiés, sera définitivement supprimé!', 'Möchtest du dein Konto wirklich löschen? Alle Inhalte einschließlich veröffentlichter Posts werden dauerhaft entfernt!', 'Вы действительно хотите удалить свою учетную запись? Весь контент, включая опубликованные сообщения, будет удален!', '¿Seguro que quieres eliminar tu cuenta? ¡Todo el contenido, incluidas las publicaciones publicadas, se eliminará de forma permanente!', 'Hesabınızı silmek istediğinizden emin misiniz? Yayınlanmış gönderiler dahil tüm içerikler kalıcı olarak kaldırılacak!'),
(161, 'enter_ur_passwd', 'Enter your password', 'ادخل رقمك السري', 'Voer uw wachtwoord in', 'Tapez votre mot de passe', 'Gib dein Passwort ein', 'Введите ваш пароль', 'Ingresa tu contraseña', 'Şifrenizi girin'),
(162, 'continue', 'Continue', 'استمر', 'Doorgaan met', 'Continuer', 'Fortsetzen', 'Продолжать', 'Continuar', 'Devam et'),
(163, 'ur_account_deleted', 'Your account successfully deleted. Please wait..', 'تم حذف حسابك بنجاح. أرجو الإنتظار..', 'Uw account is succesvol verwijderd. Even geduld aub..', 'Votre compte a bien été supprimé. Sil vous plaît, attendez..', 'Ihr Konto wurde erfolgreich gelöscht. Warten Sie mal..', 'Ваша учетная запись успешно удалена. Пожалуйста, подождите..', 'Su cuenta fue eliminada exitosamente. Por favor espera..', 'Hesabınız başarıyla silindi. Lütfen bekle..'),
(164, 'ur_avatar_changed', 'Your profile avatar has been successfully changed', 'تم تغيير الصورة الشخصية لملفك الشخصي بنجاح', 'Je profielavatar is succesvol gewijzigd', 'Votre avatar de profil a été modifié avec succès', 'Dein Profilavatar wurde erfolgreich geändert', 'Ваш аватар профиля успешно изменен', 'Tu avatar de perfil ha sido cambiado con éxito', 'Profil avatarınız başarıyla değiştirildi'),
(165, 'terms_of_use', 'Terms of use', 'تعليمات الاستخدام', 'Gebruiksvoorwaarden', 'Conditions dutilisation', 'Nutzungsbedingungen', 'Условия эксплуатации', 'Términos de Uso', 'Kullanım Şartları'),
(166, 'login_to_lc_post', 'To like or comment.', 'أحب أو تعليق.', 'Leuk vinden of commentaar geven.', 'Aimer ou commenter', 'Zu mögen oder zu kommentieren.', 'Любить или комментировать.', 'Me gusta o comenta', 'Beğenmek veya yorum yapmak.'),
(167, 'page_not_found', 'Sorry, this page is not available.', 'عذرا، هذه الصفحة غير متوفرة.', 'Sorry, deze pagina is niet beschikbaar.', 'Désolé, cette page nest pas disponible.', 'Leider ist diese Seite nicht verfügbar.', 'Извините, эта страница недоступна.', 'Lo sentimos, esta página no está disponible.', 'Maalesef, bu sayfa mevcut değil.'),
(168, 'page_link_is_invalid', 'You may have used an invalid link or the page was deleted', 'ربما تكون قد استخدمت رابطًا غير صالح أو تم حذف الصفحة', 'Mogelijk hebt u een ongeldige link gebruikt of is de pagina verwijderd', 'Vous avez peut-être utilisé un lien incorrect ou la page a été supprimée', 'Möglicherweise haben Sie einen ungültigen Link verwendet oder die Seite wurde gelöscht', 'Возможно, вы использовали неверную ссылку или страница была удалена', 'Es posible que haya utilizado un enlace no válido o que la página haya sido eliminada', 'Geçersiz bir bağlantı kullanmış olabilirsiniz veya sayfa silinmiş'),
(169, 'story_system_limit', 'You have reached the daily update limit for your story. maximum limit is 20', 'لقد وصلت إلى الحد اليومي للتحديث لقصتك. الحد الأقصى هو 20', 'U heeft de dagelijkse updatelimiet voor uw verhaal bereikt. maximale limiet is 20', 'Vous avez atteint la limite de mise à jour quotidienne pour votre histoire. la limite maximale est de 20', 'Du hast das tägliche Aktualisierungslimit für deine Geschichte erreicht. Höchstgrenze ist 20', 'Вы достигли ежедневного предела обновления для своей истории. максимальный предел равен 20', 'Has alcanzado el límite de actualización diaria de tu historia. el límite máximo es 20', 'Hikayeniz için günlük güncelleme limitine ulaştınız. maksimum sınır 20'),
(170, 'delete_story', 'Delete story', 'احذف القصة', 'Verhaal verwijderen', 'Supprimer lhistoire', 'Geschichte löschen', 'Удалить историю', 'Eliminar historia', 'Hikayeyi sil'),
(171, 'confirm_del_story', 'Are you sure you want to delete this status? Note all of your followers can not see it after removal', 'هل أنت متأكد من أنك تريد حذف هذه الحالة؟ لاحظ أن جميع المتابعين لا يمكنهم رؤيته بعد الإزالة', 'Weet je zeker dat je deze status wilt verwijderen? Let op al uw volgers kunnen het niet zien na verwijdering', 'Êtes-vous sûr de vouloir supprimer ce statut? Notez que tous vos abonnés ne peuvent pas le voir après la suppression', 'Möchten Sie diesen Status wirklich löschen? Beachten Sie, dass alle Ihre Follower es nach dem Entfernen nicht sehen können', 'Вы действительно хотите удалить этот статус? Обратите внимание, что все ваши сторонники не видят его после удаления', '¿Estás seguro de que deseas eliminar este estado? Tenga en cuenta que todos sus seguidores no pueden verlo después de la eliminación', 'Bu durumu silmek istediğinizden emin misiniz? Tüm takipçileriniz kaldırıldıktan sonra göremediğini unutmayın'),
(172, 'people_who_liked', 'People who liked this post', 'الناس الذين أحب هذا المنصب', 'Mensen die dit bericht leuk vonden', 'Personnes qui ont aimé ce post', 'Leute, die diesen Beitrag mochten', 'Люди, которым понравился этот пост', 'Gente a la que le gustó esta publicación', 'Bu yayını beğenenler'),
(173, 'show_more', 'Show more', 'أظهر المزيد', 'Laat meer zien', 'Montre plus', 'Zeig mehr', 'Показать больше', 'Mostrar más', 'Daha fazla göster'),
(174, 'no_more_comments', 'No more comments', 'لا المزيد من التعليقات', 'Geen commentaar meer', 'Pas dautres commentaires', 'Keine weiteren Kommentare', 'Больше комментариев нет', 'No mas comentarios', 'Daha fazla yorum yok'),
(175, 'add_story', 'Add story', 'أضف قصة', 'Voeg een verhaal toe', 'Ajouter une histoire', 'Geschichte hinzufügen', 'Добавить историю', 'Añadir historia', 'Hikaye ekle'),
(176, 'imp_gif', 'Embed gif', 'تضمين ملف gif', 'Embed gif', 'Intégrer gif', 'Gif einbetten', 'Вставить gif', 'Insertar gif', 'Embed gif'),
(177, 'imp_vid', 'Embed video', 'تضمين الفيديو', 'Video insluiten', 'Intégrer la vidéo', 'Video einbetten', 'Встроенное видео', 'Video incrustado', 'Gömülü video'),
(178, 'add_vid', 'Upload video', 'رفع فيديو', 'Upload video', 'Télécharger une video', 'Video hochladen', 'Загрузить видео', 'Subir video', 'Video yükle'),
(179, 'add_img', 'Upload image', 'تحميل الصور', 'Afbeelding uploaden', 'Importer une image', 'Bild hochladen', 'Загрузить изображение', 'Cargar imagen', 'Fotoğraf yükleniyor'),
(180, 'website', 'Website', 'موقع الكتروني', 'Website', 'Site Internet', 'Webseite', 'Веб-сайт', 'Sitio web', 'Web sitesi'),
(181, 'facebook', 'Facebook', 'فيس بوك', 'Facebook', 'Facebook', 'Facebook', 'facebook', 'Facebook', 'Facebook'),
(182, 'google', 'Google', 'جوجل', 'Google', 'Google', 'Google', 'Google', 'Google', 'Google'),
(183, 'twitter', 'Twitter', 'تغريد', 'tjilpen', 'Gazouillement', 'Twitter', 'щебет', 'Gorjeo', 'heyecan'),
(184, 'ur_website', 'Your website url', 'عنوان موقعك', 'Jouw website URL', 'Ladresse URL de votre site', 'Deine Website URL', 'URL вашего сайта', 'URL de tu sitio web', 'Web sitenizin URLsi'),
(185, 'ur_facebook', 'Your facebook profile url', 'الفيسبوك الخاص بك', 'Je facebook profiel url', 'Votre URL de profil facebook', 'Ihre Facebook Profil URL', 'Ваш профиль профиля facebook', 'Tu URL de perfil de Facebook', 'Facebook profil URL’niz'),
(186, 'ur_google', 'Your google-plus profile url', 'Your google-plus profile url', 'Uw Google-plus profiel-URL', 'Votre URL de profil google-plus', 'Ihre Google-Plus-Profil-URL', 'Ваш URL-адрес профиля google-plus', 'Tu URL de perfil de google-plus', 'Google artı profil URL’niz'),
(187, 'ur_twitter', 'Your twitter profile url', 'رابط تويتر الخاص بك', 'Je twitterprofiel-URL', 'Votre URL de profil twitter', 'Deine Twitter-Profil-URL', 'Ваш URL профиля твиттера', 'Tu url del perfil de twitter', 'Twitter profiliniz'),
(188, 'about_u', 'About you', 'حولك', 'Over jou', 'Au propos de vous', 'Über dich', 'О тебе', 'Acerca de ti', 'Senin hakkında'),
(189, 'fname_is_long', 'First name is too long Please enter a valid first name', 'الاسم الأول طويل جدًا الرجاء إدخال اسم أول صالح', 'Voornaam is te lang Voer een geldige voornaam in', 'Le prénom est trop long Veuillez entrer un prénom valide', 'Vorname ist zu lang Bitte geben Sie einen gültigen Vornamen ein', 'Имя слишком длинное Пожалуйста, введите действительное имя', 'El nombre es demasiado largo Por favor ingrese un nombre válido', 'İsim çok uzun. Lütfen geçerli bir ilk isim giriniz'),
(190, 'lname_is_long', 'Last name is too long Please enter a valid last name', 'الاسم الأخير طويل جدًا الرجاء إدخال اسم العائلة الصحيح', 'Achternaam is te lang Voer een geldige achternaam in', 'Le nom est trop long Veuillez entrer un nom de famille valide', 'Nachname ist zu lang Bitte geben Sie einen gültigen Nachnamen ein', 'Фамилия слишком длинная Пожалуйста, введите действительную фамилию', 'El apellido es demasiado largo. Ingrese un apellido válido', 'Soyadı çok uzun! Lütfen geçerli bir soyad girin'),
(191, 'about_is_long', 'Your text about you is too long The maximum number of text characters is 150.', 'نصك عنك طويل جدًا الحد الأقصى لعدد أحرف النص هو 150.', 'Uw tekst over u is te lang. Het maximale aantal teksttekens is 150.', 'Votre texte à votre sujet est trop long Le nombre maximum de caractères est de 150.', 'Ihr Text über Sie ist zu lang Die maximale Anzahl an Textzeichen beträgt 150.', 'Ваш текст о вас слишком длинный. Максимальное количество текстовых символов - 150.', 'Su texto sobre usted es demasiado largo. La cantidad máxima de caracteres de texto es 150.', 'Sizinle ilgili metniniz çok uzun. Maksimum metin karakter sayısı 150dir.');
INSERT INTO `pxp_langs` (`id`, `lang_key`, `english`, `arabic`, `dutch`, `french`, `german`, `russian`, `spanish`, `turkish`) VALUES
(192, 'invalid_webiste_url', 'Your website url is invalid Please enter a valid url', 'عنوان URL لموقعك غير صالح يرجى إدخال عنوان url صالح', 'De url van uw website is ongeldig Voer een geldige URL in', 'LURL de votre site Web est invalide Veuillez entrer une URL valide', 'Ihre Website-URL ist ungültig Bitte geben Sie eine gültige URL ein', 'Недопустимый URL-адрес вашего веб-сайта. Введите действительный URL-адрес', 'La URL de su sitio web no es válida. Ingrese una URL válida.', 'Web sitenizin URLsi geçersiz Lütfen geçerli bir URL girin'),
(193, 'invalid_facebook_url', 'Your facebook profile url is invalid Please enter a valid url', 'عنوان URL الخاص بك على فيسبوك غير صالح يرجى إدخال عنوان url صالح', 'De URL van je Facebook-profiel is ongeldig Voer een geldige URL in', 'Votre URL de profil facebook est invalide Veuillez entrer une URL valide', 'Ihre Facebook-Profil-URL ist ungültig. Bitte geben Sie eine gültige URL ein', 'Ваш URL-адрес профиля facebook недействителен. Введите действительный URL-адрес', 'Tu URL de perfil de Facebook no es válida. Ingresa una URL válida.', 'Facebook profile url geçersiz Lütfen geçerli bir url girin'),
(194, 'invalid_google_url', 'Your google profile url is invalid Please enter a valid url', 'Your google profile url is invalid الرجاء إدخال عنوان url صالح', 'De URL van uw Google-profiel is ongeldig Voer een geldige URL in', 'Votre URL de profil Google nest pas valide Veuillez entrer une URL valide', 'Ihre Google Profil-URL ist ungültig Bitte geben Sie eine gültige URL ein', 'Ваш URL-адрес профиля google недействителен Пожалуйста, введите действительный URL-адрес', 'Tu URL de perfil de google no es válida. Ingresa una URL válida.', 'Google profil URL’niz geçersiz. Lütfen geçerli bir URL girin'),
(195, 'invalid_twitter_url', 'Your twitter profile url is invalid Please enter a valid url', 'عنوان url الخاص بموقع twitter الخاص بك غير صالح يرجى إدخال عنوان url صالح', 'De URL van je twitterprofiel is ongeldig Voer een geldige URL in', 'Votre URL de profil twitter est invalide Veuillez entrer une URL valide', 'Deine Twitter-Profil-URL ist ungültig Bitte gib eine gültige URL ein', 'Неверный URL-адрес профиля Twitter. Введите действительный URL-адрес', 'Tu URL de perfil de twitter no es válida. Ingresa una URL válida.', 'Twitter profiliniz geçersiz. Lütfen geçerli bir URL girin'),
(196, 'time_ago', 'ago', 'منذ', 'geleden', 'depuis', 'vor', 'тому назад', 'hace', 'önce'),
(197, 'time_from_now', 'from now', 'من الان', 'vanaf nu', 'à partir de maintenant', 'in', 'отныне', 'desde ahora', 'şu andan itibaren'),
(198, 'time_any_moment_now', 'any moment now', 'في اي لحظة الان', 'elk moment nu', 'à tout moment maintenant', 'jeden Moment jetzt', 'в любой момент сейчас', 'en cualquier momento ahora', 'şimdi her an'),
(199, 'time_just_now', 'Just now', 'الآن فقط', 'Net nu', 'Juste maintenant', 'Gerade jetzt', 'Прямо сейчас', 'Justo ahora', 'Şu anda'),
(200, 'time_about_a_minute_ago', 'about a minute ago', 'منذ دقيقة واحدة', 'ongeveer een minuut geleden', 'Il y a environ une minute', 'Vor ca. einer Minute', 'около минуты назад', 'hace alrededor de un minuto', 'yaklaşık bir dakika önce'),
(201, 'time_minute_ago', '%d minutes ago', 'قبل٪ d دقيقة', '% d minuten geleden', 'Il y a% d minutes', '% d Minuten vor', '% d минут назад', 'Hace% d minutos', '% d dakika önce'),
(202, 'time_about_an_hour_ago', 'about an hour ago', 'منذ ساعة تقريبا', 'ongeveer een uur geleden', 'il y a à peu près une heure', 'vor ungefähr einer Stunde', 'около часа назад', 'Hace aproximadamente una hora', 'yaklaşık bir saat önce'),
(203, 'time_hours_ago', '%d hours ago', 'قبل٪ d ساعة', '% d uur geleden', 'Il y a% d heures', '% d Stunden vor', '% часов назад', 'Hace% d horas', '% d saat önce'),
(204, 'time_a_day_ago', 'a day ago', 'قبل يوم', 'een dag geleden', 'il y a un jour', 'vor einem Tag', 'день назад', 'Hace un día', 'bir gün önce'),
(205, 'time_a_days_ago', '%d days ago', 'قبل٪ d يومًا', '% d dagen geleden', 'il y a% d jours', '% d Tage vor', '% дней назад', 'hace% d días', '% d gün önce'),
(206, 'time_about_a_month_ago', 'about a month ago', 'قبل شهر مضى', 'ongeveer een maand geleden', 'il y a environ un mois', 'vor ungefähr einem Monat', 'Около месяца назад', 'Hace más o menos un mes', 'yaklaşık bir ay önce'),
(207, 'time_months_ago', '%d months ago', 'قبل شهر واحد', '% d maanden geleden', 'Il y a% d mois', '% d Monate zuvor', '% d месяцев назад', 'Hace% d meses', '% d ay önce'),
(208, 'time_about_a_year_ago', 'about a year ago', 'قبل نحو سنة', 'ongeveer een jaar geleden', 'Il ya environ un an', 'vor ungefähr einem Jahr', 'около года назад', 'Hace un año', 'yaklaşık bir yıl önce'),
(209, 'time_years_ago', '%d years ago', 'قبل٪ d سنة', '% d jaar geleden', 'Il y a% d années', '% d Jahren', '% d лет назад', '% d años atrás', '% d yıl önce'),
(210, 'year', 'year', 'عام', 'jaar', 'an', 'Jahr', 'год', 'año', 'yıl'),
(211, 'month', 'month', 'شهر', 'maand', 'mois', 'Monat', 'месяц', 'mes', 'ay'),
(212, 'day', 'day', 'يوم', 'dag', 'journée', 'Tag', 'день', 'día', 'gün'),
(213, 'hour', 'hour', 'ساعة', 'uur', 'heure', 'Stunde', 'час', 'hora', 'saat'),
(214, 'minute', 'minute', 'اللحظة', 'minuut', 'minute', 'Minute', 'минут', 'minuto', 'dakika'),
(215, 'second', 'second', 'ثانيا', 'tweede', 'seconde', 'zweite', 'второй', 'segundo', 'ikinci'),
(216, 'years', 'years', 'سنوات', 'jaar', 'années', 'Jahre', 'лет', 'años', 'yıl'),
(217, 'months', 'months', 'الشهور', 'maanden', 'mois', 'Monate', 'месяцы', 'meses', 'ay'),
(218, 'days', 'days', 'أيام', 'dagen', 'journées', 'Tage', 'дней', 'dias', 'günler'),
(219, 'hours', 'hours', 'ساعات', 'uur', 'heures', 'Std.', 'часов', 'horas', 'saatler'),
(220, 'minutes', 'minutes', 'الدقائق', 'notulen', 'minutes', 'Protokoll', 'минут', 'minutos', 'dakika'),
(221, 'seconds', 'seconds', 'ثواني', 'seconden', 'secondes', 'Sekunden', 'секунд', 'segundos', 'saniye'),
(222, 'home', 'Home', 'الصفحة الرئيسية', 'Huis', 'Accueil', 'Zuhause', 'Главная', 'Casa', 'Ev'),
(223, 'no_users_yet', 'There are no users yet', 'لا يوجد مستخدم بعد', 'Er zijn nog geen gebruikers', 'Il n\'y a pas encore d\'utilisateurs', 'Es gibt noch keine Benutzer', 'Пока нет пользователей', 'Todavía no hay usuarios', 'Henüz hiç kullanıcı yok'),
(224, 'image', 'Image', 'صورة', 'Beeld', 'Image', 'Bild', 'Образ', 'Imagen', 'görüntü'),
(225, 'video', 'Video', 'فيديو', 'Video', 'Vidéo', 'Video', 'видео', 'Vídeo', 'Video'),
(226, 'embed_video', 'Embed Video', 'تضمين الفيديو', 'Video insluiten', 'Intégrer la vidéo', 'Video einbetten', 'Встроенное видео', 'Video incrustado', 'Gömülü Video'),
(227, 'story', 'Story', 'قصة', 'Verhaal', 'Récit', 'Geschichte', 'История', 'Historia', 'Öykü'),
(228, 'delete', 'Delete', 'حذف', 'Verwijder', 'Effacer', 'Löschen', 'Удалить', 'Borrar', 'silmek'),
(229, 'block', 'Block', 'منع', 'Blok', 'Bloc', 'Block', 'блок', 'Bloquear', 'Blok'),
(230, 'explore', 'Explore', 'يكتشف', 'onderzoeken', 'Explorer', 'Erkunden', 'Исследовать', 'Explorar', 'keşfetmek'),
(231, 'copy_link', 'Copy Link', 'انسخ الرابط', 'Kopieer link', 'Copier le lien', 'Link kopieren', 'Копировать ссылку', 'Copiar link', 'Bağlantıyı kopyala'),
(232, 'about_us', 'About Us', 'معلومات عنا', 'Over ons', 'À propos de nous', 'Über uns', 'О нас', 'Sobre nosotros', 'Hakkımızda'),
(233, 'sign_in', 'Sign In', 'تسجيل الدخول', 'Aanmelden', 'Se connecter', 'Anmelden', 'Войти в систему', 'Registrarse', 'Oturum aç'),
(234, 'welcome_to', 'Welcome to', 'مرحبا بك في', 'Welkom bij', 'Bienvenue à', 'Willkommen zu', 'Добро пожаловать в', 'Bienvenido a', 'Hoşgeldiniz'),
(235, 'welcome_feature_1', 'Just Like the photos which you found interesting, unique and best.', 'تماما مثل الصور التي وجدت للاهتمام ، وفريدة من نوعها وأفضل.', 'Net als de foto\'s die u interessant, uniek en best vond.', 'Juste comme les photos que vous avez trouvées intéressantes, uniques et meilleures.', 'Genau wie die Fotos, die Sie interessant, einzigartig und am besten fanden.', 'Просто как фотографии, которые вы нашли интересными, уникальными и лучшими.', 'Al igual que las fotos que le parecieron interesantes, únicas y mejores.', 'Sadece ilginç, benzersiz ve en iyi bulduğunuz fotoğraflar gibi.'),
(236, 'welcome_feature_2', 'Become a follower of Famous people, celebrities and many more in your area.', 'أصبح تابعا من المشاهير والمشاهير وغيرها الكثير في منطقتك.', 'Word een volgeling van beroemde mensen, beroemdheden en nog veel meer in jouw omgeving.', 'Devenir un adepte des personnes célèbres, des célébrités et bien d\'autres dans votre région.', 'Werden Sie ein Anhänger von Berühmtheiten, Prominenten und vielen mehr in Ihrer Nähe.', 'Станьте последователем Знаменитых людей, знаменитостей и многих других в своей области.', 'Conviértete en seguidor de personajes famosos, celebridades y muchos más en tu área.', 'Ünlülerin, ünlülerin ve bölgenizdeki daha birçok kişinin takipçisi ol.'),
(237, 'welcome_feature_3', 'Immediately Save Images or videos to check them later anytime.', 'احفظ الصور أو مقاطع الفيديو فورًا للتحقق منها لاحقًا في أي وقت.', 'Sla onmiddellijk afbeeldingen of video\'s op om ze later op elk gewenst moment te bekijken.', 'Immédiatement enregistrer des images ou des vidéos pour les vérifier plus tard à tout moment.', 'Speichern Sie sofort Bilder oder Videos, um sie später jederzeit zu überprüfen.', 'Немедленно сохраните изображения или видео, чтобы проверить их позже в любое время.', 'Guarde de inmediato imágenes o videos para verlos más tarde en cualquier momento.', 'Hemen görüntüleri veya videoları istediğiniz zaman kontrol etmek için kaydedin.'),
(238, 'let_set_up', 'Let&#039;s get you set up', 'دعنا ننصحك', 'Laten we je instellen', 'Laissez-vous mettre en place', 'Lass uns dich einrichten', 'Дадим вам настроить', 'Vamos a prepararte', 'Ayarlayalım'),
(239, 'create_acc_proceed', 'Create your Account to continue to', 'قم بإنشاء حسابك للاستمرار', 'Maak uw account aan om door te gaan', 'Créez votre compte pour continuer à', 'Erstellen Sie Ihr Konto, um fortzufahren', 'Создайте свою учетную запись, чтобы продолжить', 'Crea tu cuenta para continuar', 'Devam etmek için Hesabınızı oluşturun'),
(240, 'min_to_get_start', 'It will take only couple of minutes to get started.', 'سوف يستغرق الأمر بضع دقائق فقط للبدء.', 'Het duurt maar een paar minuten om aan de slag te gaan.', 'Cela ne prendra que quelques minutes pour commencer.', 'Es dauert nur ein paar Minuten, um loszulegen.', 'Чтобы начать работу, потребуется всего несколько минут.', 'Solo tomará unos minutos para comenzar.', 'Başlamak için sadece birkaç dakika alacak.'),
(241, 'reset_password', 'Reset your Password', 'اعد ضبط كلمه السر', 'Stel je wachtwoord opnieuw in', 'Réinitialisez votre mot de passe', 'Setze dein Passwort zurück', 'Сбросить пароль', 'Restablecer su contraseña', 'Şifrenizi Sıfırla'),
(242, 'reset', 'Reset', 'إعادة تعيين', 'Reset', 'Réinitialiser', 'Zurücksetzen', 'Сброс', 'Reiniciar', 'Reset'),
(243, 'like', 'Like', 'مثل', 'Graag willen', 'Comme', 'Mögen', 'подобно', 'Me gusta', 'Sevmek'),
(244, 'save', 'Save', 'حفظ', 'Opslaan', 'sauvegarder', 'sparen', 'Сохранить', 'Salvar', 'Kayıt etmek'),
(245, 'select', 'Select', 'تحديد', 'kiezen', 'Sélectionner', 'Wählen', 'Выбрать', 'Seleccionar', 'seçmek'),
(246, 'email_not_exists', 'Email not found', 'البريد الإلكتروني غير موجود', 'e-mail niet gevonden', 'Email non trouvé', 'Email wurde nicht gefunden', 'Электронная почта не найдена', 'El correo electrónico no encontrado', 'Email bulunamadı'),
(247, 'sent_email', 'We have sent you an email, please check your inbox or spam folder.', 'لقد أرسلنا إليك بريدًا إلكترونيًا ، يرجى التحقق من مجلد البريد الوارد أو مجلد الرسائل غير المرغوب فيها.', 'We hebben je een e-mail gestuurd, kijk in je inbox of spam-map.', 'Nous vous avons envoyé un e-mail, vérifiez votre boîte de réception ou votre dossier de spam.', 'Wir haben Ihnen eine E-Mail geschickt, überprüfen Sie bitte Ihren Posteingang oder Spam-Ordner.', 'Мы отправили вам электронное письмо, пожалуйста, проверьте папку «Входящие» или «Спам».', 'Le hemos enviado un correo electrónico, consulte su bandeja de entrada o carpeta de correo no deseado.', 'Size bir e-posta gönderdik, lütfen gelen kutunuzu veya spam klasörünüzü kontrol edin.'),
(248, 'account_not_activated', 'Your account is not activated.', 'حسابك غير مفعل.', 'Je account is niet geactiveerd.', 'Votre compte n\'est pas activé.', 'Dein Konto ist nicht aktiviert.', 'Ваша учетная запись не активирована.', 'Su cuenta no está activada.', 'Hesabınız aktif değil.'),
(249, 'click_on_activation_link', 'Please click on activation link that was sent to your email.', 'الرجاء النقر فوق رابط التنشيط الذي تم إرساله إلى بريدك الإلكتروني.', 'Klik op de activeringslink die naar uw e-mail is verzonden.', 'Veuillez cliquer sur le lien d\'activation envoyé à votre adresse e-mail.', 'Bitte klicken Sie auf den Aktivierungslink, der an Ihre E-Mail gesendet wurde.', 'Нажмите ссылку активации, которая была отправлена ​​на ваш адрес электронной почты.', 'Haga clic en el enlace de activación que se envió a su correo electrónico.', 'Lütfen e-postanıza gönderilen aktivasyon linkine tıklayın.'),
(250, 'activate_user', 'Activate User', 'تفعيل المستخدم', 'Activeer Gebruiker', 'Activer l\'utilisateur', 'Benutzer aktivieren', 'Активировать пользователя', 'Activar usuario', 'Kullanıcıyı Etkinleştir'),
(251, 'successfully_loged_in', 'you were successfully logged in, please wait...', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(252, 'v2_reset_password', 'Reset Password', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(253, 'v2_reset_password_msg', 'To reset your password, please click the link below:', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(254, 'successfully_joined_created', 'Your account was succesffuly created, please check your inbox/spam folder for the activation link', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(255, 'v2_email_confirmed', 'Email Confirmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(256, 'website_use_cookies', 'This website uses cookies to ensure you get the best experience on our website.', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(257, 'got_it', 'Got it!', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(258, 'learn_more1', 'Learn more', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(259, 'views', 'Views', 'الآراء', 'Keer bekeken', 'Des vues', 'Ansichten', 'Просмотры', 'Puntos de vista', 'Görünümler'),
(260, 'verification', 'Verification', 'التحقق', 'Verificatie', 'Vérification', 'Nachprüfung', 'верификация', 'Verificación', 'Doğrulama'),
(261, 'verify_p', 'Verification of the profile!', 'التحقق من الملف الشخصي!', 'Verificatie van het profiel!', 'Vérification du profil!', 'Überprüfung des Profils!', 'Проверка профиля!', 'Verificación del perfil!', 'Profilin doğrulanması!'),
(262, 'name', 'Name', 'اسم', 'Naam', 'prénom', 'Name', 'название', 'Nombre', 'isim'),
(263, 'upload_docs', 'Upload documents', 'تحميل المستندات', 'Upload documenten', 'Télécharger des documents', 'Dokumente hochladen', 'Загрузить документы', 'Subir documentos', 'Belgeleri Yükle'),
(264, 'select_verif_images', 'Please upload a photo with your passport / ID &amp; your distinct photo', 'يرجى تحميل صورة مع جواز سفرك / هويتك وصورتك المميزة', 'Upload een foto met uw paspoort / ID en uw afzonderlijke foto', 'S&#039;il vous plaît télécharger une photo avec votre passeport / ID et votre photo distincte', 'Bitte lade ein Foto mit deinem Pass / Ausweis und deinem eigenen Foto hoch', 'Загрузите фотографию с вашим паспортом / удостоверением личности и вашей отдельной фотографией', 'Por favor, cargue una foto con su pasaporte / identificación y su foto distintiva', 'Lütfen pasaportunuz / kimliğiniz ve farklı fotoğrafınız ile fotoğraf yükleyin'),
(265, 'your_photo', 'Your Photo', 'صورتك', 'Je foto', 'Ta photo', 'Dein Foto', 'Твое фото', 'Tu foto', 'Senin resmin'),
(266, 'your_ip', 'Passport / id card', 'جواز السفر / بطاقة الهوية', 'Paspoort / identiteitskaart', 'Passeport / carte d&#039;identité', 'Reisepass / ID-Karte', 'Паспорт / удостоверение личности', 'Pasaporte / tarjeta de identificación', 'Pasaport / kimlik kartı'),
(267, 'send', 'Send', 'إرسال', 'Sturen', 'Envoyer', 'Senden', 'послать', 'Enviar', 'göndermek'),
(268, 'your_photo_invalid', 'Your Photo is invalid please select another photo', 'صورتك غير صالحة ، يرجى تحديد صورة أخرى', 'Uw foto is ongeldig. Selecteer een andere foto', 'Votre photo n&#039;est pas valide, veuillez sélectionner une autre photo.', 'Ihr Foto ist ungültig. Bitte wählen Sie ein anderes Foto aus', 'Ваша фотография недействительна, выберите другую фотографию', 'Tu foto no es válida, selecciona otra foto', 'Fotoğrafınız geçersiz. Lütfen başka bir fotoğraf seç'),
(269, 'your_ip_invalid', 'Your ip file is invalid please select another one', 'ملف IP الخاص بك غير صالح ، يرجى تحديد ملف آخر', 'Uw IP-bestand is ongeldig. Selecteer een ander bestand', 'Votre fichier ip n&#039;est pas valide, veuillez en choisir un autre', 'Ihre IP-Datei ist ungültig. Bitte wählen Sie eine andere aus', 'Ваш ip-файл недействителен, выберите другой', 'Su archivo ip no es válido por favor seleccione otro', 'IP dosyanız geçersiz, lütfen bir tane daha seçin'),
(270, 'request_done', 'Your verification request soon will be considered!', 'سيُنظر في طلب التحقق قريبًا!', 'Uw verificatieverzoek wordt snel overwogen!', 'Votre demande de vérification sera bientôt prise en compte!', 'Ihre Bestätigungsanfrage wird bald berücksichtigt!', 'Ваш запрос на подтверждение скоро будет рассмотрен!', 'Su solicitud de verificación pronto será considerada!', 'Doğrulama isteğiniz yakında dikkate alınacaktır!'),
(271, 'contact_us', 'Contact Us', 'اتصل بنا', 'Neem contact met ons op', 'Contactez nous', 'Kontaktiere uns', 'Связаться с нами', 'Contáctenos', 'Bizimle iletişime geçin'),
(272, 'email_sent', 'Your email has been sent', 'تم إرسال البريد الإلكتروني الخاص بك', 'Je e-mail is verzonden', 'Votre e mail a été envoyé', 'Ihre E-Mail wurde gesendet', 'Ваше сообщение было отправлено', 'Tu correo ha sido enviado', 'Emailiniz gönderildi'),
(273, 'embed', 'Embed', 'تضمين', 'insluiten', 'Intégrer', 'Einbetten', 'встраивать', 'Empotrar', 'Göm'),
(274, 'post_m_report', 'Warning: This post might contain harmful or offensive images or adult (18+) content.', 'تحذير: قد تحتوي هذه المشاركة على صور ضارة أو مسيئة أو محتوى للبالغين (18 عامًا).', 'Waarschuwing: dit bericht kan schadelijke of aanstootgevende afbeeldingen of inhoud voor volwassenen (18+) bevatten.', 'Avertissement: Ce message peut contenir des images nuisibles ou offensantes ou du contenu réservé aux adultes (18 ans et plus).', 'Warnung: Dieser Beitrag enthält möglicherweise schädliche oder beleidigende Bilder oder Inhalte für Erwachsene (18+).', 'Предупреждение. Это сообщение может содержать вредные или оскорбительные изображения или контент для взрослых (18+).', 'Advertencia: esta publicación puede contener imágenes dañinas u ofensivas o contenido para adultos (mayores de 18 años).', 'Uyarı: Bu yayın zararlı veya rahatsız edici resimler veya yetişkinlere yönelik (18+) içerik barındırıyor olabilir.'),
(275, 'skip_step', 'Or Skip this step for now', 'أو تخطي هذه الخطوة في الوقت الحالي', 'Of sla deze stap nu over', 'Ou sauter cette étape pour l&#039;instant', 'Oder Überspringe diesen Schritt für jetzt', 'Или пропустите этот шаг', 'O Salta este paso por ahora', 'Veya Şimdilik bu adımı atla'),
(276, 'save_c', 'Save &amp; Continue', 'حفظ ومتابعة', 'Opslaan doorgaan', 'Enregistrer continuer', 'Speichern fortsetzen', 'Сохранить и продолжить', 'Guardar Continuar', 'Kaydet ilerle'),
(277, 'add_photo_s', 'Add a photo.', 'إضافة صورة.', 'Voeg een foto toe.', 'Ajouter une photo.', 'Füge ein Foto hinzu.', 'Добавить фото.', 'Agregar una foto.', 'Fotoğraf ekle.'),
(278, 'tell_us', 'Tell us about you.', 'أخبرنا عن نفسك.', 'Vertel ons over jezelf.', 'Parlez nous de vous.', 'Erzähl uns von dir.', 'Расскажи нам о себе.', 'Cuéntanos acerca de ti.', 'Bize hakkında bilgi verin.'),
(279, 'follow_famous', 'Follow our famous users.', 'اتبع المستخدمين المشهورين لدينا.', 'Volg onze beroemde gebruikers.', 'Suivez nos utilisateurs célèbres.', 'Folge unseren berühmten Nutzern.', 'Следуйте за нашими знаменитыми пользователями.', 'Sigue a nuestros famosos usuarios.', 'Ünlü kullanıcılarımızı takip edin.'),
(280, 'follow_c', 'Follow &amp; Continue', 'متابعة ومتابعة', 'Volgen en doorgaan', 'Suivre et continuer', 'Folgen Sie und fahren Sie fort', 'Продолжить и продолжить', 'Seguir, continuar', 'Takip et ve devam et'),
(281, 'manage_sessions', 'Manage Sessions', 'إدارة الجلسات', 'Sessies beheren', 'Gérer les sessions', 'Sitzungen verwalten', 'Управление сеансами', 'Gestionar sesiones', 'Oturumları Yönet'),
(282, 'profile_search', 'Show your profile in search engines', 'اعرض ملفك الشخصي في محركات البحث', 'Toon uw profiel in zoekmachines', 'Affichez votre profil dans les moteurs de recherche', 'Zeigen Sie Ihr Profil in Suchmaschinen', 'Показывать свой профиль в поисковых системах', 'Muestra tu perfil en los buscadores.', 'Profilinizi arama motorlarında göster'),
(283, 'reCaptcha_error', 'Please check the re-captcha', 'يرجى التحقق من إعادة captcha', 'Controleer de re-captcha', 'S&#039;il vous plaît vérifier le re-captcha', 'Bitte überprüfe das Re-Captcha', 'Пожалуйста, проверьте переквалификацию', 'Por favor, compruebe el re-captcha', 'Lütfen yeniden captcha’yı kontrol edin'),
(284, 'username_in_blacklist', 'The username is blacklisted and not allowed, please choose another username', 'اسم المستخدم مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار اسم مستخدم آخر', 'De gebruikersnaam staat op de zwarte lijst en is niet toegestaan, kies een andere gebruikersnaam', 'Le nom d&#039;utilisateur est sur la liste noire et n&#039;est pas autorisé, veuillez choisir un autre nom d&#039;utilisateur.', 'Der Benutzername ist auf der Blacklist und nicht erlaubt, bitte wähle einen anderen Benutzernamen', 'Имя пользователя занесено в черный список и не разрешено, выберите другое имя пользователя', 'El nombre de usuario está en la lista negra y no está permitido, elija otro nombre de usuario', 'Kullanıcı adı kara listede ve izin verilmiyor, lütfen başka bir kullanıcı adı seçin'),
(285, 'email_in_blacklist', 'The email is blacklisted and not allowed, please choose another email', 'البريد الإلكتروني مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار بريد إلكتروني آخر', 'De e-mail staat op de zwarte lijst en is niet toegestaan, kies een andere e-mail', 'L&#039;email est sur la liste noire et n&#039;est pas autorisé, veuillez choisir un autre email.', 'Die E-Mail ist auf der schwarzen Liste und nicht erlaubt. Bitte wählen Sie eine andere E-Mail', 'Электронная почта в черный список и не разрешена, выберите другое электронное письмо', 'El correo electrónico está en la lista negra y no está permitido, elija otro correo electrónico', 'E-posta kara listeye alındı ​​ve izin verilmedi, lütfen başka bir e-posta adresi seçin'),
(286, 'email_username_in_blacklist', 'The email or username is blacklisted and not allowed, please choose another email or username', 'البريد الإلكتروني أو اسم المستخدم مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار بريد إلكتروني آخر أو اسم مستخدم آخر', 'De e-mail of gebruikersnaam staat op de zwarte lijst en is niet toegestaan, kies een andere e-mail of gebruikersnaam', 'L&#039;email ou le nom d&#039;utilisateur est sur la liste noire et n&#039;est pas autorisé. Veuillez choisir un autre email ou nom d&#039;utilisateur.', 'Die E-Mail oder der Benutzername ist auf der schwarzen Liste und nicht erlaubt. Bitte wählen Sie eine andere E-Mail oder einen anderen Nutzernamen', 'Электронная почта или имя пользователя занесены в черный список и не разрешены, выберите другое электронное письмо или имя пользователя', 'El correo electrónico o nombre de usuario está en la lista negra y no está permitido, elija otro correo electrónico o nombre de usuario', 'E-posta veya kullanıcı adı kara listede ve izin verilmiyor, lütfen başka bir e-posta adresi veya kullanıcı adı seçin'),
(287, 'ip_in_blacklist', 'The IP is blacklisted and not allowed', 'عنوان IP مدرج في القائمة السوداء وغير مسموح به', 'De IP staat op de zwarte lijst en is niet toegestaan', 'L&#039;IP est sur la liste noire et non autorisé', 'Die IP ist auf der schwarzen Liste und nicht erlaubt', 'IP заблокирован и не разрешен', 'La IP está en la lista negra y no está permitida', 'IP kara listede ve izin verilmiyor'),
(288, 'click_to_visit', 'Click to visit', 'انقر لزيارة', 'Klik om te bezoeken', 'Cliquez pour visiter', 'Klicken Sie, um zu besuchen', 'Нажмите, чтобы посетить', 'Haga clic para visitar', 'Ziyaret etmek için tıklayın'),
(289, 'browser', 'Browser', 'المتصفح', 'browser', 'Navigateur', 'Browser', 'браузер', 'Navegador', 'Tarayıcı'),
(290, 'ip_address', 'IP Address', 'عنوان IP', 'IP adres', 'Adresse IP', 'IP Adresse', 'Айпи адрес', 'Dirección IP', 'IP adresi'),
(291, 'verify_user', 'Verify User', 'تحقق من المستخدم', 'Verifieer gebruiker', 'Vérifier l&#039;utilisateur', 'Benutzer bestätigen', 'Проверить пользователя', 'Verificar usuario', 'Kullanıcıyı Doğrula'),
(292, 'no_more_activities', 'No more activities', 'لا مزيد من الأنشطة', 'Geen activiteiten meer', 'Pas plus d&#039;activités', 'Keine Aktivitäten mehr', 'Больше никаких действий', 'No mas actividades', 'Daha fazla aktivite yok'),
(293, 'activities', 'Activities', 'أنشطة', 'Activiteiten', 'Activités', 'Aktivitäten', 'мероприятия', 'Ocupaciones', 'faaliyetler'),
(294, 'commented_on_post', 'commented on {user} {post}', 'علّق على {user} {post}', 'hebben gereageerd op {user} {post}', 'a commenté sur {user} {post}', 'kommentiert auf {user} {post}', 'прокомментировал {user} {post}', 'comentó en {user} {post}', '{user} {post} sitesinde yorum yaptı'),
(295, 'post', 'post', 'بريد', 'post', 'poster', 'Post', 'сообщение', 'enviar', 'posta'),
(296, 'followed_user', 'started following {user}', 'بدأت باتباع {user}', 'start met {user}', 'commencé à suivre {user}', 'gestartet nach {user}', 'начал {user}', 'comenzó a seguir a {user}', '{user} takip etmeye başladı'),
(297, 'liked__post', 'liked {user} {post}', 'أعجبه {user} {post}', 'vond {user} {post} leuk', 'aimé {user} {post}', 'gemocht {user} {post}', 'понравилось {user} {post}', 'me gustó {user} {post}', 'beğendi {user} {post}'),
(298, 'from_camera', 'Take a picture using webcam', 'التقط صورة باستخدام كاميرا الويب', 'Maak een foto met de webcam', 'Prendre une photo en utilisant webcam', 'Mach ein Foto mit der Webcam', 'Сделайте снимок с помощью веб-камеры', 'Toma una foto con la webcam', 'Web kamerasını kullanarak fotoğraf çek'),
(299, 'active', 'Active', 'نشيط', 'Actief', 'actif', 'Aktiv', 'активный', 'Activo', 'Aktif'),
(300, 'no_camera', 'No camera device found, please make sure the camera is plugged in and the browser has the persmission to use it.', 'لم يتم العثور على أي كاميرا ، يرجى التأكد من توصيل الكاميرا والمتصفح يحتفظ باستخدامه.', 'Geen camera-apparaat gevonden, zorg ervoor dat de camera is aangesloten en dat de browser de toestemming heeft om het te gebruiken.', 'Aucun appareil photo n&#039;a été trouvé, assurez-vous que l&#039;appareil photo est branché et que le navigateur a la permission de l&#039;utiliser.', 'Kein Kamera-Gerät gefunden, bitte stellen Sie sicher, dass die Kamera angeschlossen ist und der Browser die Erlaubnis hat, sie zu benutzen.', 'Не найдено ни одного устройства камеры, убедитесь, что камера подключена, и браузер имеет возможность использовать его.', 'No se ha encontrado ningún dispositivo de cámara, asegúrese de que la cámara esté enchufada y que el navegador tenga la capacidad de usarla.', 'Hiçbir kamera cihazı bulunamadı, lütfen kameranın takılı olduğundan ve tarayıcının onu kullanmak için gerekli olduğuna emin olun.'),
(301, 'you', 'You', 'أنت', 'U', 'Vous', 'Sie', 'Вы', 'Tú', 'Sen'),
(302, 'your', 'your', 'ك', 'jouw', 'votre', 'Ihre', 'ваш', 'tu', 'sizin'),
(303, 'his', 'his', 'له', 'zijn', 'le sien', 'seine', 'его', 'su', 'onun');

-- --------------------------------------------------------

--
-- Table structure for table `pxp_media_files`
--

CREATE TABLE `pxp_media_files` (
  `id` int(30) NOT NULL,
  `post_id` int(30) DEFAULT '0',
  `user_id` int(15) NOT NULL DEFAULT '0',
  `file` varchar(3000) NOT NULL DEFAULT '',
  `extra` varchar(3000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_messages`
--

CREATE TABLE `pxp_messages` (
  `id` int(11) NOT NULL,
  `from_id` int(15) NOT NULL DEFAULT '0',
  `to_id` int(15) NOT NULL DEFAULT '0',
  `text` text,
  `media_file` varchar(3000) NOT NULL DEFAULT '',
  `media_type` varchar(20) NOT NULL DEFAULT '',
  `deleted_fs1` enum('0','1') NOT NULL DEFAULT '0',
  `deleted_fs2` enum('0','1') NOT NULL DEFAULT '0',
  `seen` varchar(50) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0',
  `extra` varchar(500) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_notifications`
--

CREATE TABLE `pxp_notifications` (
  `id` int(11) NOT NULL,
  `notifier_id` int(11) NOT NULL DEFAULT '0',
  `recipient_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(100) NOT NULL DEFAULT '',
  `text` text,
  `url` varchar(3000) NOT NULL DEFAULT '',
  `seen` varchar(50) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0',
  `sent_push` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_posts`
--

CREATE TABLE `pxp_posts` (
  `post_id` int(30) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `link` varchar(3000) NOT NULL DEFAULT '',
  `youtube` varchar(150) NOT NULL DEFAULT '',
  `vimeo` varchar(20) NOT NULL DEFAULT '',
  `dailymotion` varchar(50) NOT NULL DEFAULT '',
  `playtube` varchar(250) NOT NULL DEFAULT '',
  `mp4` text NOT NULL,
  `time` varchar(100) NOT NULL DEFAULT '0',
  `type` varchar(100) NOT NULL DEFAULT '',
  `registered` varchar(32) NOT NULL DEFAULT '0000/0',
  `views` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_post_comments`
--

CREATE TABLE `pxp_post_comments` (
  `id` int(30) NOT NULL,
  `post_id` int(20) NOT NULL DEFAULT '0',
  `user_id` int(20) NOT NULL DEFAULT '0',
  `text` text,
  `time` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_post_likes`
--

CREATE TABLE `pxp_post_likes` (
  `id` int(11) NOT NULL,
  `post_id` int(30) NOT NULL DEFAULT '0',
  `user_id` int(30) NOT NULL DEFAULT '0',
  `type` varchar(20) NOT NULL DEFAULT 'up',
  `time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_post_reports`
--

CREATE TABLE `pxp_post_reports` (
  `id` int(11) NOT NULL,
  `post_id` int(30) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `text` varchar(1000) NOT NULL DEFAULT '',
  `type` varchar(150) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_saved_posts`
--

CREATE TABLE `pxp_saved_posts` (
  `id` int(11) NOT NULL,
  `user_id` int(15) NOT NULL DEFAULT '0',
  `post_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_sessions`
--

CREATE TABLE `pxp_sessions` (
  `id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `platform` varchar(30) NOT NULL DEFAULT 'web',
  `platform_details` text CHARACTER SET utf8 NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_static_pages`
--

CREATE TABLE `pxp_static_pages` (
  `id` int(11) NOT NULL,
  `page_name` varchar(255) NOT NULL DEFAULT '',
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pxp_static_pages`
--

INSERT INTO `pxp_static_pages` (`id`, `page_name`, `content`) VALUES
(1, 'terms_of_use', '&lt;h4&gt;1- Write your Terms Of Use here.&lt;/h4&gt;&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h4&gt;2- Random title&lt;/h4&gt;&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&lt;/p&gt;'),
(2, 'privacy_and_policy', '&lt;h2&gt;Who we are?&lt;/h2&gt;&lt;p&gt;Provide name and contact details of the data controller. This will typically be your business or you, if you are a sole trader. Where applicable, you should include the identity and contact details of the controller’s representative and/or the data protection officer.&lt;/p&gt;&lt;h2&gt;What information do we collect?&lt;/h2&gt;&lt;p&gt;Specify the types of personal information you collect, eg names, addresses, user names, etc. You should include specific details on: how you collect data (eg when a user registers, purchases or uses your services, completes a contact form, signs up to a newsletter, etc) what specific data you collect through each of the data collection method if you collect data from third parties, you must specify categories of data and source if you process sensitive personal data or financial information, and how you handle this&amp;nbsp;&lt;br&gt;&lt;br&gt;You may want to provide the user with relevant definitions in relation to personal data and sensitive personal data.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;How do we use personal information?&lt;/h2&gt;&lt;p&gt;Describe in detail all the service- and business-related purposes for which you will process data. For example, this may include things like: personalisation of content, business information or user experience account set up and administration delivering marketing and events communication carrying out polls and surveys internal research and development purposes providing goods and services legal obligations (eg prevention of fraud) meeting internal audit requirements&amp;nbsp;&lt;br&gt;&lt;br&gt;Please note this list is not exhaustive. You will need to record all purposes for which you process personal data.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;What legal basis do we have for processing your personal data?&lt;/h2&gt;&lt;p&gt;Describe the relevant processing conditions contained within the GDPR. There are six possible legal grounds: consent contract legitimate interests vital interests public task legal obligation&amp;nbsp;&lt;br&gt;&lt;br&gt;Provide detailed information on all grounds that apply to your processing, and why. If you rely on consent, explain how individuals can withdraw and manage their consent. If you rely on legitimate interests, explain clearly what these are.&amp;nbsp;&lt;br&gt;&lt;br&gt;If you’re processing special category personal data, you will have to satisfy at least one of the six processing conditions, as well as additional requirements for processing under the GDPR. Provide information on all additional grounds that apply.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;When do we share personal data?&lt;/h2&gt;&lt;p&gt;Explain that you will treat personal data confidentially and describe the circumstances when you might disclose or share it. Eg, when necessary to provide your services or conduct your business operations, as outlined in your purposes for processing. You should provide information on: how you will share the data what safeguards you will have in place what parties you may share the data with and why&lt;/p&gt;&lt;h2&gt;Where do we store and process personal data?&lt;/h2&gt;&lt;p&gt;If applicable, explain if you intend to store and process data outside of the data subject’s home country. Outline the steps you will take to ensure the data is processed according to your privacy policy and the applicable law of the country where data is located. If you transfer data outside the European Economic Area, outline the measures you will put in place to provide an appropriate level of data privacy protection. Eg contractual clauses, data transfer agreements, etc.&lt;/p&gt;&lt;h2&gt;How do we secure personal data?&lt;/h2&gt;&lt;p&gt;Describe your approach to data security and the technologies and procedures you use to protect personal information. For example, these may be measures: to protect data against accidental loss to prevent unauthorised access, use, destruction or disclosure to ensure business continuity and disaster recovery to restrict access to personal information to conduct privacy impact assessments in accordance with the law and your business policies to train staff and contractors on data security to manage third party risks, through use of contracts and security reviews&amp;nbsp;&lt;br&gt;&lt;br&gt;Please note this list is not exhaustive. You should record all mechanisms you rely on to protect personal data. You should also state if your organisation adheres to certain accepted standards or regulatory requirements.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;How long do we keep your personal data for?&lt;/h2&gt;&lt;p&gt;Provide specific information on the length of time you will keep the information for in relation to each processing purpose. The GDPR requires you to retain data for no longer than reasonably necessary. Include details of your data or records retention schedules, or link to additional resources where these are published.&amp;nbsp;&lt;br&gt;&lt;br&gt;If you cannot state a specific period, you need to set out the criteria you will apply to determine how long to keep the data for (eg local laws, contractual obligations, etc)&amp;nbsp;&lt;br&gt;&lt;br&gt;You should also outline how you securely dispose of data after you no longer need it.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Your rights in relation to personal data&lt;/h2&gt;&lt;p&gt;Under the GDPR, you must respect the right of data subjects to access and control their personal data. In your privacy notice, you must outline their rights in respect of: access to personal information correction and deletion withdrawal of consent (if processing data on condition of consent) data portability restriction of processing and objection lodging a complaint with the Information Commissioner’s Office You should explain how individuals can exercise their rights, and how you plan to respond to subject data requests. State if any relevant exemptions may apply and set out any identity verifications procedures you may rely on. Include details of the circumstances where data subject rights may be limited, eg if fulfilling the data subject request may expose personal data about another person, or if you’re asked to delete data which you are required to keep by law.&lt;/p&gt;&lt;h2&gt;Use of automated decision-making and profiling&lt;/h2&gt;&lt;p&gt;Where you use profiling or other automated decision-making, you must disclose this in your privacy policy. In such cases, you must provide details on existence of any automated decision-making, together with information about the logic involved, and the likely significance and consequences of the processing of the individual.&lt;/p&gt;&lt;h2&gt;How to contact us?&lt;/h2&gt;&lt;p&gt;Explain how data subject can get in touch if they have questions or concerns about your privacy practices, their personal information, or if they wish to file a complaint. Describe all ways in which they can contact you – eg online, by email or postal mail.&amp;nbsp;&lt;br&gt;&lt;br&gt;If applicable, you may also include information on:&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;Use of cookies and other technologies&lt;/h2&gt;&lt;p&gt;You may include a link to further information, or describe within the policy if you intend to set and use cookies, tracking and similar technologies to store and manage user preferences on your website, advertise, enable content or otherwise analyse user and usage data. Provide information on what types of cookies and technologies you use, why you use them and how an individual can control and manage them.&amp;nbsp;&lt;br&gt;&lt;br&gt;Linking to other websites / third party content If you link to external sites and resources from your website, be specific on whether this constitutes endorsement, and if you take any responsibility for the content (or information contained within) any linked website.&amp;nbsp;&lt;br&gt;&lt;br&gt;You may wish to consider adding other optional clauses to your privacy policy, depending on your business’ circumstances.&lt;/p&gt;'),
(3, 'about_us', '&lt;h4&gt;1- Write about your website here.&lt;/h4&gt;&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&amp;nbsp;&lt;br&gt;&lt;br&gt;&lt;/p&gt;&lt;h4&gt;2- Random title&lt;/h4&gt;&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dxzcolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&lt;/p&gt;'),
(4, 'contact_us', '&lt;form class=&quot;form row pp_sett_form&quot; id=&quot;contact_us_form&quot;&gt;&lt;div class=&quot;col-md-3&quot;&gt;&amp;nbsp;&lt;br&gt;&lt;/div&gt;&lt;div class=&quot;col-md-6&quot;&gt;&lt;div class=&quot;pp_mat_input&quot;&gt;&lt;input required=&quot;true&quot; type=&quot;text&quot; name=&quot;first_name&quot; class=&quot;form-control&quot;&gt;  &lt;label&gt;First Name*&lt;/label&gt;&lt;/div&gt;&lt;div class=&quot;pp_mat_input&quot;&gt;&lt;input required=&quot;true&quot; type=&quot;text&quot; name=&quot;last_name&quot; class=&quot;form-control&quot;&gt;  &lt;label&gt;Last Name*&lt;/label&gt;&lt;/div&gt;&lt;div class=&quot;pp_mat_input&quot; style=&quot;margin-bottom: 1.7em;&quot; data-mce-style=&quot;margin-bottom: 1.7em;&quot;&gt;&lt;input required=&quot;true&quot; type=&quot;email&quot; name=&quot;email&quot; class=&quot;form-control&quot;&gt;  &lt;label&gt;Email*&lt;/label&gt;&lt;/div&gt;&lt;div class=&quot;pp_mat_input&quot;&gt;&lt;textarea class=&quot;form-control&quot; name=&quot;message&quot; rows=&quot;3&quot;&gt;&lt;/textarea&gt;  &lt;label&gt;Messages&lt;/label&gt;&lt;/div&gt;&lt;div class=&quot;pp_load_loader&quot;&gt;&lt;button class=&quot;btn btn-info pp_flat_btn&quot; type=&quot;submit&quot;&gt;Send&lt;/button&gt;&lt;/div&gt;&lt;div class=&quot;clear&quot;&gt;&amp;nbsp;&lt;br&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class=&quot;col-md-3&quot;&gt;&amp;nbsp;&lt;br&gt;&lt;/div&gt;&lt;/form&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `pxp_story`
--

CREATE TABLE `pxp_story` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `caption` varchar(500) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT '0',
  `media_file` varchar(3000) NOT NULL DEFAULT '',
  `type` enum('1','2') NOT NULL,
  `duration` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_story_views`
--

CREATE TABLE `pxp_story_views` (
  `id` int(11) NOT NULL,
  `story_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_users`
--

CREATE TABLE `pxp_users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `ip_address` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `password` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `fname` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `lname` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gender` varchar(10) CHARACTER SET latin1 NOT NULL DEFAULT 'male',
  `email_code` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `language` varchar(22) CHARACTER SET latin1 NOT NULL DEFAULT 'english',
  `avatar` varchar(1000) CHARACTER SET latin1 NOT NULL DEFAULT 'media/img/d-avatar.jpg',
  `cover` varchar(3000) CHARACTER SET utf8 NOT NULL DEFAULT 'media/img/d-cover.jpg',
  `country_id` int(11) NOT NULL DEFAULT '0',
  `about` text COLLATE utf8_unicode_ci NOT NULL,
  `google` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `facebook` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `twitter` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `website` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `admin` int(11) NOT NULL DEFAULT '0',
  `verified` int(11) NOT NULL DEFAULT '0',
  `last_seen` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `registered` varchar(40) CHARACTER SET latin1 NOT NULL DEFAULT '0000/0',
  `is_pro` int(11) NOT NULL DEFAULT '0',
  `posts` int(11) NOT NULL DEFAULT '0',
  `p_privacy` enum('2','1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '2',
  `c_privacy` enum('1','2') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `n_on_like` enum('1','0') CHARACTER SET utf8 NOT NULL DEFAULT '1',
  `n_on_mention` enum('1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `n_on_comment` enum('1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `n_on_follow` enum('1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `startup_avatar` int(11) NOT NULL DEFAULT '0',
  `startup_info` int(11) NOT NULL DEFAULT '0',
  `startup_follow` int(11) NOT NULL DEFAULT '0',
  `src` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `login_token` char(32) COLLATE utf8_unicode_ci DEFAULT '',
  `search_engines` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '1',
  `mode` varchar(11) CHARACTER SET utf8 NOT NULL DEFAULT 'day',
  `device_id` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

INSERT INTO `pxp_users` (`user_id`, `username`, `email`, `ip_address`, `password`, `fname`, `lname`, `gender`, `email_code`, `language`, `avatar`, `cover`, `country_id`, `about`, `google`, `facebook`, `twitter`, `website`, `active`, `admin`, `verified`, `last_seen`, `registered`, `is_pro`, `posts`, `p_privacy`, `c_privacy`, `n_on_like`, `n_on_mention`, `n_on_comment`, `n_on_follow`, `src`) VALUES
(1, 'admin', 'admin@admin.com', '::1', 'd033e22ae348aeb5660fc2140aec35850c4da997', '', '', 'male', '', 'english', 'media/img/d-avatar.jpg', 'media/img/d-cover.jpg', 0, '', '', '', '', '', 1, 1, 0, '1533791744', '2018/8', 0, 0, '2', '1', '1', '1', '1', '1', '');
--
-- Table structure for table `pxp_user_reports`
--

CREATE TABLE `pxp_user_reports` (
  `id` int(11) NOT NULL,
  `user_id` int(15) NOT NULL DEFAULT '0',
  `profile_id` int(15) NOT NULL DEFAULT '0',
  `type` int(5) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pxp_verification_requests`
--

CREATE TABLE `pxp_verification_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `passport` text NOT NULL,
  `photo` text NOT NULL,
  `message` varchar(200) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `time` int(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pxp_activities`
--
ALTER TABLE `pxp_activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pxp_blacklist`
--
ALTER TABLE `pxp_blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pxp_blocks`
--
ALTER TABLE `pxp_blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `profile_id` (`profile_id`);

--
-- Indexes for table `pxp_chats`
--
ALTER TABLE `pxp_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `pxp_config`
--
ALTER TABLE `pxp_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `pxp_connectivities`
--
ALTER TABLE `pxp_connectivities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follower_id` (`follower_id`),
  ADD KEY `following_id` (`following_id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `pxp_hashtags`
--
ALTER TABLE `pxp_hashtags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hash` (`hash`),
  ADD KEY `tag` (`tag`),
  ADD KEY `last_trend_time` (`last_trend_time`);

--
-- Indexes for table `pxp_langs`
--
ALTER TABLE `pxp_langs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pxp_media_files`
--
ALTER TABLE `pxp_media_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pxp_messages`
--
ALTER TABLE `pxp_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seen` (`seen`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`);

--
-- Indexes for table `pxp_notifications`
--
ALTER TABLE `pxp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `type` (`type`),
  ADD KEY `notifier_id` (`notifier_id`);

--
-- Indexes for table `pxp_posts`
--
ALTER TABLE `pxp_posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `registered` (`registered`);

--
-- Indexes for table `pxp_post_comments`
--
ALTER TABLE `pxp_post_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `pxp_post_likes`
--
ALTER TABLE `pxp_post_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `pxp_post_reports`
--
ALTER TABLE `pxp_post_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pxp_saved_posts`
--
ALTER TABLE `pxp_saved_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `pxp_sessions`
--
ALTER TABLE `pxp_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `platform` (`platform`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `pxp_static_pages`
--
ALTER TABLE `pxp_static_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pxp_story`
--
ALTER TABLE `pxp_story`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `pxp_story_views`
--
ALTER TABLE `pxp_story_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `story_id` (`story_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pxp_users`
--
ALTER TABLE `pxp_users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `username` (`username`),
  ADD KEY `email` (`email`),
  ADD KEY `password` (`password`),
  ADD KEY `last_active` (`last_seen`),
  ADD KEY `admin` (`admin`),
  ADD KEY `active` (`active`),
  ADD KEY `registered` (`registered`),
  ADD KEY `p_privacy` (`p_privacy`),
  ADD KEY `c_privacy` (`c_privacy`),
  ADD KEY `n_on_like` (`n_on_like`),
  ADD KEY `n_on_mention` (`n_on_mention`),
  ADD KEY `n_on_comment` (`n_on_comment`),
  ADD KEY `n_on_follow` (`n_on_follow`),
  ADD KEY `src` (`src`);

--
-- Indexes for table `pxp_user_reports`
--
ALTER TABLE `pxp_user_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `pxp_verification_requests`
--
ALTER TABLE `pxp_verification_requests`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pxp_activities`
--
ALTER TABLE `pxp_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_blacklist`
--
ALTER TABLE `pxp_blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_blocks`
--
ALTER TABLE `pxp_blocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_chats`
--
ALTER TABLE `pxp_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_config`
--
ALTER TABLE `pxp_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- AUTO_INCREMENT for table `pxp_connectivities`
--
ALTER TABLE `pxp_connectivities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_hashtags`
--
ALTER TABLE `pxp_hashtags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_langs`
--
ALTER TABLE `pxp_langs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;
--
-- AUTO_INCREMENT for table `pxp_media_files`
--
ALTER TABLE `pxp_media_files`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_messages`
--
ALTER TABLE `pxp_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_notifications`
--
ALTER TABLE `pxp_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_posts`
--
ALTER TABLE `pxp_posts`
  MODIFY `post_id` int(30) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_post_comments`
--
ALTER TABLE `pxp_post_comments`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_post_likes`
--
ALTER TABLE `pxp_post_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_post_reports`
--
ALTER TABLE `pxp_post_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_saved_posts`
--
ALTER TABLE `pxp_saved_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_sessions`
--
ALTER TABLE `pxp_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_static_pages`
--
ALTER TABLE `pxp_static_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pxp_story`
--
ALTER TABLE `pxp_story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_story_views`
--
ALTER TABLE `pxp_story_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_users`
--
ALTER TABLE `pxp_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_user_reports`
--
ALTER TABLE `pxp_user_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pxp_verification_requests`
--
ALTER TABLE `pxp_verification_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `pxp_connectivities`
--
ALTER TABLE `pxp_connectivities`
  ADD CONSTRAINT `pxp_connectivities_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pxp_connectivities_ibfk_2` FOREIGN KEY (`following_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_media_files`
--
ALTER TABLE `pxp_media_files`
  ADD CONSTRAINT `pxp_media_files_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `pxp_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_notifications`
--
ALTER TABLE `pxp_notifications`
  ADD CONSTRAINT `pxp_notifications_ibfk_1` FOREIGN KEY (`notifier_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pxp_notifications_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_posts`
--
ALTER TABLE `pxp_posts`
  ADD CONSTRAINT `pxp_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_post_comments`
--
ALTER TABLE `pxp_post_comments`
  ADD CONSTRAINT `pxp_post_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `pxp_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_post_likes`
--
ALTER TABLE `pxp_post_likes`
  ADD CONSTRAINT `pxp_post_likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `pxp_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pxp_post_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_post_reports`
--
ALTER TABLE `pxp_post_reports`
  ADD CONSTRAINT `pxp_post_reports_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `pxp_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pxp_post_reports_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_saved_posts`
--
ALTER TABLE `pxp_saved_posts`
  ADD CONSTRAINT `pxp_saved_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pxp_saved_posts_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `pxp_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_sessions`
--
ALTER TABLE `pxp_sessions`
  ADD CONSTRAINT `pxp_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_story`
--
ALTER TABLE `pxp_story`
  ADD CONSTRAINT `pxp_story_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `pxp_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pxp_story_views`
--
ALTER TABLE `pxp_story_views`
  ADD CONSTRAINT `pxp_story_views_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `pxp_story` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
