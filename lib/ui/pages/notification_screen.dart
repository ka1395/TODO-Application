import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.payload}) : super(key: key);
  String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    _payload = widget.payload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(_payload.toString().split("|")[0],
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr)),
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back,color:Get.isDarkMode ? Colors.white : darkGreyClr,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: const [
                Text(
                  "Hello,Khaled",
                  style: TextStyle(
                      color: darkGreyClr,
                      fontWeight: FontWeight.w900,
                      fontSize: 26),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You Have A New reminder",
                  style: TextStyle(
                      color: darkGreyClr,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryClr,
              ),
              margin: EdgeInsets.only(left: 30, right: 30),
              padding: EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Icon(Icons.text_format, size: 35, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(_payload.toString().split("|")[1],
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Icon(Icons.description, size: 35, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(_payload.toString().split("|")[2],
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Icon(Icons.date_range, size: 35, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Date",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(_payload.toString().split("|")[3],
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
