import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa/provider/api_provider.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key? key}) : super(key: key);

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        backgroundColor: const Color(0xFFfce7fe),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Sort By:',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 25)),
        content: Consumer<ApiProvider>(builder: (context, notifier, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Price',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      notifier.sortPriceLowest();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 4),
                                color: Color.fromARGB(255, 38, 24, 109))
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 248, 207, 252)),
                      child: Text(
                        'Low-High',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      notifier.sortPriceHighest();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 4),
                                color: Color.fromARGB(255, 38, 24, 109))
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 248, 207, 252)),
                      child: Text(
                        'High-Low',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Rating',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      notifier.sortRatingLowest();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 4),
                                color: Color.fromARGB(255, 38, 24, 109))
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 248, 207, 252)),
                      child: Text(
                        'Low-High',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      notifier.sortRatingHighest();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 4),
                                color: Color.fromARGB(255, 38, 24, 109))
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 248, 207, 252)),
                      child: Text(
                        'High-Low',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
