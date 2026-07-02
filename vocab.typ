#import "@preview/rubby:0.10.2": get-ruby

#let vocab-content(词, 义, 例, 类, 注) = [
  #align(left)[
    #set text(top-edge: 0.1em, bottom-edge: 0em)
    #set par(leading: 1em)
    #v(1.2em)
    *#text(size: 1.5em, font: "Source Han Serif")[#词]* #义

    #if 例 != none [
      #text(font: "Source Han Serif")[#例]
    ]

    #if 类 != none [
      #grid(columns: 2, gutter: 0pt)[
        _分类：_ #类
      ]
    ]

    #if 注 != none [
      #text(size: 0.9em)[_注：_ #注]
    ]
  ]
]

#let vocab(
  词,
  义,
  例,
  类,
  注,
  width: auto,
  height: auto,
  extend_width: 0pt,
  extend_height: 0pt,
) = box(
  width: auto,
  height: auto,
  stroke: 1pt + gray,
  radius: 6pt,
  inset: 2pt,
)[
  #let item = vocab-content(词, 义, 例, 类, 注)

  #context {
    let sz_item = measure(item)
    let card-width = if width == auto { sz_item.width + 1.6em + extend_width } else { width }
    let card-height = if height == auto { sz_item.height + 1.6em + extend_height } else { height }

    block(
      width: card-width,
      height: card-height,
      item,
      inset: 0.8em,
      radius: 4pt,
      stroke: 0.6pt + gray,
    )
  }
]

#let r = get-ruby(
  size: 0.5em, // Ruby font size
  dy: 0.8em, // Vertical offset of the ruby
  pos: top, // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|", // The delimiter between words
  auto-spacing: true, // Automatically add necessary space around words
)

#let small(cont) = text(size: 0.75em, fill: blue, cont)

#let item-tuple(词, 义, 例, 类, 注: none) = (词, 义, 例, 类, 注)

#let item-sizes(items) = {
  let sizes = ()
  for item in items {
    sizes.push(measure(vocab(..item)))
  }
  sizes
}

#let render-row(items, sizes, start, end, max-width, row-width, row-height) = {
  let row-len = end - start + 1
  let extra-width = (max-width - row-width) / row-len

  for i in range(start, end + 1) {
    let item = items.at(i)
    let size = sizes.at(i)
    vocab(
      ..item,
      width: size.width + extra-width,
      height: row-height,
    )
  }
}

#let auto-arrange(items-list-in) = {
  layout(size => {
    let items-list = items-list-in
    let N = items-list.len()
    let max-width = size.width - 1pt
    let sizes = item-sizes(items-list)

    let row-start = 0
    let row-width = 0pt
    let row-height = 0pt

    let cur = 0
    while cur < N {
      let item-size = sizes.at(cur)
      row-width += item-size.width
      row-height = calc.max(row-height, item-size.height)

      let next-width = if cur + 1 < N { sizes.at(cur + 1).width } else { none }
      let is-row-end = next-width == none or row-width + next-width >= max-width

      if is-row-end {
        render-row(items-list, sizes, row-start, cur, max-width, row-width, row-height)
        row-start = cur + 1
        row-width = 0pt
        row-height = 0pt
      }
      cur += 1
    }
  })
}

