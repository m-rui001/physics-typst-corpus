// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 2.50cm, right: 2.50cm, top: 2.03cm, bottom: 1.92cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.13em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show figure.where(kind: table): set figure.caption(position: top)
#set math.equation(numbering: "(1)", supplement: none)
#show table: set text(size: 9pt)


#align(center)[
  #text(17pt, weight: "bold")[Sub-percent Precision Measurement of Neutrino Oscillation Parameters with JUNO]
]

#v(1em)
#align(center)[
  #text(size: 12pt)[Angel Abusleme#super[5,41], Thomas Adam#super[46], Shakeel Ahmad#super[67], Rizwan Ahmed#super[67], Sebastiano Aiello#super[56], Muhammad Akram#super[67], Abid Aleem#super[67], Tsagkarakis Alexandros#super[49], Fengpeng An#super[29], Qi An#super[22], Giuseppe Andronico#super[56], Nikolay Anfimov#super[68], Vito Antonelli#super[58], Tatiana Antoshkina#super[68], Burin Asavapibhop#super[72], João Pedro Athayde Marcondes de André#super[46], Didier Auguste#super[44], Weidong Bai#super[20], Nikita Balashov#super[68], Wander Baldini#super[57], Andrea Barresi#super[59], Davide Basilico#super[58], Eric Baussan#super[46], Marco Bellato#super[61], Antonio Bergnoli#super[61], Thilo Birkenfeld#super[49], Sylvie Blin#super[44], David Blum#super[55], Simon Blyth#super[10], Anastasia Bolshakova#super[68], Mathieu Bongrand#super[48], Clément Bordereau#super[45,40], Dominique Breton#super[44], Augusto Brigatti#super[58], Riccardo Brugnera#super[62], Riccardo Bruno#super[56], Antonio Budano#super[65], Jose Busto#super[47], Ilya Butorov#super[68], Anatael Cabrera#super[44], Barbara Caccianiga#super[58], Hao Cai#super[34], Xiao Cai#super[10], Yanke Cai#super[10], Zhiyan Cai#super[10], Riccardo Callegari#super[62], Antonio Cammi#super[60], Agustin Campeny#super[5], Chuanya Cao#super[10], Guofu Cao#super[10], Jun Cao#super[10], Rossella Caruso#super[56], Cédric Cerna#super[45], Chi Chan#super[38], Jinfan Chang#super[10], Yun Chang#super[39], Guoming Chen#super[28], Pingping Chen#super[18], Po-An Chen#super[40], Shaomin Chen#super[13], Xurong Chen#super[26], Yixue Chen#super[11], Yu Chen#super[20], Zhiyuan Chen#super[10], Zikang Chen#super[20], Jie Cheng#super[11], Yaping Cheng#super[7], Yu Chin Cheng#super[40], Alexey Chetverikov#super[68], Davide Chiesa#super[59], Pietro Chimenti#super[3], Artem Chukanov#super[68], Gérard Claverie#super[45], Catia Clementi#super[63], Barbara Clerbaux#super[2], Selma Conforti Di Lorenzo#super[45], Daniele Corti#super[61], Flavio Dal Corso#super[61], Olivia Dalager#super[75], Christophe De La Taille#super[45], Zhi Deng#super[13], Ziyan Deng#super[10], Wilfried Depnering#super[52], Marco Diaz#super[5], Xuefeng Ding#super[58], Yayun Ding#super[10], Bayu Dirgantara#super[74], Sergey Dmitrievsky#super[68], Tadeas Dohnal#super[42], Dmitry Dolzhikov#super[68], Georgy Donchenko#super[70], Jianmeng Dong#super[13], Evgeny Doroshkevich#super[69], Marcos Dracos#super[46], Frédéric Druillole#super[45], Ran Du#super[10], Shuxian Du#super[37], Stefano Dusini#super[61], Martin Dvorak#super[42], Timo Enqvist#super[43], Heike Enzmann#super[52], Andrea Fabbri#super[65], Donghua Fan#super[24], Lei Fan#super[10], Jian Fang#super[10], Wenxing Fang#super[10], Marco Fargetta#super[56], Dmitry Fedoseev#super[68], Zhengyong Fei#super[10], Li-Cheng Feng#super[38], Qichun Feng#super[21], Richard Ford#super[58], Amélie Fournier#super[45], Haonan Gan#super[32], Feng Gao#super[49], Alberto Garfagnini#super[62], Arsenii Gavrikov#super[68], Marco Giammarchi#super[58], Nunzio Giudice#super[56], Maxim Gonchar#super[68], Guanghua Gong#super[13], Hui Gong#super[13], Yuri Gornushkin#super[68], Alexandre Göttel#super[51,49], Marco Grassi#super[62], Vasily Gromov#super[68], Minghao Gu#super[10], Xiaofei Gu#super[37], Yu Gu#super[19], Mengyun Guan#super[10], Yuduo Guan#super[10], Nunzio Guardone#super[56], Cong Guo#super[10], Jingyuan Guo#super[20], Wanlei Guo#super[10], Xinheng Guo#super[8], Yuhang Guo#super[35], Paul Hackspacher#super[52], Caren Hagner#super[50], Ran Han#super[7], Yang Han#super[20], Miao He#super[10], Wei He#super[10], Tobias Heinz#super[55], Patrick Hellmuth#super[45], Yuekun Heng#super[10], Rafael Herrera#super[5], YuenKeung Hor#super[20], Shaojing Hou#super[10], Yee Hsiung#super[40], Bei-Zhen Hu#super[40], Hang Hu#super[20], Jianrun Hu#super[10], Jun Hu#super[10], Shouyang Hu#super[9], Tao Hu#super[10], Yuxiang Hu#super[10], Zhuojun Hu#super[20], Guihong Huang#super[24], Hanxiong Huang#super[9], Kaixuan Huang#super[20], Wenhao Huang#super[25], Xin Huang#super[10], Xingtao Huang#super[25], Yongbo Huang#super[28], Jiaqi Hui#super[30], Lei Huo#super[21], Wenju Huo#super[22], Cédric Huss#super[45], Safeer Hussain#super[67], Ara Ioannisian#super[1], Roberto Isocrate#super[61], Beatrice Jelmini#super[62], Ignacio Jeria#super[5], Xiaolu Ji#super[10], Huihui Jia#super[33], Junji Jia#super[34], Siyu Jian#super[9], Di Jiang#super[22], Wei Jiang#super[10], Xiaoshan Jiang#super[10], Xiaoping Jing#super[10], Cécile Jollet#super[45], Jari Joutsenvaara#super[43], Leonidas Kalousis#super[46], Philipp Kampmann#super[54,51], Li Kang#super[18], Rebin Karaparambil#super[48], Narine Kazarian#super[1], Amina Khatun#super[71], Khanchai Khosonthongkee#super[74], Denis Korablev#super[68], Konstantin Kouzakov#super[70], Alexey Krasnoperov#super[68], Nikolay Kutovskiy#super[68], Pasi Kuusiniemi#super[43], Tobias Lachenmaier#super[55], Cecilia Landini#super[58], Sébastien Leblanc#super[45], Victor Lebrin#super[48], Frederic Lefevre#super[48], Ruiting Lei#super[18], Rupert Leitner#super[42], Jason Leung#super[38], Daozheng Li#super[10], Demin Li#super[37], Fei Li#super[10], Fule Li#super[13], Gaosong Li#super[10], Huiling Li#super[10], Mengzhao Li#super[10], Min Li#super[10], Nan Li#super[10], Nan Li#super[16], Qingjiang Li#super[16], Ruhui Li#super[10], Rui Li#super[30], Shanfeng Li#super[18], Tao Li#super[20], Teng Li#super[25], Weidong Li#super[10,14], Weiguo Li#super[10], Xiaomei Li#super[9], Xiaonan Li#super[10], Xinglong Li#super[9], Yi Li#super[18], Yichen Li#super[10], Yufeng Li#super[10], Zepeng Li#super[10], Zhaohan Li#super[10], Zhibing Li#super[20], Ziyuan Li#super[20], Zonghai Li#super[34], Hao Liang#super[9], Hao Liang#super[22], Jiajun Liao#super[20], Ayut Limphirat#super[74], Guey-Lin Lin#super[38], Shengxin Lin#super[18], Tao Lin#super[10], Jiajie Ling#super[20], Ivano Lippi#super[61], Fang Liu#super[11], Haidong Liu#super[37], Haotian Liu#super[34], Hongbang Liu#super[28], Hongjuan Liu#super[23], Hongtao Liu#super[20], Hui Liu#super[19], Jianglai Liu#super[30,31], Jinchang Liu#super[10], Min Liu#super[23], Qian Liu#super[14], Qin Liu#super[22], Runxuan Liu#super[51,49], Shubin Liu#super[22], Shulin Liu#super[10], Xiaowei Liu#super[20], Xiwen Liu#super[28], Yan Liu#super[10], Yunzhe Liu#super[10], Alexey Lokhov#super[70,69], Paolo Lombardi#super[58], Claudio Lombardo#super[56], Kai Loo#super[52], Chuan Lu#super[32], Haoqi Lu#super[10], Jingbin Lu#super[15], Junguang Lu#super[10], Shuxiang Lu#super[37], Bayarto Lubsandorzhiev#super[69], Sultim Lubsandorzhiev#super[69], Livia Ludhova#super[51,49], Arslan Lukanov#super[69], Daibin Luo#super[10], Fengjiao Luo#super[23], Guang Luo#super[20], Shu Luo#super[36], Wuming Luo#super[10], Xiaojie Luo#super[10], Vladimir Lyashuk#super[69], Bangzheng Ma#super[25], Bing Ma#super[37], Qiumei Ma#super[10], Si Ma#super[10], Xiaoyan Ma#super[10], Xubo Ma#super[11], Jihane Maalmi#super[44], Jingyu Mai#super[20], Yury Malyshkin#super[68], Roberto Carlos Mandujano#super[75], Fabio Mantovani#super[57], Francesco Manzali#super[62], Xin Mao#super[7], Yajun Mao#super[12], Stefano M. Mari#super[65], Filippo Marini#super[62], Cristina Martellini#super[65], Gisele Martin-Chassard#super[44], Agnese Martini#super[64], Matthias Mayer#super[53], Davit Mayilyan#super[1], Ints Mednieks#super[66], Artur Meinusch#super[52], Yue Meng#super[30], Anselmo Meregaglia#super[45], Emanuela Meroni#super[58], David Meyhöfer#super[50], Mauro Mezzetto#super[61], Jonathan Miller#super[6], Lino Miramonti#super[58], Marta Colomer Molla#super[2], Paolo Montini#super[65], Michele Montuschi#super[57], Axel Müller#super[55], Massimiliano Nastasi#super[59], Dmitry V. Naumov#super[68], Elena Naumova#super[68], Diana Navas-Nicolas#super[44], Igor Nemchenok#super[68], Minh Thuan Nguyen Thi#super[38], Feipeng Ning#super[10], Zhe Ning#super[10], Hiroshi Nunokawa#super[4], Lothar Oberauer#super[53], Juan Pedro Ochoa-Ricoux#super[75,5,41], Alexander Olshevskiy#super[68], Domizia Orestano#super[65], Fausto Ortica#super[63], Rainer Othegraven#super[52], Alessandro Paoloni#super[64], Sergio Parmeggiano#super[58], Yatian Pei#super[10], Luca Pelicci#super[51,49], Nicomede Pelliccia#super[63], Anguo Peng#super[23], Haiping Peng#super[22], Yu Peng#super[10], Zhaoyuan Peng#super[10], Frédéric Perrot#super[45], Pierre-Alexandre Petitjean#super[2], Fabrizio Petrucci#super[65], Oliver Pilarczyk#super[52], Luis Felipe Piñeres Rico#super[46], Artyom Popov#super[70], Pascal Poussot#super[46], Ezio Previtali#super[59], Fazhi Qi#super[10], Ming Qi#super[27], Sen Qian#super[10], Xiaohui Qian#super[10], Zhen Qian#super[20], Hao Qiao#super[12], Zhonghua Qin#super[10], Shoukang Qiu#super[23], Gioacchino Ranucci#super[58], Neill Raper#super[20], Reem Rasheed#super[45], Alessandra Re#super[58], Henning Rebber#super[50], Abdel Rebii#super[45], Mariia Redchuk#super[61], Bin Ren#super[18], Jie Ren#super[9], Barbara Ricci#super[57], Mariam Rifai#super[51,49], Mathieu Roche#super[45], Narongkiat Rodphai#super[72], Aldo Romani#super[63], Bedřich Roskovec#super[42], Xichao Ruan#super[9], Arseniy Rybnikov#super[68], Andrey Sadovsky#super[68], Paolo Saggese#super[58], Simone Sanfilippo#super[65], Anut Sangka#super[73], Utane Sawangwit#super[73], Julia Sawatzki#super[53], Michaela Schever#super[51,49], Cédric Schwab#super[46], Konstantin Schweizer#super[53], Alexandr Selyunin#super[68], Andrea Serafini#super[62], Giulio Settanta#super[51], Mariangela Settimo#super[48], Zhuang Shao#super[35], Vladislav Sharov#super[68], Arina Shaydurova#super[68], Jingyan Shi#super[10], Yanan Shi#super[10], Vitaly Shutov#super[68], Andrey Sidorenkov#super[69], Fedor Šimkovic#super[71], Chiara Sirignano#super[62], Jaruchit Siripak#super[74], Monica Sisti#super[59], Maciej Slupecki#super[43], Mikhail Smirnov#super[20], Oleg Smirnov#super[68], Thiago Sogo-Bezerra#super[48], Sergey Sokolov#super[68], Julanan Songwadhana#super[74], Boonrucksar Soonthornthum#super[73], Albert Sotnikov#super[68], Ondřej Šrámek#super[42], Warintorn Sreethawong#super[74], Achim Stahl#super[49], Luca Stanco#super[61], Konstantin Stankevich#super[70], Dušan Štefánik#super[71], Hans Steiger#super[52,53], Jochen Steinmann#super[49], Tobias Sterr#super[55], Matthias Raphael Stock#super[53], Virginia Strati#super[57], Alexander Studenikin#super[70], Jun Su#super[20], Shifeng Sun#super[11], Xilei Sun#super[10], Yongjie Sun#super[22], Yongzhao Sun#super[10], Zhengyang Sun#super[30], Narumon Suwonjandee#super[72], Michal Szelezniak#super[46], Jian Tang#super[20], Qiang Tang#super[20], Quan Tang#super[23], Xiao Tang#super[10], Vidhya Thara Hariharan#super[50], Eric Theisen#super[52], Alexander Tietzsch#super[55], Igor Tkachev#super[69], Tomas Tmej#super[42], Marco Danilo Claudio Torri#super[58], Konstantin Treskov#super[68], Andrea Triossi#super[62], Giancarlo Troni#super[5], Wladyslaw Trzaska#super[43], Cristina Tuve#super[56], Nikita Ushakov#super[69], Vadim Vedin#super[66], Giuseppe Verde#super[56], Maxim Vialkov#super[70], Benoit Viaud#super[48], Cornelius Moritz Vollbrecht#super[51,49], Cristina Volpe#super[44], Katharina Von Sturm#super[62], Vit Vorobel#super[42], Dmitriy Voronin#super[69], Lucia Votano#super[64], Pablo Walker#super[5,41], Caishen Wang#super[18], Chung-Hsiang Wang#super[39], En Wang#super[37], Guoli Wang#super[21], Jian Wang#super[22], Jun Wang#super[20], Lu Wang#super[10], Meifen Wang#super[10], Meng Wang#super[23], Meng Wang#super[25], Ruiguang Wang#super[10], Siguang Wang#super[12], Wei Wang#super[27], Wei Wang#super[20], Wenshuai Wang#super[10], Xi Wang#super[16], Xiangyue Wang#super[20], Yangfu Wang#super[10], Yaoguang Wang#super[10], Yi Wang#super[13], Yi Wang#super[24], Yifang Wang#super[10], Yuanqing Wang#super[13], Yuman Wang#super[27], Zhe Wang#super[13], Zheng Wang#super[10], Zhimin Wang#super[10], Zongyi Wang#super[13], Apimook Watcharangkool#super[73], Wei Wei#super[10], Wei Wei#super[25], Wenlu Wei#super[10], Yadong Wei#super[18], Kaile Wen#super[10], Liangjian Wen#super[10], Christopher Wiebusch#super[49], Steven Chan-Fai Wong#super[20], Bjoern Wonsak#super[50], Diru Wu#super[10], Qun Wu#super[25], Zhi Wu#super[10], Michael Wurm#super[52], Jacques Wurtz#super[46], Christian Wysotzki#super[49], Yufei Xi#super[32], Dongmei Xia#super[17], Xiang Xiao#super[20], Xiaochuan Xie#super[28], Yuguang Xie#super[10], Zhangquan Xie#super[10], Zhao Xin#super[10], Zhizhong Xing#super[10], Benda Xu#super[13], Cheng Xu#super[23], Donglian Xu#super[31,30], Fanrong Xu#super[19], Hangkun Xu#super[10], Jilei Xu#super[10], Jing Xu#super[8], Meihang Xu#super[10], Yin Xu#super[33], Baojun Yan#super[10], Taylor Yan#super[74], Wenqi Yan#super[10], Xiongbo Yan#super[10], Yupeng Yan#super[74], Changgen Yang#super[10], Chengfeng Yang#super[28], Huan Yang#super[10], Jie Yang#super[37], Lei Yang#super[18], Xiaoyu Yang#super[10], Yifan Yang#super[10], Yifan Yang#super[2], Haifeng Yao#super[10], Jiaxuan Ye#super[10], Mei Ye#super[10], Ziping Ye#super[31], Frédéric Yermia#super[48], Na Yin#super[25], Zhengyun You#super[20], Boxiang Yu#super[10], Chiye Yu#super[18], Chunxu Yu#super[33], Hongzhao Yu#super[20], Miao Yu#super[34], Xianghui Yu#super[33], Zeyuan Yu#super[10], Zezhong Yu#super[10], Cenxi Yuan#super[20], Chengzhuo Yuan#super[10], Ying Yuan#super[12], Zhenxiong Yuan#super[13], Baobiao Yue#super[20], Noman Zafar#super[67], Vitalii Zavadskyi#super[68], Shan Zeng#super[10], Tingxuan Zeng#super[10], Yuda Zeng#super[20], Liang Zhan#super[10], Aiqiang Zhang#super[13], Bin Zhang#super[37], Binting Zhang#super[10], Feiyang Zhang#super[30], Guoqing Zhang#super[10], Honghao Zhang#super[20], Jialiang Zhang#super[27], Jiawen Zhang#super[10], Jie Zhang#super[10], Jin Zhang#super[28], Jingbo Zhang#super[21], Jinnan Zhang#super[10], Mohan Zhang#super[10], Peng Zhang#super[10], Qingmin Zhang#super[35], Shiqi Zhang#super[20], Shu Zhang#super[20], Tao Zhang#super[30], Xiaomei Zhang#super[10], Xin Zhang#super[10], Xuantong Zhang#super[10], Xueyao Zhang#super[25], Yinhong Zhang#super[10], Yiyu Zhang#super[10], Yongpeng Zhang#super[10], Yu Zhang#super[10], Yuanyuan Zhang#super[30], Yumei Zhang#super[20], Zhenyu Zhang#super[34], Zhijian Zhang#super[18], Fengyi Zhao#super[26], Jie Zhao#super[10], Rong Zhao#super[20], Runze Zhao#super[10], Shujun Zhao#super[37], Dongqin Zheng#super[19], Hua Zheng#super[18], Yangheng Zheng#super[14], Weirong Zhong#super[19], Jing Zhou#super[9], Li Zhou#super[10], Nan Zhou#super[22], Shun Zhou#super[10], Tong Zhou#super[10], Xiang Zhou#super[34], Jiang Zhu#super[20], Jingsen Zhu#super[29], Kangfu Zhu#super[35], Kejun Zhu#super[10], Zhihang Zhu#super[10], Bo Zhuang#super[10], Honglin Zhuang#super[10], Liang Zong#super[13], Jiaheng Zou#super[10]]
]
#v(0.8em)
#text(size: 8pt)[#super[1] Yerevan Physics Institute, Yerevan, Armenia \
  #super[2] Université Libre de Bruxelles, Brussels, Belgium \
  #super[3] Universidade Estadual de Londrina, Londrina, Brazil \
  #super[4] Pontificia Universidade Catolica do Rio de Janeiro, Rio de Janeiro, Brazil \
  #super[5] Pontificia Universidad Católica de Chile, Santiago, Chile \
  #super[6] Universidad Tecnica Federico Santa Maria, Valparaiso, Chile \
  #super[7] Beijing Institute of Spacecraft Environment Engineering, Beijing, China \
  #super[8] Beijing Normal University, Beijing, China \
  #super[9] China Institute of Atomic Energy, Beijing, China \
  #super[10] Institute of High Energy Physics, Beijing, China \
  #super[11] North China Electric Power University, Beijing, China \
  #super[12] School of Physics, Peking University, Beijing, China \
  #super[13] Tsinghua University, Beijing, China \
  #super[14] University of Chinese Academy of Sciences, Beijing, China \
  #super[15] Jilin University, Changchun, China \
  #super[16] College of Electronic Science and Engineering, National University of Defense Technology, Changsha, China \
  #super[17] Chongqing University, Chongqing, China \
  #super[18] Dongguan University of Technology, Dongguan, China \
  #super[19] Jinan University, Guangzhou, China \
  #super[20] Sun Yat-Sen University, Guangzhou, China \
  #super[21] Harbin Institute of Technology, Harbin, China \
  #super[22] University of Science and Technology of China, Hefei, China \
  #super[23] The Radiochemistry and Nuclear Chemistry Group in University of South China, Hengyang, China \
  #super[24] Wuyi University, Jiangmen, China \
  #super[25] Shandong University, Jinan, China, and Key Laboratory of Particle Physics and Particle Irradiation of Ministry of Education, Shandong University, Qingdao, China \
  #super[26] Institute of Modern Physics, Chinese Academy of Sciences, Lanzhou, China \
  #super[27] Nanjing University, Nanjing, China \
  #super[28] Guangxi University, Nanning, China \
  #super[29] East China University of Science and Technology, Shanghai, China \
  #super[30] School of Physics and Astronomy, Shanghai Jiao Tong University, Shanghai, China \
  #super[31] Tsung-Dao Lee Institute, Shanghai Jiao Tong University, Shanghai, China \
  #super[32] Institute of Hydrogeology and Environmental Geology, Chinese Academy of Geological Sciences, Shijiazhuang, China \
  #super[33] Nankai University, Tianjin, China \
  #super[34] Wuhan University, Wuhan, China \
  #super[35] Xi'an Jiaotong University, Xi'an, China \
  #super[36] Xiamen University, Xiamen, China \
  #super[37] School of Physics and Microelectronics, Zhengzhou University, Zhengzhou, China \
  #super[38] Institute of Physics, National Yang Ming Chiao Tung University, Hsinchu \
  #super[39] National United University, Miao-Li \
  #super[40] Department of Physics, National Taiwan University, Taipei \
  #super[41] Millennium Institute for SubAtomic Physics at the High-energy Frontier (SAPHIR), Chile \
  #super[42] Charles University, Faculty of Mathematics and Physics, Prague, Czech Republic \
  #super[43] University of Jyvaskyla, Department of Physics, Jyvaskyla, Finland \
  #super[44] IJCLab, Université Paris-Saclay, CNRS/IN2P3, 91405 Orsay, France \
  #super[45] Univ. Bordeaux, CNRS, LP2i Bordeaux, UMR 5797, F-33170 Gradignan, France \
  #super[46] IPHC, Université de Strasbourg, CNRS/IN2P3, F-67037 Strasbourg, France \
  #super[47] Centre de Physique des Particules de Marseille, Marseille, France \
  #super[48] SUBATECH, Université de Nantes, IMT Atlantique, CNRS-IN2P3, Nantes, France \
  #super[49] III. Physikalisches Institut B, RWTH Aachen University, Aachen, Germany \
  #super[50] Institute of Experimental Physics, University of Hamburg, Hamburg, Germany \
  #super[51] Forschungszentrum Jülich GmbH, Nuclear Physics Institute IKP-2, Jülich, Germany \
  #super[52] Institute of Physics and EC PRISMA#super[+], Johannes Gutenberg Universität Mainz, Mainz, Germany \
  #super[53] Technische Universität München, München, Germany \
  #super[54] GSI Helmholtzzentrum für Schwerionenforschung, Planckstrasse 1, D-64291 Darmstadt, Germany \
  #super[55] Eberhard Karls Universität Tübingen, Physikalisches Institut, Tübingen, Germany \
  #super[56] INFN Catania and Dipartimento di Fisica e Astronomia dell Università di Catania, Catania, Italy \
  #super[57] Department of Physics and Earth Science, University of Ferrara and INFN Sezione di Ferrara, Ferrara, Italy \
  #super[58] INFN Sezione di Milano and Dipartimento di Fisica dell Università di Milano, Milano, Italy \
  #super[59] INFN Milano Bicocca and University of Milano Bicocca, Milano, Italy \
  #super[60] INFN Milano Bicocca and Politecnico of Milano, Milano, Italy \
  #super[61] INFN Sezione di Padova, Padova, Italy \
  #super[62] Dipartimento di Fisica e Astronomia dell'Università di Padova and INFN Sezione di Padova, Padova, Italy \
  #super[63] INFN Sezione di Perugia and Dipartimento di Chimica, Biologia e Biotecnologie dell'Università di Perugia, Perugia, Italy \
  #super[64] Laboratori Nazionali di Frascati dell'INFN, Roma, Italy \
  #super[65] University of Roma Tre and INFN Sezione Roma Tre, Roma, Italy \
  #super[66] Institute of Electronics and Computer Science, Riga, Latvia \
  #super[67] Pakistan Institute of Nuclear Science and Technology, Islamabad, Pakistan \
  #super[68] Joint Institute for Nuclear Research, Dubna, Russia \
  #super[69] Institute for Nuclear Research of the Russian Academy of Sciences, Moscow, Russia \
  #super[70] Lomonosov Moscow State University, Moscow, Russia \
  #super[71] Comenius University Bratislava, Faculty of Mathematics, Physics and Informatics, Bratislava, Slovakia \
  #super[72] Department of Physics, Faculty of Science, Chulalongkorn University, Bangkok, Thailand \
  #super[73] National Astronomical Research Institute of Thailand, Chiang Mai, Thailand \
  #super[74] Suranaree University of Technology, Nakhon Ratchasima, Thailand \
  #super[75] Department of Physics and Astronomy, University of California, Irvine, California, USA]
#v(1.6em)
#v(1.6em)


#v(1.2em)


JUNO is a multi-purpose neutrino observatory under construction in the south of China. This publication presents new sensitivity estimates for the measurement of the $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ oscillation parameters using reactor antineutrinos, which is one of the primary physics goals of the experiment. The sensitivities are obtained using the best knowledge available to date on the location and overburden of the experimental site, the nuclear reactors in the surrounding area and beyond, the detector response uncertainties, and the reactor antineutrino spectral shape constraints expected from the TAO satellite detector. It is found that the $Delta m_31^2$, $Delta m_21^2$, and $sin^2 theta_12$ oscillation parameters will be determined to better than 0.5\% precision in six years of data collection, which represents approximately an order of magnitude improvement over existing constraints.


*Keywords:* neutrino oscillation, reactor antineutrino, precision measurement, JUNO


= Introduction
<introduction>


Neutrinos have provided us with the first direct evidence of physics beyond the Standard Model (SM) of elementary particles, and the study of their properties stands as one of the most active directions within particle physics. First detected by Reines and Cowan in 1956 @Cowan:1992xc, these particles were discovered to oscillate roughly four decades later@Kajita:2016cak @McDonald:2016ixn, an unambiguous sign that they are massive and that the SM needs to be modified.


The phenomenology of neutrino oscillations granted elegant solutions to the solar neutrino @SNO:2002tuh and atmospheric neutrino @Super-Kamiokande:1998kpq anomalies through the transformation of electron and muon neutrinos into other neutrino flavors, respectively.


To date, almost all neutrino data collected with accelerator, solar, atmospheric, and reactor neutrinos @Zyla:2020zbs can be explained within the standard three-neutrino oscillation paradigm that will be described in the next section. It is essential, however, that the accuracy of this paradigm be scrutinized with increasing precision to inform future experiments, provide important constraints to model building, and probe for other physics beyond the SM.


== Neutrino Masses and Mixing
<neutrino-masses-and-mixing>


In the standard three neutrino flavor scheme, neutrino oscillations imply that there exist three distinct neutrino mass eigenstates possessing definite neutrino masses, $m_i$ ($i = 1, 2, 3$), which are non-degenerate, namely, $m_i eq.not m_j$ for $i eq.not j$. This in turn implies that at least two neutrino species must be massive. In such a non-degenerate neutrino mass spectrum, each known flavor eigenstate, ($nu_e$, $nu_mu$, $nu_tau$), linked to three respective charged leptons ($e$, $mu$, $tau$) via the charged current interactions, can be regarded as a non-trivial mixture of the neutrino mass eigenstates as

$ mat(nu_e; nu_mu; nu_tau) = U_"PMNS" mat(nu_1; nu_2; nu_3), $

where $nu_i$ ($i = 1, 2, 3$) denote the mass eigenstates, and $U_"PMNS"$ is the so called #emph[Pontecorvo-Maki-Nakagawa-Sakata] (PMNS) @Pontecorvo:1967fh @Maki:1962mu matrix, a $3 times 3$ unitary matrix describing neutrino mixing. The first mass eigenstate $nu_1$ is defined as the one with the largest portion of the electron flavor eigenstate $nu_e$. The mixing matrix for antineutrinos is a complex conjugate of the one for neutrinos, $U_"PMNS" -> U_"PMNS"^*$. The standard parametrization of the PMNS matrix is given by @Zyla:2020zbs,

$ U_"PMNS" = mat(1, 0, 0; 0, c_23, s_23; 0, -s_23, c_23) mat(c_13, 0, s_13 e^(-i delta_"CP"); 0, 1, 0; -s_13 e^(i delta_"CP"), 0, c_13) mat(c_12, s_12, 0; -s_12, c_12, 0; 0, 0, 1) mat(e^(i eta_1), 0, 0; 0, e^(i eta_2), 0; 0, 0, 1), $ <eq-pmns>

where the notation $c_(i j) equiv cos theta_(i j)$ and $s_(i j) equiv sin theta_(i j)$ is used, and $delta_"CP"$ is often called the Dirac CP phase. Here, $eta_i$ ($i = 1, 2$) are the Majorana CP phases, which are physical only if neutrinos are Majorana-type particles but play no role in neutrino oscillations @Bilenky:1980cx.


As shown later, a total of six parameters are needed to fully describe neutrino oscillations, namely, three mixing angles, one Dirac CP phase, and two independent mass squared differences. The latter characterize the degree of non-degeneracy of neutrino masses and are defined as

$ Delta m_(i j)^2 equiv m_i^2 - m_j^2 quad (i, j = 1, 2, 3, quad i > j). $ <eq-mass-splittings>

As will be discussed in detail in this publication, among these six parameters, the Jiangmen Underground Neutrino Observatory (JUNO) can significantly improve the precision of $Delta m_31^2$ (or equivalently $Delta m_32^2$), $Delta m_21^2$, and $sin^2 theta_12$. In addition, JUNO can measure $sin^2 theta_13$ but with less precision than current reactor experiments@Adey:2018zwh @DoubleChooz:2019qbj @Bak:2018ydk, and is insensitive to $sin^2 theta_23$ and $delta_"CP"$.


== Today's Knowledge on Oscillation Parameters
<todays-knowledge-on-oscillation-parameters>


@tab-oscillation-parameters presents the current precision of the four mixing parameters within the reach of JUNO as obtained from the 2020 Review of Particle Physics @Zyla:2020zbs, which is referred to as PDG2020. The mass ordering (MO) of neutrinos is still unknown, meaning that the sign of $Delta m_32^2$ can be positive or negative. The normal mass ordering (NMO) corresponds to $Delta m_32^2 > 0$, and the inverted mass ordering (IMO) to $Delta m_32^2 < 0$. The most recent global analyses @Esteban:2020cvm @deSalas:2020pgw @Capozzi:2021fjo yield estimations that are consistent with the values shown in @tab-oscillation-parameters. Current precision on most oscillation parameters is in the order of a few percent.


// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [Table #context it.counter.display(it.numbering) #it.body]
}

#figure(
  table(
    columns: 3,
    align: (left, center, center),
    table.header([], [PDG2020], [Relative Uncertainty (1$sigma$)]),
    table.hline(),
    [$Delta m_32^2$ (NMO)], [$(2.453 plus.minus 0.034) times 10^(-3) "eV"^2$], [1.4\%],
    [$Delta m_32^2$ (IMO)], [$-(2.546 plus.minus 0.037) times 10^(-3) "eV"^2$], [1.5\%],
    [$Delta m_21^2$], [$(7.53 plus.minus 0.18) times 10^(-5) "eV"^2$], [2.4\%],
    [$sin^2 theta_12$], [$0.307 plus.minus 0.013$], [4.2\%],
    [$sin^2 theta_13$], [$0.0218 plus.minus 0.0007$], [3.2\%],
  ),
  caption: [
    Today's best knowledge of neutrino oscillation parameters within the reach of JUNO and their 1$sigma$ uncertainties, as reported in the PDG2020 @Zyla:2020zbs. The relative uncertainties (in \%) are indicated in the last column. NMO (IMO) implies normal mass ordering (inverted mass ordering).
  ],
  kind: table,
) <tab-oscillation-parameters>


== New Knowledge to be Provided by JUNO
<new-knowledge-to-be-provided-by-juno>
One of the main goals of JUNO@An:2015jdp @JUNO:2022hxd  is to determine the neutrino MO. This can be done by precisely measuring the interference in the reactor antineutrino oscillation probability driven by two independent mass squared differences, $Delta m_31^2$ and $Delta m_32^2$, as originally considered in Ref. @Petcov:2001sy. Additional details on JUNO's MO determination can be found in Ref. @An:2015jdp, and an updated estimate is under preparation. JUNO's physics program also includes studies of neutrinos from the Sun @Abusleme:2020zyc, the atmosphere @JUNO:2021tll, supernovae @Lu:2016ipr, and planet Earth @An:2015jdp, as well as explorations of physics beyond the SM @An:2015jdp.


JUNO's measurement of the oscillated reactor antineutrino spectrum at $tilde$52.5 km will also enable an independent determination of the $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ oscillation parameters, which is the focus of this publication. Of these, the first three will be determined to significantly better than $1 "%"$, inaugurating a new era of precision in neutrino oscillation measurements@An:2015jdp @DUNE:2020ypp @Hyper-Kamiokande:2018ofw. Such extraordinary precision is expected to have a vast impact across different research fields including particle physics, astrophysics, and cosmology. For instance, it will enable more stringent tests of the standard 3 flavor neutrino mixing picture, such as probing the unitarity of the PMNS matrix@Antusch:2006vwa @Parke:2015goa @Fong:2016yyh @Blennow:2016jkn @Li:2018jgd @Ellis:2020hus, with the potential to discover physics beyond the SM. It will also have important implications for other experimental efforts, for example by reducing the parameter space in the search for leptonic CP violation@DUNE:2015lol @Hyper-KamiokandeProto-:2015xww  and neutrinoless double beta decay@Dueck:2011hu @Ge:2015bfa @Cao:2019hli. The precise knowledge of the leptonic mixing matrix may reveal its most fundamental structure and provide important clues for identifying the theoretical mechanisms behind neutrino mass and mixing generation @King:2019gif. Finally, the new precision will allow using neutrinos as a more reliable tool or messenger to probe the deep interiors of astrophysical objects such as the Sun, supernovae, and planet Earth.


Important updates are made compared to the previous estimate @An:2015jdp of JUNO's sensitivity to the $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ oscillation parameters. Only eight nuclear reactors at $52.5$~km are considered instead of the ten envisioned when the experiment was first conceived. Likewise, realistic IBD selection and muon veto efficiencies obtained with the state of the art simulation software, as well as realistic assumptions on the detector performance and the final information about the location and overburden of the experimental site, are used. Finally, the expected constraints on the reactor antineutrino spectral shape from the satellite Taishan Antineutrino Observatory (TAO @Abusleme:2020bzt:TAO_CDR) are employed. All these inputs are described in detail in the following sections.


The remainder of this publication is organised as follows. Sections 2 and 3 introduce the neutrino oscillation framework and the experimental setup of JUNO, respectively. Section 4 provides the specifics related to reactor antineutrino detection and selection. Section 5 describes the methodology used to perform the oscillation analysis and parameter extraction, together with the main results. Section 6 is dedicated to the conclusions.


= Neutrino Oscillation Framework for JUNO
<sec-osc-framework>


In the presence of non-degenerate neutrino masses and non-trivial mixing, neutrinos and antineutrinos undergo flavor oscillations when they propagate in vacuum or in matter. In this section, we present the neutrino oscillation framework used in the rest of this work.


== Neutrino Oscillation in Vacuum
<neutrino-oscillation-in-vacuum>


The general $U_"PMNS"$-parameterization-independent expression of the $nu_alpha -> nu_beta$ neutrino oscillation probabilities in vacuum for ultra-relativistic neutrinos is given by @Zyla:2020zbs

$
  cal(P)(nu_alpha -> nu_beta) = delta_(alpha beta)
  &- 4 sum_(i > j) op("Re")(U_(alpha i)^* U_(alpha j) U_(beta i) U_(beta j)^*) sin^2 ((Delta m_(i j)^2 L) / (4 E)) \
  &+ 2 sum_(i > j) op("Im")(U_(alpha i)^* U_(alpha j) U_(beta i) U_(beta j)^*) sin((Delta m_(i j)^2 L) / (2 E)),
$ <eq-osc-prob-vac-general>

where $U_(alpha i)$, $U_(beta j)$, $U_(alpha j)$, $U_(beta i)$ (with $alpha, beta = e, mu, tau$ and $i, j = 1, 2, 3$ being the flavor and mass indices respectively) are PMNS matrix elements, $L$ is the distance traveled by the neutrino, $E$ is the neutrino energy, and $Delta m_(i j)^2$ are the mass squared differences defined in @eq-mass-splittings. For antineutrinos, the mixing matrix elements in @eq-osc-prob-vac-general are replaced by their complex conjugates, as mentioned before.


In this work, we are particularly interested in the case where $alpha = beta = e$ in @eq-osc-prob-vac-general, which yields the survival probability of electron antineutrinos. Due to CPT invariance, the neutrino survival probabilities for neutrinos and antineutrinos are identical and given by:

$
  cal(P)(overline(nu)_e -> overline(nu)_e) &= 1 - sin^2 2 theta_12 c_13^4 sin^2 Delta_21 - sin^2 2 theta_13 (c_12^2 sin^2 Delta_31 + s_12^2 sin^2 Delta_32) \
  &= 1 - sin^2 2 theta_12 c_13^4 sin^2 Delta_21 - 1/2 sin^2 2 theta_13 (sin^2 Delta_31 + sin^2 Delta_32) \
  &quad quad - 1/2 cos 2 theta_12 sin^2 2 theta_13 sin Delta_21 sin(Delta_31 + Delta_32),
$ <eq-p-ee-vac>

where $Delta_(i j) equiv Delta m_(i j)^2 L \/ (4 E)$, and the standard parametrization of the mixing matrix shown in @eq-pmns has been used. Note that in the second and third lines of the above equation, we have reformulated the survival probability in a manner that different parts of the solar-dominated (second term), atmospheric-dominated (third term), and MO-sensitive oscillations (fourth term), are factored out. Note also that there is no dependence on either $sin^2 theta_23$ or $delta_"CP"$.


== Neutrino Oscillation in Matter
<sec-matter>


Even though matter effects are relatively small in JUNO compared to long-baseline oscillation experiments, it is necessary to account for them to extract the correct values of the mixing parameters. In fact, ignoring matter effects would lead to biases in $Delta m_21^2$ and $sin^2 theta_12$ of about $1$\% and 0.2\% @Li:2016txk, respectively. A complete treatment of the impact of matter effects in JUNO can be found in Refs@Li:2016txk @Capozzi:2013psa @Khan:2019doq., and this Section offers only a brief synopsis of the main points.


The effective Hamiltonian that is responsible for the antineutrino propagation in matter@Wolfenstein:1977ue @Mikheyev:1985zog  is given by

$
  tilde(cal(H))_"eff" = 1/(2 E) [U mat(m_1^2, 0, 0; 0, m_2^2, 0; 0, 0, m_3^2) U^dagger - mat(A, 0, 0; 0, 0, 0; 0, 0, 0)] = 1/(2 E) [tilde(U) mat(tilde(m)_1^2, 0, 0; 0, tilde(m)_2^2, 0; 0, 0, tilde(m)_3^2) tilde(U)^dagger],
$

where $tilde(U)$ and $tilde(m)_i$ stand, respectively, for the effective neutrino mixing matrix and the $i$-th neutrino mass in matter. The matter parameter $A$ can be expressed as

$
  A = 2 sqrt(2) G_F N_e E approx 1.52 times 10^(-4) "eV"^2 times Y_e [rho / ("g" dot "cm"^(-3))] [E / "GeV"],
$

where $Y_e tilde.eq 0.5$ is the electron fraction per nucleon and $rho = (2.45 plus.minus 0.15) "g/cm"^3$ is the estimated average matter density with its associated uncertainty, obtained for JUNO by considering that the antineutrino trajectory passes through both the crust and the sediment of the Earth. Note that the minus sign in front of $A$ denotes the charged-current matter potential of electron antineutrinos in matter.


In JUNO, where matter effects are relatively small, a constant matter density profile can be assumed and the survival probability can be written in an analogous form as in vacuum, by simply replacing the mass eigenvalues and mixing angles used in @eq-p-ee-vac by those in matter, which are indicated with a tilde placed over the corresponding quantities as

$
  cal(P)(overline(nu)_e -> overline(nu)_e) &= 1 - sin^2 2 tilde(theta)_12 tilde(c)_13^4 sin^2 tilde(Delta)_21 - sin^2 2 tilde(theta)_13 (tilde(c)_12^2 sin^2 tilde(Delta)_31 + tilde(s)_12^2 sin^2 tilde(Delta)_32) \
  &= 1 - sin^2 2 tilde(theta)_12 tilde(c)_13^4 sin^2 tilde(Delta)_21 - 1/2 sin^2 2 tilde(theta)_13 (sin^2 tilde(Delta)_31 + sin^2 tilde(Delta)_32) \
  &quad quad - 1/2 cos 2 tilde(theta)_12 sin^2 2 tilde(theta)_13 sin tilde(Delta)_21 sin(tilde(Delta)_31 + tilde(Delta)_32),
$ <eq-p-ee-mat>

where $tilde(c)_(i j) equiv cos tilde(theta)_(i j)$, $tilde(s)_(i j) equiv sin tilde(theta)_(i j)$, with $tilde(theta)_(i j)$ ($i, j = 1, 2, 3$, $i < j$) being the effective mixing angles in $tilde(U)$ with the standard parametrization as in @eq-pmns.


An exact calculation of the survival probability can be obtained by numerical derivations of the eigenvalues and eigenvectors of $tilde(cal(H))_"eff"$, in principle, for an arbitrary matter density profile along the neutrino trajectory. On the other hand, there are also several analytical approximations based on different expansion methods performed under the constant matter density assumption. For some approximated analytic formulae of $cal(P)(overline(nu)_e -> overline(nu)_e)$ and effective mixing parameters in matter for JUNO, please refer to, for example, Refs@Li:2016txk @Capozzi:2013psa @Khan:2019doq. In the following sensitivity studies, both the exact calculation and analytical approximations were employed and found to produce consistent results.


= JUNO Experimental Setup
<juno-experimental-setup>


JUNO is a multipurpose experiment currently under construction in Southern China that will use a 20 kton liquid scintillator target to study neutrinos from a variety of natural sources as well as from nuclear reactors. Most reactor antineutrinos in JUNO will originate from 2 and 6 cores in the Taishan and Yangjiang nuclear power plants (NPPs), respectively. Both plants are located at a baseline of about 52.5 km, which was optimized for the best sensitivity to the neutrino MO and have a combined nominal thermal power of 26.6~GW#sub[th]. Knowledge of the unoscillated reactor antineutrino spectrum shape is important for JUNO, so a dedicated small satellite detector @Abusleme:2020bzt:TAO_CDR, called TAO, will be placed at about 30~m from one of the Taishan reactors to precisely measure it, serving as a data-driven input to constrain the spectra of the other cores. A schematic illustrating the location of both JUNO and TAO is shown in @fig-setup. The experiment's main detector and the reactors considered in the analysis are described in detail in the following Subsections.


// [figvision-cn] imgs/layout.png
// 该图像由上下两部分组成，共同展示了JUNO实验装置的布局及
// 其与核反应堆的相对位置关系。 上半部分为俯视图示意图，
// 描绘了JUNO探测器、TAO探测器以及两座核电站的地面平面分
// 布。 在图的上方中心位置，有一个蓝色实心圆点，旁边标注
// 有蓝色文字“JUNO”，代表JUNO探测器的地面投影位置。 在图
// 的左侧，有一组六个排列整齐的灰色冷却塔图标，代表阳江核
// 电站（Yangjiang NPP）。图标旁标注黑色文字“Yangjiang
// NPP”和“6×2.9 GW_th”。在该组图标下方，有一条双向箭头线
// 段，标注长度为“736.0 m”，表示这六个反应堆核心的跨度范
// 围。一条红色虚线从这组反应堆的中心区域连接到上方的JUNO
// 蓝点，虚线旁标注距离“~52.5 km”。 在图的右侧，有一组两
// 个排列较近的灰色冷却塔图标，代表台山核电站（Taishan
// NPP）。图标旁标注黑色文字“Taishan NPP”和“2×4.6 GW_th”。
// 在这组图标的右下方，有一个橙色实心圆点，旁边标注橙色文
// 字“TAO”，代表TAO探测器的位置。在TAO橙点与台山核电站图
// 标之间，有一条双向箭头线段，标注距离“252.5 m”。另一条
// 红色虚线从台山核电站的反应堆区域连接到上方的JUNO蓝点。
// 下半部分为侧视剖面示意图，展示了地表曲率及地下深度结构。
// 图中底部是一条向上弯曲的黑色实线弧，代表地球表面或地壳
// 曲面。 在弧线左上方，绘制了一个小型的灰色冷却塔图标，
// 其上方标注黑色文字“8 reactors”和“26.6 GW_th”，指代上述
// 两座核电站的总功率。 在弧线右下方，即地下深处，绘制了
// 一个蓝色实心圆点，下方标注蓝色文字“JUNO”，代表地下实际
// 位置的JUNO探测器。 一条红色长虚线连接左侧地面的反应堆
// 图标与右侧地下的JUNO蓝点，该虚线沿直线穿过地壳，线旁标
// 注基线距离“~52.5 km”。 在右侧JUNO蓝点处，有一条垂直于
// 地表切线的双向箭头线段，指示从地表到探测器的垂直深度，
// 标注为“~700 m”。
#figure(
  image("imgs/layout.png", width: 70%),
  caption: [
    Setup of the JUNO experiment. The main 20~kton JUNO detector, indicated in blue, is located in an experimental cavern at a depth of about 700~m with respect to the surface and 650~m of overburden (1800~m.w.e), at a baseline of $tilde$52.5~km from six 2.9~GW#sub[th] reactor cores in the Yangjiang NPP and two 4.6~GW#sub[th] cores in the Taishan NPP. The 2.8~ton TAO detector, indicated in orange, is located about 30~m away from one of the Taishan reactor cores.
  ],
) <fig-setup>


In JUNO's location, the energy spectrum will be distorted by a slow (low frequency) oscillation driven by $Delta m_21^2$~and modulated by $sin^2 2 theta_12$, as well as a fast (high frequency) oscillation driven by $Delta m_31^2$~and modulated by $sin^2 2 theta_13$, as shown in @fig-spectrum. JUNO will be the first experiment to observe these two oscillation modes simultaneously. As detailed later, fitting the data spectrum against the predicted spectrum distorted by standard neutrino oscillations enables measuring the $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ oscillation parameters. The oscillated spectrum in JUNO also changes subtly depending on the neutrino mass ordering, thus providing sensitivity to this parameter. As previously mentioned, this measurement is not addressed in this publication.


// [figvision-cn] imgs/Spectrum_OscillationsOnly_dm2_31.png
// 该图为单张二维曲线图，展示了JUNO反应堆中微子实验在6年
// 数据采集中预期的反电子中微子能谱。 坐标轴设置如下： 横
// 坐标（X轴）标记为“E_v_e (MeV)”，代表反电子中微子的能量，
// 单位为兆电子伏特（MeV）。刻度范围从0到9，主刻度间隔为1，
// 每个主刻度之间有4个次刻度，分度值为0.2 MeV。 纵坐标（Y
// 轴）标记为“Events per 1 MeV”，代表每1 MeV能量区间内的
// 事件数。刻度范围从0到100，主刻度间隔为20。在Y轴顶部标
// 注有乘数因子“×10^3”，表示实际数值需乘以1000。 图例位于
// 右上角，包含四个条目，分别对应图中的四条曲线： “No
// oscillations”（无振荡）：对应黑色实线。 “Only solar
// term”（仅太阳项）：对应灰色虚线。 “Normal ordering”（
// 正常质量排序）：对应蓝色实线。 “Inverted ordering”（反
// 转质量排序）：对应红色实线。 图中左上角有文本标注“6
// years of data taking”。 各曲线的具体形态与物理含义描述
// 如下： 黑色实线（无振荡）：这是基准参考曲线。曲线从约
// 1.8 MeV处开始急剧上升，在约3.5 MeV处达到峰值，峰值高度
// 约为88,000事件/MeV。随后曲线平滑下降，在9 MeV处趋近于
// 零。整体呈现典型的反应堆中微子能谱形状。 灰色虚线（仅
// 太阳项）：该曲线位于黑色实线下方，幅度显著降低。它同样
// 在1.8 MeV左右开始上升，但在约3.5 MeV处的峰值仅为约25,
// 000事件/MeV。曲线整体较为平滑，带有轻微的波动，反映了
// 仅考虑由Δm²_21主导的长波振荡效应后的能谱畸变。 蓝色实
// 线（正常排序）与红色实线（反转排序）：这两条曲线几乎重
// 叠，位于图的底部区域，显示出明显的快速振荡结构（高频波
// 纹）。它们的包络线大致跟随灰色虚线的趋势，但叠加了显著
// 的短波长振荡。两条曲线在大部分区域交织在一起，仅在局部
// （如4-5 MeV区间）有微小分离，体现了不同中微子质量排序
// 对干涉条纹相位的影响。 图中包含三组用于解释物理机制的
// 标注和箭头： 左侧标注“Δm²_21”：通过一个双向水平箭头标
// 示在横坐标约1.8 MeV至2.8 MeV之间，指示由该参数决定的振
// 荡特征尺度。 中部垂直箭头标注“sin² 2θ_12”：一条垂直双
// 头箭头连接了黑色实线（无振荡）的峰值点与下方灰色/彩色
// 曲线的包络线区域，形象地展示了由混合角θ_12导致的整体通
// 量压低幅度。 右侧标注“Δm²_31”与“sin² 2θ_13”： “Δm²_31”
// 通过一个较短的双向水平箭头标示在横坐标约4.5 MeV附近，
// 指示由该参数决定的快速振荡周期。 “sin² 2θ_13”通过一个
// 垂直双头箭头标示在横坐标约7 MeV处，连接了灰色虚线（仅
// 太阳项）与蓝/红曲线（全振荡），展示了由混合角θ_13引起
// 的额外振荡深度。 结论：该图直观展示了中微子振荡效应对
// 反应堆反中微子能谱的双重调制作用：一是由太阳中微子参数
// （Δm²_21, θ_12）导致的长波、大幅度的整体压低；二是由大
// 气中微子参数（Δm²_31, θ_13）导致的高频精细振荡结构。
#figure(
  image("imgs/Spectrum_OscillationsOnly_dm2_31.png", width: 70%),
  caption: [
    JUNO reactor antineutrino energy spectrum without (black) and with (grey, blue and red) the effect of neutrino oscillation. The reactor spectra are convoluted with the inverse beta decay cross-section and assume 6 years of data-taking. The gray dashed curve shows the spectrum when only the term in the disappearance probability that is modulated by $sin^2 2 theta_12$ is included, whereas the blue and red curves are obtained using the full oscillation probability in vacuum for the normal and inverted mass orderings, respectively. A detector with perfect energy resolution is assumed for illustration purposes. Some spectral features driven by the $Delta m_31^2$, $Delta m_21^2$, $sin^2 2 theta_12$, and $sin^2 2 theta_13$ oscillation parameters are shown pictorially, illustrating the rich information available in a high-resolution measurement of the oscillated spectrum at JUNO's baseline.
  ],
  placement: top,
) <fig-spectrum>


== The JUNO Detector
<sec-detector>


The JUNO detector will be deployed in an underground laboratory under the Dashi hill to limit the cosmogenic background. The 650 m overburden with average rock density of 2.61~g/cm#super[3] will suppress the cosmic-ray muon flux to $4.1 times 10^(-3) "/" ("s" dot "m"^2)$.


// [figvision-cn] imgs/JUNO_Detector_labels_v5.png
// 这是一张JUNO探测器主探测器的结构剖面示意图。图像采用垂
// 直切面视角，展示了探测器从顶部地下设施到中心核心探测器
// 的多层嵌套布局。 整体布局： 图像主体是一个巨大的圆柱形
// 地下坑道结构，内部容纳着球形的探测器系统。右侧有一列垂
// 直排列的白色矩形标注框，通过黑色指引线指向探测器内部的
// 具体组件。图像中部偏右有一个放大的局部细节图（Inset），
// 展示了光电倍增管安装区域的微观结构。 各部分详细描述如
// 下： Top Tracker and calibration house (顶部追踪与校准
// 室)：位于图像最顶端，是一个横跨坑道口上方的巨大混凝土
// 平台结构，呈土黄色。平台上画有蓝色的人形剪影作为尺寸参
// 考，显示该平台可供人员行走。该平台下方连接着钢制的脚手
// 架或支撑框架，延伸至坑道内部。 Water pool (水池屏蔽层)：
// 位于顶部平台下方，是包围整个球形探测器系统的灰色区域。
// 这是一个巨大的圆柱形容器空间，填充物为水，用于屏蔽外部
// 辐射并标记宇宙射线缪子。其内壁附着有大量黄色的圆形物体
// （即光电倍增管）。 Earth magnetic field compensation
// coils (地磁场补偿线圈)：在水池内部、中心探测器外部的空
// 间中，分布着红色的网格状线条。这些线条构成了笼状的线圈
// 结构，环绕在中心球体周围，用于抵消地磁场对探测精度的影
// 响。 Photomultiplier tubes (光电倍增管)：图中以黄色圆
// 盘状物体表示。它们分为两组：一组密集排列在外部水池的内
// 壁上；另一组安装在中心球形容器的内表面。在放大的局部细
// 节图中，可以清晰看到这些黄色圆盘（PMT）被固定在白色的
// 支架上，并且朝向中心，即“向内面对”（inward-facing）。
// Acrylic spherical vessel filled with liquid
// scintillator (装有液体闪烁体的丙烯酸球体容器)：这是探
// 测器的核心部分，位于图像正中央。它是一个巨大的透明球体，
// 材质为丙烯酸。球体内部充满了半透明的浅蓝色液体，即液体
// 闪烁体。球体表面布满了微小的点状结构，对应着安装在内壁
// 上的小型光电倍增管。 Acrylic supporting nodes (丙烯酸
// 支撑节点)：在中心球体与外部结构之间，可以看到一些连接
// 用的节点结构。虽然图中未直接画出独立的支撑杆，但指引线
// 指向了球体外部附近的连接点，暗示了用于悬挂和固定中心球
// 体的支撑系统。 放大细节图（Inset）： 位于图像右侧中部，
// 是一个矩形的放大视图，展示了中心球体表面的局部细节。图
// 中清晰地显示了白色的丙烯酸球壁，以及紧密排列的黄色光电
// 倍增管（PMT）。红色的线圈网格叠加在这些组件之上，展示
// 了地磁场补偿线圈与光电倍增管的相对位置关系。 总结： 该
// 示意图通过剖面图和局部放大图，定量且直观地展示了JUNO探
// 测器复杂的层级结构：从顶部的操作平台，到外围的水池屏蔽
// 层，再到核心的装有液体闪烁体的丙烯酸球体，以及遍布其中
// 的各类传感器（PMT）和辅助系统（补偿线圈）。所有组件均
// 通过标签明确标识，帮助读者理解探测器的物理布局和探测原
// 理。
#figure(
  image("imgs/JUNO_Detector_labels_v5.png", width: 90%),
  caption: [
    Schematic of the main JUNO detector. An acrylic sphere containing 20~kton of liquid scintillator is immersed in water and surrounded by 17,612 large (20-inch) and 25,600 small (3-inch) inward-facing PMTs. This Central Detector is optically decoupled from a surrounding water pool instrumented with 2,400 20-inch PMTs providing shielding and cosmic-ray muon tagging. A Top Tracker system consisting of three layers of plastic scintillator provides precision tracking of cosmic-ray muons entering the Central Detector. A calibration house is used to store the corresponding instruments deployed in the detector. Two sets of large coaxial coils running along different axes surround the Central Detector, largely suppressing the effects of the Earth's magnetic field on the 20-inch PMTs' collection efficiency.
  ],
) <fig-detector>


The main JUNO detector is shown in @fig-detector. The primary antineutrino target of 20~kton of liquid scintillator is contained in a transparent 12-cm thick acrylic sphere 35.4~m in diameter. This constitutes the largest detector of this kind, securing JUNO's desired antineutrino statistics. Disentangling the two oscillation modes requires the detector to have the ability to measure the fast atmospheric oscillations, for which an unprecedented energy resolution is required. The acrylic sphere is surrounded by 17,612 large 20-inch photomultiplier tubes (PMTs), referred to as LPMTs, and 25,600 small 3-inch PMTs, referred to as SPMTs, yielding an integral 77.9\% photo-cathode coverage @JUNO:2022hxd. An ultra-pure water buffer with $tilde$1.5~m thickness fills the volume between the acrylic and the LPMT photocathodes. The light yield at the detector center is expected to be $tilde$1345~photoelectrons (PEs) per MeV @JUNO:2020xtj. This represents at least 2.5$times$ more light compared to the second highest yield achieved with the same technology @BOREXINO:2020aww, and provides the required $lt.eq 3$\% at 1~MeV energy resolution for the MO determination @Djurcic:2015vqa. The main detector is fully surrounded by an ultra-pure water Cherenkov detector that serves as both an active veto for cosmic muons (efficiency $> 99.5$\%) and as a passive shield against external radioactivity and neutrons from cosmic rays. The minimal thickness of this detector is 2.5~m. The muon cosmic veto system is supplemented with an external muon tracker consisting of three layers of plastic scintillator repurposed from the OPERA experiment @ADAM2007523 located at the top and providing a muon track angular reconstruction precision of $0.20 degree$. This system covers about 60\% of the surface above the water pool. More details about JUNO's detector design can be found in Ref. @JUNO:2022hxd. Discussion on the detector response, the corresponding systematic uncertainties, and their impact in this analysis, is deferred to @sec-detector-response.


== The JUNO Nuclear Reactors
<sec-reactors>
As shown in @fig-setup, the primary reactor antineutrino sources for JUNO are the Taishan and Yangjiang NPPs, with two and six cores respectively, located at an average distance of 52.5 km. The next closest reactor complex to JUNO is Daya Bay, whose antineutrino flux slightly degrades the sensitivity to the oscillation parameters and is thus considered in the analysis. The reactor power, baselines, and expected IBD rates from Taishan, Yangjiang, and Daya Bay reactor cores, are summarized in @tab-reactors. The Huizhou NPP, at a distance of 265~km, is still under construction but will not be ready until several years after the start of data taking. Given the uncertainty on its schedule, it is not considered in the analysis. Other NPPs are more than 300~km away and contribute approximately one event per day to the total IBD rate in JUNO. As discussed in @sec-selection, they are treated as a background. More information on the reactor antineutrino flux prediction and the associated systematic uncertainties can be found in @sec-flux.


#figure(
  table(
    columns: 5,
    align: (left, center, center, center, center),
    table.header([Reactor], [Power (GW#sub[th])], [Baseline (km)], [IBD Rate (day#super[-1])], [Relative Flux (\%)]),
    table.hline(),
    [Taishan], [9.2], [52.71], [15.1], [32.1],
    [~~~Core 1], [4.6], [52.77], [7.5], [16.0],
    [~~~Core 2], [4.6], [52.64], [7.6], [16.1],
    [Yangjiang], [17.4], [52.46], [29.0], [61.5],
    [~~~Core 1], [2.9], [52.74], [4.8], [10.1],
    [~~~Core 2], [2.9], [52.82], [4.7], [10.1],
    [~~~Core 3], [2.9], [52.41], [4.8], [10.3],
    [~~~Core 4], [2.9], [52.49], [4.8], [10.2],
    [~~~Core 5], [2.9], [52.11], [4.9], [10.4],
    [~~~Core 6], [2.9], [52.19], [4.9], [10.4],
    [Daya Bay], [17.4], [215], [3.0], [6.4],
  ),
  caption: [
    Characteristics of NPPs and their reactor cores considered in this analysis: the two closest ones to JUNO, Taishan and Yangjiang, at an approximate distance of 52.5~km, and the next closest, Daya Bay. The IBD rates are estimated from the baselines, full thermal power of the reactors, selection efficiency, and current knowledge of the neutrino oscillation parameters. Relative contribution to the total antineutrino signal in JUNO is indicated in the last column.
  ],
  kind: table,
) <tab-reactors>


= High Precision Reactor Antineutrino Detection
<high-precision-reactor-antineutrino-detection>


== Reactor Antineutrino Selection and Residual Backgrounds
<sec-selection>
Reactor antineutrinos in JUNO are detected through the inverse beta decay (IBD) reaction $macron(nu)_e + p -> e^+ + n$. The kinetic energy deposited by the positron via ionisation, together with its subsequent annihilation into typically two 0.511~MeV photons, forms a prompt signal. The impinging neutrino transfers most of its energy to the positron. This allows the deposited visible energy of the positron to be directly and very accurately related to the antineutrino energy, which is the relevant metric for neutrino oscillation measurements. The neutron is captured in an average of $tilde$220~$mu$s, and the corresponding photon emission forms a delayed signal. The neutron is captured dominantly on hydrogen~($tilde$99\%), releasing a single 2.2~MeV photon, and very infrequently on carbon~($tilde$1\%), yielding a gamma-ray signal with 4.9~MeV of total energy. With a typical kinetic energy ranging from zero to a few tens of keV, the neutron in the IBD interaction carries only a small fraction of the initial antineutrino energy. However, due to the unprecedented energy resolution of JUNO, neutron recoils cannot be neglected, and the differential IBD cross-section is used in our calculations. We have adopted the IBD cross-section from~Ref. @Vogel:1999zy. The small uncertainty in this quantity has no appreciable impact on the results presented in this publication.


The IBD prompt-delayed spatial and temporal coincidence signature can be mimicked by other events in the detector, giving rise to backgrounds. There are four main sources:

- Radiogenic events, i.e. $alpha$, $beta$, $gamma$ decays from natural radioactivity in the material of the detector.

- Cosmogenic events, i.e. fast neutrons and unstable isotopes produced by impinging muons on $""^"12"$C, typically via spallation.

- Atmospheric neutrinos, i.e. neutrinos of all flavors created in the reactions set about by the collision of primary cosmic rays with the Earth's atmosphere.

- Electron antineutrinos emitted by distant reactors or created in the U and Th decay chains in Earth, i.e. geoneutrinos.


The coincidence of two otherwise uncorrelated events, typically of radiogenic origin, forms the so-called accidental background. This background dominates the low energy part of the spectrum due to its nature. However, it can be measured with an excellent precision, typically at the permille level, and subtracted by off-time window techniques, as demonstrated by current-generation reactor antineutrino experiments@Adey:2018zwh @DoubleChooz:2019qbj @Bak:2018ydk.


Correlated backgrounds are by definition produced by a single physics process and yield both a prompt and a delayed signal. The most important such backgrounds are cosmogenic $""^"9"$Li/$""^"8"$He and fast neutrons, which can only be further suppressed by increasing the overburden. There are also geoneutrinos, mostly below 2.5 MeV in antineutrino energy @Sramek:2012hma, and atmospheric neutrinos @Cheng:2020aaw. The latter can produce neutrons, protons, $alpha$ particles, and excited light nuclei that deposit their energy immediately or shortly after production and can thus mimic the IBD signature when followed by a neutron capture. There is only one radiogenic process leading to a correlated background deserving consideration: the $""^"13"$C($alpha$, $n$)$""^"16"$O reaction in the liquid scintillator. This background is expected to be small in JUNO, more so given the stringent radiopurity control that is envisaged @JUNO:2021kxb. The production of fast neutrons and gamma rays via spontaneous fissions and $(alpha, n)$ reactions in peripheral materials of the detector @PhysRevD.104.092006 is expected to have a negligible contribution to this analysis.


IBD selection criteria are designed to suppress the aforementioned backgrounds while keeping a high efficiency for true reactor antineutrino IBD events. First, prompt and delayed candidate events are restricted to the energy windows [0.7, 12.0]~MeV and [1.9, 2.5] $union$ [4.4, 5.5]~MeV, respectively. IBD events are expected to dominate the [0.7, 8.0]~MeV prompt energy range, as shown in @fig-ibd. The delayed signal energy selection windows are selected to be centered around 2.2~MeV and 4.9~MeV corresponding to neutron capture on hydrogen and carbon, respectively. Prompt or delayed events are discarded if their vertices are more than 17.2~m far away from the detector center, since the external background rate is larger at the edge of the acrylic sphere. This fiducial volume cut will be further optimised upon data taking based on the final radiopurity of the PMTs and the detector materials. To further reduce the accidental background, the surviving prompt-delayed pairs are restricted to occur with a time separation $Delta T_(p - d)$ smaller than 1.0~ms and a spatial 3D separation $Delta R_(p - d)$ smaller than 1.5~m.


// [figvision-cn] imgs/lpmt_IBDCands_BGs_v5_Jan2022_.png
// 这是一张包含主图和右上角内嵌图的科学数据图，展示了JUNO
// 实验中LPMT系统预期的可见能谱。 子图类型：曲线图（堆叠
// 面积图与线形图组合）。 坐标轴：横坐标为“Visible Energy
// [MeV]”（可见能量），范围从0到12 MeV，主刻度间隔为2 MeV；
// 纵坐标为“Events/0.02 [MeV^-1 day^-1]”（每0.02 MeV能量
// 区间内的日事件数），范围从0到0.22，主刻度间隔为0.02。
// 背景有虚线网格。 图中主要包含两条粗实线曲线： 黑色粗实
// 线：标记为“IBD Signal”，代表反中微子-质子逆β衰变（IBD）
// 信号谱。该曲线在约1.8 MeV处有一个峰值（约0.15），随后
// 下降，在3至5 MeV之间呈现波动上升，于4.5至5 MeV附近达到
// 最大值（约0.21），之后随能量增加单调下降，在8 MeV以上
// 趋近于零。 灰色粗实线：标记为“IBD + residual BG”，代表
// IBD信号加上剩余本底后的总谱。其形状与黑色曲线相似，但
// 在低能区（特别是1.5至2.5 MeV）明显高于黑色曲线，显示出
// 本底的贡献。 在主图底部，靠近横坐标轴的位置，绘制了多
// 个彩色填充区域，代表不同来源的本底贡献： 橙色点状填充
// 区域：位于约1.0至1.6 MeV之间，对应地中微子（
// Geoneutrinos）。 蓝色点状填充区域：分布较广，主要在1.0
// 至3.0 MeV之间，对应偶然符合事件（Accidentals）。 深蓝
// 色点状填充区域：覆盖大部分能量范围，但幅度较低，对应全
// 球反应堆中微子（Global Reactors）。 绿色、红色、青色和
// 紫色线条或区域：分别对应^9Li/^8He、^13C(α,n)^16O、大气
// 中性流（Atmospheric NC）和快中子（Fast Neutrons）本底，
// 这些在本底总量中占比较小。 右下角图例说明： “IBD
// Signal”对应黑色实线。 “IBD + residual BG”对应灰色实线。
// 内嵌图（Inset）： 位置：位于主图右上角。 类型：堆叠面
// 积图，展示各本底成分的细节。 坐标轴：横坐标“Visible
// Energy (MeV)”，范围1.0至4.5 MeV；纵坐标“Events/0.02 [
// MeV^-1 day^-1]”，对数刻度，范围10^-4至10^-1。 内容：展
// 示了七种本底成分的堆叠分布，每种用不同颜色和线型表示，
// 并在右侧列出图例： Geoneutrinos：橙色，带斜线填充。
// Accidentals：浅蓝色，带点状填充。 Global Reactors：深
// 蓝色，带交叉线填充。 ^9Li, ^8He：绿色，实线。 ^13C(α,n
// )^16O：红色，实线。 Atmospheric NC：青色，实线。 Fast
// Neutrons：紫色，实线。 趋势：所有本底主要集中在低于3
// MeV的能量区域，其中地中微子和偶然符合事件是主要贡献者。
// 总本底约占IBD候选样本的7%。 整体结论：该图表明，在JUNO
// 实验中，IBD信号在高于3 MeV的能量区间占主导地位，而各类
// 本底主要集中在低能区（<3 MeV），且总本底水平约为信号的
// 7%，可通过能量阈值进行有效抑制。
#figure(
  image("imgs/lpmt_IBDCands_BGs_v5_Jan2022_.png", width: 90%),
  caption: [
    Visible energy spectrum expected in JUNO as measured with the LPMT system with (grey) and without (black) backgrounds. The assumptions detailed in the text are used, which include the energy resolution from Ref. @JUNO:2020xtj. The inset shows the spectra of the expected backgrounds, which amount to about 7\% of the total IBD candidate sample and are mostly localized below $tilde$3~MeV.
  ],
) <fig-ibd>


A series of cosmic muon veto cuts are enforced to suppress the cosmogenic backgrounds, most of which satisfy the IBD coincidence selection criteria. Muon-induced neutrons can be greatly reduced by imposing a time cut proportional to the characteristic time of neutron capture, as done in other underground liquid scintillator experiments @Adey:2018zwh @DoubleChooz:2019qbj @Bak:2018ydk @KamLAND:2008dgz. However, this approach does not fully eliminate the longer-lived isotopes, in particular $""^"9"$Li/$""^"8"$He, that are produced along the muon track. The exploitation of this topological correlation has been considered by other experiments@KamLAND:2008dgz @Super-Kamiokande:2016yck. A refinement of this strategy has been developed for JUNO with state of the art simulations by using a different veto time window depending on the candidate event's proximity to a recent muon track or spallation neutron capture. This strategy is a variation of the muon veto reported in Ref. @Abusleme:2020zyc, but optimized for the IBD selection. The details are as follows:

- For all muons passing the water pool Cherenkov detector and/or the Central Detector, a veto of 1~ms after each muon is applied over the whole fiducial volume to suppress spallation neutrons and short-lived radio-isotopes.

- For well-reconstructed muon tracks in the Central Detector caused by single or two far-apart muons, a veto of 0.6~s, 0.4~s, and 0.1~s is applied to candidate events with reconstructed vertices smaller than 1~m, 2~m, and 4~m away from the track(s), respectively.

- For events containing two close and parallel muons ($< 3$~m), which constitute roughly 0.6\% of muon-related events, a single track is often reconstructed. The veto is applied around this track as described above, but the cylinder radii are increased according to their separation, which can be inferred from the charge pattern around the entrance and exit points.

- For events where a track cannot be properly reconstructed, which amount to about 2\% of all muon-related events and occur primarily when more than two muons go through the detector simultaneously, a 0.5~s veto is applied over the whole fiducial volume.

- A 1.2~s veto is applied on any candidate events reconstructed inside a 3~m radius sphere around spallation neutron capture events. This cut helps further reject backgrounds from cosmogenic isotope decays.

This updated strategy improves the muon veto efficiency from the previously reported 83.0 @An:2015jdp\% to 91.6\%, while keeping the residual cosmogenic background almost unchanged. The combined antineutrino detection efficiency after all selection cuts is 82.2\%. A rounded value of 82.0\% was used in the analyses reported here. Breakdown of the selection efficiency is summarised in @tab-efficiency.


#figure(
  table(
    columns: 3,
    align: (left, center, center),
    table.header([Selection Criterion], [Efficiency (\%)], [IBD Rate (day#super[-1])]),
    table.hline(),
    [All IBDs], [100.0], [57.4],
    [Fiducial Volume], [91.5], [52.5],
    [IBD Selection], [98.1], [51.5],
    [~~~~Energy Range], [~~~~99.8], [-],
    [~~~~Time Correlation ($Delta T_(p - d)$)], [~~~~99.0], [-],
    [~~~~Spatial Correlation ($Delta R_(p - d)$)], [~~~~99.2], [-],
    [Muon Veto (Temporal $xor$ Spatial)], [91.6], [47.1],
    [Combined Selection], [82.2], [47.1],
  ),
  caption: [
    Summary of cumulative reactor antineutrino selection efficiencies. The reported IBD rates refer to the expected events per day after the selection criteria are progressively applied. These rates are calculated for nominal reactor power, and do not include any reactor time off.
  ],
  kind: table,
) <tab-efficiency>


After applying the antineutrino event selection cuts mentioned above, seven backgrounds remain that are considered in this analysis: geoneutrinos, $macron(nu)_e$'s from world reactors (with a baseline to JUNO larger than 300~km), accidental coincidences, $""^"9"$Li/$""^"8"$He decays, atmospheric neutrinos, fast neutrons, and $""^"13"$C($alpha$, $n$)$""^"16"$O interactions. Their rates and uncertainties are summarized in @tab-backgrounds. These values are consistent with those in our previous work @An:2015jdp, although some adjustments are made. The rates of geoneutrinos and $""^"9"$Li/$""^"8"$He decays are adjusted by +0.1~day#super[-1] and -0.8~day#super[-1], respectively, because of the new muon veto strategy. Likewise, the accidental background rate is reduced by 0.1~day#super[-1] due to new knowledge on the radiopurity of the detector components @JUNO:2021kxb. The world reactors and the atmospheric neutrino backgrounds are new additions in this publication. The former is calculated from Ref. @Dye:2015bsw and the same uncertainty of the $macron(nu)_e$ signal described in @sec-flux is applied. The latter is estimated following the methodology of Ref. @Cheng:2020aaw. The IBD selection criteria is applied to simulate final states of atmospheric neutrinos interacting with $""^"12"$C nuclei in the liquid scintillator. In the [0.7, 12.0]~MeV energy range, neutral-current interactions are found to dominate, with charged-current interactions contributing a negligible amount. The uncertainty is estimated from the largest variation in predicted rate between an interaction model that relies on GENIE 2.12.0, which is taken as the nominal, and four others relying on the NuWro generator that use different nuclear models and values of the axial mass @Cheng:2020aaw.


The geoneutrino and world reactors' antineutrino spectra are obtained from Refs. @Araki:2005qa and @Dye:2015bsw, respectively. The accidental spectrum is obtained by applying the IBD selection to events from a full JUNO simulation with a recently re-estimated radioactivity budget @JUNO:2021kxb. The $""^"9"$Li/$""^"8"$He spectrum is obtained from a theoretical calculation. The atmospheric neutrino spectrum is the one produced by the nominal interaction model relying on the GENIE 2.12.0 generator in Ref. @Cheng:2020aaw. The fast neutron spectrum is assumed to be flat in the energy range of interest, which is a reasonable approximation as seen in both simulation and recent reactor experiments@DoubleChooz:2019qbj @Bak:2018ydk @DayaBay:2016ggj. Finally, the spectrum of $""^"13"$C($alpha$, $n$)$""^"16"$O is obtained from simulation. In all cases the full detector response of @sec-detector-response is applied.


With the exception of the two newly considered backgrounds, the spectral shape uncertainties are the same as in Ref. @An:2015jdp. The shape uncertainty of the world reactors' $macron(nu)_e$ background is considered to be the same of the $macron(nu)_e$ signal, described in @sec-flux. The spread between interaction models is assigned as the shape uncertainty of the atmospheric neutrino background. All shape uncertainties are conservatively treated as bin-to-bin uncorrelated. Their knowledge is expected to improve through JUNO data analysis.


Compared to other underground liquid scintillator experiments, the impact of the backgrounds on the precision of the measurement of the oscillation parameters is limited. This is because JUNO exploits the large spectral shape distortion of the IBD spectrum as the primary handle to extract the oscillation parameters. As illustrated in @fig-ibd, the residual backgrounds' spectra are manifestly distinct from the oscillated spectrum.


#figure(
  table(
    columns: 4,
    align: (center, center, center, center),
    table.header([Background], [Rate (day#super[-1])], [Rate Uncertainty (\%)], [Shape Uncertainty (\%)]),
    table.hline(),
    [Geoneutrinos], [1.2], [30], [5],
    [World reactors], [1.0], [2], [5],
    [Accidentals], [0.8], [1], [negligible],
    [$""^"9"$Li/$""^"8"$He], [0.8], [20], [10],
    [Atmospheric neutrinos], [0.16], [50], [50],
    [Fast neutrons], [0.1], [100], [20],
    [$""^"13"$C($alpha$, $n$)$""^"16"$O], [0.05], [50], [50],
  ),
  caption: [Background rates and uncertainties.],
  kind: table,
) <tab-backgrounds>


== Detector Response
<sec-detector-response>
The extraction of the oscillation parameters relies strongly on the careful control of systematic uncertainties affecting both the precision and accuracy of the spectral distortion caused by neutrino oscillation. The energy response model considered in this analysis includes three effects: energy transfer in the IBD reaction, detector nonlinearity, and energy resolution. The event-vertex dependence of the energy response, i.e. the non-uniformity, also plays an important role and has been included in the energy resolution model as described below.


Energy transfer in the IBD reaction is calculated by integrating the IBD differential cross-section over the positron scattering angle. The kinetic energy of the positron, together with the typically two 0.511~MeV annihilation photons, is assumed to be fully deposited in the detector and is defined as $E_"dep"$. Energy losses from escaping secondary particles only affect less than 1\% of IBD events and are consequently ignored in this analysis. Due to the quenching effect of the scintillation light, the Cherenkov radiation, and the photon detection, the visible energy that would be observed if JUNO had perfect energy resolution, defined as $E_"vis"^*$, does not depend linearly on the deposited energy. Accordingly, the factor $E_"vis"^* \/ E_"dep"$ represents the nonlinear response of the detector. The instrumental charge nonlinearity of the JUNO PMTs and their electronics is assumed to be negligible ($< 0.3$\%) thanks to the dual-calorimetry calibration technique described in Ref. @JUNO:2020xtj. Therefore, in this analysis only the nonlinearity from the liquid scintillator itself is considered and assumed to be identical to the one measured in the Daya Bay experiment @Adey:2019zfo:DYB_NL, whose scintillator composition is similar. The implementation of this systematic uncertainty in JUNO follows a similar strategy as in Daya Bay, where a nominal curve is first employed and four curves weighted by pull parameters are used to account for possible variations and to generate an uncertainty band, as shown in Ref. @Adey:2019zfo:DYB_NL.


Finally, the visible energy $E_"vis"$ will be further smeared relative to $E_"vis"^*$ because of the finite energy resolution of the detector. When detector leakage effects are neglected, the resolution can be parameterized using a Gaussian function with a standard deviation $sigma_(E_"vis")$ given by

$ sigma_(E_"vis") / E_"vis" = sqrt((a / sqrt(E_"vis"))^2 + b^2 + (c / E_"vis")^2), $ <eq-energy-resolution>

where $a$ is the term driven by the Poisson statistics of the total number of detected photoelectrons, $c$ is dominated by the PMT dark noise, and $b$ is dominated by the detector's spatial non-uniformity. The large and small PMTs work as two complementary photon detection systems, resulting in the energy of every event being measured twice with very different resolutions. The energy resolution of the LPMT system was carefully studied using Monte Carlo simulation in Ref. @JUNO:2020xtj, yielding $a = (2.61 plus.minus 0.02) "%" sqrt("MeV")$, $b = (0.82 plus.minus 0.01) "%"$, and $c = (1.23 plus.minus 0.04) "%" "MeV"$ as the average values for the fiducial volume of the detector. For the SPMT system, $a$ is expected to dominate because of the smaller light level, making $b$ and $c$ almost irrelevant. The value of this parameter is determined according to the ratio of the simulated total number of photoelectrons between the two PMT systems, while $c$ is calculated based on the measured dark noise rate of the SPMTs @Cao:2021wrq. $b$ is not modified because detector effects are expected to be largely the same for both PMT systems. This results in $a = 15.36 "%" sqrt("MeV")$, $b = 0.82 "%"$, and $c = 6.77 "%" "MeV"$ for the SPMT energy resolution. Despite the poorer energy resolution, the SPMT system allows for a semi-independent measurement of the slow $Delta m_21^2$-$sin^2 theta_12$ oscillation, as explained in @sec-results.


The energy spectrum at different stages in the calculation can be found in @fig-response, embedded with the nonlinearity curve and the energy resolution curves of both PMT systems.


// [figvision-cn] imgs/DetectorResponse_v0308.png
// 该图像包含一个主图区域和两个位于右侧的插图（子图），标
// 题为“JUNO 6 years data taking”。 左侧主图： 类型：曲线
// 图。 坐标轴：横轴为“Energy [MeV]”，范围从0到12，主刻度
// 间隔为2；纵轴为“Events per 20 keV”，范围从0到500，主刻
// 度间隔为100。 曲线与图例：图中包含四条线，分别代表不同
// 的探测器响应模拟情况。红色实线表示“w/o NL&Res”（无非线
// 性效应及能量分辨率）；蓝色实线表示“w/ NL”（仅含非线性
// 效应）；绿色实线表示“LPMT w/ NL&Res”（大光电倍增管系统，
// 含非线性及分辨率）；黑色虚线表示“SPMT w/ NL&Res”（小光
// 电倍增管系统，含非线性及分辨率）。 趋势与结论：所有曲
// 线均展示了反中微子能谱的形状，在约1.8 MeV处有一个明显
// 的峰值，随后在2至4 MeV之间呈现振荡结构。红色曲线（理想
// 情况）振幅最大且最尖锐。蓝色曲线在红色基础上进行了平滑
// 处理，振荡幅度减小。绿色和黑色曲线进一步被展宽和平滑，
// 其中黑色虚线（SPMT）比绿色实线（LPMT）更宽、更低，表明
// SPMT系统的能量分辨率较差，导致能谱特征模糊。 右上角子
// 图： 类型：曲线图。 坐标轴：横轴为“Deposited Energy
// E_dep [MeV]”，范围从2到12；纵轴为“E_vis^* / E_dep”，范
// 围从0.9到1.05。 曲线与标注：图中有一条蓝色实线，标注为
// “NL”，代表液闪探测器的非线性能量响应。 趋势与结论：曲
// 线显示可见能量与沉积能量的比值随沉积能量增加而上升，在
// 低能区（<4 MeV）上升较快，在高能区趋于平缓并接近1.0，
// 表明探测器在低能区的响应是非线性的。 右下角子图： 类型：
// 曲线图。 坐标轴：横轴为“Visible Energy E_vis^* [MeV]”，
// 范围从2到12；纵轴为“Energy Resolution [%]”，范围从0到
// 25。 曲线与图例：图中有两条曲线。红色实线表示“LPMT”系
// 统的能量分辨率；黑色实线表示“SPMT”系统的能量分辨率。
// 趋势与结论：两条曲线均随可见能量增加而下降。红色曲线（
// LPMT）始终低于黑色曲线（SPMT），表明LPMT系统的能量分辨
// 率优于SPMT系统。在低能区（如2 MeV），SPMT的分辨率约为
// 15%，而LPMT约为3%；在高能区（如12 MeV），两者分别降至
// 约7%和1%以下。
#figure(
  image("imgs/DetectorResponse_v0308.png", width: 90%),
  caption: [
    Detector response impact on the IBD spectrum. The top right panel shows the nonlinear energy response of the liquid scintillator. The bottom right panel shows the energy resolution of the LPMT and the SPMT systems as a function of visible energy. In both cases the resolution is described using the same model introduced in @eq-energy-resolution, with $a$=2.61\%, $b$=0.82\%, $c$=1.23\% for LPMT and $a$=15.36\%, $b$=0.82\%, $c$=6.77\% for SPMT. The main panel shows the deposited energy spectrum from the IBD reaction in 6~years of JUNO data without detector nonlinearity (NL) nor energy resolution (Res) in red, with NL only in blue, and with both detector effects in green, where the energy resolution corresponds to the LPMT system. The spectrum detected by the SPMT system with both NL and Res is also shown in dashed black.
  ],
) <fig-response>


== Reactor Antineutrino Flux
<sec-flux>


The expected visible energy spectrum observed at JUNO can be calculated as

$ S(E_"vis") = N_p dot epsilon integral_(T_"DAQ") dif t integral_(1.8 "MeV")^(12 "MeV") dif E_(macron(nu)_e) dot Phi (E_(macron(nu)_e), t) dot sigma (E_(macron(nu)_e)) dot R (E_(macron(nu)_e), E_"vis"), $ <eq-energy-response>

where $R (E_(macron(nu)_e), E_"vis")$ is the detector energy response function embedding the effects described in @sec-detector-response that maps the antineutrino energy to the visible energy, $sigma (E_(macron(nu)_e))$ is the IBD cross-section, $Phi (E_(macron(nu)_e), t)$ is the oscillated reactor antineutrino flux in JUNO at time $t$, $T_"DAQ"$ is the total data taking time, $epsilon$ is the detection efficiency, and $N_p = 1.44 times 10^33$ is the number of free protons in the detector target.


In a commercial reactor, electron antineutrinos are produced from the fission products of four major isotopes, $""^"235"$U, $""^"238"$U, $""^"239"$Pu, and $""^"241"$Pu. The oscillated antineutrino flux at time $t$ is written as

$ Phi (E_(macron(nu)_e), t) = sum_r frac(cal(P)_(macron(nu)_e -> macron(nu)_e) (E_(macron(nu)_e), L_r), 4 pi L_r^2) phi_r (E_(macron(nu)_e), t), $ <eq-flux>

where $E_(macron(nu)_e)$ is the $macron(nu)_e$ energy, $r$ is the reactor index, $L_r$ is the distance from the detector to reactor $r$, $cal(P)_(macron(nu)_e -> macron(nu)_e) (E_(macron(nu)_e), L_r)$ is the $macron(nu)_e$ survival probability, and $phi_r (E_(macron(nu)_e), t)$ is the reactor antineutrino energy spectrum. The latter can be calculated as

$ phi_r (E_(macron(nu)_e), t) = frac(W_r (t), sum_i f_(i r) (t) e_i) sum_i f_(i r) (t) s_i (E_(macron(nu)_e)), $ <eq-reactor-spectrum>

where $W_r (t)$ is the thermal power, $e_i$ is the mean energy released per fission for isotope $i$, $f_(i r) (t)$ is the fission fraction, and $s_i (E_(macron(nu)_e))$ is the antineutrino energy spectrum per fission for each isotope. Averaged reactor power and fission fractions are used for this study, although these quantities will be provided by the power plants for each core as a function of time once JUNO begins operating. To account for refueling, which typically takes one month per year, the average reactor thermal power is calculated as the nominal value reduced by a reactor duty cycle factor of 11/12. The average fission fractions are assumed to be 0.58, 0.07, 0.30, 0.05, with mean energies per fission of 202.36~MeV, 205.99~MeV, 211.12~MeV, 214.26~MeV @Ma:2012bm for $""^"235"$U, $""^"238"$U, $""^"239"$Pu, $""^"241"$Pu, respectively. The $macron(nu)_e$ energy spectrum per fission of $""^"235"$U, $""^"239"$Pu and $""^"241"$Pu is obtained from Huber @Huber:2011wv, and of $""^"238"$U from Mueller #emph[et al.] @Mueller:2011nm.


Additional corrections are applied to account for the non-equilibrium and spent nuclear fuel contributions. The former arises from beta decays of some long-lived fission fragments and adds an extra $tilde$0.6\% to the antineutrino flux. The latter is caused by the spent nuclear fuel removed to cooling pools near the reactor cores still emitting antineutrinos and contributes an additional $tilde$0.3\% to the flux. The corrections are obtained from Ref. @An:2016srz, both of which are assigned a 30\% rate uncertainty and a negligible spectrum shape uncertainty, in agreement with the latest results from Daya Bay @Adey:2018zwh. The total unoscillated spectrum for JUNO is obtained by aggregating the contributions of the four isotopes in the Huber-Mueller model and correcting for these two effects. Discrepancies have been found between the data and the models, most notably a $tilde$5\% deficit of the total flux with respect to the Huber-Mueller prediction, commonly known as the reactor antineutrino anomaly, and a spectral distortion in the $tilde$[4, 6]~MeV region observed when comparing to both conversion and summation models@DoubleChooz:2019qbj @Bak:2018ydk @DayaBay:2019yxq @Ko:2016owz @PROSPECT:2020sxr @STEREO:2020fvd @Giunti:2021kab @Hayes:2016qnu. Therefore, the ratio between the measurement and the total prediction in Daya Bay @An:2016srz is used to further correct the total prediction used in this sensitivity study.


The uncertainties of the predicted reactor antineutrino flux are listed at the top of @tab-rate-systematics. The baselines are known to 1~m, resulting in a negligible contribution to the flux uncertainty at distances of $tilde$52.5~km. The reactor power data will be provided by the NPPs with an uncertainty of 0.5\%. Likewise, the fission fractions will be provided with an uncertainty of 5\%, which will contribute an uncertainty of 0.6\% to the predicted number of events. The mean energy per fission is known precisely and contributes only a 0.2\% uncertainty to the predicted number of events. Finally, a 2\% correlated uncertainty is assigned for the mean cross-section per fission, which is the product of the IBD cross-section with the total antineutrino spectrum and is thus proportional to the number of predicted events. All of these uncertainties are drawn directly from the experience accumulated by the Daya Bay experiment @An:2016srz.


As noted in @sec-detector, TAO is a satellite detector whose primary objective is to provide a precise and model-independent antineutrino spectrum for JUNO to use as a reference @Abusleme:2020bzt:TAO_CDR. This spectrum will be measured with sub-percent energy resolution in most of the energy region of interest.


The expected uncertainty from TAO's measured spectrum, estimated from a simulation of that detector @Abusleme:2020bzt:TAO_CDR, is propagated as the spectral shape uncertainty in this analysis. TAO will collect about two million IBD events in three years, representing 20 times the statistics of JUNO. As a result, the statistical uncertainty with 20 keV-sized bins will be below 1\% across the $tilde$[2.5, 5.5]~MeV energy range. The systematic uncertainties considered include the scintillator nonlinearity, differences in fission fractions, and the impact of using a fiducial volume cut. As will be shown in @fig-shape, the combined statistical and systematic uncertainties yield a spectral shape uncertainty that is below $1.5 "%"$ in the [2, 4]~MeV energy region. This energy-dependent uncertainty replaces the uniform 1\% bin-to-bin uncertainty used in Ref. @An:2015jdp.


= Neutrino Oscillation Analysis
<neutrino-oscillation-analysis>


To extract the neutrino oscillation parameters, we compare the nominal spectrum, a proxy of the expected spectrum that JUNO will measure, illustrated in @fig-ibd, against the hypothesis model based on the standard parametrization ($Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$) described in @sec-osc-framework. The current section describes the procedure, inputs, and systematic uncertainties used to perform this comparison, as well as the resulting sensitivities. The sensitivities' evolution with time, the correlations between oscillation parameters, and the impact of the systematic uncertainties on the parameters' precision, are also shown.


== Statistical Method
<sec-stat-method>


To compare the data to the hypothesis model, we employ the least-squares method, and construct a binned $chi^2$ with covariance matrices and/or pull terms to account for systematic uncertainties @Stump:2001gu,

$ chi^2 equiv (bold(M) - bold(T) (theta, alpha))^T dot bold(V)^(-1) dot (bold(M) - bold(T) (theta, alpha)) + sum_i (alpha_i / sigma_i)^2, $ <eq-chi-squared>

where $bold(M)$ and $bold(T)$ represent the measured and expected vectors of events per individual energy bin, respectively, and $bold(V)$ is the covariance matrix of the prediction. For this analysis, $bold(M)$ is set to the nominal expectation without any fluctuations. $bold(T)$ depends on the oscillation parameters $bold(theta)$ described in @sec-osc-framework, as well as on the nuisance parameters $alpha_i$, each of which has a corresponding systematic uncertainty $sigma_i$. The pull terms on the right hand side of @eq-chi-squared can substitute any covariance matrix representing a systematic uncertainty, and vice-versa.


The full analysis, from the determination of $bold(M)$ and $bold(T) (theta, alpha)$ to the sensitivity calculations, was independently carried out by four analysis groups that started from the same common inputs. These common inputs express the current best knowledge of JUNO's performance and reactor situation, as described in the previous sections, and are also used by other sensitivity studies within the JUNO collaboration. Each of the four groups chose a different strategy to perform the minimization of @eq-chi-squared. One group used a covariance matrix-only approach, two groups used a pull term-only approach, and a fourth group used a mixture of both. Results were carefully compared at every stage of the analysis chain and differences in the final sensitivities were found to be much smaller than the systematic uncertainties. Accordingly, only one set of results, which is representative of the four groups, is shown in the remainder of this publication.


== Rate and Shape Systematic Effects
<sec-systematics>


The assessment of the systematic uncertainties benefits largely from the large pool of knowledge accumulated by past and current reactor experiments, particularly those focused on precisely measuring the $theta_13$ mixing angle @Adey:2018zwh @DoubleChooz:2019qbj @Bak:2018ydk. Systematic effects fall into two categories: rate and shape. Rate systematic uncertainties are those affecting the total number of IBD candidates (normalization), while shape systematic uncertainties are those that can bias the expected spectral shape (events per individual energy bin).


#figure(
  table(
    columns: 2,
    align: (left, center),
    table.header([Component], [Input Uncertainty (\%)]),
    table.hline(),
    [Flux], [2.2],
    [~~~Baseline (L)], [~~~~~~-],
    [~~~Energy per Fission], [~~~~~~0.2],
    [~~~Thermal Power (P)], [~~~~~~0.5],
    [~~~Fission Fraction], [~~~~~~0.6],
    [~~~Mean Cross-Section per Fission], [~~~~~~2.0],
    [Detection], [1.0],
    [~~~Fiducial volume (2~cm vertex bias)], [~~~~~~0.4],
    [~~~IBD Selection cuts], [~~~~~~0.2],
    [~~~Muon Veto], [~~~~~~-],
    [~~~Proton Number], [~~~~~~0.9],
    [Backgrounds], [1.0],
    [~~~Geoneutrinos], [~~~~~~0.8],
    [~~~$""^"9"$Li/$""^"8"$He], [~~~~~~0.4],
    [~~~Atmospheric neutrinos], [~~~~~~0.2],
    [~~~Fast neutrons], [~~~~~~0.2],
    [~~~$""^"13"$C($alpha$, $n$)$""^"16"$O], [~~~~~~0.1],
    [~~~Accidentals], [~~~~$< 0.1$],
    [~~~World reactors], [~~~~$< 0.1$],
  ),
  caption: [
    Signal normalization systematic uncertainties of JUNO. All uncertainties (backgrounds included) are relative to the signal rate of 43.2 measured IBDs per day, which accounts for the reactors' duty cycle. These uncertainties are used as inputs to the analysis. The flux systematic uncertainties have correlated and uncorrelated terms, with respect to the reactors. See the text for more details. The detection systematic uncertainties contain the same items of @tab-efficiency plus the uncertainty on the number of target protons.
  ],
  kind: table,
) <tab-rate-systematics>


Rate systematic effects and their corresponding uncertainties are summarized in @tab-rate-systematics. They are divided into three main subcategories: flux, detection, and backgrounds. Within the flux subcategory, reactor-related uncertainties impact the analysis differently depending on whether they are correlated (2\%) or uncorrelated (0.8\%). Reactor correlated uncertainties, namely the mean cross-section per fission and energy per fission, affect all reactors contributing to the total neutrino flux in the same way, while reactor uncorrelated uncertainties, namely the thermal power and fission fraction, can vary independently from reactor to reactor. The detection systematic uncertainty of 1\% encapsulates those uncertainties affecting the total number of selected IBD events.


The dominant contribution on the flux category is the mean cross-section per fission, while on the detection category it is the target proton number uncertainty, which is estimated based on Daya Bay's experience @DayaBay:2016ggj. The background rate uncertainties that are used as input to the analysis are shown in @tab-backgrounds, but @tab-rate-systematics shows the relative uncertainty of the background rates compared to the IBD signal rate so they can be compared to other rate systematic uncertainties. The relative impact of the various backgrounds is different in JUNO compared to short baseline reactor neutrino experiments because of the drastic difference in the signal to background ratio. The two dominant backgrounds in terms of their uncertainty relative to the IBD signal are geoneutrinos and $""^"9"$Li/$""^"8"$He, but their very different spectral shapes compared to the distorted IBD spectra, illustrated in @fig-ibd, provide additional constraints during the analysis.


The effects distorting the shape of the spectrum and their impact relative to the number of events are summarized in @fig-shape.


// [figvision-cn] imgs/ShapeUncertainties_v0318_linearscale.png
// 该图像为一张单图，类型为曲线图。 横坐标轴名称为“
// Visible Energy [MeV]”（可见能量），单位为兆电子伏特（
// MeV），数值范围从0.5延伸至8，主刻度标记为1至8的整数。
// 纵坐标轴名称为“Relative Uncertainty [%]”（相对不确定性），
// 单位为百分比（%），数值范围从0至10，主刻度标记为0、2、
// 4、6、8、10。 图中包含八条不同颜色的曲线，分别代表不同
// 的物理量来源及其组合： 红色实线：代表“TAO-based flux”
// （基于TAO的通量）。该曲线在低能区（约1 MeV附近）具有极
// 高的值，随后迅速下降，在3 MeV处降至约1%，之后随着能量
// 增加缓慢上升，在7.8 MeV附近达到约8.5%。 黑色粗实线：代
// 表“Total”（总不确定性）。该曲线位于所有其他曲线的上方
// 或与之重合，代表了各项不确定性的综合效果。其趋势与红色
// 曲线高度一致，在低能区极高，中间区域（约3-5 MeV）保持
// 最低水平（约1%），并在高能区显著上升，在8 MeV处接近10%。
// 绿色实线：代表“Background”（本底）。该曲线在1 MeV附近
// 出现一个显著的峰值，约为7.5%，随后下降并在3 MeV后保持
// 在较低水平，但在超过6 MeV后急剧上升，最终在8 MeV处超过
// 10%。 青色实线：代表“Nonlinearity”（非线性效应）。该曲
// 线在1 MeV以下数值较高，随能量增加迅速下降，在2-6 MeV区
// 间内维持在1%以下，但在7 MeV附近出现一个局部小峰，随后
// 再次下降。 品红色实线：代表“Non-equilibrium”（非平衡态）。
// 该曲线整体处于极低水平，始终低于1.5%，并随能量增加呈现
// 缓慢下降趋势。 橄榄绿色实线：代表“Spent nuclear fuel”
// （乏燃料）。该曲线在整个能量范围内都非常低，始终低于1%，
// 变化平缓。 深蓝色实线：代表“Energy resolution”（能量分
// 辨率）。该曲线几乎完全贴合横坐标轴，数值接近于0，仅在
// 极低的能量区域有微小的波动。 棕色实线：代表“Matter
// density”（物质密度）。该曲线同样几乎完全贴合横坐标轴，
// 数值接近于0。 图例位于图表的顶部中央及两侧，列出了上述
// 各曲线对应的标签。 该子图传达了反应堆反中微子信号在不
// 同可见能量下的相对形状不确定性分布。结论显示，总的不确
// 定性主要由“TAO-based flux”主导，特别是在高能区；而“
// Background”在低能区和极高能区对不确定性有显著贡献。在3
// 到5 MeV的能量区间内，总不确定性最小，约为1%。
#figure(
  image("imgs/ShapeUncertainties_v0318_linearscale.png", width: 90%),
  caption: [
    Shape uncertainties relative to the number of events in each bin. These are obtained by generating simulated samples where systematic parameters are varied based on their assumed uncertainties and taking the ratio of the diagonal elements of the resulting covariance matrix to the number of nominal reactor antineutrino signal events in each bin. The rate uncertainties of the spent nuclear fuel and non-equilibrium corrections, as well as of the backgrounds, also distort the observed spectrum, and are consequently included in this figure.
  ],
) <fig-shape>


The main contributions are the uncertainties in the reactor antineutrino spectrum and the backgrounds. As already mentioned in @sec-flux, there is mounting evidence that the systematic uncertainties of the predicted reactor antineutrino flux and shape are underestimated. For JUNO, the dedicated satellite detector TAO will provide the data-driven spectral uncertainty with an unprecedented energy resolution better than 2\% at 1~MeV @Abusleme:2020bzt:TAO_CDR. We use this TAO-based spectrum model uncertainty in our analysis. The uncertainty of the detector response model, described in @sec-detector-response and typically controlled to less than 0.5\% @Adey:2019zfo:DYB_NL @Chauveau:2018ze @Re:2018ze @Gando:2018ze, is also important for the accuracy of the neutrino oscillation parameters. Its propagated uncertainty relates directly to the signal spectral shape, thus the small oscillations on @fig-shape. This figure also shows the background uncertainty with respect to the antineutrino signal, which includes all rate and shape uncertainties of @tab-backgrounds. Similarly, the non-equilibrium and spent nuclear fuel uncertainties, discussed in the end of @sec-flux, are included in this figure, since they affect the signal spectrum in specific energy ranges. Finally, the 6\% uncertainty on the matter density impacts the oscillation probability, as described in @sec-matter, but makes a very small contribution to the shape uncertainty.


== Neutrino Oscillation Sensitivity Results
<sec-results>


The 1$sigma$ uncertainty for $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ is calculated with all rate and shape systematic uncertainties in three different regimes of data-taking time: 100 days (statistics-dominated regime); 6 years (nominal); and 20 years (systematics-dominated regime). The 1$sigma$ limits of each parameter are obtained by marginalizing over all others, and finding the values for which $Delta chi^2$ changes by a unit. The total precision obtained is summarized in @tab-sensitivity. Additionally, @fig-sensitivity shows the $Delta chi^2$ profiles of JUNO compared to today's state of the art knowledge @Zyla:2020zbs. As shown there, JUNO is expected to improve upon today's precision by almost one order of magnitude for three out of six neutrino oscillation parameters, measuring them to the per mille precision. In fact, about 100~days of data taking would be enough for JUNO to dominate the world precision on those parameters, although additional improvements are expected with more statistics. This is particularly the case for $Delta m_31^2$, as coarsely quantified in @tab-sensitivity, but fully illustrated in @fig-sensitivity-time where the impact of the systematic uncertainties can be observed via the deviation of the total sensitivity from the statistics-only limit.


#figure(
  table(
    columns: 6,
    align: center,
    table.header([], [Central Value], [PDG2020], [100 days], [6 years], [20 years]),
    table.hline(),
    [$Delta m_31^2$ ($times 10^(-3) "eV"^2$)], [2.5283], [$plus.minus 0.034$ (1.3\%)], [$plus.minus 0.021$ (0.8\%)], [$plus.minus 0.0047$ (0.2\%)], [$plus.minus 0.0029$ (0.1\%)],
    [$Delta m_21^2$ ($times 10^(-5) "eV"^2$)], [7.53], [$plus.minus 0.18$ (2.4\%)], [$plus.minus 0.074$ (1.0\%)], [$plus.minus 0.024$ (0.3\%)], [$plus.minus 0.017$ (0.2\%)],
    [$sin^2 theta_12$], [0.307], [$plus.minus 0.013$ (4.2\%)], [$plus.minus 0.0058$ (1.9\%)], [$plus.minus 0.0016$ (0.5\%)], [$plus.minus 0.0010$ (0.3\%)],
    [$sin^2 theta_13$], [0.0218], [$plus.minus 0.0007$ (3.2\%)], [$plus.minus 0.010$ (47.9\%)], [$plus.minus 0.0026$ (12.1\%)], [$plus.minus 0.0016$ (7.3\%)],
    table.hline(),
  ),
  caption: [
    A summary of precision levels for the oscillation parameters. The current knowledge (PDG2020 @Zyla:2020zbs) is compared with 100~days, 6~years, and 20~years of JUNO data taking. No external constraint on $sin^2 theta_13$ is applied for these results.
  ],
  kind: table,
) <tab-sensitivity>


// [figvision-cn] imgs/Chi_dmsq31_sinsq12_dmsq21_sinsq13_6years.png
// 该图像由四个水平排列的独立子图组成，从左至右依次展示不
// 同振荡参数的分布比较。所有子图共享左侧一个统一的纵坐标
// 轴和右上角的一个统一图例。 纵坐标轴 名称：Δχ²（Delta
// Chi-squared）。 范围与刻度：数值范围从0到10。主刻度线
// 标记在0, 2, 4, 6, 8, 10处。图中绘制了三条贯穿所有子图
// 的灰色水平虚线，分别位于y=1, y=3.84（对应约95%置信度）
// 和y=9（对应约99.7%置信度）的位置，作为参考阈值。 图例
// 位置：位于最右侧子图的上方区域。 内容：包含两个条目。
// 第一条目：一条黑灰色的点划线（dash-dot line），标注文
// 字为“PDG2020 precision”，代表当前粒子数据组（Particle
// Data Group 2020）的测量精度分布。 第二条目：一条实心红
// 线（solid red line），标注文字为“JUNO 6 years”，代表
// JUNO实验运行6年后的投影精度分布。 子图a（左一） 类型：
// 曲线图（抛物线拟合分布）。 横坐标轴： 名称：Δm²₃₁ [10⁻
// ³ eV²]（质量平方差）。 范围：2.50 到 2.60。 刻度：主刻
// 度标记在2.50, 2.55, 2.60。 曲线特征： 黑灰色点划线：呈
// 现为一个开口向上的宽抛物线形状，顶点位于x≈2.53附近，y=
// 0。曲线较平缓，当y值达到4时，x轴跨度约为2.51至2.56。
// 红色实线：呈现为一个极窄且陡峭的开口向上抛物线形状，顶
// 点同样位于x≈2.53附近，y=0。曲线非常尖锐，在y值仅为4左
// 右时，x轴跨度极小，几乎垂直上升。 结论：JUNO实验对参数
// Δm²₃₁的测量精度（红线的狭窄程度）显著优于当前的PDG2020
// 精度（灰线的宽阔程度）。 子图b（左二） 类型：曲线图（
// 抛物线拟合分布）。 横坐标轴： 名称：Δm²₂₁ [10⁻⁵ eV²]（
// 质量平方差）。 范围：7.25 到 7.75。 刻度：主刻度标记在
// 7.25, 7.50, 7.75。 曲线特征： 黑灰色点划线：呈现为宽抛
// 物线，顶点位于x≈7.50，y=0。 红色实线：呈现为极窄陡峭的
// 抛物线，顶点位于x≈7.50，y=0。其宽度远小于灰线。 结论：
// JUNO实验对参数Δm²₂₁的测量精度将大幅提升。 子图c（右二）
// 类型：曲线图（抛物线拟合分布）。 横坐标轴： 名称：sin²
// θ₁₂（混合角正弦平方）。 范围：0.28 到 0.32。 刻度：主
// 刻度标记在0.28, 0.30, 0.32。 曲线特征： 黑灰色点划线：
// 呈现为宽抛物线，顶点位于x≈0.305，y=0。 红色实线：呈现
// 为极窄陡峭的抛物线，顶点位于x≈0.305，y=0。 结论：JUNO
// 实验将显著提高对混合角参数sin²θ₁₂的测量精度。 子图d（
// 右一） 类型：曲线图（抛物线拟合分布）。 横坐标轴： 名
// 称：sin²θ₁₃ [10⁻²]（混合角正弦平方）。 范围：2.0 到
// 2.5。 刻度：主刻度标记在2.0, 2.5。 曲线特征： 黑灰色点
// 划线：呈现为宽抛物线，顶点位于x≈2.2，y=0。 红色实线：
// 呈现为比前三个子图稍宽的抛物线，但仍明显窄于灰线。顶点
// 位于x≈2.2，y=0。 结论：JUNO实验对参数sin²θ₁₃的测量精度
// 也有提升，但相对于其他三个参数，其精度的相对提升幅度在
// 视觉上略小。
#figure(
  image("imgs/Chi_dmsq31_sinsq12_dmsq21_sinsq13_6years.png", width: 90%),
  caption: [
    Comparison of 1-d $Delta chi^2$ distributions of oscillation parameters: Today (PDG2020, dashed curve) v.s. projection with 6~years data taking of JUNO (solid red curve).
  ],
) <fig-sensitivity>


// [figvision-cn] imgs/SensitivityOverTimeBOTH_days.png
// 该图是一张双对数坐标曲线图，展示了JUNO实验在数据采集时
// 间从100天到超过10万天的过程中，四个振荡参数相对精度的
// 变化趋势。横坐标为“JUNO Data Taking Time [days]”，即
// JUNO数据采集时间（单位：天），采用对数刻度，范围从10²
// （100天）至10⁵（100,000天）。纵坐标为“Relative
// Precision [%]”，即相对精度（单位：百分比），同样采用对
// 数刻度，范围从10⁻²%到10²%。 图中包含四条主曲线，分别对
// 应四个物理参数： 红色实心圆点标记的曲线代表Δm₃₁²； 绿
// 色五角星标记的曲线代表Δm₂₁²； 蓝色左向三角形标记的曲线
// 代表sin²θ₁₂； 黑色叉号标记的曲线代表sin²θ₁₃。 每条参数
// 曲线均绘制了两条线型以区分误差来源： 实线表示统计误差
// 与系统误差之和（Stat.+syst.）； 虚线表示仅考虑统计误差
// 的情况（Stat. only）。 图例位于右上角，明确标注了上述
// 符号、颜色及线型含义。 三条垂直虚线标示关键时间节点：
// 橙色虚线位于横坐标10²处，上方标注“100 days”； 黑色虚线
// 位于约2×10³处（对应6年），上方标注“6 years”； 绿色虚线
// 位于约7.3×10³处（对应20年），上方标注“20 years”。 一条
// 水平灰色虚线贯穿全图，位于纵坐标10⁰%处，代表1%的相对精
// 度基准线。 所有曲线均随数据采集时间增加而下降，表明精
// 度提升。其中： sin²θ₁₃（黑色叉号）初始精度最差（100天
// 时约40%），但下降最快，在20年后降至约8%； Δm₃₁²（红色
// 圆点）和Δm₂₁²（绿色五角星）在统计误差主导下几乎重合（
// 红绿虚线重叠），100天时约为1%，20年后分别降至约0.1%和
// 0.2%； sin²θ₁₂（蓝色三角）始终优于其他参数，100天时约2%，
// 20年后仍保持在0.3%左右。 在100天时间点，各参数对应的数
// 据点被特别标出： sin²θ₁₃：~40% sin²θ₁₂：~2% Δm₂₁²：~1%
// Δm₃₁²：~0.9% 在6年（约2200天）时： sin²θ₁₃：~12% sin²θ
// ₁₂：~0.6% Δm₂₁²：~0.4% Δm₃₁²：~0.25% 在20年（约7300天）
// 时： sin²θ₁₃：~8% sin²θ₁₂：~0.4% Δm₂₁²：~0.2% Δm₃₁²：~
// 0.12% 值得注意的是，对于Δm₃₁²和Δm₂₁²，其统计误差曲线（
// 虚线）完全重合，说明两者在纯统计极限下的精度表现一致。
// 而系统误差的存在使得实线与虚线分离，尤其在长时间运行后
// 更为明显，例如sin²θ₁₃在20年后实线比虚线高出约一个数量
// 级。 整体趋势显示：随着数据采集时间延长，所有参数精度
// 持续提升，但受系统误差限制，部分参数（如sin²θ₁₃）在长
// 周期内收敛速度放缓。目标1%精度线在约1000–2000天内被多
// 个参数突破，其中Δm₃₁²最早达到（约500天），sin²θ₁₃最晚
// （约10000天）。
#figure(
  image("imgs/SensitivityOverTimeBOTH_days.png", width: 90%),
  caption: [
    Relative precision of the oscillation parameters as a function of JUNO data taking time. The markers and vertical lines stand for 100 days, 6 years, and 20 years of data taking. The horizontal gray dashed line stands for 1\% relative precision. The green dotted and red dotted lines are on top of each other since the statistical-only precision is essentially identical for the $Delta m_31^2$ and $Delta m_21^2$ parameters.
  ],
) <fig-sensitivity-time>


The breakdown of statistical and systematic uncertainties on each parameter is shown in @fig-sensitivity-breakdown for a nominal exposure of 6 years, allowing to identify the most important systematic effects. The statistics-only sensitivity is also provided so that the relative impact of the systematic uncertainties can be easily seen.


// [figvision-cn] imgs/syst_stat_V2_dm2_21_6years.png
// 该图像是一个水平条形图，展示了针对物理参数 Δm²₂₁ 的相
// 对误差来源分析。图表顶部中央标题为“Δm²₂₁”。 图表布局分
// 为左、中、右三个部分。左侧列出了误差来源的分类标签；中
// 间列显示了对应的数值，表头为“1σ (%)”；右侧是可视化的条
// 形图区域。 条形图的横坐标位于底部，单位标记为“%”，刻度
// 范围从0.0开始，标有0.2的刻度线，并有一条垂直虚线延伸至
// 图表顶部以辅助读数。纵轴没有连续的数值刻度，而是由一系
// 列分类标签组成。 图表中的条目及其对应的数据值和图形特
// 征如下： 第一部分（统计误差）： 第一行标签为“
// Statistics”。对应的数值为0.16。右侧条形为一个空心矩形
// 框，轮廓线为蓝色，内部透明，长度对应数值0.16。 第二部
// 分（反应堆相关系统误差，Reactor）： 此部分包含五个子项，
// 均为实心蓝色条形： “- Uncorrelated”：数值0.01，条形极
// 短。 “- Correlated”：数值0.03，条形较短。 “- Reference
// spectrum”：数值0.07，条形长度约为0.2刻度的三分之一。 “
// - Spent Nuclear Fuel”：数值0.07，条形长度与上一项相同。
// “- Non-equilibrium”：数值0.14，条形较长，接近0.2刻度但
// 未达到。 第三部分（探测相关系统误差，Detection）： 此
// 部分包含四个子项，均为实心蓝色条形： “- Efficiency”：
// 数值0.02，条形很短。 “- Energy resolution”：数值0.01，
// 条形极短。 “- Nonlinearity”：数值0.05，条形长度适中。
// “- Backgrounds”：数值0.18，条形很长，几乎触及0.2的垂直
// 虚线。 第四部分（其他及总计）： 标签“Matter density”：
// 数值0.01，条形极短，为实心蓝色。 标签“All systematics”：
// 数值0.27，条形为实心黑色，长度明显超过0.2的垂直虚线。
// 标签“Total”：数值0.32，条形为实心橙色，是图中所有条形
// 中最长的一个。 图表传达的趋势是：对于 Δm²₂₁ 参数，总误
// 差（0.32%）主要由系统误差（0.27%）主导，而不仅仅是统计
// 误差（0.16%）。在系统误差中，“Backgrounds”（背景噪声）、
// “Non-equilibrium”（非平衡态）以及反应堆相关的谱和燃料
// 因素是主要的贡献者。
// [figvision-cn] imgs/syst_stat_V2_dm2_31_6years.png
// 该图为一张水平条形图，标题为“Δm²₃₁”，展示了不同不确定
// 性来源对振荡参数 Δm²₃₁ 总精度的相对影响。图表由左侧的
// 类别标签列、中间的数值列和右侧的可视化条形组成。 中间
// 列的表头为“1σ (%)”，表示各因素导致的 1 倍标准差百分比
// 误差。 右侧的横坐标轴位于底部，单位为“%”，刻度标记包括
// 0.0 和 0.1，并有一条垂直虚线穿过 0.1 的位置作为参考。
// 数据行从上到下依次为： 第一行：“Statistics”（统计误差），
// 数值为 0.17。对应的条形是一个空心蓝色矩形框，长度延伸
// 至约 0.17 处，代表仅考虑反应堆反中微子样本统计不确定性
// 时的结果。 第二行为分类标题“Reactor:”。 第三行：“-
// Uncorrelated”（不相关系统误差），数值小于 0.01。对应一
// 个极短的实心蓝色条。 第四行：“- Correlated”（相关系统
// 误差），数值为 0.01。对应一个较短的实心蓝色条。 第五行：
// “- Reference spectrum”（参考能谱），数值为 0.05。对应
// 一个中等长度的实心蓝色条。 第六行：“- Spent Nuclear
// Fuel”（乏燃料），数值小于 0.01。对应一个极短的实心蓝色
// 条。 第七行：“- Non-equilibrium”（非平衡态），数值小于
// 0.01。对应一个极短的实心蓝色条。 第八行为分类标题“
// Detection:”。 第九行：“- Efficiency”（探测效率），数值
// 为 0.01。对应一个较短的实心蓝色条。 第十行：“- Energy
// resolution”（能量分辨率），数值小于 0.01。对应一个极短
// 的实心蓝色条。 第十一行：“- Nonlinearity”（非线性），
// 数值为 0.04。对应一个中等长度的实心蓝色条。 第十二行：
// “- Backgrounds”（本底），数值为 0.04。对应一个中等长度
// 的实心蓝色条。 第十三行：“Matter density”（物质密度），
// 数值为 0.01。对应一个较短的实心蓝色条。 第十四行：“All
// systematics”（所有系统误差总和），数值为 0.08。对应一
// 个较长的实心黑色条，代表所有系统误差综合后的影响。 最
// 后一行：“Total”（总误差），数值为 0.19。对应一个最长的
// 实心橙色条，代表统计误差与系统误差合成后的总精度。 结
// 论：该图表明，对于 Δm²₃₁ 参数，统计误差（0.17%）是主要
// 的不确定性来源，其次是系统误差中的参考能谱（0.05%）、
// 非线性（0.04%）和本底（0.04%）。所有系统误差综合贡献为
// 0.08%，最终总精度为 0.19%。
// [figvision-cn] imgs/syst_stat_V2_sin2_th12_6years.png
// 该图像展示了一张针对振荡参数 sin²θ₁₂ 的误差来源分析水
// 平条形图。图表由左侧的文本标签列、中间的数值数据列和右
// 侧的可视化条形图三部分组成，背景为白色，带有浅灰色水平
// 网格线。 顶部标题位于图表左上方，显示数学符号“sin²θ₁₂”。
// 在标题下方，图表分为两列，中间一列的表头为“1σ (%)”，表
// 示数据单位为百分比且代表1倍标准差的不确定度；最右侧为
// 绘图区，底部横轴标签为“%”，刻度从0.0开始，主要刻度标记
// 为0.2和0.4，并在对应位置有垂直虚线网格。 图表按行展示
// 了不同误差源对总精度的影响，具体描述如下： 第一行标签
// 为“Statistics”（统计误差），对应的数值为0.34。右侧绘制
// 了一个空心矩形条，边框为蓝色，内部透明，其长度延伸至横
// 坐标约0.34的位置。根据参考信息，这代表仅考虑反应堆反中
// 微子样本统计误差时的不确定度。 第二行为分类标题“
// Reactor:”（反应堆相关），无对应数值和条形。 第三行标签
// 为“- Uncorrelated”（不相关误差），数值为0.10。右侧是一
// 个实心蓝色矩形条，长度对应0.10。 第四行标签为“-
// Correlated”（相关误差），数值为0.27。右侧是一个实心蓝
// 色矩形条，长度对应0.27。 第五行标签为“- Reference
// spectrum”（参考能谱），数值为0.09。右侧是一个实心蓝色
// 矩形条，长度对应0.09。 第六行标签为“- Spent Nuclear
// Fuel”（核废料），数值为0.05。右侧是一个较短的实心蓝色
// 矩形条，长度对应0.05。 第七行标签为“- Non-equilibrium”
// （非平衡态），数值为0.10。右侧是一个实心蓝色矩形条，长
// 度对应0.10。 第八行为分类标题“Detection:”（探测相关），
// 无对应数值和条形。 第九行标签为“- Efficiency”（效率），
// 数值为0.23。右侧是一个实心蓝色矩形条，长度对应0.23。
// 第十行标签为“- Energy resolution”（能量分辨率），数值
// 为0.01。右侧是一个非常短的实心蓝色矩形条，几乎贴近纵轴。
// 第十一行标签为“- Nonlinearity”（非线性），数值为0.09。
// 右侧是一个实心蓝色矩形条，长度对应0.09。 第十二行标签
// 为“- Backgrounds”（本底），数值为0.20。右侧是一个实心
// 蓝色矩形条，长度对应0.20。 第十三行标签为“Matter
// density”（物质密度），数值为0.07。右侧是一个实心蓝色矩
// 形条，长度对应0.07。 第十四行标签为“All systematics”（
// 所有系统误差总和），数值为0.40。右侧是一个实心黑色矩形
// 条，长度对应0.40。这代表了图中所有蓝色条形所示的系统误
// 差的综合影响。 最后一行标签为“Total”（总不确定度），数
// 值为0.52。右侧是一个实心橙色矩形条，是所有条形中最长的
// 一个，长度对应0.52。这代表了统计误差与所有系统误差合成
// 后的最终总精度。 整体趋势表明，对于 sin²θ₁₂ 参数的测量，
// 总不确定度（0.52%）略高于仅考虑统计误差的情况（0.34%）。
// 在所有系统误差源中，“Correlated”（0.27%）、“Efficiency
// ”（0.23%）和“Backgrounds”（0.20%）是贡献最大的三个因素。
// [figvision-cn] imgs/syst_stat_V2_dm2_21_6years.png
// 该图像是一个水平条形图，展示了针对物理参数 Δm²₂₁ 的相
// 对误差来源分析。图表顶部中央标题为“Δm²₂₁”。 图表布局分
// 为左、中、右三个部分。左侧列出了误差来源的分类标签；中
// 间列显示了对应的数值，表头为“1σ (%)”；右侧是可视化的条
// 形图区域。 条形图的横坐标位于底部，单位标记为“%”，刻度
// 范围从0.0开始，标有0.2的刻度线，并有一条垂直虚线延伸至
// 图表顶部以辅助读数。纵轴没有连续的数值刻度，而是由一系
// 列分类标签组成。 图表中的条目及其对应的数据值和图形特
// 征如下： 第一部分（统计误差）： 第一行标签为“
// Statistics”。对应的数值为0.16。右侧条形为一个空心矩形
// 框，轮廓线为蓝色，内部透明，长度对应数值0.16。 第二部
// 分（反应堆相关系统误差，Reactor）： 此部分包含五个子项，
// 均为实心蓝色条形： “- Uncorrelated”：数值0.01，条形极
// 短。 “- Correlated”：数值0.03，条形较短。 “- Reference
// spectrum”：数值0.07，条形长度约为0.2刻度的三分之一。 “
// - Spent Nuclear Fuel”：数值0.07，条形长度与上一项相同。
// “- Non-equilibrium”：数值0.14，条形较长，接近0.2刻度但
// 未达到。 第三部分（探测相关系统误差，Detection）： 此
// 部分包含四个子项，均为实心蓝色条形： “- Efficiency”：
// 数值0.02，条形很短。 “- Energy resolution”：数值0.01，
// 条形极短。 “- Nonlinearity”：数值0.05，条形长度适中。
// “- Backgrounds”：数值0.18，条形很长，几乎触及0.2的垂直
// 虚线。 第四部分（其他及总计）： 标签“Matter density”：
// 数值0.01，条形极短，为实心蓝色。 标签“All systematics”：
// 数值0.27，条形为实心黑色，长度明显超过0.2的垂直虚线。
// 标签“Total”：数值0.32，条形为实心橙色，是图中所有条形
// 中最长的一个。 图表传达的趋势是：对于 Δm²₂₁ 参数，总误
// 差（0.32%）主要由系统误差（0.27%）主导，而不仅仅是统计
// 误差（0.16%）。在系统误差中，“Backgrounds”（背景噪声）、
// “Non-equilibrium”（非平衡态）以及反应堆相关的谱和燃料
// 因素是主要的贡献者。
// 后一行：“Total”（总误差），数值为 0.19。对应一个最长的
// 实心橙色条，代表统计误差与系统误差合成后的总精度。 结
// 论：该图表明，对于 Δm²₃₁ 参数，统计误差（0.17%）是主要
// 的不确定性来源，其次是系统误差中的参考能谱（0.05%）、
// 非线性（0.04%）和本底（0.04%）。所有系统误差综合贡献为
// 0.08%，最终总精度为 0.19%。
// 第十一行标签为“- Nonlinearity”（非线性），数值为0.09。
// 右侧是一个实心蓝色矩形条，长度对应0.09。 第十二行标签
// 为“- Backgrounds”（本底），数值为0.20。右侧是一个实心
// 蓝色矩形条，长度对应0.20。 第十三行标签为“Matter
// density”（物质密度），数值为0.07。右侧是一个实心蓝色矩
// 形条，长度对应0.07。 第十四行标签为“All systematics”（
// 所有系统误差总和），数值为0.40。右侧是一个实心黑色矩形
// 条，长度对应0.40。这代表了图中所有蓝色条形所示的系统误
// 差的综合影响。 最后一行标签为“Total”（总不确定度），数
// 值为0.52。右侧是一个实心橙色矩形条，是所有条形中最长的
// 一个，长度对应0.52。这代表了统计误差与所有系统误差合成
// 后的最终总精度。 整体趋势表明，对于 sin²θ₁₂ 参数的测量，
// 总不确定度（0.52%）略高于仅考虑统计误差的情况（0.34%）。
// 在所有系统误差源中，“Correlated”（0.27%）、“Efficiency
// ”（0.23%）和“Backgrounds”（0.20%）是贡献最大的三个因素。
#figure(
  grid(
    columns: 2,
    gutter: 1em,
    image("imgs/syst_stat_V2_dm2_31_6years.png", width: 100%),
    image("imgs/syst_stat_V2_dm2_21_6years.png", width: 100%),
    image("imgs/syst_stat_V2_sin2_th12_6years.png", width: 100%),
    image("imgs/syst_stat_V2_sin2_th13_6years.png", width: 100%),
  ),
  caption: [
    An illustration of the relative impact of individual sources of uncertainty on the total precision of the $Delta m_31^2$, $Delta m_21^2$, $sin^2 theta_12$, and $sin^2 theta_13$ oscillation parameters. The empty boxes represent the uncertainty resulting from considering only the statistical uncertainty of the reactor antineutrino sample. The impact of each source of systematic error, represented by the filled blue boxes, is assessed by enabling the corresponding uncertainty together with the statistical uncertainty and removing the latter. The removal is done by assuming that the statistical and systematic uncertainties add in quadrature, which allows to isolate the systematic component as $sqrt(("stat." + "syst.")^2 - ("stat.")^2)$. The filled black box on every graph is obtained using the same procedure but simultaneously turning on all sources of systematic uncertainty rather than one at a time. The total uncertainty resulting from simultaneously considering all sources of statistical and systematic error is shown in the last orange row of each table. All uncertainties correspond to six years of JUNO data and are reported as relative uncertainty contributions to the precision of the particular oscillation parameter.
  ],
) <fig-sensitivity-breakdown>


The sensitivity of the two mixing angles is dominated by rate systematic uncertainties, mainly from the reactor flux normalization and the detector efficiency, both of which affect the analysis in the exact same way. Rate uncertainties have dominated most measurements of oscillation parameters to date, but their impact here is mitigated by JUNO's rich spectral shape information that provides a constraint on the normalization. Even though the reactor correlated uncertainty (due to the mean cross-section per fission and energy per fission uncertainties) is roughly double the efficiency uncertainty as indicated in @tab-rate-systematics, their impact on the mixing angles is quite similar as seen in @fig-sensitivity-breakdown, differing by $tilde$15\% relative. In fact, if these uncertainties are increased very significantly, their impact on the precision changes very little from what it is shown. As a matter of fact, JUNO will be the first oscillation experiment where the spectral information provides such a good constraint on the normalization.


On the other hand, the sensitivity to the two mass splittings is dominated by systematic uncertainties distorting the spectral shape, mainly those from the reference spectrum and the detector nonlinearity. The spent nuclear fuel, non-equilibrium, and background systematic effects also distort the spectral shape, particularly in the low energy region, impacting the precision of $Delta m_21^2$. The precision of the $Delta m_31^2$ and $sin^2 theta_13$ parameters is statistics dominated even after six years of data taking, as indicated in @fig-sensitivity-time.


@fig-sensitivity-breakdown also shows that the impact of the density uncertainty in the calculation of the matter effects is small. Nevertheless, it is important to consider this effect when fitting the oscillation parameters, since it impacts the central value of the measurement, as discussed in the beginning of @sec-matter.


@tab-sensitivity and @fig-sensitivity-time show that JUNO alone has very limited ability to constrain $sin^2 theta_13$ beyond today's world knowledge. On the other hand, if we constrain $sin^2 theta_13$ with the uncertainty from PDG2020 @Zyla:2020zbs, the relative improvement in the precision of the other three parameters is smaller than 0.3\% with 6 years of data.


The impact of the neutrino mass ordering choice on the sensitivity of the parameters was also evaluated and found to be negligible. Therefore, the nominal results presented here are good for both the normal and inverted ordering hypotheses. Using the wrong ordering (e.g. using inverted ordering in a sample where normal ordering was assumed) produced sensitivities that are no larger than 5\% of the nominal values.


As discussed in @sec-reactors, our nominal analysis considered the neutrino flux from the eight reactors $tilde$52.5~km away from the JUNO detector, the six in the Daya Bay power plant and, as a background, all the other reactors in the world. The flux from the Huizhou power plant was not included since no official date for its start of operations was available at the time of writing. However, assuming that the Huizhou power plant is operational from the beginning of JUNO data-taking degrades the sensitivities by less than a relative 3\%.


@sec-detector describes how JUNO has two independent PMT systems (SPMT and LPMT) for photo-detection with different photon occupancy regimes. The ability to perform a measurement of the oscillation parameters using only the SPMT system ($sigma_E tilde$17\% for 1 MeV energy depositions) was also evaluated. While the measurement of the fast oscillation in @fig-spectrum driven by $sin^2 2 theta_13$ and $Delta m_31^2$ requires a very good energy resolution, the solar parameters $sin^2 2 theta_12$ and $Delta m_21^2$ that drive the low frequency oscillation can be measured with the SPMT system alone (see @fig-response). Using the simple model of @sec-detector-response to describe the energy resolution of this system, it was found that the expected precision of the two solar parameters is only less than 5\% worse than the nominal results using the combined LPMT+SPMT system. This will provide a valuable internal validation of these parameters' measurement with some different systematic uncertainties, namely those uncorrelated across the two systems.


Finally, the stability and precision of the results are illustrated by the correlations between the oscillation parameters shown in @fig-correlations. This figure depicts how these parameters are nearly uncorrelated, highlighting the abundant information available in JUNO's high-resolution measurement of the reactor antineutrino spectrum. It also explains the small impact of constraining $sin^2 theta_13$ as discussed above. Each parameter has a specific effect on the spectral shape that is retrievable with minimum interference between the parameters through the analysis described here.


// [figvision-cn] imgs/InterCorrelation_v2_6years.png
// 该图由六个二维参数约束子图以3行2列的矩阵形式排列组成，
// 展示了JUNO实验运行6年后对三组中微子振荡参数对的灵敏度。
// 图中包含一个位于右侧的独立图例区域。所有子图均绘制了三
// 个同心椭圆区域，代表不同置信水平下的参数允许范围。 整
// 体布局与坐标轴定义： 图表呈下三角矩阵排列。 第一行左侧
// 子图（位置1,1）：纵轴为Delta m_21^2，单位是10^-5 eV^2，
// 刻度范围从7.4到7.7；横轴未标注数值，但与下方子图共享x
// 轴变量。 第二行左侧子图（位置2,1）：纵轴为sin^2(
// theta_12)，无单位，刻度范围从0.302到0.312；横轴为Delta
// m_31^2，单位是10^-3 eV^2，刻度范围从2.51到2.55。 第二
// 行中间子图（位置2,2）：纵轴同左图（sin^2(theta_12)），
// 横轴为Delta m_21^2，单位是10^-5 eV^2，刻度范围从7.4到
// 7.7。 第三行左侧子图（位置3,1）：纵轴为sin^2(theta_13)，
// 单位是10^-2，刻度范围从1.5到3.5；横轴同上方子图（Delta
// m_31^2）。 第三行中间子图（位置3,2）：纵轴同左图（sin^
// 2(theta_13)），横轴同上方子图（Delta m_21^2）。 第三行
// 右侧子图（位置3,3）：纵轴为sin^2(theta_13)，单位是10^
// -2，刻度范围从1.5到3.5；横轴为sin^2(theta_12)，无单位，
// 刻度范围从0.302到0.312。 子图详细内容： 每个子图内部均
// 包含三个填充颜色的同心椭圆环带和一个中心标记点。 颜色
// 与区域含义：最内层深蓝色实心椭圆代表68.27%置信度（C.L.）
// 区域；中间层浅蓝色环带代表95.45% C.L.区域；最外层浅橙
// 色/粉色环带代表99.73% C.L.区域。 符号含义：每个子图中
// 心的黑色五角星（★）代表最佳拟合点（Best-fit point）。
// 相关性系数：每个子图的左上角或右上角标注了该平面内两个
// 参数的相关系数rho值。具体数值如下： 第一行左侧子图（
// Delta m_21^2 vs Delta m_31^2）：rho = 0.044。 第二行左
// 侧子图（sin^2(theta_12) vs Delta m_31^2）：rho = 0.033。
// 第二行中间子图（sin^2(theta_12) vs Delta m_21^2）：rho
// = -0.056。 第三行左侧子图（sin^2(theta_13) vs Delta
// m_31^2）：rho = 0.006。 第三行中间子图（sin^2(theta_13
// ) vs Delta m_21^2）：rho = -0.069。 第三行右侧子图（
// sin^2(theta_13) vs sin^2(theta_12)）：rho = -0.032。
// 趋势与结论：所有椭圆均近似圆形且中心聚集紧密，表明各参
// 数间的相关性极弱（rho接近0）。最佳拟合点位于所有置信区
// 间的几何中心附近。 图例说明： 图例位于整个矩阵的右侧空
// 白处，标题为“JUNO 6 years”。 内容包含四项： 深蓝色矩形
// 块：对应文字“68.27% C.L.”。 浅蓝色矩形块：对应文字“
// 95.45% C.L.”。 浅橙色矩形块：对应文字“99.73% C.L.”。
// 黑色五角星符号：对应文字“Best-fit”。
#figure(
  image("imgs/InterCorrelation_v2_6years.png", width: 90%),
  caption: [
    Two-dimensional 68.27\%, 95.45\%, and 99.73\% confidence level (C.L.) contours for all pairs of oscillation parameters that JUNO is sensitive to. These contours correspond to the 1, 2, and 3$sigma$ confidence regions, respectively. For each point in these projections, the underlying $Delta chi^2$ value is obtained by minimizing over the other two parameters. The black stars represent the best-fit points as well as the true values of the oscillation parameters. The correlation coefficient between each pair of oscillation parameters is shown as $rho$.
  ],
) <fig-correlations>


= Conclusion
<conclusion>


JUNO is a next-generation liquid scintillator neutrino observatory under construction at a baseline of about $52.5$~km from eight nuclear reactors in the south of China. Its unprecedented size and energy resolution will enable it to make a precise measurement of the oscillated spectrum of reactor antineutrinos and to observe the so-called solar and atmospheric oscillation effects simultaneously for the first time. As a result, the $Delta m_31^2$, $Delta m_21^2$, and $sin^2 theta_12$ oscillation parameters will be determined to significantly better than sub-percent precision. Updated sensitivities to these parameters have been obtained using the most recent information available to date about the experimental site's location and overburden, the detector response, the backgrounds, the surrounding nuclear reactors, and the reactor antineutrino spectral shape constraints expected from the TAO satellite detector. The sensitivities were assessed with four independent analyses using alternative but equally rigorous treatments of the systematic uncertainties, all of which yielded results in excellent agreement with each other. With six years of JUNO data taking, the $Delta m_31^2$, $Delta m_21^2$, and $sin^2 theta_12$ parameters will be determined to a world-leading precision of $0.5 "%"$, $0.3 "%"$, and $0.2 "%"$, respectively. These measurements will constitute an important input to other experiments, provide constraints for model building, and enable more precise searches for physics beyond the Standard Model in the neutrino sector.


#heading(numbering: none)[Acknowledgements]
<acknowledgements>


We are grateful for the ongoing cooperation from the China General Nuclear Power Group. This work was supported by the Chinese Academy of Sciences, the National Key R&D Program of China, the CAS Center for Excellence in Particle Physics, Wuyi University, and the Tsung-Dao Lee Institute of Shanghai Jiao Tong University in China, the Institut National de Physique Nucléaire et de Physique de Particules (IN2P3) in France, the Istituto Nazionale di Fisica Nucleare (INFN) in Italy, the Italian-Chinese collaborative research program MAECI-NSFC, the Fond de la Recherche Scientifique (F.R.S-FNRS) and FWO under the “Excellence of Science -- EOS” in Belgium, the Conselho Nacional de Desenvolvimento Científico e Tecnològico in Brazil, the Agencia Nacional de Investigacion y Desarrollo and ANID - Millennium Science Initiative Program - ICN2019\_044 in Chile, the Charles University Research Centre and the Ministry of Education, Youth, and Sports in Czech Republic, the Deutsche Forschungsgemeinschaft (DFG), the Helmholtz Association, and the Cluster of Excellence PRISMA+ in Germany, the Joint Institute of Nuclear Research (JINR) and Lomonosov Moscow State University in Russia, the joint Russian Science Foundation (RSF) and National Natural Science Foundation of China (NSFC) research program, the MOST and MOE in Taiwan, the Chulalongkorn University and Suranaree University of Technology in Thailand, University of California at Irvine and the National Science Foundation in USA.

#bibliography("refs.yml", style: "american-physics-society", title: [References])