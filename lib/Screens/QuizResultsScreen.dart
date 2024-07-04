import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class QuizResultsScreen extends StatefulWidget {
  @override
  _QuizResultsScreenState createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen> {
  List<Map<String, dynamic>> quizResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getQuizResults();
  }

  Future<void> getQuizResults() async {
    try {
      // Reference to the collection
      CollectionReference quizResultsRef =
          FirebaseFirestore.instance.collection('Quiz reslut');
      // await FirebaseFirestore.instance.collection('Quiz reslut').add({'name': "${CacheHelper.getData(key: 'name')}",'score':score,"cheating":cheating});

      // Get the documents in the collection
      QuerySnapshot querySnapshot = await quizResultsRef.get();

      // Iterate through the documents and add the data to the list
      List<Map<String, dynamic>> tempResults = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        tempResults.add(data);
        print(tempResults);
      }

      setState(() {
        quizResults = tempResults;
        isLoading = false;
      });
    } catch (e) {
      print('Error getting quiz results: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(AppLocalizations.of(context)!.quizResults),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppColor.primaryColor,
                  thickness: 2,
                  height: 10,
                  indent: 40,
                  endIndent: 40,
                );
              },
              itemCount: quizResults.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: Text(' ${quizResults[index]['name']}'),
                      ),
                      subtitle: Row(
                        children: [
                          Text('Score: ${quizResults[index]['score']} '),
                          Spacer(),
                          Text(' Cheating: ${quizResults[index]['cheating']}')
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
// ListView.separated(
//       separatorBuilder: (context, index) {
//         return  Divider(
//           color: AppColor.primaryColor,
//           thickness: 2,
//           height: 10,
//           indent: 40,
//           endIndent: 40,
//         );
//       },
//       itemCount: PdfCubit.get(context).pdfUrl.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => PdfViewer(),
//                   settings:RouteSettings(
//                     arguments: PdfCubit.get(context).pdfUrl[index]
//                   ) ));
//             },
//             child: Card(
//               child: ListTile(
//                 title: Text(" ${PdfCubit.get(context).pdfTitle[index]}",),
//               //  subtitle: Text("Lec['subtitle'"),
//               ),
//             ),
//           ),
//         );
//       },
//     );