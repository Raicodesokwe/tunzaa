import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa/pages/checkout_page.dart';
import 'package:tunzaa/provider/api_provider.dart';
import 'package:tunzaa/widgets/sort_dialog.dart';

import '../model/product_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>>? fetchProds;
  @override
  void initState() {
    super.initState();

    fetchProds = Provider.of<ApiProvider>(context, listen: false).getProducts();
  }

  int totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double aspectRatio = 0.65;
    double spacing = 30;
    return SafeArea(
      child: Consumer<ApiProvider>(builder: (context, notifier, child) {
        List<Product> addedList = notifier.productList
            .where((element) => element.addToCart == true)
            .toList();
        totalAmount = addedList.fold(
            0, (previousValue, element) => previousValue + element.amount);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.purple,
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SortDialog();
                        });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: Color.fromARGB(255, 38, 24, 109)),
                        color: Color.fromARGB(255, 248, 207, 252),
                      ),
                      child: Icon(Icons.filter_list)),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 7,
              backgroundColor: Colors.purple,
              onPressed: addedList.isEmpty
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Add items to cart')));
                    }
                  : () {
                      // print('das length is ${theList.length}');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                                goodsList: addedList,
                              )));
                    },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.white,
                  ),
                  Positioned(
                      top: -20,
                      right: -10,
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Text(
                            '$totalAmount',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 48, 9, 116)),
                      ))
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Products',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 4),
                                color: Color.fromARGB(255, 38, 24, 109))
                          ],
                          border: Border.all(
                              color: Color.fromARGB(255, 38, 24, 109)),
                          color: Color.fromARGB(255, 248, 207, 252),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        onChanged: ((value) {
                          Provider.of<ApiProvider>(context, listen: false)
                              .changeSearchString(value);
                        }),
                        validator: (value) => value!.isEmpty ? 'no text' : null,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black54,
                        style: GoogleFonts.prompt(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                        decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: GoogleFonts.prompt(),
                            border: InputBorder.none),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                      future: fetchProds,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.triangleExclamation,
                                size: 70,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Error has occured',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18))
                            ],
                          ));
                        } else if (!snapshot.hasData ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        } else {
                          return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // physics: AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.6,
                                      crossAxisSpacing: spacing,
                                      mainAxisSpacing: spacing),
                              itemCount: notifier.prods.length,
                              itemBuilder: (context, index) {
                                final prodItem = notifier.prods[index];
                                return Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 8,
                                      shadowColor: Colors.black54,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                                height: 70,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/tunzaalogo.png',
                                                  image: prodItem.image,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Text(prodItem.title,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                                    'Tsh ${prodItem.price}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
                                            // Expanded(
                                            //     child: Text(
                                            //         '${prodItem.rating.rate}',
                                            //         style: GoogleFonts.montserrat(
                                            //             fontSize: 12,
                                            //             fontWeight:
                                            //                 FontWeight.w600))),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                notifier.addToCart(index);
                                              },
                                              child: prodItem.addToCart == false
                                                  ? Container(
                                                      height: 40,
                                                      width: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Add to cart',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .cartShopping,
                                                            size: 10,
                                                            color: Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.purple,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                    )
                                                  : SizedBox(
                                                      height: 30,
                                                      width: 110,
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (prodItem
                                                                        .amount >
                                                                    1) {
                                                                  notifier
                                                                      .reduceAmount(
                                                                          index);
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            25,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFF300974),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '${prodItem.amount}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (prodItem
                                                                        .amount >=
                                                                    1) {
                                                                  notifier
                                                                      .addAmount(
                                                                          index);
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    '+',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            25),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            48,
                                                                            9,
                                                                            116),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          child: Text(
                                            '${prodItem.rating.rate} / 5',
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF8CFFC),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ))
                                  ],
                                );
                              });
                        }
                      }),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
