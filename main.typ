#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: ("基于Typst 的 SHTthesis 模板", "SHTthesis - based on typst"),
  authors: ((
    "糌粑", "Test"
  ),(
    "ZAMBAR", "Test"
  )),
  ids: ("114514", "19190810"),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  enroll: "2023",
  institution: ("信息科学与技术学院","SIST"),
  year: 2023,
  month: 12,
  major: ("计算机科学与技术","Computer Science"),
  advisor: ("田所浩二","TSH2"),
  keywords: ([
    均质充量压缩着火，化学动力学，数值模拟，二甲醚，EGR
  ],
  [
    HCCI, chemical kinetics, numerical simulation, DME, EGR
  ]),
  abstract: ([
      均质充量压缩着火（HCCI）燃烧，作为一种能有效实现高效低污染的燃烧方式，能够使发动机同时保持较高的燃油经济性和动力性能，而且能有效降低发动机的NOx和碳烟排放。此外HCCI燃烧的一个显著特点是燃料的着火时刻和燃烧过程主要受化学动力学控制，基于这个特点，发动机结构参数和工况的改变将显著地影响着HCCI发动机的着火和燃烧过程。本文以新型发动机代用燃料二甲醚（DME）为例，对HCCI发动机燃用DME的着火和燃烧过程进行了研究。研究采用由美国Lawrence Livermore国家实验室提出的DME详细化学动力学反应机理及其开发的HCT化学动力学程序，且DME的详细氧化机理包括399个基元反应，涉及79个组分。为考虑壁面传热的影响，在HCT程序中增加了壁面传热子模型。采用该方法研究了压缩比、燃空当量比、进气充量加热、发动机转速、EGR和燃料添加剂等因素对HCCI着火和燃烧的影响。结果表明，DME的HCCI燃烧过程有明显的低温反应放热和高温反应放热两阶段；增大压缩比、燃空当量比、提高进气充量温度、添加H2O2、H2、CO使着火提前；提高发动机转速、采用冷却EGR、添加CH4、CH3OH使着火滞后。
    ],
    [
      HCCI (Homogenous Charge Compression Ignition) combustion has advantages in terms of efficiency and reduced emission. HCCI combustion can not only ensure both the high economic and dynamic quality of the engine, but also efficiently reduce the NOx and smoke emission. Moreover, one of the remarkable characteristics of HCCI combustion is that the ignition and combustion process are controlled by the chemical kinetics, so the HCCI ignition time can vary significantly with the changes of engine configuration parameters and operating conditions. In this work numerical scheme for the ignition and combustion process of DME homogeneous charge compression ignition is studied. The detailed reaction mechanism of DME proposed by American Lawrence Livermore National Laboratory (LLNL) and the HCT chemical kinetics code developed by LLNL are used to investigate the ignition and combustion processes of an HCCI engine fueled with DME. The new kinetic mechanism for DME consists of 79 species and 399 reactions. To consider the effect of wall heat transfer, a wall heat transfer model is added into the HCT code. By this method, the effects of the compression ratio, the fuel-air equivalence ratio, the intake charge heating, the engine speed, EGR and fuel additive on the HCCI ignition and combustion are studied. The results show that the HCCI combustion fueled with DME consists of a low temperature reaction heat release period and a high temperature reaction heat release period. It is also founded that increasing the compression ration, the equivalence ratio, the intake charge temperature and the content of H2O2, H2 or CO cause advanced ignition timing. Increasing the engine speed, adoption of cold EGR and the content of CH4 or CH3OH will delay the ignition timing.
    ]),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= 绪论

随着汽车工业的发展和汽车保有量的增加,汽车在大量消耗石油燃料的同时,尾气排出的有害气体还严重地污染了人们赖以生存的大气环境,实现能源与环境长期可持续发展是摆在汽车和内燃机工作者面前的重大课题。环保和能源是发动机工业需要解决的两个主要问题。目前，随着人们对环境污染重视程度的日益提高，各国越来越重视环境保护，现在已制定了将NOx和PM视为大气污染源的强化法规，如美国加州在1998年生效的一项超低排放汽车法规规定汽车的NO#sub[x]+HC排放\<2.5g/bph-hr, PM排放\<0.05g/bph-hr。为满足严格的排放要求，研究人员在各个相关领域进行了大量的研究工作，改进发动机的燃烧系统作为一个重要解决途径，也取得了一定进展[1]。

传统汽油机均质混合气,尾气排放污染物主要包括氮氧化物(NOx)、碳氢化合物(HC)、一氧化碳(CO),可以通过三效催化后处理加以解决,但要达到欧IV及其以上标准仍存在较大困难,且汽油机的热效率低,在中低负荷工作时还有较大的泵气损失。柴油机热效率高,但排气中的NOx和碳烟微粒排放物(PM)却难以折中,使用一种排放物减少的措施,往往导致另一排放物的增加。由于柴油机总体上富氧燃烧, NOx的催化处理技术尚未成熟。汽油机和柴油机的燃烧方式都不能解决碳烟和氮氧化物生成的trade-off关系,因而很难在这两种燃烧模式下通过改进燃烧来同时大量降低碳烟和氮氧化物的生成。

== HCCI的数值模拟研究现状

HCCI发动机的着火与燃烧过程与传统的火花塞点火式和压燃式发动机有着本质的区别，在HCCI发动机的着火燃烧过程中，燃料的化学反应动力学起着至关重要的作用。因此，相对于传统发动机数值模拟研究主要侧重于湍流混合与燃烧模型而言，HCCI发动机燃烧模拟的焦点主要集中在燃料的反应机理和化学动力学模型上。

=== HCCI数值模拟模型

目前HCCI数值模拟研究主要集中在单区、多区和多维模型上[2]。本节将从这三方面分别予以介绍：

+ 单区模型#repeat(".")
+ 双区和多区模型#repeat(".")
+ 多维模型#repeat(".")


= DME均质充量压燃着火的数值模拟方法

== 二级标题

正文内容

=== 三级标题

正文内容

$ m = sum_(k=1)^K m_k $

#math.equation(block: true, supplement: [Eq.], numbering: "(1)")[ $ m = sum_(k=1)^K m_k $ ] <example>

引用 @example

$ 
f(x,y) &= f(0,0) + 1/1! (x diff/(diff x) + y diff/(diff y)) f(0,0) \
&+ 1/2! (x diff/(diff x) + y diff/(diff y))^2 f(0,0) + K \
&+ 1/n! (x diff/(diff x) + y diff/(diff y))^n f(0,0) + K
$

