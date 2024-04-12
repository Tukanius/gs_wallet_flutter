import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:intl/intl.dart';

class CompanyCard extends StatefulWidget {
  final String? name;
  final String? profileUrl;
  final String? createdDate;
  final String? description;
  final List<String>? products;
  final Function()? onClick;
  const CompanyCard({
    super.key,
    this.onClick,
    this.name,
    this.profileUrl,
    this.createdDate,
    this.description,
    this.products,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${widget.profileUrl}"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat("yyyy-MM-dd HH:mm").format(
                  DateTime.parse(widget.createdDate!),
                ),
                style: TextStyle(
                  color: colortext,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Манай дэлгүүр 2014 оноос хойш тасралтгүй Америкаас бараа бүтээгдэхүүн оруулж ирж байгаа. Only originals! 🇺🇸💯',
            style: TextStyle(
              color: colortext,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 18,
          ),
          DottedLine(
            dashColor: colortext.withOpacity(0.5),
            dashLength: 10,
            dashGapLength: 10,
            lineThickness: 1,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 18),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: widget.products!
                  .map(
                    (e) => Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image(
                              image: NetworkImage('$e'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          GestureDetector(
            onTap: widget.onClick,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: buttonbg,
              ),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(
                child: Text(
                  'Дэлгэрэнгүй',
                  style: TextStyle(
                    color: white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
