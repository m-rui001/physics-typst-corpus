// [figvision] ../src/3.3Veto/Global_TT_02.png
// This is a single 3D CAD-style schematic of an elevated detector assembly. Sixteen blue rectangular panels
// cover the top surface in a grid separated by thin black gaps. The panels rest on a white truss framework with
// yellow edge walkways and railings around the perimeter. Four human figures wearing green vests and red helmets
// stand on the walkways for scale. An orange overhead crane beam spans the top with two hooks hanging downward.
// Below the array, white slatted structures and scattered orange spheres are partially visible against a grey
// background. No axes, units, or numerical values are shown.
// [figvision] ../src/3.3Veto/Global_TT_02.png
// Panel (a) is a 3D rendering of an elevated solar panel array on a white steel truss framework. At top, a
// yellow gantry crane spans the width with two hanging hooks. Rows of blue rectangular photovoltaic panels sit
// on white support beams, separated by yellow-edged walkways with white railings. Four small worker figures in
// green vests, blue trousers, and red hard hats stand on the walkways at scattered positions. The structure is
// raised above an orange lower section containing red piping and orange spherical components. Grey slatted
// structures line the right side against a plain grey background. The scene depicts a modular solar installation
// under construction or maintenance, with no axes, units, or data series.
// [figvision] ../src/3.3Veto/Global_TT_02.png
// Panel (a) is a 3D rendering of an elevated solar panel array on a white steel truss framework. At top, a
// yellow gantry crane spans the width with two hanging hooks. Rows of blue rectangular photovoltaic panels sit
// on white support beams, separated by yellow-edged walkways with white railings. Four small worker figures in
// green vests, blue trousers, and red hard hats stand on the walkways at scattered positions. The structure is
// raised above an orange lower section containing red piping and orange spherical components. Grey slatted
// structures line the right side against a plain grey background. The scene depicts a modular solar installation
// under construction or maintenance, with no axes, units, or data series.
#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    content((0, 0), image("../src/3.3Veto/Global_TT_02.png", width: 6.7cm))
    line((-0.46, -1.49), (-2.98, -0.65), stroke: 0.8pt, mark: (start: "<", end: ">"))
    content((-2.11, -1.13), angle: -18.4deg, [*20~m*])
    line((-3.02, -0.20), (0.66, 1.08), stroke: 0.8pt, mark: (start: "<", end: ">"))
    content((-1.24, 0.61), angle: 19.2deg, [*47~m*])
    line((-2.98, -0.65), (-3.02, -0.20), stroke: 0.8pt, mark: (start: "<", end: ">"))
    content((-3.35, -0.46), angle: -85deg, [*3~m*])
    line(
      (-0.71, -0.32), (-1.54, -0.11), (-0.89, 0.16), (-0.09, -0.02),
      close: true,
      stroke: (paint: red, thickness: 0.4pt),
      fill: red.transparentize(60%),
    )
    content((-0.85, -0.23), angle: -14.2deg, text(size: 7pt)[*6.7~m*])
    content((-0.62, -0.35), angle: 25.8deg, text(size: 7pt)[*6.7~m*])
    content((-0.8075, -0.0725), text(size: 8pt, fill: green)[*TT wall*])
  }),
)
