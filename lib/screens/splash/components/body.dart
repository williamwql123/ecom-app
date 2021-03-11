import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/models/Company.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  Future<Company> futureCompany;

  @override
  void initState() {
    super.initState();
    futureCompany = fetchCompany().then((company) {
      // Run the code here using the value
      if (company.splashData?.isEmpty ?? true) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, ModalRoute.withName('/'));
        return null;
      }
      return company;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<Company>(
          future: futureCompany,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: snapshot.data.splashData.length,
                      itemBuilder: (context, index) => SplashContent(
                        title: snapshot.data.splashData[index]["title"],
                        image: snapshot.data.splashData[index]["image"],
                        text: snapshot.data.splashData[index]['text'],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Column(
                        children: <Widget>[
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              snapshot.data.splashData.length,
                              (index) => buildDot(index: index),
                            ),
                          ),
                          Spacer(flex: 3),
                          DefaultButton(
                            text: "Continue",
                            press: () {
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context,
                              //     HomeScreen.routeName,
                              //     ModalRoute.withName('/'));
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
