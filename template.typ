// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let fontfamily = (
  heiti : ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei", "PT Sans"),
  songti : ("Times New Roman", "Songti SC", "Songti TC", "SimSun"),
  zhongsong : ("Times New Roman", "STZhongsong", "SimSun")
)

#let project(
  title: ("标题","TITLE"),
  abstract: ([],[]),
  authors: ((),()),
  ids: (),
  enroll: "20XX",
  institution: ("",""),
  major: ("",""),
  advisor: ("",""),
  year: 2023,
  month: 12,
  logo: "./logo_red.svg",
  keywords: (),
  body,
) = {
  set document(author: authors.at(0), title: title.at(0))
  set page(
    margin: (left: 25mm, right: 25mm, top: 31mm, bottom: 31mm),
  )
  set text(/*font: "Linux Libertine", */lang: "zh")
  
  // 中文封面
  
  {  
    align(left)[#image(logo, height:1.45cm)]
    
    v(1.75cm)
  
    align(center)[
    #text(
        size: 22pt,
        font: fontfamily.zhongsong,
        weight: "bold"
      )[本科毕业论文（设计）]
    ]
    v(4.1cm)
  
    let juststr(body_str, target) = {
      let sliced = body_str.split("")
      let space = "　"
      let str_len = sliced.len() - 2
      let s = calc.max(0, calc.round((target - str_len) / (str_len - 1)))
      [#sliced.slice(1,str_len + 1).join(space*int(s))]
    }
    let infovalue(data) = {
        rect(
          stroke: (bottom: 1pt + black), width:100%, text(
          font: fontfamily.zhongsong,
          size: 16pt
        )[#data] 
        )
    }
    let infokey(data) = {
      text(
          font: fontfamily.zhongsong,
          size: 16pt,
        )[#juststr(data,4)：]
    }
    align(center)[#table(
      columns: (auto, 9cm),
      align: horizon,
      stroke: none,
        infokey("题目"), infovalue(title.at(0)),
        infokey("学生姓名"), infovalue(authors.at(0).join(", ")),
        infokey("学号"), infovalue(ids.join(", ")),
        infokey("入学年份"), infovalue(enroll),
        infokey("所在学院"), infovalue(institution.at(0)),
        infokey("攻读专业"), infovalue(major.at(0)),
        infokey("指导教师"), infovalue(advisor.at(0)),
    )]
  
  
    align(bottom + center)[
      #text(
        font: fontfamily.zhongsong,
        size: 12pt,
      )[上海科技大学 \ #year#[年]#month#[月]]
    ]
  }

  pagebreak()
  
  // 英文封面

  {
    align(left)[#image(logo, height:1.45cm)]
    
    v(1.75cm)
  
    align(center)[
    #text(
        size: 22pt,
        font: fontfamily.heiti,
        weight: "bold"
      )[THESIS]
    ]
    v(4.1cm)

    let infovalue(data) = {
        rect(
          stroke: (bottom: 1pt + black), width:100%, text(
          font: fontfamily.zhongsong,
          size: 16pt
        )[#data] 
        )
    }
    let infokey(data) = {
      align(left)[#text(
          font: fontfamily.zhongsong,
          size: 16pt,
        )[#data: ]]
    }
    align(center)[#table(
      columns: (auto, 9cm),
      align: horizon,
      stroke: none,
        infokey("Subject"), infovalue(title.at(1)),
        infokey("Student Name"), infovalue(authors.at(1).join(", ")),
        infokey("Student ID"), infovalue(ids.join(", ")),
        infokey("Year of Entrance"), infovalue(enroll),
        infokey("School"), infovalue(institution.at(1)),
        infokey("Major"), infovalue(major.at(1)),
        infokey("Advisor"), infovalue(advisor.at(1)),
    )]
  
    align(bottom + center)[
      #text(
        font: fontfamily.zhongsong,
        size: 12pt,
      )[ShanghaiTech University \ Date: #year / #month]
    ]
  }

  pagebreak()
  
  //本科毕业论文诚信声明、版权使用授权书
  {
    set text(  
        size: 14pt,
        font: fontfamily.songti,
      )
    v(2.2cm)
    align(center)[
      #text(
          size: 18pt,
          font: fontfamily.heiti,
          weight: "bold"
        )[
          #set par(justify: false, leading: 1.15em, first-line-indent: 2em)
          上海科技大学 \ 毕业论文(设计)学术诚信声明
        ]
    ]

    v(1.1cm)

    
    [
      #set par(justify: false, leading: 1.5em, first-line-indent: 2em)
      本人郑重声明：所呈交的毕业论文（设计），是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。]
      
    v(7em)
    align(right)[
      作者签名：#h(14em)

      日#h(2em)期：#h(2em)年#h(1em)月#h(1em)日#h(7em)
    ]
    
    pagebreak()

    
    v(2.2cm)
    align(center)[
      #text(
          size: 18pt,
          font: fontfamily.heiti,
          weight: "bold"
        )[
          #set par(justify: false, leading: 1.15em)
          上海科技大学 \ 毕业论文（设计）版权使用授权书
        ]
    ]
    
    v(1.1cm)

    
    [
      #set par(justify: false, leading: 1.5em, first-line-indent: 2em)
      
      本毕业论文（设计）作者同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权上海科技大学可以将本毕业论文（设计）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业论文（设计）。

      #h(7em)*保#h(1em)密* #text(size:20pt,math.square)，在#("_"*4)年年解密后适用本授权书。

      本论文属于

      #h(7em)*不保密* #text(size:20pt,math.square)。

      （请在以上方框内打“√”）
    ]

    
    v(3em)

    grid(
      columns:(1fr, 1fr),
      [
        #align(left)[
          作者签名：
          
          日#h(2em)期：#h(2em)年#h(1em)月#h(1em)日
        ]],[
        #align(left)[
          指导教师签名：
          
          日#h(2em)期：#h(2em)年#h(1em)月#h(1em)日
        ]
      ]
    )
    
  }

  counter(page).update(0)
  pagebreak()

  // 含页眉页尾页面
  
  {
    set page(header: [
      #rect(
        stroke: (bottom: black + 1pt),
        grid(
        columns: (auto, 1fr), 
        [#image(logo, height: 1.16cm)],
        [#align(right)[#text(font: fontfamily.songti, size: 9pt,title.at(0))]])
      )
    ],)

    set page(
      numbering: "I",
      number-align: center,
    )

    // 中文摘要
    
    { 
      align(center)[
        #text(size: 16pt, font:fontfamily.heiti, weight: "bold")[
          #v(1em) 
          #title.at(0)
          #v(2em) 
        ] 
        #heading(
          outlined: false,
          numbering: none,
          text(size: 14pt, font:fontfamily.heiti, weight: "medium")[
            摘要
            #v(3em)
          ]
        )
      ]
      
      set par(justify: false, leading: 0.77em, first-line-indent: 2em)
      set text(size: 10.5pt, font:fontfamily.songti)
      [
          #h(2em)#abstract.at(0)
      ]

      v(2em)

      [
        #text(size: 12pt, font:fontfamily.heiti)[关键词：]
        #text(size: 12pt, font:fontfamily.songti)[#keywords.at(0)]
      ]
    }

    pagebreak()
    
    // 英文摘要

    {
      align(center)[
        #text(size: 16pt, font:fontfamily.songti, weight: "bold")[
          #v(1em) 
          #upper(title.at(1))
          #v(2em) 
        ] 
        #heading(
          outlined: false,
          numbering: none,
          text(size: 14pt, font:fontfamily.songti, weight: "bold")[
            ABSTRACT
            #v(3em)
          ]
        )
      ]
      
      set par(justify: true, leading: 0.77em, first-line-indent: 2em)
      set text(size: 10.5pt, font:fontfamily.songti)
      [
          #h(2em)#abstract.at(1)
      ]

      v(2em)

      [
        #text(size: 12pt, font:fontfamily.songti, weight: "bold")[Key words: ]
        #text(size: 12pt, font:fontfamily.songti)[#keywords.at(1)]
      ]
    }
    
    pagebreak()
    
    // 目录和编号
    
    align(center, text(size: 16pt, font:fontfamily.heiti, weight: "bold")[
          #v(1em) 
          目录
          #v(1em) 
        ])
    
    set heading(numbering: "1")
    let number-until-with(max-level, schema) = (..numbers) => {
      if numbers.pos().len() <= max-level {
        numbering(schema, ..numbers)
      }
    }
    
    set heading(numbering: number-until-with(3, "1.1.1"))

    
    show outline.entry: it => {
      text(size: 10.5pt, font: fontfamily.songti)[
        #let bdy = it.body
        #bdy #box(width: 1fr, repeat(".")) #it.page.text.match(regex("第(.*?)页")).captures.at(0)
      ]
    }
    
    {
      set par(leading: 1em)
      outline(depth: 3, indent: true, title:{})
    }
    pagebreak()

    set page(
      numbering: "第 1 页 共 1 页",
      number-align: center,
    )
    counter(page).update(1)
  
    // 正文版式
    {
      set heading(
        numbering: (..numbers) =>
          if numbers.pos().len() == 1 {
            return numbering("第一章", ..numbers)
          }
          else {
            return numbering("1.1", ..numbers)
          }
      )

      show heading.where(
        level: 1
      ): it => block(width: 100%)[
        #set align(center)
        #set text(16pt, weight: "bold", font: fontfamily.heiti)
        #v(1em)
        #it
        #v(1em)
      ]
      
      // set par(justify: true, first-line-indent: 2em)
      set par(justify: true, leading: 1.24em, first-line-indent: 2em)
      show par: set block(spacing: 1.24em)
      show heading: it => {
        set text(weight: "bold", font: fontfamily.heiti, size: 12pt)
        set block(above: 1.5em, below: 1.5em)
        it
      } + v(-1em) + box()
      body
    }
  }
}