import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;

  ArticlePage({required this.title, required this.imageUrl, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ReadAboutHealthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedArticles = [
      {
        'title': 'Ensuring Dental Health During Pregnancy: The Safety of Root Canal Procedures',
        'imageUrl': 'https://as1.ftcdn.net/v2/jpg/04/48/76/68/1000_F_448766846_5yJik1VSkqoAAtweCIxhe9KeMJM2sfht.jpg',
        'content': 'Pregnancy is an extraordinary journey characterized by a multitude of changes, both physical and emotional. Amidst the anticipation and joy, expectant mothers often find themselves navigating various health considerations, including dental care. Root canal procedures, in particular, can evoke questions and concerns regarding their safety during pregnancy. In this article, we aim to provide comprehensive insights into the safety of root canal treatments for pregnant women, empowering them to make informed decisions about their dental health.\n\nUnderstanding Root Canal Procedures\n\nA root canal procedure is a common dental treatment employed to salvage a tooth afflicted by severe decay or infection. The process involves meticulously removing the infected pulp from within the tooth, followed by thorough cleansing and sealing to prevent further microbial intrusion. While the prospect of undergoing dental intervention during pregnancy may induce apprehension, it\'s essential to recognize that maintaining optimal oral health is integral to overall well-being, both for the expectant mother and her unborn child.\n\n Safety Considerations During Pregnancy \n\nResearch suggests that root canal procedures, when performed under appropriate clinical supervision and within the recommended timeframe, are generally considered safe during pregnancy. The second trimester, in particular, is often deemed the optimal window for elective dental treatments, owing to the decreased likelihood of potential risks to maternal and fetal health. However, it\'s imperative for expectant mothers to communicate openly with their healthcare providers, disclosing their pregnancy status and any pertinent medical history, to ensure personalized and judicious care.\n\nPrioritizing Maternal and Fetal Well-being\n\nThe significance of dental health during pregnancy cannot be overstated. Hormonal fluctuations inherent to pregnancy can predispose individuals to oral health issues, such as gingivitis and periodontal disease, underscoring the importance of proactive dental maintenance and timely intervention. By addressing dental concerns promptly and effectively, expectant mothers can mitigate the risk of complications and safeguard their oral health throughout the prenatal journey.\n\nEmpowering Informed Decision-Making\n\nIn conclusion, while the prospect of undergoing dental procedures during pregnancy may evoke uncertainty, rest assured that root canal treatments, when deemed necessary and executed under professional guidance, can be performed safely. By fostering open communication with healthcare providers and prioritizing dental well-being, expectant mothers can navigate dental interventions confidently, ensuring the preservation of their smiles and the promotion of maternal-fetal health.'
      },
      {
        'title': 'Straightening Smiles: Determining the Optimal Age for Orthodontic Treatment',
        'imageUrl': 'https://www.shutterstock.com/image-photo/woman-teeth-smile-close-uphalf-600nw-155131391.jpg',
        'content': 'Orthodontic treatment, characterized by the use of braces, aligners, or other orthodontic appliances, aims to correct misaligned teeth and jaws, enhancing oral function and aesthetics. While orthodontic intervention is commonly associated with adolescence, the optimal age for initiating treatment may vary depending on individual factors and treatment goals. In this article, we explore the factors influencing the timing of orthodontic treatment, offering insights to help individuals and parents make informed decisions about orthodontic care.\n\n Early Orthodontic Evaluation \n\nThe American Association of Orthodontists recommends that children undergo an orthodontic evaluation by age 7 to assess their dental development and identify any potential orthodontic issues. While not all children will require early intervention, early evaluation allows orthodontists to detect and address emerging problems promptly, potentially minimizing the need for more extensive treatment later on.\n\n Adolescent Orthodontic Treatment \n\nAdolescence is often considered the optimal time for orthodontic treatment, as it coincides with the period of active growth and development. During this stage, the jawbones are still growing, making it easier to guide teeth into their proper positions and correct bite abnormalities. Additionally, many adolescents are motivated to undergo orthodontic treatment for cosmetic reasons, seeking to improve their smile and boost their self-confidence.\n\n Adult Orthodontic Treatment \n\nWhile orthodontic treatment is commonly associated with adolescence, an increasing number of adults are pursuing orthodontic care to address longstanding dental issues or enhance their smile. Advances in orthodontic technology, such as clear aligners and discreet braces, have made orthodontic treatment more accessible and appealing to adults, allowing them to achieve a straighter smile without compromising aesthetics or comfort.\n\n Factors Influencing Treatment Timing \n\nSeveral factors may influence the timing of orthodontic treatment, including the severity of the orthodontic problem, the presence of underlying dental issues or skeletal abnormalities, and the individual\'s oral health status and treatment preferences. Ultimately, the decision to pursue orthodontic treatment and the timing thereof should be made in consultation with an experienced orthodontist, who can assess the unique needs and circumstances of each patient and develop a customized treatment plan.\n\nIn summary, the optimal age for orthodontic treatment depends on various factors, including the individual\'s dental development, treatment goals, and personal preferences. By seeking early orthodontic evaluation and collaborating with an experienced orthodontist, individuals and parents can make informed decisions about orthodontic care, ensuring optimal oral health and a confident, radiant smile.'
      },
      {
        'title': '12 Surprising Benefits of Black Tea',
        'imageUrl': 'https://images.pexels.com/photos/327136/pexels-photo-327136.jpeg?auto=compress&cs=tinysrgb&w=600',
        'content': 'Black tea, derived from the leaves of the Camellia sinensis plant, is renowned for its rich flavor, bold aroma, and myriad health benefits. While often overshadowed by its green and herbal counterparts, black tea boasts a diverse array of compounds and antioxidants that contribute to its therapeutic properties. In this article, we explore 12 surprising benefits of black tea, shedding light on its potential to promote health, vitality, and well-being.\n\n1. Supports Heart Health: Black tea contains flavonoids and polyphenols, potent antioxidants that help protect the heart by reducing inflammation, improving blood vessel function, and lowering cholesterol levels.\n\n2. Boosts Immune Function: The polyphenols in black tea possess antimicrobial properties that help bolster the immune system, enhancing the body\'s ability to defend against infections and illnesses.\n\n3. Enhances Mental Alertness: Black tea contains caffeine, a natural stimulant that promotes mental alertness, concentration, and cognitive function, helping individuals stay focused and attentive throughout the day.\n\n4. Improves Oral Health: The polyphenols and tannins in black tea have antibacterial properties that help inhibit the growth of cavity-causing bacteria and reduce the risk of gum disease and tooth decay.\n\n5. Supports Digestive Health: Black tea contains tannins, compounds that aid digestion by promoting the secretion of digestive enzymes and soothing gastrointestinal discomfort, such as bloating and indigestion.\n\n6. Regulates Blood Sugar: Studies suggest that black tea may help regulate blood sugar levels and improve insulin sensitivity, potentially reducing the risk of type 2 diabetes and managing diabetes-related complications.\n\n7. Protects Against Cancer: The polyphenols in black tea possess anticancer properties that help inhibit the growth of cancer cells and reduce the risk of various types of cancer, including breast, prostate, and colorectal cancer.\n\n8. Promotes Weight Management: Black tea may aid in weight management by increasing metabolism, promoting fat oxidation, and suppressing appetite, helping individuals maintain a healthy body weight.\n\n9. Enhances Skin Health: The antioxidants in black tea help protect the skin from oxidative stress and UV damage, reducing the signs of aging and promoting a clear, radiant complexion.\n\n10. Supports Bone Health: Black tea contains fluoride and other minerals that help strengthen bones and prevent osteoporosis, reducing the risk of fractures and maintaining bone density.\n\n11. Improves Mood and Well-being: Black tea contains L-theanine, an amino acid that promotes relaxation and reduces stress, anxiety, and depression, enhancing overall mood and well-being.\n\n12. Hydrates the Body: Contrary to popular belief, black tea is a hydrating beverage that contributes to daily fluid intake, helping maintain optimal hydration and supporting overall health and vitality.\n\nBy incorporating black tea into your daily routine, you can reap its many health benefits and enjoy a delicious, comforting beverage that nourishes the body and uplifts the spirit.'
      },
      {
        'title': '6 Essential Nutrients for Women',
        'imageUrl': 'https://www.healthifyme.com/blog/wp-content/uploads/2022/01/shutterstock_1015800871-1.jpg',
        'content': 'Nutrition plays a crucial role in supporting women\'s health and well-being across the lifespan, influencing various physiological processes, from hormonal balance and reproductive health to immune function and bone density. While a balanced diet rich in whole foods forms the foundation of optimal nutrition, certain nutrients are particularly important for women\'s health due to their unique physiological needs and life stages. In this article, we highlight six essential nutrients for women, outlining their functions, dietary sources, and potential health benefits.\n\n1. Iron\n\nIron is a vital mineral involved in the production of hemoglobin, a protein in red blood cells that transports oxygen from the lungs to tissues throughout the body. Women have higher iron requirements than men due to blood loss during menstruation and the demands of pregnancy. Iron-rich foods include lean meats, poultry, fish, beans, lentils, tofu, spinach, and fortified cereals.\n\n2. Calcium\n\nCalcium is essential for bone health, muscle function, and nerve transmission, playing a critical role in preventing osteoporosis and fractures, especially in postmenopausal women. Dairy products, leafy greens, fortified plant milks, tofu, almonds, and sardines with bones are excellent sources of calcium.\n\n3. Vitamin D\n\nVitamin D is necessary for calcium absorption, immune function, and mood regulation, with emerging research linking adequate vitamin D levels to a reduced risk of certain cancers, autoimmune diseases, and mental health disorders. Sunlight exposure, fatty fish, fortified dairy products, egg yolks, and mushrooms are primary sources of vitamin D.\n\n4. Folate\n\nFolate, also known as vitamin B9, is essential for DNA synthesis, cell division, and red blood cell formation, making it especially important during pregnancy to prevent neural tube defects and support fetal development. Leafy greens, legumes, citrus fruits, fortified grains, and supplements are rich sources of folate.\n\n5. Omega-3 Fatty Acids\n\nOmega-3 fatty acids, including EPA (eicosapentaenoic acid) and DHA (docosahexaenoic acid), are beneficial fats with anti-inflammatory properties that support heart health, brain function, and mood regulation. Fatty fish such as salmon, mackerel, and sardines, as well as flaxseeds, chia seeds, walnuts, and algae-based supplements, are excellent sources of omega-3s.\n\n6. Magnesium\n\nMagnesium is involved in over 300 biochemical reactions in the body, including energy production, muscle function, and bone strength, with research suggesting that adequate magnesium intake may reduce the risk of type 2 diabetes and hypertension. Magnesium-rich foods include nuts, seeds, whole grains, leafy greens, legumes, and dark chocolate.\n\nBy prioritizing nutrient-dense foods and meeting their unique nutritional needs, women can optimize their health, vitality, and well-being at every stage of life.'
      },
      {
        'title': 'How to Destress? Insights from Ayurveda',
        'imageUrl': 'https://img.freepik.com/premium-photo/young-woman-practicing-yoga-sitting-among-grass-sunny-light-background-morning-mountains-meditation-calm-tranquil-moment-connection-with-nature-copy-space_250813-3465.jpg',
        'content': 'In today\'s fast-paced world, stress has become a ubiquitous part of modern life, affecting individuals of all ages and backgrounds. While occasional stress is a normal response to life\'s challenges, chronic stress can have detrimental effects on physical, mental, and emotional well-being, contributing to a wide range of health problems, from cardiovascular disease and digestive disorders to anxiety and depression. In this article, we explore time-tested strategies from Ayurveda, the ancient Indian system of medicine, for managing stress and promoting balance, harmony, and resilience in daily life.\n\nUnderstanding Stress According to Ayurveda\n\nAyurveda views stress as an imbalance of the doshas, the three fundamental energies that govern all physiological and psychological processes in the body. When the doshas—Vata (air and space), Pitta (fire and water), and Kapha (earth and water)—become aggravated or imbalanced due to various internal and external factors, it can disrupt the body\'s natural equilibrium and predispose individuals to stress-related symptoms and health issues.\n\nAyurvedic Strategies for Stress Management\n\n1. Establishing a Daily Routine (Dinacharya)\n\nAccording to Ayurveda, maintaining a consistent daily routine aligned with the body\'s natural rhythms is essential for promoting balance and stability in mind and body. This includes waking up and going to bed at regular times, eating nourishing meals at scheduled intervals, and engaging in rejuvenating self-care practices such as meditation, yoga, and pranayama (breathwork).\n\n2. Cultivating Mindfulness and Awareness (Sati)\n\nMindfulness, or Sati in Pali, is the practice of nonjudgmental awareness of the present moment, allowing individuals to observe their thoughts, emotions, and sensations with clarity and equanimity. By cultivating mindfulness through meditation, mindful movement, and conscious living, individuals can develop greater resilience to stress and cultivate a deeper sense of inner peace and well-being.\n\n3. Nourishing the Body and Mind (Sattvic Diet)\n\nAyurveda emphasizes the importance of dietary choices in promoting physical, mental, and emotional balance. A sattvic diet, consisting of fresh, whole foods that are light, easily digestible, and rich in prana (life force energy), is recommended for maintaining optimal health and vitality while minimizing stress and toxicity in the body and mind.\n\n4. Herbal Support and Adaptogens\n\nHerbal remedies and adaptogenic herbs play a key role in Ayurvedic medicine for supporting the body\'s natural resilience to stress and promoting overall well-being. Ashwagandha, Brahmi (Bacopa monnieri), Tulsi (Holy Basil), and Shatavari are among the many herbs prized for their adaptogenic and stress-relieving properties.\n\n5. Creating Sacred Space\n\nCreating a nurturing and supportive environment at home and work is essential for reducing stress and fostering a sense of safety, tranquility, and well-being. This may include decluttering and organizing living spaces, incorporating elements of nature and beauty, and establishing daily rituals that nourish the soul and uplift the spirit.\n\nIncorporating these Ayurvedic principles and practices into daily life can help individuals cultivate resilience, reduce stress, and embrace life with greater ease, joy, and vitality. By honoring the wisdom of Ayurveda and prioritizing self-care, individuals can navigate life\'s challenges with grace and equanimity, fostering greater harmony and balance in mind, body, and spirit.'
      },
      {
        'title': '6 Common Myths About Diabetes',
        'imageUrl': 'https://i.pinimg.com/736x/45/a3/cc/45a3cc7ffe29cdff6321fa810842d2c7.jpg',
        'content': 'Diabetes, a chronic metabolic disorder characterized by elevated blood sugar levels, affects millions of people worldwide and poses significant challenges for disease management and prevention. Despite advances in research and medical understanding, several myths and misconceptions persist surrounding diabetes, leading to confusion and misinformation among patients and the general public. In this article, we debunk six common myths about diabetes, providing accurate information and empowering individuals to make informed choices about their health.\n\nMyth 1: Diabetes is caused by consuming too much sugar.\n\nFact: While consuming excessive sugar and refined carbohydrates can contribute to the development of type 2 diabetes, the condition is multifactorial, with genetics, lifestyle factors, and metabolic health playing significant roles. Type 1 diabetes, an autoimmune condition characterized by insulin deficiency, is not caused by sugar consumption.\n\nMyth 2: People with diabetes can\'t eat carbs.\n\nFact: Carbohydrates are an essential macronutrient that provides energy and nutrients for the body. People with diabetes can include carbohydrates in their diet by choosing nutrient-dense, fiber-rich options such as whole grains, fruits, vegetables, and legumes, and monitoring portion sizes and blood sugar levels.\n\nMyth 3: Only overweight or obese individuals develop diabetes.\n\nFact: While excess weight and obesity are risk factors for type 2 diabetes, individuals of all body types, including those who are thin or of normal weight, can develop the condition. Genetic predisposition, family history, ethnicity, and lifestyle factors such as physical activity and diet influence diabetes risk.\n\nMyth 4: Diabetes is not a serious disease.\n\nFact: Diabetes is a serious and potentially life-threatening condition that requires lifelong management to prevent complications such as heart disease, stroke, kidney failure, vision loss, nerve damage, and lower limb amputation. Proper diabetes management, including medication, diet, exercise, and regular monitoring, is essential for maintaining optimal health and quality of life.\n\nMyth 5: Insulin is only used to treat type 1 diabetes.\n\nFact: While insulin therapy is a cornerstone of treatment for type 1 diabetes, it is also used in the management of type 2 diabetes, particularly in advanced cases or when other treatments fail to adequately control blood sugar levels. Insulin therapy may be administered via injections or insulin pumps, depending on individual needs and preferences.\n\nMyth 6: Diabetes can be cured.\n\nFact: While diabetes cannot be cured, it can be managed effectively with lifestyle modifications, medication, and regular medical care. With proper treatment and self-care practices, many individuals with diabetes can achieve good blood sugar control, prevent complications, and lead full, active lives.\n\nBy dispelling these common myths and misconceptions about diabetes, we can promote greater awareness, understanding, and support for individuals living with the condition, empowering them to take control of their health and well-being.'
      },
      {
        'title': 'Arthritis - Living and Coping with It',
        'imageUrl': 'https://psrihospital.com/wp-content/uploads/2023/02/artheritis-symptoms-causes-types-treatment.jpg',
        'content': 'Arthritis, a chronic inflammatory condition characterized by joint pain, stiffness, and swelling, affects millions of people worldwide and can significantly impact daily functioning and quality of life. While there is no cure for arthritis, various treatment options and self-care strategies can help manage symptoms, improve mobility, and enhance overall well-being. In this article, we explore the different types of arthritis, common symptoms and causes, and practical tips for living and coping with the condition.\n\nTypes of Arthritis\n\nThere are more than 100 different types of arthritis, but the most common forms include:\n\n1. Osteoarthritis (OA): A degenerative joint disease characterized by the breakdown of cartilage, leading to pain, stiffness, and reduced mobility, often affecting weight-bearing joints such as the knees, hips, and spine.\n\n2. Rheumatoid Arthritis (RA): An autoimmune disorder that causes inflammation of the synovium (joint lining), resulting in joint pain, swelling, and deformity, commonly affecting the hands, wrists, and feet.\n\n3. Psoriatic Arthritis: A type of inflammatory arthritis that occurs in some individuals with psoriasis, a chronic skin condition, causing joint pain, swelling, and nail changes, often affecting the fingers, toes, and spine.\n\n4. Ankylosing Spondylitis: An inflammatory arthritis that primarily affects the spine and sacroiliac joints, causing stiffness, pain, and limited mobility, typically starting in early adulthood.\n\nCommon Symptoms and Causes\n\nThe symptoms of arthritis can vary depending on the type and severity of the condition but often include:\n\n- Joint pain, stiffness, and swelling\n- Reduced range of motion\n- Joint deformity or malalignment\n- Fatigue\n- Muscle weakness\n\nThe exact cause of arthritis varies depending on the type but may involve a combination of genetic, environmental, and lifestyle factors, such as:\n\n- Age-related wear and tear (osteoarthritis)\n- Autoimmune dysfunction (rheumatoid arthritis)\n- Genetic predisposition\n- Joint injury or trauma\n- Infection\n- Obesity\n- Sedentary lifestyle\n\nLiving and Coping with Arthritis\n\nWhile arthritis can pose significant challenges, there are many strategies for managing symptoms and improving quality of life:\n\n1. Exercise: Regular physical activity, including low-impact exercises such as walking, swimming, and cycling, can help improve joint flexibility, strength, and endurance, reduce pain and stiffness, and maintain overall health and mobility.\n\n2. Weight Management: Maintaining a healthy weight through a balanced diet and regular exercise can help reduce stress on weight-bearing joints and minimize arthritis symptoms.\n\n3. Medication: Over-the-counter pain relievers, nonsteroidal anti-inflammatory drugs (NSAIDs), corticosteroids, and disease-modifying antirheumatic drugs (DMARDs) may be prescribed to alleviate pain, reduce inflammation, and slow disease progression.\n\n4. Physical Therapy: Working with a physical therapist can help individuals with arthritis learn exercises and techniques to improve joint mobility, strength, and function, as well as manage pain and prevent disability.\n\n5. Assistive Devices: Using assistive devices such as braces, splints, canes, or orthopedic shoes can help support weak or damaged joints, reduce pain, and improve mobility and independence.\n\n6. Self-Care: Practicing self-care activities such as stress management, relaxation techniques, hot and cold therapy, and joint protection techniques can help individuals cope with arthritis symptoms and improve overall well-being.\n\nBy adopting a holistic approach to arthritis management and incorporating these practical strategies into daily life, individuals can minimize pain and disability, maximize function and mobility, and live well with arthritis.'
      },
      {
        'title': 'Benefits of Regular Exercise',
        'imageUrl': 'https://media.istockphoto.com/id/1366052585/photo/shot-of-a-group-of-friends-hanging-out-before-working-out-together.jpg?s=612x612&w=0&k=20&c=rj7LgjUuXde0eLWikS1rvDnsKDdBotgsy9eM5HDzko0=',
        'content': 'Regular exercise is essential for maintaining optimal health and well-being, providing a wide range of physical, mental, and emotional benefits that contribute to overall vitality and quality of life. Whether it\'s brisk walking, swimming, cycling, or yoga, engaging in regular physical activity can have profound effects on various aspects of health, from cardiovascular fitness and muscle strength to mood regulation and cognitive function. In this article, we explore the numerous benefits of regular exercise and highlight its importance for individuals of all ages and fitness levels.\n\n1. Improves Cardiovascular Health\n\nRegular exercise strengthens the heart muscle, improves blood circulation, and lowers blood pressure and cholesterol levels, reducing the risk of heart disease, stroke, and other cardiovascular conditions.\n\n2. Enhances Muscle Strength and Endurance\n\nExercise helps build and maintain muscle mass and strength, improving overall physical performance, functional capacity, and resistance to injury and fatigue.\n\n3. Promotes Weight Management\n\nPhysical activity plays a key role in energy balance and weight control by burning calories, increasing metabolism, and preserving lean body mass, helping individuals achieve and maintain a healthy weight.\n\n4. Boosts Mood and Mental Health\n\nExercise stimulates the release of endorphins, neurotransmitters that promote feelings of happiness and well-being, while reducing stress, anxiety, and symptoms of depression, enhancing mood and cognitive function.\n\n5. Enhances Sleep Quality\n\nRegular physical activity improves sleep duration and quality by regulating sleep-wake cycles, reducing insomnia, and promoting relaxation and stress relief, leading to better overall sleep hygiene and daytime alertness.\n\n6. Supports Bone Health\n\nWeight-bearing and resistance exercises help build and maintain bone density and strength, reducing the risk of osteoporosis and fractures, especially in postmenopausal women and older adults.\n\n7. Improves Immune Function\n\nModerate-intensity exercise enhances immune function by increasing circulation and lymphatic flow, promoting the production of immune cells, and reducing inflammation, helping the body defend against infections and illnesses.\n\n8. Boosts Brain Health\n\nPhysical activity has neuroprotective effects on the brain, promoting neuroplasticity, synaptic growth, and cognitive function, reducing the risk of cognitive decline and dementia, and enhancing memory, learning, and attention.\n\n9. Fosters Social Connection\n\nExercise provides opportunities for social interaction, teamwork, and community engagement, fostering friendships, support networks, and a sense of belonging and camaraderie, which are essential for mental and emotional well-being.\n\n10. Enhances Longevity\n\nNumerous studies have shown that regular exercise is associated with increased longevity and a reduced risk of premature death from all causes, highlighting its importance for overall health and longevity.\n\nBy making physical activity a regular part of daily life and incorporating a variety of enjoyable and sustainable activities into one\'s routine, individuals can reap the many benefits of exercise and enjoy a healthier, happier, and more fulfilling life.'
      },
      {
        'title': 'Healthy Eating Habits for Better Digestion',
        'imageUrl': 'https://images.pexels.com/photos/6551415/pexels-photo-6551415.jpeg?auto=compress&cs=tinysrgb&w=600',
        'content': 'Digestive health plays a crucial role in overall well-being, influencing nutrient absorption, immune function, and disease prevention. While genetics and lifestyle factors such as physical activity and stress management impact digestive function, dietary choices are among the most significant determinants of digestive health. In this article, we explore healthy eating habits that promote better digestion, improve gut health, and enhance overall vitality and well-being.\n\n1. Eat a Balanced Diet\n\nA balanced diet rich in fiber, lean protein, healthy fats, fruits, vegetables, and whole grains provides essential nutrients and promotes optimal digestive function. Aim to include a variety of colorful fruits and vegetables in your meals to ensure adequate intake of vitamins, minerals, and antioxidants.\n\n2. Stay Hydrated\n\nWater is essential for proper digestion, nutrient absorption, and waste elimination. Drink plenty of fluids throughout the day, including water, herbal teas, and broths, to stay hydrated and support optimal digestive function.\n\n3. Chew Your Food Thoroughly\n\nChewing food thoroughly aids digestion by breaking down food particles into smaller, more easily digestible pieces and stimulating the release of digestive enzymes in the mouth and stomach. Take your time to savor each bite and chew slowly and mindfully.\n\n4. Practice Mindful Eating\n\nMindful eating involves paying attention to hunger and fullness cues, eating slowly and without distractions, and savoring the flavors, textures, and aromas of food. By tuning into your body\'s signals and honoring its needs, you can prevent overeating and promote better digestion.\n\n5. Limit Processed Foods and Added Sugars\n\nProcessed foods high in refined carbohydrates, added sugars, artificial additives, and preservatives can disrupt gut microbiota, promote inflammation, and contribute to digestive issues such as bloating, gas, and constipation. Opt for whole, minimally processed foods whenever possible.\n\n6. Include Fermented Foods\n\nFermented foods such as yogurt, kefir, sauerkraut, kimchi, and kombucha contain beneficial probiotics that support gut health by replenishing and diversifying the microbiome, enhancing digestion, and strengthening the immune system. Incorporate fermented foods into your diet regularly.\n\n7. Manage Stress\n\nChronic stress can impair digestive function by disrupting the balance of gut microbiota, altering gut motility and permeability, and exacerbating symptoms of irritable bowel syndrome (IBS) and other digestive disorders. Practice stress-reduction techniques such as deep breathing, meditation, yoga, and progressive muscle relaxation.\n\n8. Be Physically Active\n\nRegular physical activity stimulates digestion, promotes bowel regularity, and reduces the risk of constipation and other digestive problems. Aim for at least 30 minutes of moderate-intensity exercise most days of the week to support digestive health and overall well-being.\n\nBy adopting these healthy eating habits and lifestyle practices, you can optimize digestive function, alleviate digestive discomfort, and promote overall health and vitality.'
      }
    ];

void main() {
  runApp(MaterialApp(
    home: ReadAboutHealthPage(),
  ));
}


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HealthShaala',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: displayedArticles.map((article) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(
                          title: article['title']!,
                          imageUrl: article['imageUrl']!,
                          content: article['content']!,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article['imageUrl']!.isNotEmpty)
                        Image.network(
                          article['imageUrl']!,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          article['title']!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReadAboutHealthPage(),
  ));
}
