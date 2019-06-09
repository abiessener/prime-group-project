CREATE TABLE questions
(
    id SERIAL PRIMARY KEY,
    question_number INT,
    english TEXT NOT NULL,
    somali TEXT NOT NULL,
    spanish TEXT NOT NULL,
    hmong TEXT NOT NULL,
    theme TEXT,
    year INT
);
CREATE TABLE translations
(
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL,
    english TEXT NOT NULL,
    somali TEXT NOT NULL,
    spanish TEXT NOT NULL,
    hmong TEXT NOT NULL
);
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role TEXT,
    token TEXT,
    active BOOLEAN DEFAULT FALSE,
    timestamp TEXT
);
CREATE TABLE occupancy
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    unit TEXT NOT NULL,
    responded BOOLEAN,
    paper_response BOOLEAN,
    paid BOOLEAN,
    occupied BOOLEAN,
    year INT NOT NULL
);
CREATE TABLE properties
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    household BOOLEAN
);
CREATE TABLE responses
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    language TEXT NOT NULL,
    year INT NOT NULL,
    answer1 INT,
    answer2 INT,
    answer3 INT,
    answer4 INT,
    answer5 INT,
    answer6 INT,
    answer7 INT,
    answer8 INT,
    answer9 INT,
    answer10 INT,
    answer11 INT,
    answer12 INT,
    answer13 INT,
    answer14 INT,
    answer15 INT,
    answer16 INT,
    answer17 INT,
    answer18 INT,
    answer19 INT,
    answer20 INT,
    answer21 TEXT,
    answer22 TEXT,
    answer23 INT,
    answer24 INT,
    answer25 TEXT,
    answer26 INT,
    answer27 INT,
    answer28 TEXT,
    answer29 INT,
    answer30 BOOLEAN,
    answer31 TEXT,
    answer32 TEXT,
    answer33 BOOLEAN,
    answer34 TEXT
);

CREATE TABLE occupancy_users
(
    occupancy_property TEXT NOT NULL,
    user_id INT REFERENCES users,
    PRIMARY KEY(occupancy_property, user_id)
);

CREATE TABLE household
(
    id SERIAL PRIMARY KEY,
    property TEXT NOT NULL,
    unit TEXT NOT NULL,
    year INT,
    name TEXT,
    date_of_birth DATE,
    gender TEXT,
    race_white BOOLEAN,
    race_black BOOLEAN,
    race_islander BOOLEAN,
    race_native BOOLEAN,
    race_asian BOOLEAN,
    race_self_identify TEXT,
    hispanic_or_latino BOOLEAN,
    disabled BOOLEAN,
);


INSERT INTO translations (type, english, spanish, somali, hmong) VALUES
('directions1', 'For each question, touch the button that best describes your experience during the last 12 months. Touch NEXT to go to the next page. Touch GO BACK to go back a page. Press CANCEL to cancel the survey', 'En cada pregunta, pulse el botón que describe mejor su experiencia en los últimos 12 meses.
Presione AVANZAR para pasar a la siguiente página. Presione RETROCEDER para devolverse a la página anterior. Presione CANCELAR para cancelar la encuesta.', 'Su’aal kasta, taabo batoonka jawaabta kuugu fiican wixii aad la kulantay 12-kii
bilood ee ugu dambeeyey. Taabo NEXT si aad bog kale ugu gudubto. Taabo GO
BACK si aad dib ugu noqoto. Taabo CANCEL si aad isaga joojiso su’aalaha.', 'Rau ib lo lus nug, nias lub npov uas piav qhia qhov koj tau ntsib zoo dua tshaj
rau lub sijhawm 12 lub hlis tag los. Kov TOM NTEJ NTXIV MUS yog xav mus rau
nplooj ntawv tom ntej. Kov ROV MUS TOM QAB yog xav rov mus rau nplooj
ntawm tom qab. Nias MUAB TSO TSEG yog xav muab daim ntawv xam phaj tso
tseg.'),
('directions2', 'Please enter your answers to each question in the box.', 'Por favor ingrese sus respuestas de cada pregunta en el recuadro.', 'Fadlan santuuqa dhex ku qor jawaabaha su’aal kasta.', 'Thov tso koj cov lus teb rau txhua lo lus nug nyob rau hauv lub npov.'),
('begin', 'Begin Survey', 'Comenzar encuesta', 'Bilow Su’aalaha', 'Pib Cov Lus Xam Phaj'),
('property', 'Property', 'Propiedad', 'Guri', 'Vaj Tse'),
('unit', 'Unit Number', 'Número de apartamento', 'Lambarka Guriga', 'Chav Tsev'),
('progress', 'Survey Progress', 'Progreso de la encuesta', 'Su’aalahaad ka Jawaabtay', 'Kev Xam Phaj Txog Twg Lawm'),
('continue', 'Continue', 'Continuar', 'Sii-wad', 'Ua Ntxiv Mus'),
('instructions', 'Instructions', 'Instrucciones', 'Tilmaamo', 'Cov Lus Taw Qhia'),
('next', 'Next', 'Avanzar', 'Sii-soco', 'Mus Tom Ntej'),
('goback', 'Go Back', 'Retroceder', 'Dib u Noqo', 'Rov Mus Tom Qab'),
('cancel', 'Cancel', 'Cancelar', 'Tirtir', 'Tso Tseg'),
('review', 'Review Your Answers', 'Revisar sus respuestas', 'Eeg Jawaabahaaga', 'Rov Saib Xyuas Dua Koj Cov Lus Teb'),
('touchToGoBack', 'Touch any question to go back and change your answer.', 'Pulse cualquier pregunta para retroceder y cambiar su respuesta', 'Taabo su’aal kasta si aad dib ugu noqoto oo aad u beddesho jawaabtaada.', 'Nias lo lus nug twg los tau yog koj xav mus rau tom qab thiab hloov koj lo lus teb'),
('submit', 'Submit', 'Completar y enviar encuesta', 'Dir', 'Muab Xa Mus'),
('submitdesc', 'Pressing the Submit button will submit your answers to Aeon and enter you into a drawing for gift cards and one month of free rent. After doing so, please hand this tablet back to the Aeon site manager to receive $10.', 'Sus respuestas serán enviadas al presionar el botón de Enviar. Usted estará participando en una rifa de una tarjeta de regalo y de un mes de alquiler gratis. Después de presionar el botón de Enviar lleve este document al administrador de su
edificio y obtendrá $10. ¡Gracias!','Guji batoonka ‘Submit’ si aad u dirto jawaabahaaga. Markaas waxaa lagugu dari doonaa abaalmarin bakhtiyaa-nasiib ah oo aad ku heli karto kaar hadyad ah iyo hal bil oo kiro bilaash ah. Markaad dirto ee aad gujiso ‘Submit’, warqadda u dhiib maamulaha guriga aad ku nooshahay si laguu siiyo 10 doollar oo ah hadyad. Mahadsanid!', 'Nias lub npov Xa Mus yuab muab koj cov lus teb xa mus. Thiab lawv yuav muab koj tso npe cuv xab laj saib puas tau ib daim npav phaj tshab thiab tau nyob pub dawb tsis them nqi tsev ib lub hlis. Tom qab nias Xa Mus, muab qhov no cev rov
rau koj tus nai saib vaj tse ces koj tau txais $10. Ua tsaug!'),
('howlong1', '1 to 3 months', '1 a 3 meses', '1 illaa 3 bilood', '1 txog 3 hlis'),
('howlong2', '4 to 11 months', '4 a 11 meses', '4 illaa 11 bilood', '4 txog 11 hlis'),
('howlong3', '1 to 3 years', '1 a 3 años', '1 illaa 3 sano', '1 txog 3 xyoos'),
('howlong4', '3 to 5 years', '3 a 5 años', '3 illaa 5 sano', '3 txog 5 xyoos'),
('howlong5', '5+ years', '5+ años', '5+ Sano', '5 xyoos rov sauv'),
('ethnicity1', 'American Indian', 'American Indian', 'Hindi Maraykan', 'Neeg Khab'),
('ethnicity2', 'African Immigrant (Somali, Nigerian, Eritrean, other)', 'Inmigrante de Africa (Somali, Nigerian, Eritrean, otro)', 'Immigrant Afrika (Soomaaliya, Nigeria, Eritrean, kale)', 'Neeg Dub (Tuaj lwm teb chaws tuaj, xws li Xas Mas Lias)'),
('ethnicity3', 'Asian / Pacific Islander', 'Asian / Pacific Islander', 'Aasiyaan / Jasiidlay Baasifik ', 'Neeg Es Xias'),
('ethnicity4', 'Black / African American', 'Negro / African American', 'Madow / Afrikaan Ameerikaan', 'Kheej Dub'),
('ethnicity5', 'Caucasian / White', 'Anglo / Blanco', 'Kookeeshiyaan / Caddaan', 'Neeg Dawb'),
('ethnicity6', 'Hispanic / Latino', 'Hispanic / Latino', 'Hisbaanik / Laatino', 'Neeg Mev'),
('ethnicity7', 'Other', 'Otro', 'Kuwo kale', 'Lwm Yam'),
('gender1', 'Female', 'Mujer', 'Dheddig', 'Poj niam'),
('gender2', 'Male', 'Hombre', 'Lab', 'txiv neej'),
('gender3', 'Self Identify', 'Autoproclamarse', 'Isku aqoonsi', 'Koj xaiv (lwm yam)'),
('age1', 'Under 18', 'Bajo 18', 'Ka yar 18', 'Qis dua 18'),
('age2', '18-25', '18-25', '18-25', '18-25'),
('age3', '26-35', '26-35', '26-35', '26-35'),
('age4', '36-45', '36-45', '36-45', '36-45'),
('age5', '46-55', '46-55', '46-55', '46-55'),
('age6', 'Over 55', 'Más de 55', 'Ka wayn 55', 'tshaj 55'),
('income1', 'Less than $800/mo. (Less than $9,600/yr.)', 'Bajo de $800/mes. (Bajo de $9,600/año.)', 'In ka yar $800/bish. (In ka yar $9,600/san.)', 'Ib hlis tsawg dua $800 (ib xyoos tsawg dua $9,600)'),
('income2', '$801- 1,300/mo. ($9601 - 15,600/yr.)', '$801-1,300/mes. ($9601 - 15,600/año.)', '$801-1,300/bish. ($9601 - 15,600/san.)', 'Ib hlis $801 - $1,300 (ib xyoos $$9,601 - $15,600)'),
('income3', '$1,301-1,800/mo. ($15,601 -21,600/yr.)', '$1,301-1,800/mes. ($15,601 - 21,600/año.)', '$1,301-1,800/bish. ($15,601 - 21,600/san.', 'Ib hlis $1,301 - $1,800 (ib xyoos $15,601 - $$21,600)'),
('income4', '$1,801-2,300/mo. ($21,601-27,600/yr.)', '$1,801-2,300/mes. ($21,601- 27,600/año.)', '$1,801-2,300/bish. ($21,601- 27,600/san.)', 'Ib hlis $1,801 - $2,300 (ib xyoos $21,601 - $27,600)'),
('income5', '$2,301-2,800/mo. ($27,601-33,600/yr.)', '$2,301-2,800/mes. ($27,601-33,600/año.)', '$2,301-2,800/bish. ($27,601-33,600/san.)', 'Ib hlis $2,301 - $2,800 (ib xyoos $27,601 - $33,600)'),
('income6', '$2,801-3,300/mo. ($33,601-39,600/yr.)', '$2,801-3,300/mes. ($33,601- 39,600/año.)', '$2,801-3,300/bish. ($33,601- 39,600/san.)', 'Ib hlis $2,801 - $3,300 (ib xyoos $33,601 - $39,600)'),
('income7', '$3,301-3,800/mo. ($39,601-45,600/yr.)', '$3,301-3,800/mes. ($39,601- 45,600/año.)', '$3,301-3,800/bish. ($39,601- 45,600/san.)', 'Ib hlis $3,301 - $3,800 (ib xyoos $39,601 - $45,600)'),
('income8', 'More than $3,800/mo. (More than 45,600/yr.)', 'Más de $3,800/mes. (Má de 45,600/año.)', 'In ka badan $ 3,800/mo. (In ka badan 45,600/san.)', 'Ib hlis ntau dua $3,800 (ib xyoos ntau dua $45,600)'),
('thanks', 'Thank you – your feedback is very important to us!', 'Gracias.  ¡Nos importa mucho su opinión!', 'Waad mahadsan tahay – jawaabaha aan kaa helno aad bay muhiim noogu yihiin!', 'Ua tsaug - koj cov lus teb no tseem ceeb heev rau peb.'),
('requestresults', 'Summarized results of this confidential survey will be available from Aeon after September 1, upon your request. To request results, call us at 612-746-0520.', 'Los resultados resumidos de este formulario confidencial estarán disponible a partir de Aeon con una petición. Para solicitar los resultados llámenos al 612-746-0520.', 'Natiijada la soo koobay ee ra''yi-ururintan asturnaanta kalsoonida leh ayaa laga heli doonaa Aeon marka alaga codsato. Si aad u codsato natiijada, naga soo wac 612-746-0520.', 'Cov lus uas nej sawv daws teb rau cov lus nug no Aeon yuav muab sau kom tiav log rau hnub 9/1/2019 no.  Yog nej leej twg xav tau ib daim no ces hu tau rau 612 - 746 - 0520.'),
('optional', '(Questions 23-27 are optional)', '(Preguntas 23-27 son opcionales)', '(Su''aalaha 23-27 ayaa ikhtiyaar ah)', '(Cov Lus Nug Nqe 23 - 27 no teb los tau hos tsis teb los tsis ua cas)'),
('intro1', 'Thank you for taking this survey to tell Aeon what it’s like to live in your home. All answers are private and will be combined with everyone else’s answers, so we will not know how you answered each question. You can skip questions or stop the survey at any time. When answering, please think about the past 12 months.', 'Gracias por tomar esta encuesta para contar a Aeon cómo es vivir en su casa.  Todas las respuestas son privadas y las combinarán con las respuestas de los demás.  Por lo tanto, no sabremos cómo usted haya contestado cada pregunta.  Puede brincar preguntas o detener la encuesta en cualquier momento.  Cuando contesta, favor de pensar con respeto a los últimos 12 meses.', 'Waad ku mahadsan tahay in aad ka jawaabto su’aalo qoran oo aad Aeon fikrad uga siineyso nolosha guriga aad deggen tahay. Jawaabaha dadka oo dhan waa kuwa qarsoodi ah oo waa la isu-geyn doonaa, lama ogaan karo sida aad adigu wax uga jawaabtay. Haddii aad rabto su’aalaha kama jawaabeysid ama markii aad rabto ayaad iska joojin kartaa. Marka aad su’aalaha ka jawaabeyso fadlan ka feker 12-kii bilood ee ugu dambeeyey.', 'Ua tsaug uas koj tseem teb cov lus qhia rau Aeon hais tias koj nyob hauv lub tsev no nws ho zoo li cas rau li cas. Koj cov lus teb yuav tsis muab qhia rau leej twg paub li, thiab peb yuav muab xyaw rau lwm leej lwm tus cov lus teb, uas yuav tsis muaj neeg paub hais tias leej twg yog tus teb li cas. Koj teb teb txog tog koj txawm xav tsum los yeej tsum tau li nawb. Thaum koj teb cov lus, koj teb raws li 12 lub hlis dhau los no xwb.'),
('intro2', 'If you have any questions, please talk to your Site Manager or Resident Connections Coordinator. Surveys are available in English, Hmong, Somali, and Spanish. Other languages can be made available, please ask your Site Manager.', 'Si tiene alguna duda, favor de hablar con su gerente de sitio o un coordinador de Conexiones de Residente.  Las encuestas están disponibles en inglés, hmong, somalí y español. Se puede hacer disponibles otros idiomas.  Favor de preguntar a su gerente de sitio.', 'Haddii aad su’aalo ka qabto arrintan, fadlan kala hadal Maamulaha Guriga ama Isku-duwaha Xiriirka Kireystaha. Su’aaluhu waxa ay ku qoran yihiin afafka kala ah Ingiriis, Soomaali, Moong iyo Isbaanish. Luuqad kale qofkii raba waa loogu soo diyaarin karaa, fadlan kala xiriir Maamulaha Guriga.', 'Yog koj muaj lus nug dab tsi no ces nug tus nai saib nej koog tsev no los yog tus nai loj (Resident Connection Coordinator). Cov lus nug no muaj ntau hom lus, xws li: Mis Kas, Hmoob, Xas Mas Lis, thiab Mev. Yog leej twg ho xav yuav lwm hom lus no ces qhia rau nej tus nai saib xyuas vaj tse.'),
('intro3', 'helloEnglish', 'helloSpanish', 'helloSomali', 'helloHmong'),
('survey', 'Home Survey', 'Encuesta de casa', 'Su’aalo Qoran oo ku Saabsan Guriga', 'Lus Nug Txog Tsev'),
('answer1', 'Strongly agree', 'Completamente de acuerdo', 'Aad Baan Ugu Raacsanahay', 'Txaus pom zoo'),
('answer2', 'Agree', 'De acuerdo', 'Waan Ku Raacsanahay', 'Pom zoo'),
('answer3', 'Disagree', 'En desacuerdo', 'Waan Diiddanahay', 'Tsis pom zoo'),
('answer4', 'Strongly disagree', 'Definitivamente en desacuerdo', 'Aad baan u Diiddanahay', 'Txaus tsis pom zoo'),
('logout', 'Logout', 'Cerrar la session','Ka Bax','Tua Tawm Mus'),
('writeanswer', 'Write your answer here.', 'Escriba su respuesta aquí.','Halkan ku qor jawaabtaada.','Sau koj lo lus teb rau ntawm no.'),
('surecancel', 'Are you sure you want to cancel? This cannot be undone.', '¿Está seguro de que quiere cancelar? No podrá recuperar la información.','Ma iska hubtaa in aad joojiso? Arrintan kama noqon kartid.', 'Koj puas xav muab tso tseg tiag? Qhov no rov thim ua dua tsis tau lawm.'),
('suresubmit', 'Are you sure you want to submit?', '¿Está seguro de que quiere completar y enviar? Ya no podrá regresar.','Ma iska hubtaa in aad rabto inaad dirto? Arrintan kama noqon kartid.', 'Koj puas xav muab xa mus tiag? Qhov no rov thim ua dua tsis tau lawm.'),
('list_members', 'Please list the members of your household:', 'Por favor, enumere y mencione cada uno de los miembros de su familia:', 'Fadlan qor macluumaadka qof kasta oo qoyskaaga ka mid ah:', 'Please list the members of your household:'),
('add_household_member', 'Add another household member', 'Añadir otro nombre de la casa', 'Ku dar xubnaha kale ee qoyska', 'Add another household member'),
('name','Name','Nombre','Magac','Name'),
('yes','Yes','Sí','Haa','Yes'),
('no','No','No','Maya','No'),
('military_active','Yes - Active','Sí-Activo','Haa-Ciidanka','Yes - Active'),
('military_veteran','Yes - Veteran','Sí-Veterano','Haa-Hawlgab-ciidan','Yes - Veteran'),
('enter_number','Enter number here.','Ingrese el número aquí','Ku qor lambarka','Enter number here.'),
('remove_household_member','Remove this household member','Eliminar este miembro de la casa','Ka saar xubintan aqalka','Remove this household member'),
('date_of_birth','Date of Birth','Fecha De Nacimiento','Taariikhda Dhalashada','Date of Birth'),
('race_check_all','Race (check all that apply)','Raza (seleccione todas las opciones que correspondan)','Qowmiyadda (Calaamadee dhammaan wixii ku khuseeya)','Race (check all that apply)'),
('race_white','White','Blanco','Caddaan','White'),
('race_black','Black','Negro o Africano Americano','Madoow ama Afrikaanka','Black'),
('race_islander','Native Hawaiian or other Pacific Islander','Nativo de Hawaii o de las Islas del Pacífico','Dhaladka Haawaay ama Jasiiradaha kale','Native Hawaiian or other Pacific Islander'),
('race_asian','Asian','Asiático','Aasiyaan','Asian'),
('race_native','American Indian or Alaskan Native','Indio Americano o Nativo de Alaska','Hindida Mareykanka ama Dhaladka Alaska','American Indian or Alaskan Native'),
('race_other','Other:','Otro:','Qowmiyad kale:','Other:'),
('race_hispanic','Hispanic or Latino','Hispano o Latino','Isbaanish ama Laatiin','Hispanic or Latino'),
('disabled','Disabled','Discapacitado','Naafo','Disabled');

INSERT INTO questions
    (question_number,
    english,
    somali,
    spanish,
    hmong,
    theme,
    year)
VALUES
    (1,
        'I feel safe in my apartment unit.',
        'Waxaan ku dareemaa ammaan abaarmankayga gudahiisa.',
        'Yo siento seguro en mi apartamento.',
        'Nyob hauv kuv chav tsev no, kuv tau luag (tsis ntshai dab tsi).',
        'Safety',
        2019),
    (2,
        'I feel safe in the public areas inside my building (outside my apartment unit).',
        'Waxaan ku dareemaa ammaan goobaha dadwaynaha ee ku dhex yaal dhismahayga (ee ka baxsan abaarmankayga).',
        'Yo siento seguro es los lugares públicos adentro mi edifico (y fuera mis cuartos de apartamento).',
        'Nyob sab hauv lub tsev loj loj no, kuv tau luag (tawm ntawm kuv lub qhov rooj sab nrauv).',
        'Safety',
        2019),
    (3,
        'I feel safe in outdoor areas near my building.',
        'Waxaan ku dareemaa ammaan goobaha bannaanka ee u dhow dhismahayga.',
        'Yo siento seguro en los lugares para afuera que son cerca de mi edificio.',
        'Nyob ib ncig sab nraum zoov kuv tau luag.',
        'Safety',
        2019),
    (4,
        'I feel safe in the neighborhood in which I live.',
        'Waxaan ku dareemaa ammaan xaafadda aan ku noolahay.',
        'Yo siento seguro en el barrio en donde vivo.',
        'Ib ncig ze ntawm peb lub tsev no, kuv tau luag.',
        'Safety',
        2019),
    (5,
        'I help take care of my building.',
        'Waxaan gacan ka geystaa daryeelka dhismahayga.',
        'Yo ayudo cuidar de mi edificio.',
        'Kuv yeej pab tu peb lub tsev no thiab.',
        'Engagement',
        2019),
    (6,
        'I report problems in my apartment ',
        'Waxaan uga warbixiyaa dhibaatooyinka ka jira abaarmankayga maamulaha goobta.',
        'Yo informo problemas en mis cuartos al manager de mi sitio.',
        'Yog kuv chav tsev muaj teeb meem dab tsi, kuv yuav qhia rau tus saib xyuas lub tsev no.',
        'Engagement',
        2019),
    (7,
        'I report problems in my building to my site manager or the police.',
        'Waxaan uga warbixiyaa dhibaatooyinka ka jira dhismahayga maamulaha goobta ama booliska.',
        'Yo informo problemas en mi edificio al manager del sitio o la policía.',
        'Yog muaj teeb meem rau peb lub tsev no, kuv yuav qhia rau tus saib xyuas los yog tub ceev xwm.',
        'Engagement',
        2019),
    (8,
        'I avoid talking to other people in my building.',
        'Waxaan iska ilaaliyaa inaan la hadalo dadka kale ee dhismahayga.',
        'Yo evito hablar con otras personas en mi edificio.',
        'Kuv zam kom dhau thiab tsis nrog lwm tus neeg xauj tsev hauv no sib tham.',
        'Engagement',
        2019),
    (9,
        'I help my neighbors in my building.',
        'Waan caawiyaa deriskayga ku nool dhismahayga.',
        'Yo ayudo mis vecinos en mi edifico.',
        'Kuv pab lwm tus neeg uas xauj tsev nyob hauv lub tsev loj loj no. git stat',
        'Engagement',
        2019),
    (10,
        'I participate in events in my building.',
        'Waxaan ka qayb qaataa dhacdooyinka ka jira dhismahayga.',
        'Yo participo en los eventos en mi edificio.',
        'Yog hauv lub tsev loj loj no muaj sib tham tej ntawd, kuv kam koom thiab.',
        'Engagement',
        2019),
    (11,
        'I participate in events in my neighborhood.',
        'Waxaan ka qayb qaataa dhacdooyinka ka jira xaafaddayda.',
        'Yo participo en los eventos en mi vecindad.',
        'Yog cov neeg nyob ib ncig no muaj sib tham ntej ntawd, kuv kam koom thiab.',
        'Engagement',
        2019),
    (12,
        'I help my building or community.',
        'Waan caawiyaa dhismahayga ama beeshayda.',
        'Yo ayudo mi comunidad.',
        'Kuv pab cov neeg hauv peb lub tsev no, thiab pab cov neeg hauv zej zog no tib si.',
        'Engagement',
        2019),
    (13,
        'I talk to five or more of my neighbors every week.',
        'Waxaan la hadlaa shan ama in ka badan dadka dariskayga ah toddobaad kasta.',
        'Yo hablo con cinco o más de mis vecinos cada semana.',
        'Ib lub as thiv twg, kuv nrog yam tsawg kawg tsib (5) tug neeg uas nyob hauv lub tsev no sib tham.',
        'Engagement',
        2019),
    (14,
        'I have decorated or personalized my apartment unit.',
        'Waan qurxistay oo aan si gaar u sharraxday abaarmankayga.',
        'Yo he personalizado o decorado mi apartamento.',
        'Kuv muab kuv chav tsev no lo ub lo no los yog tu kom zoo nkauj raws li kuv nyiam.',
        'Ownership',
        2019),
    (15,
        'I feel proud of my apartment unit.',
        'Waxaan ku dareemaa sharaf abaarmankayga.',
        'Yo siento orgulloso de mi apartamento.',
        'Kuv zoo siab hlo rau kuv chav tsev.',
        'Ownership',
        2019),
    (16,
        'The overall condition of my apartment unit is excellent.',
        'Xaaladda guud ee abaarmankaygu waa heer sare.',
        'La condición general de mi apartamento esta excelente.',
        'Kuv chav tsev no huv si thiab zoo heev.',
        'Staff Performance',
        2019),
    (17,
        'Overall professionalism of staff and quality of customer service is excellent.',
        'Dhaqanka guud ee xirfadyaqaanimada shaqaalaha iyo tayada adeegga macaamiisha ayaa heer sare ah.',
        'El profesionalismo general del personal y calidad del servicio a la atención de cliente esta excelente.',
        'Cov neeg ua hauj lwm saib xyuas peb lub tsev no yog neeg txawj ntse thiab coj zoo heev.',
        'Staff Performance',
        2019),
    (18,
        'The overall condition of my apartment building is excellent.',
        'Xaaladda guud ee dhismaha abaarmankayga ayaa heer sare ah.',
        'La condición general de mi edifico esta excelente.',
        'Peb lub tsev loj loj no tshiab, huv, thiab zoo heev.',
        'Staff Performance',
        2019),
    (19,
        'My apartment unit feels like home.',
        'Abaarmankayga ayaa ka dareemaa meel hoy ii ah.',
        'is cuartos de apartamento sientan como un hogar.',
        'Chav tsev uas kuv xauj no, kuv yeej nyiam thiab saib tam nkaus li yog kuv lub tsev tiag tiag ntag.',
        'Theme Not Known',
        2019),
    (20,
        'I would recommend this apartment building to others.',
        'Anigu waxaan kula talin dadka kale dhismahan. abaarman inay soo degaan.',
        'Yo recomendaría este edificio de cuartos a otras personas.',
        'Kuv yeej xav qhia lwm tus neeg hais tias lub tsev no zoo thiab kom lawv los xauj nyob.',
        'Ownership',
        2019),
    (21,
        'What makes your apartment feel like home?',
        'Maxaa ka dhiga in hoy laga dareemo abaarmankaaga?',
        '¿Qué hace sentir tu apartamento como un hogar?',
        'Yam twg uas yog yam ua rau koj nyiam lub tsev no thiab saib zoo tam li yog koj lub tsev tiag tiag?',
        'Theme Not Known',
        2019),
    (22,
        'What could be done to make your apartment more like home?',
        'Maxaa ah in lagu kaco si looga dhigo abaarmaankaaga hoy kuu habboon?',
        '¿Qué puede hacer para poner tu apartamento más como un hogar?',
        'Tshuav dab tsi thiab uas koj xav kom peb ua es koj thiaj saib lub tsev no li yog koj lub tiag tiag?',
        'Theme Not Known',
        2019),
    (23,
        'How long have you been a resident at this apartment building?',
        'Muddo intee le''eg ayaad deggenayd dhismahan abaarman?',
        '¿Por cuanto tiempo ha sido Usted un residente de este edificio?',
        'Koj twb los xauj lub tsev no nyob tau ntev li cas los lawm?',
        'Demographics',
        2019),
    (24,
        'Please select the category that best describes your ethnicity:',
        'Xulo qaybta sida ugu fiican u qeexeysa qoymiyaddaada:',
        'Por favor elige la categoría que describe tu etnicidad mejor:',
        'Qhia seb koj yog haiv neeg dab tsi:',
        'Demographics',
        2019),
    (25,
        'Gender',
        'Jinsi:',
        'Género:',
        'Koj Yog Poj Niam Los Txiv Neej',
        'Demographics',
        2019),
    (26,
        'Age',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Demographics',
        2019),
    (27,
        'Your household income is:',
        'Dakhliga reerkaagu waa:',
        'Su ingreso del hogar es:',
        'Nej tsev neeg khwv tau nyiaj:',
        'Demographics',
        2019),
    (28,
        'Name of head of household:',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (29,
        'How many people are in your household and live in your apartment?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (30,
        'Does any member of your household speak English as a second language or not speak English?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (31,
        'If yes, primary language is:',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (32,
        'Is any household member an active member or veteran of the U. S. military?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (33,
        'Have you or your household experienced homelessness in the past?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019),
    (34,
        'What is the amount of your household’s annual income?',
        'Da''da:',
        'Edad:',
        'Hnub nyoog',
        'Household',
        2019);