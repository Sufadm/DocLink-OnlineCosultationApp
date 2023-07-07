import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthTipScreen extends StatelessWidget {
  const HealthTipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HealthTips',
          style: kTextStyleLargeBlack,
        ),
        // elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change your color here
        ),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              Text(
                '1. Eat a healthy diet',
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/1-20190529-091438-lr.tmb-1366v.jpg?Culture=en&sfvrsn=9ba890c9_2'),
              Text(
                'Eat a combination of different foods, including fruit, vegetables, legumes, nuts and whole grains. Adults should eat at least five portions (400g) of fruit and vegetables per day. You can improve your intake of fruits and vegetables by always including veggies in your meal; eating fresh fruit and vegetables as snacks; eating a variety of fruits and vegetables; and eating them in season. By eating healthy, you will reduce your risk of malnutrition and noncommunicable diseases (NCDs) such as diabetes, heart disease, stroke and cancer.',
                style: GoogleFonts.outfit(fontSize: 15),
              ),
              const Divider(),
              Text('2. Consume less salt and sugar',
                  style: GoogleFonts.outfit(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/2-who-056764-orig.tmb-1366v.jpg?Culture=en&sfvrsn=c20a162e_2'),
              Text(
                'Filipinos consume twice the recommended amount of sodium, putting them at risk of high blood pressure, which in turn increases the risk of heart disease and stroke. Most people get their sodium through salt. Reduce your salt intake to 5g per day, equivalent to about one teaspoon. It’s easier to do this by limiting the amount of salt, soy sauce, fish sauce and other high-sodium condiments when preparing meals; removing salt, seasonings and condiments from your meal table; avoiding salty snacks; and choosing low-sodium products.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              kHeight10,
              Text(
                '3. Avoid harmful use of alcohol',
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/4-who-056030-img.tmb-1366v.jpg?Culture=en&sfvrsn=227d74e_2'),
              Text(
                'There is no safe level for drinking alcohol. Consuming alcohol can lead to health problems such as mental and behavioural disorders, including alcohol dependence, major NCDs such as liver cirrhosis, some cancers and heart diseases, as well as injuries resulting from violence and road clashes and collisions.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              kHeight10,
              Text(
                '4. Be active',
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/6-f2-300032016-ph-06573-lr.tmb-1366v.jpg?Culture=en&sfvrsn=f4bc39b4_2'),
              Text(
                'Physical activity is defined as any bodily movement produced by skeletal muscles that requires energy expenditure. This includes exercise and activities undertaken while working, playing, carrying out household chores, travelling, and engaging in recreational pursuits. The amount of physical activity you need depends on your age group but adults aged 18-64 years should do at least 150 minutes of moderate-intensity physical activity throughout the week. Increase moderate-intensity physical activity to 300 minutes per week for additional health benefits.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              kHeight10,
              Text(
                '5. Check your blood pressure regularly',
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/7-img-3982-lr.tmb-1366v.jpg?Culture=en&sfvrsn=20ea404c_2'),
              Text(
                'Hypertension, or high blood pressure, is called a “silent killer”. This is because many people who have hypertension may not be aware of the problem as it may not have any symptoms. If left uncontrolled, hypertension can lead to heart, brain, kidney and other diseases. Have your blood pressure checked regularly by a health worker so you know your numbers. If your blood pressure is high, get the advice of a health worker. This is vital in the prevention and control of hypertension.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              kHeight10,
              Text(
                '6. Drink only safe water',
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/14-mg-9033-lr.tmb-1366v.jpg?Culture=en&sfvrsn=eca64271_2'),
              Text(
                'Drinking unsafe water can lead to water-borne diseases such as cholera, diarrhoea, hepatitis A, typhoid and polio. Globally, at least 2 billion people use a drinking water source contaminated with faeces. Check with your water concessionaire and water refilling station to ensure that the water you’re drinking is safe. In a setting where you are unsure of your water source, boil your water for at least one minute. This will destroy harmful organisms in the water. Let it cool naturally before drinking.',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              kHeight10,
              Text(
                "7. Talk to someone you trust if you're feeling down",
                style: GoogleFonts.outfit(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              kHeight10,
              Image.network(
                  'https://www.who.int/images/default-source/wpro/countries/philippines/feature-stories/16-mg-8143-lr.tmb-1366v.jpg?Culture=en&sfvrsn=1d58571b_2'),
              Text(
                'Depression is a common illness worldwide with over 260 million people affected. Depression can manifest in different ways, but it might make you feel hopeless or worthless, or you might think about negative and disturbing thoughts a lot or have an overwhelming sense of pain. If you’re going through this, remember that you are not alone. Talk to someone you trust such as a family member, friend, colleague or mental health professional about how you feel. If you feel that you are in danger of harming yourself, contact the National Center for Mental Health hotline at 0917-899-USAP (8727).',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: ,
    );
  }
}
