class Util {
//   setGameHomeBackgroundImage() async {;
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['jpg', 'png'],
//   );

//   if (result != null) {
//     games!.gameHomeBackgroundImage = result.files.single.path!;
//     box.putAt(1, games);
//     print(games);
//     print('successfully added picked image file path');
//   } else {
//     print('null');
//     return 'null';
//   }

// }
// getImagePath() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['jpg', 'png'],
//   );
//   return result!.files.single.path!;
// //   if (result != null) {
// //     return result.files.single.path!;
// //   } else {
// //     return null;
// //   }
// // }
}

bool checkifGameNameExists(List gamelist, String gameName) {
  int gameIndex = gamelist.indexWhere((game) => game.gamename == gameName);
  if (gameIndex >= 0) {
    return true;
  } else {
    return false;
  }
}
