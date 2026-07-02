#let japanese-vocab-doc(
  title: [日语词汇表],
  author: [Shitful],
  footer-title: [谢特伏词汇表],
  date: datetime.today().display(),
  body,
) = {
  set page(
    paper: "a4",
    margin: (top: 16mm, bottom: 20mm, left: 16mm, right: 16mm),
  )

  set text(
    font: ("Source Han Serif"),
    size: 12pt,
  )

  set page(numbering: none)
  align(center + horizon)[
    #set text(size: 56pt, weight: "bold")
    #title

    #v(2em)

    #set text(size: 18pt)
    作者：#author

    日期：#date
  ]

  pagebreak()
  pagebreak()
  counter(page).update(1)

  set page(footer: context [
    #set text(
      font: ("Source Han Serif"),
      size: 16pt,
    )
    *#footer-title*
    #h(1fr)
    #counter(page).display("1/1", both: true)
  ])

  body
}
