#import "@preview/cetz:0.4.2"
#set page(paper: "a5", flipped: false, margin: 0pt)

#let in_path = sys.inputs.in
#let n = int(sys.inputs.page_cnt)


#for p in range(1, n + 1, step: 1) {
  if p <= n {
    image(in_path, page: p, width: 100%)
  }
}


