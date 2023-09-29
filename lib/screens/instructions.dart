import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/functions/dataIO.dart';
import 'package:tic_tac_toe_pro/screens/options.dart';

void changeScreen(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GameOptions(),
    ),
  );
}

class Explain extends StatelessWidget {
  final String image;
  Explain({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;

  final List<Widget> _pages = [
    Explain(image: "assets/image1.png"),
    Explain(image: "assets/image2.png"),
    Explain(image: "assets/proMode.gif"),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 50,
              child: Container(
                color: Colors.grey,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextButton(
                        onPressed: () async {
                          await dataIO.firstTimeSet();
                          changeScreen(context);
                        },
                        child: Text("Skip"),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          _pages.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () {
                                    _pageController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: _activePage == index
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                              )),
                    ),
                    Spacer(),
                    _activePage == _pages.length - 1
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                              onPressed: () async {
                                await dataIO.firstTimeSet();
                                changeScreen(context);
                              },
                              child: Text("Play"),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                              onPressed: () {
                                _pageController.animateToPage(_activePage + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: Text("Next"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
