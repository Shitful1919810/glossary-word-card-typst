#import "@preview/rubby:0.10.2": get-ruby

#let vocab(
  词,
  义,
  例,
  类,
  注,
  extend_width: 0pt,
  extend_height: 0pt,
) = box(
  width: auto,
  height: auto,
  stroke: 1pt + gray,
  radius: 6pt,
  inset: 2pt,
)[
  #let item = [
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
      ]]
  ]

  #context {
    let sz_item = measure(item)
    block(
      width: sz_item.width + 1.6em + extend_width,
      height: sz_item.height + 1.6em + extend_height,
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

#let auto-arrange(items-list-in) = {
  layout(size => {
    let items-list = items-list-in
    let N = items-list.len()
    let cur = 0
    let last = 0

    let consumed-width = 0pt
    let cur-max-height = 0pt

    let item-size-info = ()
    let processed-array = ()
    while cur < N {
      let max-width = size.width - 1pt
      let default-size = measure(vocab(..items-list.at(cur)))
      item-size-info.push(default-size)
      let default-item-width = default-size.width
      let default-item-height = default-size.height
      consumed-width += default-item-width
      cur-max-height = calc.max(cur-max-height, default-item-height)


      let default-item-width-nxt = if cur != N - 1 { measure(vocab(..items-list.at(cur + 1))).width } else {
        1145141919810pt
      }

      // check if a new line is needed
      if consumed-width + default-item-width-nxt < max-width {
        processed-array.push((items-list.at(cur), 0pt, 0pt))
      } else {
        processed-array.push((items-list.at(cur), 0pt, 0pt))

        // adjust width and height of all items in last row
        for i in range(last, cur + 1) {
          // divide tailing space into all items in last row
          processed-array.at(i).at(1) = (max-width - consumed-width) / (cur - last + 1)

          // adjust the height of all items in last row
          processed-array.at(i).at(2) = cur-max-height - item-size-info.at(i).height
        }
        last = cur + 1
        cur-max-height = 0pt
        consumed-width = 0pt
      }
      cur += 1
    }
    for item in processed-array {
      let (word, ext-width, ext-height) = item
      vocab(..word, extend_width: ext-width, extend_height: ext-height)
    }
  })
}


