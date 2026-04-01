import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // Common & Login
      'appName': 'Driver Bus App',
      'welcome': 'Welcome',
      'loginToStart': 'Log in to start your shift',
      'usernameOrEmployeeId': 'Username/Employee ID',
      'password': 'Password',
      'forgotPassword': 'Forgot Password?',
      'login': 'Login',
      'accountManagedBy': 'Account managed by',
      'admin': 'Administrator',
      'pleaseEnterUsername': 'Please enter username',
      'pleaseEnterPassword': 'Please enter password',
      'loginSuccess': 'Login successful',
      'loginFailed': 'Login failed',
      "Welcome back,": "Welcome back,",
      "Captain ": 'Captain',

      //forget&&resetPage
      'forgotPasswordTitle': 'Forgot Password?',
      'forgotPasswordDesc': 'Enter your email to receive reset code.',
      'emailOrUser': 'Email',
      'pleaseEnterEmail': 'Please enter email first',
      'pleaseEnterValidEmail': 'Please enter a valid email',
      'sendCode': 'Send Code',
      'resetCodeSent': 'Reset code sent successfully to your email',
      'resetPassword': 'Reset Password',
      'enterCodeSent': 'Enter the 6-digit code sent to your email',
      'newPassword': 'New Password',
      'confirmPassword': 'Confirm Password',
      'passwordTooShort': 'Password too short',
      'passwordsNotMatch': 'Passwords don\'t match',
      'resendCode': 'Resend Code',
      'resetPasswordButton': 'Reset Password',

      // Schedule & Trips
      'schedule': 'Schedule',
      "Active Status": 'Active Status',
      'Online': 'Online',
      'Offline':'Offline',
      'beOffline': 'Be Offline',
      "Active Status: ":"Active Status: ",
      "ORIGIN":"ORIGIN",
      "Go Offline":"Go Offline",
      "Go Online":"Go Online",
      'Upcoming': 'Upcoming',
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'ongoing': 'ONGOING',
      'destination': 'DESTINATION',
      'viewMap': 'View Map',
      'bus': 'Bus',
      'noTrips': 'No trips available',
      "Trips": "Trips",
      "Messages": "Messages",
      "Notifications":"Notifications",
      "Profile": "Profile",


      // Profile Page Specific
      "Driver Profile": "Driver Profile",
      "Experience": "Experience",
      'years': 'Years',
      "Status": "Status",
      'Active': 'Active',
      "License Number": "License Number",
      "Assigned Vehicle": "Assigned Vehicle",
      "Email Address": "Email Address",
      'totalTrips': 'trips',


       //Passenger
      "Passenger List":"Passenger List",
      "Passengers":"Passengers",
      "ROUTE":"ROUTE",
      "DEPARTURE":"DEPARTURE",
      "Search by name or seat...":"Search by name or seat...",
      "PAID":"PAID",
      "UNPAID":"UNPAID",
      "TOTAL":"TOTAL",
      "Scan Ticket":"Scan Ticket",


      //ticket
      'ticketVerified': 'Ticket Verified',
      'passenger': 'Passenger',
      'route': 'Route',
      'seat': 'Seat',
      'class': 'Class',
      'nextScan': 'Next Scan',
      'details': 'Details',
      'scanPassengerTicket': 'Scan Passenger Ticket',


      // Notifications Screen
      'notifications': 'Notifications',
      'noNotifications': 'No notifications yet',
      'clearAll': 'Clear All',
      'newMessage': 'New Message',

      //TripDetails
      "tripDetails":"tripDetails",
      "scheduledDeparture":"scheduledDeparture",
      "passengers":"passengers",
      "distance":"distance",
      "busStatus":"Bus Status",
      "startTrip":"start Trip",
      "tripStatus":"Trip Status",

      //complaintPage
      'sendComplaint': 'Send Company Complaint',
      'howCanWeHelp': 'How can we help?',
      'complaintDesc': 'Please write your complaint details for review.',
      'writeYourComplaint': 'Write complaint details here...',
      'pleaseWriteSomething': 'Please write something first',
      'complaintSentSuccess': 'Complaint sent successfully',
      'send': 'Send Now',

      "attachments": "attachments",
      "Attachments (Images / Documents)": "Attachments (Images / Documents",
      "Attach File or Image": "Attach File or Image",
      "No attachments yet": "No attachments yet",
      "Choose from Gallery":"Choose from Gallery",
      "Take Photo":"Take Photo",
      "Files & Documents":"Files & Documents",

      //Settings
      "settings":"settings",
      "language":"language",
      "darkMode":"darkMode",
      "العربية":'Arabic',
      "English":"English",
    },
    'ar': {
      // Common & Login
      'appName': 'تطبيق سائق الحافلة',
      'welcome': 'مرحباً',
      'loginToStart': 'تسجيل الدخول لبدء الوردية',
      'usernameOrEmployeeId': 'اسم المستخدم/رقم الموظف',
      'password': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'login': 'تسجيل الدخول',
      'accountManagedBy': 'الحساب مدار بواسطة',
      'admin': 'المدير',
      'pleaseEnterUsername': 'الرجاء إدخال اسم المستخدم',
      'pleaseEnterPassword': 'الرجاء إدخال كلمة المرور',
      'loginSuccess': 'تم تسجيل الدخول بنجاح',
      'loginFailed': 'فشل تسجيل الدخول',
      "Welcome back,": "أهلاً بعودتك،",
      "Captain ": 'الكابتن ',
     //forget&&resetPage
      'forgotPasswordTitle': 'نسيت كلمة المرور؟',
      'forgotPasswordDesc': 'يرجى كتابة البريد الإلكتروني لتلقي رمز استعادة كلمة المرور الخاص بك.',
      'emailOrUser': 'البريد الإلكتروني ',
      'pleaseEnterEmail': 'الرجاء إدخال البريد الإلكتروني أولاً',
      'pleaseEnterValidEmail': 'الرجاء إدخال بريد إلكتروني صالح',
      'sendCode': 'إرسال الرمز',
      'resetCodeSent': 'تم إرسال رمز الاستعادة لبريدك بنجاح',
      'resetPassword': 'إعادة تعيين كلمة المرور',
      'enterCodeSent': 'أدخل الرمز المكون من 6 أرقام المرسل إلى بريدك الإلكتروني',
      'newPassword': 'كلمة المرور الجديدة',
      'confirmPassword': 'تأكيد كلمة المرور',
      'passwordTooShort': 'كلمة المرور قصيرة جداً',
      'passwordsNotMatch': 'كلمات المرور غير متطابقة',
      'resendCode': 'إعادة إرسال الرمز',
      'resetPasswordButton': 'إعادة تعيين',

      // Schedule & Trips
      'schedule': 'الجدول',
      "Active Status: ": 'الحالة ',
      'online': 'متصل',
      'Online':'متصل',
      'Offline':'غير متصل',
      'beOffline': 'غير متصل',
      "Go Offline":"غير متصل",
      "Go Online":"متصل",
      'upcoming': 'القادمة',
      'UPCOMING': 'القادمة',
      'completed': 'المكتملة',
      'COMPLETED': 'المكتملة',
      'cancelled': 'الملغاة',
      'CANCELLED': 'الملغاة',
      'ongoing': 'الحالية',
      'ONGOING': 'الحالية',
      'ORIGIN':'الانطلاق',
      'DESTINATION': 'الوجهة',
      "View Map": 'عرض الخريطة',
      'bus': 'حافلة',
      'noTrips': 'لا توجد رحلات',
      "Trips": 'الرحلات',
      "Messages": 'الرسائل',
      "Notifications":"الاشعارات",
      "Profile": 'الملف الشخصي',

      // Profile Page Specific
      "Driver Profile": 'ملف السائق',
      "Experience": 'الخبرة',
      'years': 'سنوات',
      "Status": 'الحالة',
      'Active': 'نشط',
      "License Number": 'رقم الرخصة',
      "Assigned Vehicle": 'المركبة المخصصة',
      "Email Address": 'البريد الإلكتروني',
      'totalTrips': 'رحلة',
      "trips":'رحلة',

      //Passenger
      "Passenger List":"قائمة الركاب",
      "Passengers":"الركاب",
      "ROUTE":"المسار",
      "DEPARTURE":"وقت الانطلاق",
      "Search by name or seat...":"ابحث بالاسم أو رقم المقعد...",
      "TOTAL":"الإجمالي",
      "PAID":"مدفوع",
      "UNPAID":"غير مدفوع",
      "Scan Ticket":"مسح التذكرة",

      //ticket
      'ticketVerified': 'تم التحقق من التذكرة',
      'passenger': 'المسافر',
      'route': 'المسار',
      'seat': 'المقعد',
      'class': 'الفئة',
      'nextScan': 'المسح التالي',
      'details': 'التفاصيل',
      'scanPassengerTicket': 'مسح تذكرة الراكب',
       'status':'الحالة',


      // Notifications Screen
      'notifications': 'الإشعارات',
      'noNotifications': 'لا توجد إشعارات حالياً',
      'clearAll': 'مسح الكل',
      'newMessage': 'رسالة جديدة',




      //TripDetails
      "tripDetails":"تفاصيل الرحلة",
      "scheduledDeparture":"المغادرة المقررة",
      "passengers":"الركاب",
      "distance":"المسافة",
      "busStatus":"حالة الحافلة",
      "startTrip":"بدء الرحلة",
      'tripStatus':'حالة الرحلة',
      'Start':'بدء الرحلة',
      'Arrived': 'وصلت الرحلة',
      'Ready': 'جاهز',
      'Needs Maintenance': 'يحتاج إلى صيانة',
      'Breakdown': 'عطل',
      'Emergency': 'طارئ',
      'Trip Progress': 'حالة الرحلة',
      'Bus Condition': 'حالة الباص',

      //complaintPage
      'sendComplaint': 'إرسال شكوى للشركة',
      'howCanWeHelp': 'كيف يمكننا مساعدتك؟',
      'complaintDesc': 'يرجى كتابة تفاصيل الشكوى وسنقوم بمراجعتها فوراً.',
      'writeYourComplaint': 'اكتب تفاصيل الشكوى هنا...',
      'pleaseWriteSomething': 'الرجاء كتابة الشكوى أولاً',
      'complaintSentSuccess': 'تم إرسال شكواك بنجاح للشركة',
      'send': 'إرسال الآن',

      "attachments": "المرفقات",
      "Attachments (Images / Documents)": "المرفقات (صور / وثائق)",
      "Attach File or Image": "إرفاق ملف أو صورة",
      "No attachments yet": "لا توجد مرفقات حالياً",
      "Choose from Gallery":"اختر من المعرض",
      "Take Photo":"التقط صورة",
      "Files & Documents":"ملفات & مستندات",
      //Settings
      "settings":"الاعدادات",
      "language":'اللغة',
      "darkMode":'الوضع الداكن',
      "العربية":"العربية",
      "English":'الانكليزية'


    },
  };
}