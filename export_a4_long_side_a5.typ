#import "@preview/cetz:0.4.2"

#let in_path = sys.inputs.in
#let n = int(sys.inputs.page_cnt)

#let cut-line() = layout(size => {
  place(
    top + left,
    dx: 0%,
    dy: 50%,
    [
      #cetz.canvas(length: size.height, {
        import cetz.draw: *
        set-style(
          stroke: (
            paint: gray,
            thickness: 0.6pt,
            dash: "dashed",
          ),
        )
        line((0, 0), (2, 0))
      })
    ],
    float: true,
  )
})

#let foreground_image = cut-line()
#set page(paper: "a4", flipped: false, margin: 0pt, foreground: cut-line())

#for p in range(1, n + 1, step: 4) {
  let left_front = if (p <= n) { rotate(90deg, reflow: true)[#image(in_path, page: p, width: 100%)] }
  let right_front = if (p + 2 <= n) { rotate(90deg, reflow: true)[#image(in_path, page: p + 2, width: 100%)] }

  grid(
    columns: (1fr,),
    rows: (1fr, 1fr),
    gutter: 0pt,
    box(left_front, width: auto, height: auto),
    box(right_front, width: auto, height: auto),
  )

  let left_back = if (p + 1 <= n) { rotate(-90deg, reflow: true)[#image(in_path, page: p + 1, width: 100%)] }
  let right_back = if (p + 3 <= n) { rotate(-90deg, reflow: true)[#image(in_path, page: p + 3, width: 100%)] }
  grid(
    columns: (1fr,),
    rows: (1fr, 1fr),
    gutter: 0pt,
    box(left_back, width: auto, height: auto),
    box(right_back, width: auto, height: auto),
  )
}





