import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunzaa/model/product_model.dart';

class CheckoutPage extends StatelessWidget {
  final List<Product> goodsList;
  const CheckoutPage({Key? key, required this.goodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double grandTotal = goodsList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.amount) * element.price);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Clear cart',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 23),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: goodsList.length,
                itemBuilder: (context, index) {
                  final productItem = goodsList[index];
                  final totalAmount = productItem.amount * productItem.price;
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          productItem.image,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      productItem.title,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${productItem.amount}x',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ksh ${productItem.price}',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 7),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(4, 4),
                                          color:
                                              Color.fromARGB(255, 38, 24, 109))
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 248, 207, 252)),
                                child: Text(
                                  'Ksh ${totalAmount}',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ));
                }),
            SizedBox(
              height: 15,
            ),
            Text(
              'Grand Total',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 17),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(4, 4),
                        color: Color.fromARGB(255, 38, 24, 109))
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 248, 207, 252)),
              child: Text(
                'Ksh ${grandTotal.toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
