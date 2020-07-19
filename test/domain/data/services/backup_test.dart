// import 'dart:async';
// import 'dart:io';

// import 'package:cold_app/data/services/floor/floor_database.dart';
// import 'package:floor/floor.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart' as sqflite;

// import 'package:matcher/matcher.dart';
// import 'package:cold_app/locator.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   setUp(() async {
//     print('setupLocator');
//     await setupLocatorTest();
//   });

//   tearDown(() {
//     print('tearDown;');
//     closeDb();
//     locator.reset();
//   });

//   TestWidgetsFlutterBinding.ensureInitialized();

//   void copyFile({String sourcePath, String destinationPath}) {
//     File(destinationPath).create(recursive: true);
//     File(sourcePath).copySync(destinationPath);
//   }

//   group('Export', () {
//     test('export', () async {
//       //
//       String database = 'app_database.db';
//       bool export = true;

//       // final String database, bool export) async {

//       // Shutdown database
//       await closeDb();

//       var internalPath = 'join(await sqfliteDatabaseFactory.getDatabasePath(database), database)';
//       // var internalPath = join(await sqfliteDatabaseFactory.getDatabasePath(database), database);
//       // var internalPath = join(await sqflite.getDatabasesPath(), database);
//       var externalPath = join(await getExternalStorageDirectory().toString(), database);
//       // var externalPath = join(await '\\', database);

//       print('Exporting from ');
//       print(internalPath);
//       print('Exporting to ');
//       print(externalPath);

//       if (export) {
//         copyFile(sourcePath: internalPath, destinationPath: externalPath);
//       } else {
//         copyFile(sourcePath: externalPath, destinationPath: internalPath);
//       }

//       // Init database
//       // await init(state);
//     });
//   });
// }
