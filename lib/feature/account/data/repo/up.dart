// import 'dart:developer';
// import 'dart:io';
// // import 'package:fixit/C/prov.dart';
// // import 'package:fixit/C/requstprov.dart';
// // import 'package:fixit/C/token.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Postdata {
//   final Dio _dio = Dio();

//   Future<String> sendDataWithAudio(
//       String Itemid,
//       String serviceId,
//       String phone,
//       String description,
//       String audioFilePath,
//       String userName,
//       String address,
//       BuildContext context) async {
//     // print("454");
//     // print(audioFilePath);
//     try {
//       var provider1 = Provider.of<providervoice>(context, listen: false);
//       var provider2 = Provider.of<Prov>(context, listen: false);
//       log("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
//       // FormData formData = FormData.fromMap({
//       //   'service_id': service_id,
//       //   'item_id': Itemid,
//       //   'phone': phone,
//       //   'user_name': user_name,
//       //   'description': description,
//       //   'address': address,
//       //   'file': await MultipartFile.fromFile(
//       //     provider.image?.path ?? null.toString(),
//       //   ),
//       //   'file': await MultipartFile.fromFile(
//       //     audioFilePath,
//       //     filename: 'voice_file.mp3',
//       //   ),
//       // });
//       // FormData formData2 = FormData.fromMap({
//       //   'item_id': Itemid,
//       //   'phone': phone,
//       //   'user_name': user_name,
//       //   'description': description,
//       //   'address': address,
//       //   'file': await MultipartFile.fromFile(
//       //     provider.image?.path ?? null.toString(),
//       //   ),
//       //   'file': await MultipartFile.fromFile(
//       //     audioFilePath,
//       //     // filename: 'voice_file.mp3',
//       //   ),
//       // });

//       FormData formData = FormData();
//       formData.fields.add(MapEntry('phone', phone));
//       formData.fields.add(MapEntry('user_name', userName));
//       log('TEEEEEEEEST : des {$description}');
//       if (description.isNotEmpty) {
//         formData.fields.add(MapEntry('description', description));
//       }

//       formData.fields.add(MapEntry('address', address));
//       // log('TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEST ::  \n');
//       // log('audiopath is : {$audioFilePath} \n');
//       if (audioFilePath != 'a') {
//         log('DA');
//         formData.files.add(MapEntry(
//           'file',
//           await MultipartFile.fromFile(audioFilePath),
//         ));
//       }
//       // log('provider.image.path is : {${provider.image.path}} \n');
//       if (provider1.image?.path != null) {
//         formData.files.add(MapEntry(
//           'file',
//           await MultipartFile.fromFile(provider1.image!.path),
//         ));
//       }

//       // log('Itemid :: {${Itemid}} \n');
//       if (Itemid != 'NOT') {
//         formData.fields.add(MapEntry('item_id', Itemid));
//       }
//       // log('serv :: {${service_id}}');
//       if (serviceId != 'NOT') {
//         formData.fields.add(MapEntry('service_id', serviceId));
//       }
// //       log('''addl data what will be send :::: \n {{
// // ${formData.files}}''');

//       // print('''LAILA TESSSSTING RESSSSSSSSSSSELT ::: :: ::
//       //   phone test : ${phone} ; || ||
//       //   adress test : ${address} ;  || ||
//       //   user name test : ${user_name} ; || ||
//       //   item id test : ${Itemid} ; || ||
//       //   service id test : ${service_id} ; || ||
//       //     |||||||||||||NOW TEST ITEM ID |||||||
//       //   ''');
//       String? token = await Functions().getToken();
//       log("lljiohjijpjipjihpohoubhipguohjig");
//       Response response = await _dio.post(
//         'https://timeengcom.com/salhali/users/requests',
//         options: Options(
//           receiveTimeout: const Duration(seconds: 15),
//           headers: {
//             "Content-Type": "application/json",
//             'Authorization': 'Bearer $token',
//           },
//         ),
//         data: formData,
//       );
//       // print(
//       // 'the ///////////////////// { ${response.data} } //////////////////////');
//       if (response.statusCode == 200) {
//         provider1.audioPath = ' ';
//         provider1.decsripe.clear();
//         provider1.name.clear();
//         provider1.phone.clear();
//         provider1.site.clear();
//         provider1.showvoice(false);
//         provider1.audioPath = 'a';
//         provider1.removeimage();
//         provider2.changehh(true);
//         // print('''LAILA TESSSSTING RESSSSSSSSSSSELT ::: :: ::
//         // phone test : ${phone} ; || ||
//         // adress test : ${address} ;  || ||
//         // user name test : ${user_name} ; || ||
//         // item id test : ${Itemid} ; || ||
//         // service id test : ${service_id} ; || ||
//         //   |||||||||||||NOW TEST ITEM ID |||||||
//         // ''');
//         // print('asdadadad${service_id}');
//         // ignore: use_build_context_synchronously
//         //var provider = Provider.of<Prov>(context, listen: false);
//         //provider1.changeLoad();
//         //  provider.changetoast();
//         // print('Data sent successfully');
//         log('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN');
//         return "تم ارسال طلب بنجاح";
//       } else if (response.statusCode == 500) {
//         var provider1 = Provider.of<Prov>(context, listen: false);
//         provider1.changehh(true);
//         return "خطا في ارسال البيانات";
//       } else {
//         // print('Failed to send data');
//         // log(response.data.toString());
//         // print('the ///////////////////// { $response } //////////////////////');
//         log('wrong');
//         return "خطا في ارسال البيانات";
//       }
//     } catch (e) {
//       var provider1 = Provider.of<Prov>(context, listen: false);
//       provider1.changehh(true);
//       log("]]]]]]]]]]]]]]]]]]]]]]]]${e}");
//       if (e is DioException) {
//         if (e is SocketException) {
//           return "لايوجد انترنت";
//         } else {
//           return " يوجد خطأ في البيانات المدخلة";
//         }
//       }
//       // ignore: use_build_context_synchronously

//       //provider1.changeLoad();
//       log('Error sending data: $e');
//     }
//     return "لا يوجد انترنت";
//   }
// }
