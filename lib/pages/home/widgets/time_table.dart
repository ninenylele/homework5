import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homework5/models/Presidents.dart';

class PresidentDetailDialog extends StatelessWidget {
  final President president;

  const PresidentDetailDialog({Key? key, required this.president})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 231, 189, 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              president.name ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'ID : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${president.id ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Ordinal : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${president.ordinal ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'YearsInOffice : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${president.yearsInOffice ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'VicePresidents : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${president.vicePresidents ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // สีขอบ
                  width: 10, // ความหนาของขอบ
                ),
              ),
              child: Image.network(
                president.photo ?? '',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Icon(
                    Icons.error,
                    color: Color.fromARGB(255, 253, 62, 3),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 251, 250, 250)), // กำหนดสีตัวอักษรเป็นสีขาว
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 1, 1, 1), // กำหนดสีพื้นหลังเป็นสีเข้ม
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<President> _presidents = [];
  List<President> _filteredPresidents = [];

  @override
  void initState() {
    super.initState();
    _fetchPresidents();
  }

  Future<void> _fetchPresidents() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response =
          await dio.get('https://api.sampleapis.com/presidents/presidents');

      if (response.statusCode == 200) {
        var list = jsonDecode(response.data.toString()) as List<dynamic>;
        setState(() {
          _presidents = list.map((item) => President.fromJson(item)).toList();
          // Initialize _filteredPresidents with _presidents initially
          _filteredPresidents = _presidents;
        });
      } else {
        throw Exception('Failed to load presidents');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load presidents. Please try again later.'),
        ),
      );
    }
  }

  void _filterPresidents(String text) {
    setState(() {
      // Filter _presidents list based on search text
      _filteredPresidents = _presidents
          .where((president) =>
              president.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterPresidents,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredPresidents.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _filteredPresidents.length,
                  itemBuilder: (context, index) {
                    var president = _filteredPresidents[index];
                    var imageURL = president.photo ?? '';
                    return ListTile(
                      title: Text(
                        president.name ?? '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 223, 201, 0),
                        ),
                      ),
                      subtitle: Text(
                        president.yearsInOffice != null
                            ? 'Years in Office: ${president.yearsInOffice}'
                            : '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 254),
                        ),
                      ),
                      trailing: imageURL.isNotEmpty
                          ? SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.network(
                                imageURL,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Icon(Icons.error,
                                      color: Color.fromARGB(255, 245, 0, 0));
                                },
                              ),
                            )
                          : SizedBox.shrink(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              PresidentDetailDialog(president: president),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
