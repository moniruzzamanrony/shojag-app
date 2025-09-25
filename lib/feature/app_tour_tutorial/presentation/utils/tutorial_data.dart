import 'package:flutter/widgets.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialDataModel {
  final String titleEn;
  final String titleBn;
  final List<String> featuresEn;
  final List<String> featuresBn;
  final String? image;
  final ContentAlign contentAlign;

  const TutorialDataModel(
      {required this.titleEn,
      required this.titleBn,
      this.featuresEn = const [],
      this.featuresBn = const [],
      this.image,
      this.contentAlign = ContentAlign.bottom});
}

class TutorialKeys {
  static const String communityButton = 'communityButtonKey';
  static const String policeButton = 'policeButtonKey';
  static const String fireServiceButton = 'fireServiceButtonKey';
  static const String ambulanceButton = 'ambulanceButtonKey';
  static const String fnfButton = 'fnfButtonKey';

  static Map<String, GlobalKey> keys = <String, GlobalKey>{
    communityButton: GlobalKey(),
    policeButton: GlobalKey(),
    fireServiceButton: GlobalKey(),
    ambulanceButton: GlobalKey(),
    fnfButton: GlobalKey(),
  };

  static GlobalKey get communityButtonKey => keys[communityButton]!;

  static GlobalKey get policeButtonKey => keys[policeButton]!;

  static GlobalKey get fireServiceButtonKey => keys[fireServiceButton]!;

  static GlobalKey get ambulanceButtonKey => keys[ambulanceButton]!;

  static GlobalKey get fnfButtonKey => keys[fnfButton]!;
}

Map<String, TutorialDataModel> dashboardTutorialData = {
  TutorialKeys.communityButton: const TutorialDataModel(
      titleEn: 'Create alert to inform your community',
      featuresEn: [
        'You can create and post any incidents (Harassment, Violence, Robbery, Blood request, Found/Lost items) to inform your community members registered in Shojag.',
        'Community members will be able to post message on your alert, you can also see there response',
        'Incident Geo location will be shared with the community members',
      ],
      titleBn: 'আপনার কমিউনিটিকে জানাতে এ্যালার্ট তৈরি করুন',
      featuresBn: [
        'আপনি যে কোনো ঘটনার (হয়রানি, সহিংসতা, ডাকাতি, রক্তের অনুরোধ বা হারানো/পাওয়া জিনিস সম্পর্কিত) এ্যালার্ট তৈরি করে Shojag-এ নিবন্ধিত কমিউনিটি সদস্যদের জানাতে পারেন।',
        'কমিউনিটি সদস্যরা আপনার এ্যালার্টে বার্তা দিতে পারবে এবং আপনি তাদের প্রতিক্রিয়া দেখতে পারবেন।',
        'ঘটনার Geo লোকেশন কমিউনিটি সদস্যদের সাথে শেয়ার করা হবে।',
      ],
      image: ''),
  TutorialKeys.policeButton: const TutorialDataModel(
    titleEn:
        'Create alert to inform nearby law enforcement agency to get help faster (COMING SOON)',
    featuresEn: [
      'You can create and post any incidents to inform your nearby patrolling police force',
      'This alert will be only visible to authorized patrolling officers in your assigned radius of your location. You can change the geo radius from the settings options e.g. 1km to 5km',
      'Police will be able to see your location and respond in your post, they can also make for further details call before mobilizing to the location.',
    ],
    titleBn:
        'নিকটস্থ আইনশৃঙ্খলা রক্ষাকারী বাহিনীকে জানাতে এ্যালার্ট তৈরি করুন (শীঘ্রই আসছে)',
    featuresBn: [
      'আপনি নিকটবর্তী টহল পুলিশকে জানাতে যেকোনো ধরনের ঘটনা পোস্ট করতে পারবেন।',
      'এই এ্যালার্ট শুধুমাত্র অনুমোদিত টহল অফিসারদের কাছেই দৃশ্যমান থাকবে, আপনি আপনার অবস্থানের নির্ধারিত রেডিয়াস (১কিমি থেকে ৫কিমি) পরিবর্তন করতে পারবেন।',
      'পুলিশ সদস্যরা আপনার অবস্থান দেখতে পারবেন এবং স্থানান্তরের আগে বিস্তারিত জানার জন্য কল করতে পারেন।',
    ],
    image: '',
  ),
  TutorialKeys.fireServiceButton: const TutorialDataModel(
    titleEn:
        'Create Fire/Accident alert to inform nearby Fire station to respond faster (COMING SOON)',
    featuresEn: [
      'You can create and post any Fire/Accident incidents to inform your nearby fire station',
      'This alert will be only visible to authorized Fire station officers in your assigned radius of your location. You can change the geo radius from the settings options e.g. 1km to 5km',
      'Fire station and police officer will be able to see your location and respond in your post, they can also make for further details call before mobilizing to the location.',
      'You can also inform community members to get help',
    ],
    titleBn:
        'নিকটস্থ ফায়ার স্টেশনকে জানাতে অগ্নিকাণ্ড/দুর্ঘটনার এ্যালার্ট তৈরি করুন (শীঘ্রই আসছে)',
    featuresBn: [
      'আপনি অগ্নিকাণ্ড বা দুর্ঘটনার ঘটনা তৈরি করে নিকটস্থ ফায়ার স্টেশনকে জানাতে পারবেন।',
      'এই অ্যালার্ট শুধুমাত্র অনুমোদিত ফায়ার স্টেশন অফিসারদের নির্ধারিত রেডিয়াসের মধ্যে দৃশ্যমান থাকবে।',
      'ফায়ার স্টেশন ও পুলিশ উভয়ই আপনার অবস্থান দেখতে পারবে এবং প্রয়োজনে প্রয়োজনীয় ব্যবস্থা গ্রহণের আগে কল করতে পারবে।',
      'আপনি চাইলে কমিউনিটি সদস্যদেরও জানাতে পারবেন সহায়তার জন্য।',
    ],
    image: '',
  ),
  TutorialKeys.ambulanceButton: const TutorialDataModel(
    titleEn: 'Find ambulance during emergency in your locality (COMING SOON)',
    featuresEn: [
      'You can create post to find nearby ambulance during emergency',
      'This alert will be only visible to registered ambulance service near with in the given radius of your location. You can change the geo radius from the settings options e.g. e.g. 1km to 5km',
      'Ambulance service provider will be able to see your post and respond to you over call.',
    ],
    titleBn: 'আপনার এলাকায় জরুরি প্রয়োজনে অ্যাম্বুলেন্স খুঁজুন (শীঘ্রই আসছে)',
    featuresBn: [
      'জরুরি প্রয়োজনে নিকটস্থ অ্যাম্বুলেন্স খুঁজতে আপনি একটি পোস্ট তৈরি করতে পারেন।',
      'এই অ্যালার্ট শুধুমাত্র আপনার নির্ধারিত রেডিয়াসে থাকা নিবন্ধিত অ্যাম্বুলেন্স সার্ভিসের জন্য দৃশ্যমান থাকবে।',
      'অ্যাম্বুলেন্স সার্ভিস প্রদানকারী আপনার পোস্ট দেখতে পারবে এবং ফোনে যোগাযোগ করতে পারবে।',
    ],
    image: '',
  ),
  TutorialKeys.fnfButton: const TutorialDataModel(
      titleEn: 'Locate your family without annoying them over call or MESSAGE',
      featuresEn: [
        'This feature will allow you to locate & track live location of your family & friends registered in Shojag application.',
        'Tracking will require their permission. They can also set permission on tracking duration as per their consent.',
        'You can also add landmarks like home, University, Office etc. to get notification of their arrival and exit from the location.',
        'This is a paid feature, @35tk per month anyone can avail this tracking service for 30 days which can be renewed further.',
      ],
      titleBn: 'ফোন বা মেসেজ না করেই আপনার প্রিয়জনদের অবস্থান জানুন',
      featuresBn: [
        'এই ফিচারটি আপনাকে Shojag-এ নিবন্ধিত বন্ধু ও পরিবারের লাইভ লোকেশন দেখতে ও ট্র্যাক করতে সহায়তা করবে।',
        'ট্র্যাক করার জন্য তাদের অনুমতি প্রয়োজন হবে এবং তারা নির্দিষ্ট সময়সীমা অনুযায়ী অনুমতি সেট করতে পারবে।',
        'আপনি হোম, বিশ্ববিদ্যালয়, অফিস ইত্যাদির মত ল্যান্ডমার্ক অ্যাড করে তাদের আগমন ও প্রস্থানের নোটিফিকেশন পেতে পারেন।',
        'এই ফিচারটি একটি পেইড সার্ভিস — ৩৫ টাকা প্রতি মাসে, ৩০ দিনের জন্য অ্যাক্টিভেট করা যাবে এবং এটি নবায়নযোগ্য।',
      ],
      image: '',
      contentAlign: ContentAlign.top),
};
