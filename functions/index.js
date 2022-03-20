const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.callMetadata = functions.https.onCall((data, context) => {
  try {
    const json = JSON.parse(data);
    context = json.streams[0].songtitle;
    return context;
  } catch (e) {
    throw new functions.https.HttpsError("Error: ${e}");
  }
});

// exports.callMetadataHttp = functions.https.onRequest((req, res) => {
//   try {
//     const object = "http://usa10.fastcast4u.com:4800/statistics?json=1";
//     const json = JSON.parse(object);
//     res.send(json.streams[0].songtitle);
//   } catch (e) {
//     throw new functions.https.HttpsError("Error: ${e}");
//   }
// });
