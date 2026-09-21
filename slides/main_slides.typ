#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "@preview/booktabs:0.0.4": *
#show: booktabs-default-table-style
#import "@preview/cetz:0.5.2"

#set page(
  background: box(
    width: 100%, height: 100%,
  )
)
#show: simple-theme.with( 
  aspect-ratio: "16-9",
  footnote: none,
  footer-right: place(dx: 18pt, align(right, context utils.slide-counter.display())),
  primary: black,
  config-page(
    margin: (x: 1em, y: 1em),
  ),
  config-common(
    handout: true,
    slide-level: 0,
  ),
  subslide-preamble: none,
)
#show heading.where(level: 1): set text(size: 0.9em)
#show heading.where(level: 1): set block(above: 0pt, below: 0.5em)
#set text(font: "IBM Plex Serif", size: 20pt)
#show "https://": ""
#show ref: text.with(size: 0.9em)

#let TODO = body => text(fill: red)[\[TODO: #body\]]
#let COL_GRAY_DARK = rgb("#444")
#let comment = body => text(fill: COL_GRAY_DARK, size: 15pt, body)

#let COL_GRAY_LIGHT = rgb("#ddd")
#let COL_GRAY_LIGHT_LIGHT = COL_GRAY_LIGHT.lighten(30%)
#let COL_PURPLE = rgb("#aab")
#let COL_PURPLE_DARK = rgb("#504")
#let COL_PURPLE_LIGHT = COL_PURPLE_DARK.mix((white, 3))
#let COL_YELLOW_DARK = rgb("#fa4")
#let COL_YELLOW_LIGHT = COL_YELLOW_DARK.mix((white, 3))
#let COL_RED_DARK = rgb("#d22")
#let COL_RED_LIGHT = COL_RED_DARK.mix((white, 3))
#let COL_BLUE_DARK = rgb("#22d")
#let COL_BLUE_LIGHT = COL_BLUE_DARK.mix((white, 3))
#let COL_GREEN_DARK = rgb("#2d2")
#let COL_GREEN_LIGHT = COL_GREEN_DARK.mix((white, 3))

#let str-ref = x => box([ref: "]+text(size: 0.9em, style: "italic", x)+ ["], fill: COL_YELLOW_LIGHT, inset: 3pt, baseline: 3pt)
#let str-hyp = x => box([hyp: "]+text(size: 0.9em, style: "italic", x)+ ["], fill: COL_BLUE_LIGHT, inset: 3pt, baseline: 3pt)
#let str-src = x => box([src: "]+text(size: 0.9em, style: "italic", x)+ ["], fill: COL_GREEN_LIGHT, inset: 3pt, baseline: 3pt)

#set box(radius: 4pt)
#set block(radius: 4pt)

#let all-line = block.with(fill: COL_GRAY_LIGHT, width: 100%, inset: (top: 3pt, bottom: 3pt))
#let highlight-line = all-line.with(fill: COL_YELLOW_LIGHT, radius: 0pt)
#let above-line = all-line.with(fill: COL_GRAY_LIGHT, width: 100%, radius: (top: 4pt, bottom: 0pt))
#let bellow-line = all-line.with(fill: COL_GRAY_LIGHT, width: 100%, radius: (bottom: 4pt, top: 0pt))

// #show raw.where(block: true): it => block(fill: COL_GRAY_LIGHT, width: 100%, inset: 5pt, radius: 4pt)[#text(size: 0.9em)[#it]]
#show raw.where(block: true): text.with(size: 0.9em)

#let practice-box(title, col, body) = box(fill: col, inset: 10pt, width: 100%, radius: 4pt)[*#title:* #body]
#let bad-box = practice-box.with("Malpractice", COL_RED_LIGHT)
#let good-box = practice-box.with("Good practice", COL_GREEN_LIGHT)
#let problem-box = practice-box.with("Problem", COL_RED_LIGHT)

#let table-box = box.with(inset: 5pt)

#show table: text.with(size: 15pt)

#title-slide[
  #set text(style: "italic")
  #set par(leading: 0.6em)
  #v(1fr)
  
  = #text(size: 244pt)[human] \ #text(size: 132pt)[EVALUATION] \ #text(size: 50pt)[#h(4pt)of#h(1fr) multilingual#h(1fr) tasks#h(14pt)]
  
  #v(1.5fr)
  
  #set text(20pt)

  #h(5pt)
  Vilém Zouhar #h(1fr)
  Maike Züfle #h(1fr)
  // Dominik Macháček #h(1fr)
  Patrícia Schmidtová #h(1fr)
  2026
  #h(14pt)

  #v(1fr)
  
  #set text(weight: "bold", size: 29.5pt)
  #h(-10pt)
  "science without evaluation is limited to blind exploration"
  #h(-10pt)
]

#slide[
  = human evaluation of multilingual tasks

  #let tag = x => h(5pt)+box(radius: 5pt, fill: COL_PURPLE_DARK, outset: 5pt, text(fill: white, x))+h(5pt)

  - introduction & case studies
  - annotation protocols #tag[applied]
  - your own human evaluation #tag[hands-on]
  - experiment design #tag[theory]
  - analyzing and reporting data #tag[applied] 

  #pause
  #v(1fr)

  #grid(columns: 2, column-gutter: 2em,
     [
    *You'll learn*
    - how to setup humeval
    - common humeval mistakes
    - some theory of evaluation
    ],
    [
      *You'll _not_ learn*
    - deep human-computer interaction theory
    - how to humeval in _all_ scenarios
    ]
  )

  #v(1fr)

  *Materials:* https://github.com/zouharvi/humeval-tutorial
  
  #v(1fr)
]

#slide[
= introduction


#let mybox = box.with(radius: 4pt, inset: 2pt, outset: 4pt, fill: COL_BLUE_LIGHT)

- We need evaluation to answer this and similar questions in academia and industry:
  - #mybox[_"should we use gpt4.1 or llama3 in our pipeline?"_]
    - Without evaluation: #mybox(fill: COL_RED_LIGHT, baseline: 3pt)[_"we don't know but let's use ollama3 because I like llamas."_]
  - #mybox[_"what do our users prefer?"_]#h(10pt) #mybox[_"how many mistakes does our model make on average?"_]
  - #mybox[_"is this model good enough to remove human-in-the-loop?"_]
  - #mybox[_"which method between two papers works best and should be implemented in-house?"_]
  - #mybox[_"which method between two papers works best and should we build on?"_]

#pause

- Get the best model: $"model"^* = limits(arg max)_(m in #align(center, stack("set of all", "possible", "models"))) #mybox(fill: COL_BLUE_LIGHT, baseline: 2pt)[$"evaluation"(m)$]$
- Reinforcement learning: $max_(pi_theta) bb(E)_(x ~ cal(D), y ~ pi_theta(dot | x)) [ #move(mybox(fill: COL_BLUE_LIGHT, baseline: 2pt, outset: 1pt)[$r(x, y)$]) - beta "KL"(pi_theta (dot | x) || pi_"ref" (dot | x)) ]$ \ #pause
  #h(455pt )$arrow.t$ #text()[reward model (= evaluation)]

#pause


- *Only what can be #mybox(baseline: 3pt, outset: 2pt)[measured] can be improved*
]

#slide[
= introduction / many problems

#let mybox = box.with(radius: 4pt, inset: 10pt, width: 100%)
#set align(horizon)
#show: columns.with(2, gutter: 15pt)

#mybox(fill: COL_PURPLE_LIGHT)[
>90% papers in ACL @marie-etal-2021-scientific make claims without human evaluation
_"Our method improves over the baseline by +0.8 BLEU points."_
]

#mybox(fill: COL_RED_LIGHT)[
Bad annotation protocol design and implementation:
_"Rate these texts by typing a comma-separated list of integer scores."_
]

#mybox(fill: COL_YELLOW_LIGHT)[
Ad hoc flawed analysis:
_"We dropped outlier scores to boost agreement."_
]

#mybox(fill: COL_BLUE_LIGHT)[
Poor ethics and safety:
_"Here's our dataset without IRB approval for which we paid 1\$/hour."_
]

#mybox(fill: COL_GREEN_LIGHT)[
Inefficient and incomparable testsets:
_"We randomly selected 50 input items for each of the two modes independently and do not statistical testing._"
]

#mybox(fill: COL_GRAY_LIGHT)[
Inadequate guidelines
_"Annotators rated Fluency (no further explanation) on the scale from 1 to 5"_
]

]

#let overview-slide = (x, extra: none) => slide[
  = human evaluation

  #if extra != none {
    extra
  }

  #v(5pt)
  #align(center, image("img/highlevel.svg", width: 95%))
  #v(15pt)

  #if x == 0 { pause }

  #show: columns.with(2, gutter: -30pt)
  #set text(size: 15pt)
  // problems should correspond to the outline
  #let problems = (
    [why evaluate: diagnosis or benchmarking?],
    [what about automatic metrics?],
    [what makes a good annotation protocol?],
    [how to design studies and measure reliability?],
    // [how to address annotator subjectivity?],
    [how to approach multilingual evaluation?],
    [how to write guidelines and enforce quality?],
    [how to deploy tasks in an annotation tool?],
    [how to analyze responses?],
    [common ethics and methodological malpractices?],
    [open problems in evaluation],
  )
  #enum(
    ..problems.slice(0, x).map(x => box(fill: COL_PURPLE_LIGHT, inset: 2pt, outset: 3pt, strike(text(fill: COL_PURPLE_LIGHT.darken(30%), x)))),
    box(fill: COL_PURPLE_DARK, inset: 2pt, outset: 3pt, text(fill: white, problems.at(x)+box(scale(80%, emoji.finger.l, reflow: true)))),
    ..problems.slice(x+1).map(x => box(fill: COL_PURPLE_LIGHT, inset: 2pt, outset: 3pt, text(fill: COL_PURPLE_LIGHT.darken(30%), x)))
  )

  
]

#overview-slide(0, extra: [
  #[
    #show: only.with("1")
    #let mybox = box.with(fill: COL_BLUE_LIGHT.darken(10%), inset: 5pt)
    #set text(fill: white, size: 15pt)
    #place(top+right)[
      #mybox[design]
      #mybox[implementation]
      #mybox[execution]
      #mybox[analysis]
    ]
  ]
  #pause
])

#slide[
= evaluation is a spectrum
#set list(marker: [])
#v(1fr)

#grid(columns: 2, row-gutter: 1em, column-gutter: 1em,
  box(fill: COL_YELLOW_DARK, outset: 4pt)[_Intrinsic evaluation_], [],
  [Train loss], uncover("3-")[_e.g. perplexity_],
  [Test loss], uncover("3-")[_e.g. perplexity_],
  [Handcrafted metrics], uncover("3-")[_e.g. accuracy, chrF, BLEU, ROUGE_],
  [Trained metrics], uncover("3-")[_e.g. BertScore, COMET_],
  [LLM-as-a-judge], uncover("3-")[_e.g. "hey LLM, how much do you like this output?"_],
  [Human judgment], uncover("2-")[_e.g. "how much do you like this output?"_]+h(10pt)+uncover("4-", box(fill: COL_PURPLE_DARK, outset: 4pt, emoji.finger.l+text(fill: white)[ This tutorial])),
  [Human goal ], uncover("2-")[_e.g. happiness, impact_],
  box(fill: COL_YELLOW_DARK, outset: 4pt)[_Extrinsic evaluation_], [],
)

#v(1fr)
]

#slide[
= evaluation: what do you need answered?


#box(width: 49%, inset: 10pt, fill: COL_RED_LIGHT, height: 50%)[
== diagnosis
- "how does a given model behave?"
- requires calibrated annotators
- can be used for benchmarking
- *example:* counting severe hallucinations per document
]
#h(1fr)
#box(width: 49%, inset: 10pt, fill: COL_BLUE_LIGHT, height: 50%)[
== benchmarking
- "comparative judgments without absolute values"
- "how much is one model better than another"
- *example:* pairwise Chatbot Arena
]

#let example = (x, body, body2) => {
  set par(justify: true)
  uncover(x, place(bottom+center, dy: -30pt, block(fill: COL_YELLOW_LIGHT, inset: 10pt, width: 93%, align(left, text(weight: 600)[Example: ] + body + h(15pt) + text(weight: "bold", sym.arrow+[?])))))
  uncover(x+1, place(bottom+center, dy: -30pt, block(fill: COL_YELLOW_LIGHT, inset: 10pt, width: 93%, align(left, text(weight: 600)[Example: ] + body + h(15pt) + text(weight: "bold", sym.arrow+body2)))))
}

#example(2)[You present a human annotator with two different LLM responses to the same prompt. You ask them to click 'Model A is better', 'Model B is better', or 'Tie'.][benchmarking]
#example(4)[A safety researcher highlights specific sentences in an LLM's output and tags them from a dropdown menu as either 'PII leak', 'Toxicity', or 'Copyright infringement'.][diagnosis]
#example(6)[A human translator looks at a machine translation and post-edits the translation until it's perfect.][benchmarking/diagnosis]
]

#overview-slide(1)

#slide[
= automated metrics#footnote[Automatic metrics are a world of its own, see EAMT 2026 tutorial @balashov_translation_2026-1 and WMT metrics @lavie-etal-2025-findings]

- ...are not _metrics_ in mathematical sense #comment[(no triangle inequality, symmetry, positivity etc)] #pause
- Human judgment: #h(7pt)
  #box(fill: COL_GRAY_LIGHT, inset: 5pt, baseline: 10pt)[
    #show: scale.with(80%, reflow: true)
    input + output $arrow$ #emoji.person $arrow$ judgment
  ] $arrow.l$
- Automatic metrics:
  #box(fill: COL_GRAY_LIGHT, inset: 5pt, baseline: 10pt)[
    #show: scale.with(80%, reflow: true)
    input + output $arrow$ #emoji.robot $arrow$ judgment
  ] $arrow.l$
  #place(right, dx: -80pt, dy: -40pt, box()[Should correlate])

#pause
#v(1fr)
Examples: 
- Perplexity, MSE, MAE, BCE
- Exact match, Accuracy, $"F"_1$ score, Precision/Recall\@k
- BLEU, chrF, chrF++, ROUGE, METEOR, TER
- BERTScore, COMET xCOMET, MetricX, BLEURT
- LLM-as-a-Judge
- Time-to-first-token, latency, tokens-per-second
#v(1fr)


]

#slide[
= automated metrics / aspects

=== What is measured
- construct validity #comment[(does it measure what it claims to measure?)] \
  #comment[- low construct validity: measuring translation quality by monolingual fluency]
- ecological validity #comment[(does it generalize to real world)] \
  #comment[- low ecological validity: evaluating translation quality on subtitle translation]

#pause

=== Properties of metrics
- Robustness
- Discriminative power
- Interpretability

#pause

=== Ground truth
- Reference-based / ground-truth-based
- Reference-free / quality estimation / reward-model
]

#slide[
= automated metrics


=== 1. Handcrafted (character-level F-score)

- Handcrafted surface-level overlap with reference
- $"chrF"_2($#str-ref[The cat runs.], #str-hyp[The cat is running.]$) = 0.487$
- $"chrF"_2($#str-ref[The cat runs.], #str-hyp[The cat sleeps.]$) = 0.424$
- $"chrF"_2($#str-ref[The cat runs.], #str-hyp[A cat is running.]$) = 0.219$

#pause 
=== 2. Trained metrics (COMET)

- Trained on human data
- $"COMET"($#str-src[Die Katze rennt.], #str-ref[The cat runs.], #str-hyp[The cat is running.]$) = 0.90$
- $"COMET"($#str-src[Die Katze rennt.], #str-hyp[The cat is running.]$) = 0.92$
- $"COMET"($#str-src[Die Katze rennt.], #str-hyp[The cat sleeps.]$) = 0.40$
- #emoji.checkmark.box Higher correlation with humans #h(10pt)
- #emoji.flag.red Can be hijacked, uses shortcuts, less explainable
]

#slide[
= automated metrics

#let str-ref = x => box([]+text(size: 0.9em, x)+[], fill: COL_YELLOW_LIGHT, inset: 3pt, baseline: 3pt)
#let str-hyp = x => box([]+text(size: 0.9em, x)+[], fill: COL_BLUE_LIGHT, inset: 3pt, baseline: 3pt)
#let str-src = x => box([]+text(size: 0.9em, x)+[], fill: COL_GREEN_LIGHT, inset: 3pt, baseline: 3pt)



=== 3. LLM-as-a-Judge

- #emoji.checkmark.box #emoji.checkmark.box #emoji.checkmark.box Incredibly versatile, just prompt LLM:
  - #comment["Evaluate the quality of #str-hyp[this summary] of #str-src[this document] on scale from 0% to 100%."] 
  - #comment["Evaluate #str-hyp[this summary] of #str-src[this document] in comparison to #str-ref[this human-written summary] from 0% to 100%."]
  - #comment["Evaluate the quality of #str-hyp[this summary] of #str-src[this document] on scale from 0% to 100% for fluency and adequacy."]  #pause
- #emoji.flag.red High variance in responses:
  - #comment["Evaluate the quality of #str-hyp[this summary] on scale from 0% to 100%."] $arrow 90%$
  - #comment["Evaluate the quality of #str-hyp[this summary] on scale from 0% to 100%."] $arrow 30%$
  - #comment["Evaluate the quality of #str-hyp[this summary] on scale from 0% to 100%."] $arrow 60%$
- #emoji.flag.red LLM biased
  - #comment[LLMs like their own outputs]
  - #comment[LLMs have positional bias]
  - #comment[LLMs like discrete outputs, like 100%, 75%, etc.]

#place(right+bottom, dy: -60pt, dx: 40pt)[
#box(width: 50%)[
#set align(left)
- #emoji.flag.red Lower replicability
  - #comment[Many possible prompts, various model configurations, models being deprecated]
]
]
]

#slide[
= automatic metrics / meta-evaluation
#v(5pt)

=== Common paradigm
+ Human-annotate data subset
+ Confirm automatic metric correlates #comment[#emoji.warning always look at the data]
+ Use metric to evaluate everything


#v(-10pt)
=== Recall
- Human judgment: #h(7pt)
  #box(fill: COL_GRAY_LIGHT, inset: 5pt, baseline: 10pt)[
    #show: scale.with(80%, reflow: true)
    input + output $arrow$ #emoji.person $arrow$ judgment
  ] $arrow.l$ #v(-10pt)
- Automatic metrics:
  #box(fill: COL_GRAY_LIGHT, inset: 5pt, baseline: 10pt)[
    #show: scale.with(80%, reflow: true)
    input + output $arrow$ #emoji.robot $arrow$ judgment
  ] $arrow.l$
  #place(right, dx: 160pt, dy: -40pt, box()[Should correlate])

#v(-10pt)
#pause
=== How to meta-evaluate?
- mean average error #comment[#emoji.checkmark.box absolute agreement / interpretable #h(10pt) #emoji.flag.red dist. imbalance #h(10pt) #emoji.flag.red scale dependent] #pause
- global Pearson correlation #comment[#emoji.flag.red always high #h(10pt) #emoji.flag.red sensitive to outliers #h(10pt) #emoji.flag.red assumes linear relationship] #pause
- Kendall $tau$ group-by-item #comment[#emoji.checkmark.box per-item best model selection #h(10pt) #emoji.flag.red high variance #h(10pt) #emoji.flag.red weak with small $cal(M)$] #pause
- Kendall $tau$ group-by-model #comment[#emoji.checkmark.box aligned with leaderboard objectives #h(10pt) #h(10pt) #emoji.flag.red weak with small $cal(M)$]
]


#slide[
= automatic metrics / meta-evaluation

- _"Does automatic metric align with actual human judgments?"_
- #table-box(fill: white)[
    #table(
      columns: (auto, 450pt, auto, 1fr),
      toprule(),
      [Item 1], table.cell(colspan: 3, str-src[Die kleine schwarze Katze rennt schnell durch den Garten.]),
      [Model A], str-hyp[The little black cat is running quickly through the garden.], [Human: 5 / 5], [COMET: 0.92],
      [Model B], str-hyp[The small black cat runs fast across the garden.], [Human: 5 / 5], [COMET: 0.90],
      [Model C], str-hyp[The small black dog sleeps quietly in the garden.], [Human: 1 / 5], [COMET: 0.40],
      bottomrule()
    )
  ]
- #table-box(fill: white)[
  #table(
      columns: (auto, 450pt, auto, 1fr),
    toprule(),
    [Item 2], table.cell(colspan: 3, str-src[Trotz des Regens ist das Wetter heute überraschend angenehm.]),
    [Model A], str-hyp[Despite the rain, the weather is surprisingly pleasant today.], [Human: 5 / 5], [COMET: 0.95],
    [Model B], str-hyp[In spite of the rain, today's weather is quite nice.], [Human: 5 / 5], [COMET: 0.93],
    [Model C], str-hyp[Because of the rain, the weather is very good today.], [Human: 3 / 5], [COMET: 0.65],
    bottomrule()
  )
]
- #table-box(fill: white)[
  #table(
    columns: (auto, 400pt, auto, 1fr),
    toprule(),
    [items 3 ... 30 similar scores],
    bottomrule(),
  )]
- #emoji.checkmark.box Group-by-item human and COMET correlates \ #h(1.3em) $arrow.double$ can use COMET-only on the rest of the dataset
]

#slide[
= automatic metrics / meta-evaluation

#set list(spacing: 0.3em)

- _"What happens when the metric fails?"_
- #table-box(fill: white)[
    #table(
      columns: (auto, 400pt, auto, 1fr),
      toprule(),
      [Item 1], table.cell(colspan: 3, str-src[After the three-month investigation uncovered the misappropriation of millions in funds, the board of directors held an emergency meeting late Tuesday night, resulting in the CEO's immediate and highly publicized resignation.]),
      [System A], str-hyp[CEO steps down due to fraud.], [Human: 5 / 5], [ROUGE: 0.25],
      [System B], str-hyp[The CEO resigned after a major], [Human: 2 / 5], [ROUGE: 0.95],
      [System C], str-hyp[The CEO resigned after winning.], [Human: 1 / 5], [ROUGE: 0.75]+emoji.flag.red,
      bottomrule()
    )
  ]
- #table-box(fill: white)[
  #table(
      columns: (auto, 400pt, auto, 1fr),
    toprule(),
    [Item 2],  table.cell(colspan: 3, str-src[Following the unexpected release of the latest inflation data, investor confidence completely collapsed, causing major stock indices to drop by more than eight percent and triggering widespread panic across global trading floors.]),
    [System A], str-hyp[Global markets plummet.], [Human: 5 / 5], [ROUGE: 0.15],
    [System B], str-hyp[The stock market crashed, leading], [Human: 2 / 5], [ROUGE: 0.85]+emoji.flag.red,
    [System C], str-hyp[Global warming causes panic.], [Human: 1 / 5], [ROUGE: 0.20],
    bottomrule()
  )
]
- #table-box(fill: white)[
  #table(
    columns: (1fr,),
    toprule(),
    [items 3 ... 30 similar: metric favors naive n-gram overlap over meaning],
    bottomrule(),
  )]
- #emoji.flag.red Group-by-item human and ROUGE severely disagree \ #h(1.3em) $arrow.double$ cannot use ROUGE to evaluate the rest of the dataset
]

#overview-slide(2)

#slide[
= annotation protocol / dimensions

#let mybox = box.with(radius: 4pt, inset: 10pt, width: 100%, height: 6em)

#v(1fr)
#grid(columns: 5, rows: 2, gutter: 8pt,
  mybox(fill: COL_PURPLE_LIGHT)[
    *Output type* \
    #comment[Likert, spans, ranking]
  ]+pause,
  mybox(fill: COL_PURPLE_LIGHT)[
    *Comparison* \
    #comment[absolute vs. A vs. B]
  ]+pause,
  mybox(fill: COL_PURPLE_LIGHT)[
    *Granularity* \
    #comment[document $arrow$ segment $arrow$ token]
  ]+pause,
  mybox(fill: COL_PURPLE_LIGHT)[
    *Modality* \
    #comment[text, audio, image] \
    #comment[single modality vs multimodal]
  ]+pause,
  mybox(fill: COL_PURPLE_LIGHT)[
    *Annotator type* \
    #comment[expert, crowd, target user]
  ]+pause,
)
#v(1fr)
]

#let annotation-protocol-data = (
  "output type",
  "comparison",
  "granularity",
  "modality",
  "annotator type"
)
#let annotation-protocol = j => {
  place(bottom+center, dy: 10pt, grid(
    columns: 5,
    gutter: 4pt,
    ..annotation-protocol-data.enumerate().map( x => {
      let i = x.at(0)
      let x = x.at(1)
      box(
        width: 130pt,
        fill: if j == i { COL_PURPLE_DARK } else { COL_PURPLE_LIGHT } ,
        inset: 4pt,
        align(center, text(size: 0.85em, fill: if j ==i  { white } else { luma(100) }, x))
      )
      h(4pt)
    })
  ))
}

#slide[
  = annotation protocols

  #annotation-protocol(0)

  #v(1fr)
  #pause
  #grid(
    columns: (1.8fr, 2.5fr, 2fr),
    row-gutter: 1.5em,
    column-gutter: 1em,
    [*Likert scale*],
    [#comment[_"Rate quality X on a scale from 1 to 5"_]],
    [#comment[quick, broadly familiar]] + pause,
    
    [*Continuous / slider*],
    [#comment[_"Rate quality X on a scale from 0 to 100"_]],
    [#comment[finer-grained, less fence-sitting]] + pause,
    
    [*Categorical labels*],
    [#comment[_"Is X fluent / disfluent / broken?"_]],
    [#comment[diagnostics, error typing]] + pause,
    
    [*Span annotation*],
    [#comment[_"Highlight and annotate errors in text"_]],
    [#comment[localization, MQM, ESA]] + pause,
    
    [*Preference / ranking*],
    [#comment[_"Rank A / B / C"_]],
    [#comment[comparative evaluation]],
  )
  #v(1fr)
]

#slide[
  = annotation protocols
  #annotation-protocol(1)
  
  === Feel free to show the annotator more examples at once if you have:
  #pause
  - short outputs
  #pause
  - an interest in subjective preference
  #pause
  - a long source text
  
  === Stick to one system at a time if you:
  #pause
  - have long outputs
  #pause
  - need an objective rating
  #pause
  - need to compare scores across studies
  #pause
  #block(
    fill: COL_YELLOW_LIGHT,
    inset: 8pt,
    radius: 4pt,
    width: 100%,
  )[
    *Exercise:* #comment[You are comparing model A (more expensive/slower, assumedly higher quality) and model B (cheaper/faster). You need to decide which one to deploy. Should you choose a contrastive evaluation or not?]
  ]
  #v(-0.4em)
  #pause
  #block(
    fill: COL_GREEN_LIGHT,
    inset: 8pt,
    radius: 4pt,
    width: 100%,
  )[
    #emoji.flag.red *No* #comment[You want to gauge the objective quality difference to assess whether the cost-quality tradeoff is worth it.]
  ]

]

#slide[
  = annotation protocols
  #annotation-protocol(2)
  #v(1fr)
  #set list(spacing: 0.6em, body-indent: 4pt)
  #grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 10pt,
    [
      === Document
      - #emoji.checkmark.box Fast, low fatigue
      - #emoji.checkmark.box Holistic impression
      - #emoji.flag.red Cannot localize errors
      - #emoji.flag.red Misses local phenomena
    ]+pause,
    [
      === Paragraph
      - #emoji.checkmark.box Captures discourse-level phenomena
      - #emoji.flag.red Boundary decisions can be ambiguous
    ]+pause,
    [
      === Segment
      - #emoji.checkmark.box Most common in NLP
      - #emoji.checkmark.box Aggregates up to document
      - #emoji.flag.red No cross-sentence phenomena
    ]+pause,
    [
      === Token / span
      - #emoji.checkmark.box Finest localization
      - #emoji.checkmark.box Most reusable
      - #emoji.flag.red Slow, high fatigue
      - #emoji.flag.red Span boundary disagreements
    ],
  )

  #v(5pt)
  
  #pause
  #block(fill: COL_YELLOW_LIGHT, inset: 8pt, radius: 4pt, width: 100%)[
    #text(weight: "bold")[Exercise: ]
    #comment[You are evaluating a summarization model and care about co-reference — whether entities are referred to consistently throughout the summary. A colleague suggests segment-level scoring. Is this a good idea?]
  ]
  #v(-0.4em)
  #pause
  #block(
    fill: COL_GREEN_LIGHT,
    inset: 8pt,
    radius: 4pt,
    width: 100%,
  )[
    #emoji.flag.red *No* #comment[No, co-reference is a cross-sentence phenomenon that cannot be captured on segment-level.]
  ]

  #v(35pt)
]


#slide[
  = annotation protocols
  #annotation-protocol(3)

  Text is a great modality to evaluate but..


  #v(-50pt)
  #set align(center+horizon)
  #image("img/pearmut_multimodal.png", width: 75%)
  
]

#slide[
  = annotation protocols
  #annotation-protocol(4)

  #v(1.5fr)

  #let category(title, col, body, step) = {
    uncover(step, box(
      fill: col.lighten(60%), 
      inset: 6pt, 
      width: 100%, 
      height: 230pt, 
      radius: 6pt
    )[
      #set align(top + left)
      #strong[#title]
      #v(0.5em)
      #set text(size: 0.8em)
      #body
    ])
  }

  #grid(columns: (1fr, 1fr, 1fr, 1fr, 1fr), column-gutter: 8pt,
    category("Crowd", COL_RED_DARK, [
      - Maximum scale
      - Lowest cost
      - #emoji.flag.red Bot risk
      - #emoji.flag.red English-heavy
    ], "1-"),
    
    category("Vetted Crowd", COL_YELLOW_DARK, [
      - Targeted demographics
      - Linguistic diversity
      - Quality varies by platform
    ], "2-"),

    category("Students", COL_BLUE_DARK, [
      - In-house / Community
      - High accountability
      - Proxy for experts
      - Fairly cost-effective
    ], "3-"),

    category("Authors", COL_PURPLE_DARK, [
      - Domain masters
      - Ideal for pilot testing
      - #emoji.flag.red Massive bias
      - #emoji.flag.red Blind to flaws
    ], "4-"),

    category("Experts", COL_GREEN_DARK, [
      - Highest reliability
      - Detailed feedback
      - #emoji.flag.red Hard to recruit
      - #emoji.flag.red Expensive
    ], "5-")
  )


  #uncover("6-")[
    #align(center)[
      #text(size: 0.9em, weight: "bold", fill: COL_GRAY_LIGHT.darken(50%))[Scale & Speed]
      #text(fill: COL_GRAY_LIGHT.darken(30%), weight: "bold")[$arrow.l$]#h(-7pt)
      #box(line(length: 320pt, stroke: (paint: COL_GRAY_LIGHT.darken(30%), thickness: 1.1pt,)), baseline: -5pt)
      #h(-7pt)#text(fill: COL_GRAY_LIGHT.darken(30%), weight: "bold")[$arrow.r$]
      #text(size: 0.9em, weight: "bold", fill: COL_GRAY_LIGHT.darken(50%))[Quality & Knowledge]
    ]
  ]
  #v(30pt)
]

#overview-slide(3)

#slide[
= data selection / what do we evaluate on?

#set align(horizon)

#grid(columns: (1fr, 1.2fr), gutter: 1.5em,
  box(fill: COL_BLUE_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
    *Where to get data from?*
    #v(0.5em)
    - *Existing sets:* Cheap and standard. Risk of train-test contamination.
    - *New sets:* Clean and authentic. High cost. Licensing required (especially speech/video).
    - *Authenticity:* Inputs should reflect the target ecological domain.
  ]+pause,
  box(fill: COL_YELLOW_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
    *How to allocate resources?*
    #v(0.5em)
    Fixed budget $B = N$ items $times$ $K$ annotators.
    - *More items ($arrow.t N$):* Higher statistical power. Better coverage of the input distribution.
    - *More annotators ($arrow.t K$):* Lower variance. Better measurement of annotator reliability.
    - *Rule of thumb:* Maximize $N$ once $K$ is sufficient to model human variance.
  ]
)

#pause
#h(1fr)
#box(width: 52.5%, problem-box[How to select $N$ items?])

]

#slide[
= data selection / benchmarking

- *Goal:* Maximize statistical power to distinguish model $A$ from $B$.
- Prioritize items yielding diverse outputs. \
  #comment[- Identical outputs contribute zero information to the statistic.]

#pause

#set align(horizon)

#grid(columns: (1fr, 1.2fr), gutter: 1.5em,
  box(fill: COL_RED_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
    *#emoji.flag.red Zero variance* \
    #text(size: 0.85em)[_Source: "Hello"_] \
    #v(0.3em)
    Model A: "Hallo" \
    Model B: "Hallo" \
  ],
  box(fill: COL_GREEN_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
    *#emoji.checkmark.box High variance* \
    #text(size: 0.85em)[_Source: "The bank of the river"_] \
    #v(0.3em)
    Model A: "Die Bank am Fluss." #text(size: 0.8em)[_(financial)_] \
    Model B: "Das Ufer am Fluss." #text(size: 0.8em)[_(geographic)_] \
  ]
)
#practice-box("Caveats", COL_RED_LIGHT)[
  - This may select subjective inputs
  - People often use difficulty sampling; can provide zero signal as well
]
]

#slide[
= data selection / representative performance

- *Goal:* Estimate the expected performance (diagnosis)
- The sample distribution must  match the target population distribution.

#grid(columns: (1fr, 1fr), gutter: 1.5em,
  box(fill: COL_GRAY_LIGHT_LIGHT, inset: 12pt, radius: 4pt, width: 100%)[
    *Random sampling* \
    #v(0.5em)
    Uniformly sample from production logs. Guarantees ecological validity if the logs match future inputs. \ \
  ],
  box(fill: COL_GRAY_LIGHT_LIGHT, inset: 12pt, radius: 4pt, width: 100%)[
    *Stratified sampling* \
    #v(0.5em)
    Enforce domain quotas (e.g., 20% legal, 50% news, 30% informal) to prevent majority domains from masking minority domain failures.
  ]
)

#problem-box[
  Applying diversity-output sampling to diagnosis evaluations confounds the estimate. It over-represents difficult edge cases and ignores baseline accuracy, artificially deflating the absolute score.
]
]

#let small-text = text.with(size: 0.8em)
#let model-old = box(inset: 2pt, outset: 2pt, fill: COL_PURPLE_LIGHT, baseline: 2pt)[#small-text[Old model]]
#let model-new = box(inset: 2pt, outset: 2pt, fill: COL_BLUE_LIGHT, baseline: 2pt)[#small-text[New model]]

#slide[
= experimental design

#set block(radius: 4pt, inset: 4pt, width: 100%)

- A *condition* is the difference that is tested (e.g. #model-old vs #model-new)
- Which annotator sees which item and in which condition? 
#pause
#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
- *Between-subject design #comment[("A/B testing")]*: each annotator only sees one condition
- #comment[Alice grades outputs from the #model-old. Bob grades outputs from the #model-new.]
- #comment[#only("2")[Problem?] #uncover("3-")[#emoji.flag.red Bob might just be a negative person, which is unfair to #model-new]]
]
#pause
#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
- *Within-subject design*: same person evaluates the same item in multiple conditions
- #comment[Alice grades an output from #model-old, then grades the same output from #model-new.]
- #comment[#only("4")[Problem?] #uncover("5-")[#emoji.flag.red Alice might find errors in #model-new just because she knows the example more]] 
]
#pause
#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
- *Mixed design*: Annotators see multiple conditions, but on different items
- #comment[Alice grades Item 1 with #model-old, then Item 2 with #model-new.]
- #comment[#only("6")[Problem?] #uncover("7-")[#emoji.flag.red Alice's score for #model-new might be higher just because Item 2 is easier]]
]
]

#slide[
= experimental design

#comment[Cognitive phenomena affect experiment results (subjectivity, sequence effects, ...)]

#show list.item: comment
#set block(radius: 4pt, inset: 4pt, width: 101%)

#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
=== Between-subject
- #emoji.checkmark.box *No contamination:* Annotators aren't biased
- #emoji.flag.red *High noise:* Hard to tell if #model-new > #model-old or the annotator(s) of #model-new just happened to be generous
- #emoji.flag.red *Expensive:* Noise tackled by hiring 10 annotators to evaluate each model.
]
#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
=== Within-subject
- #emoji.checkmark.box *Precise comparisons:* Eliminates grader bias. If Alice says #model-new > #model-old, then that is the truth
- #emoji.checkmark.box *Cheap:* Faster to annotate the same item in different conditions
- #emoji.flag.red *Carryover bias:* Seeing output of #model-new for an item might bias Alice's evaluation of #model-old
]
#v(-0.5em)
#block(fill: COL_GRAY_LIGHT_LIGHT)[
=== Mixed design
- #emoji.checkmark.box *No item contamination:* Annotators don't see the exact input twice
- #emoji.checkmark.box *Grader bias is low:* Averaged away
]
]
#slide[
= experimental design

#place(top+right, box(width: 50%, comment[Assuming true model quality: Old = 60, New = 70.\ Alice is strict (-10), Bob is generous (+10).\ "Katze" is hard (-10), "Wetter" is easy (+10).]))
#show table: box.with(width: 350pt)

=== Between-subject
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Alice], str-src[Die Katze rennt.], model-old, [40],
    [Bob], str-src[Die Katze rennt.], model-new, [70],
    bottomrule()
  )
]
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Alice], str-src[Das Wetter ist schön.], model-old, [60],
    [Bob], str-src[Das Wetter ist schön.], model-new, [90],
    bottomrule()
  )
]
#v(-1em)
#comment[Annotator bias confounds the result. The +30 gap is driven by Bob's generosity. Annotations also take longer.]

#pause
=== Within-subject
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Alice], str-src[Die Katze rennt.], model-old, [40],
    [Alice], str-src[Die Katze rennt.], model-new, [50],
    bottomrule()
  )
]
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Bob], str-src[Das Wetter ist schön.], model-old, [80],
    [Bob], str-src[Das Wetter ist schön.], model-new, [90],
    bottomrule()
  )
]
#v(-1em)
#comment[Annotator bias cancels out. Both graders isolate the true +10 model improvement.]

#pause
=== Mixed design
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Alice], str-src[Die Katze rennt.], model-old, [40],
    [Alice], str-src[Das Wetter ist schön.], model-new, [70],
    bottomrule()
  )
]
#table-box[
  #table(
    columns: 4,
    toprule(),
    [Bob], str-src[Die Katze rennt.], model-new, [70],
    [Bob], str-src[Das Wetter ist schön.], model-old, [80],
    bottomrule()
  )
]
#v(-1em)
#comment[Correct rating but annotations can take longer.]
]

#slide[
= annotator reliability

#place(top+right, box(width: 300pt, comment[if human evaluators are inconsistent,\ your "ground truth" is random noise]))

#pause

=== Inter-annotator reliability: _Do different people agree on the exact same output?_
#table-box(fill: white)[
  #table(
    columns: 4,
    toprule(),
    [Alice], str-src[Die Katze rennt.], str-hyp[The feline sprints.], [95],
    [Bob], str-src[Die Katze rennt.], str-hyp[The feline sprints.], [40],
    bottomrule()
  )
]
#v(-1em)

#comment[#emoji.flag.red *Failure:* Possible reasons: (1) the guidelines are vague, (2) task is subjective (Alice rewards creative vocabulary; Bob penalizes literal deviations), (3) annotators don't do a good job]

#pause
=== Intra-annotator reliability: _Does the same person agree with themselves over time?_
#table-box(fill: white)[
  #table(
    columns: 4,
    toprule(),
    [Alice (Monday)], str-src[Das Wetter ist schön.], str-hyp[The weather is nice.], [90],
    [Alice (Friday)], str-src[Das Wetter ist schön.], str-hyp[The weather is nice.], [50],
    bottomrule()
  )
]
#v(-1em)
#comment[#emoji.flag.red *Failure:* (1) vague guidelines or (3) annotators don't do a good job (Alice is clicking randomly to finish faster)]

#v(1fr)
- can be used to filter annotators in pilot, see upper bound on metric performance
- many statistics: average MAE, Cohen's $kappa$, Fleiss' $kappa$, Krippendorff's $alpha$, correlations
- inject an overlap in data annotations to compute inter-AA and intra-AA
]


#slide[
  = subjectivity / human ground truth

  #v(1em)
  === variance is (sometimes) not noise
  - Benchmarks inherently assume a single "gold" label.
  - In human evaluation, variance often reflects genuine linguistic or demographic diversity, not annotator error.

  #bad-box[Forcing consensus. Discarding annotations that deviate from the mean to artificially inflate inter-annotator agreement (IAA).]
  #good-box[Model the group variance. Retain demographic metadata and report score distributions rather than collapsing distinct human judgments into a single scalar.]
]


#slide[
  = subjectivity / modelling variance

  #v(0.5em)
  #align(center)[
    #box(fill: COL_GRAY_LIGHT_LIGHT, inset: 15pt, radius: 4pt, width: 95%)[
      #text(size: 1.3em)[
        $ y_(i j k) = underbrace("system"_i, #text(fill: COL_GREEN_DARK.darken(20%))[signal]) + underbrace("item"_j + "annotator"_k + "progress"_"time", #text(fill: COL_RED_DARK)[confounders]) + underbrace(epsilon, #text(fill: luma(90))[noise]) $
      ]
      #v(0.5em)
      #text(size: 0.9em)[Mixed-effects models disentangle true quality from annotator bias and item difficulty.]
    ]
  ]

  #v(1fr)
  *use-case: german multidialectal evaluation*:\ Rate the naturalness of MT. Youth prefer informal _du_; Seniors prefer formal _Sie_.

  #v(0.5em)
  #grid(columns: (1fr, 1.1fr), gutter: 1.5em,
    box(fill: COL_RED_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.flag.red Naïve: Averaging* \
      #v(0.5em)
      #text(size: 0.85em)[
        Opposing preferences cancel out. Differences appear as "noise". \
        $arrow.r$ Both systems appear *mediocre*.
      ]
    ],
    box(fill: COL_GREEN_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.checkmark.box Principled: Demographics* \
      #v(0.5em)
      #text(size: 0.85em)[
        Model the latent demographic preferences. \
        $arrow.r$ System A is SOTA for Youth. \
        $arrow.r$ System B is SOTA for Seniors.
      ]
    ]
  )
]
#slide[
  = subjectivity / annotator cognitive load

  #v(1em)
  - Annotation difficulty must be calibrated to human capacity.
  - High cognitive load induces heuristic shortcuts (e.g., grading by length instead of reading).

  #let mybox = box.with(height: 255pt, inset: 10pt)

  #v(1em)
  #grid(columns: 3, gutter: 0.5em,
    mybox(fill: COL_RED_LIGHT)[
      *Too Easy* \
      #text(size: 0.8em)[Trivial comparison. Annotators auto-click. High agreement, zero discriminative power.]
      #v(1fr)
      #text(size: 0.85em, style: "italic")[Example: Evaluate MT of "Hello world". Both models output exact matches. Yields 0 bits of information.]
    ],
    mybox(fill: COL_GREEN_LIGHT)[
      *Just Right* \
      #text(size: 0.8em)[Errors are subtle but identifiable with focused reading. Maximizes signal-to-noise.]
      #v(1fr)
      #text(size: 0.85em, style: "italic")[Example: Document-level news MT. Annotator spots a pronoun gender hallucination resolved 3 sentences later.]
    ],
    mybox(fill: COL_RED_LIGHT)[
      *Too Hard* \
      #text(size: 0.8em)[Requires extreme domain expertise. Crowdworkers get tired or guess randomly. Zero signal.]
      #v(1fr)
      #text(size: 0.85em, style: "italic")[Example: Evaluate generation of a dense legal contract. Layman annotator defaults to rating purely on fluency or text length.]
    ]
  )
]

#overview-slide(4)

#slide[
  = multilinguality / translationese

  === the direction of data matters
  - *Translationese*: difference between text originally from a language and translated to the language (typically simpler, less idiomatic).
  - Many test sets (like older WMT or FLORES) contain translationese in the source.

  #bad-box[Evaluating an English$arrow$German model on English source sentences that were originally translated from Chinese. The model is penalized for generating natural German because the English "source" is already clunky and literal.]
  #good-box[Evaluate on native texts. The source text must be natively authored in the source language.]
]

#slide[
  = multilinguality / translationese

  #v(1em)

  #grid(columns: (1fr, 1fr), gutter: 1.5em,
    box(fill: COL_RED_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.flag.red Evaluating on translationese* \
      #text(size: 0.8em)[Original: _"欢迎大家提出宝贵意见。"_] \
      #v(0.3em)
      *Source:* _"Welcome everyone to put forward precious opinions."_ \
      #v(0.5em)
      *Model:* "Willkommen alle, um wertvolle Meinungen vorzubringen." \
      #v(0.5em)
      *Human Eval: 1/5* \
      #comment[The model is penalized for unnatural German, but it was just faithfully translating a broken English source.]
    ],
    box(fill: COL_GREEN_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.checkmark.box Evaluating on native source* \
      #text(size: 0.8em)[Original: _"We welcome your valuable feedback."_] \
      #v(0.3em)
      *Source:* _"We welcome your valuable feedback."_ \
      #v(0.5em)
      *Model:* "Wir freuen uns auf Ihr wertvolles Feedback." \
      #v(0.5em)
      *Human Eval: 5/5* \
      #comment[When given a natural English source, the model proves it can generate fluent, idiomatic German.]
    ]
  )
]

#slide[
  = multilinguality / cultural pragmatics

  underspecified guidelines problematic especially in multilingual and multicultural contexts

  #v(0.5em)
  #grid(columns: (1fr, 1fr), gutter: 1.5em,
    box(fill: COL_RED_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.flag.red Vague guidelines* \
      #text(size: 0.9em)[_"Evaluate the quality of the email summary."_]
      #v(0.5em)
      *Model:* "The sender hopes you are enjoying the autumn breeze, thanks you for the continued partnership, and asks for the Q3 report."
      #v(0.5em)
      *Human Eval: 5/5* \
      #comment[Rewarded for preserving all semantic information. Fails to account for US business norms.]
    ],
    box(fill: COL_GREEN_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *#emoji.checkmark.box Grounded guidelines* \
      #text(size: 0.9em)[_"Evaluate the quality of the hyper-terse summary for a US corporate Slack channel."_]
      #v(0.5em)
      *Model:* "Action item: Send Q3 report."
      #v(3.2em)
      *Human Eval: 5/5* \
      #comment[The literal model output from the left box would score 1/5 here for failing the pragmatic goal.]
    ]
  )

]

#slide[
= multilinguality / evaluation protocol

#set align(horizon)

#grid(
  columns: 3,
  gutter: 0.5em,
  box(fill: COL_BLUE_LIGHT, inset: 12pt, radius: 4pt, width: 100%, height: 85%)[
    #text(size: 1.1em, weight: "bold")[Target only] \
    #text(size: 0.85em, style: "italic")[Skill: Monolingual]
    #v(0.8em)
    Fluency, naturalness, and safety in target. \
    #strong[#emoji.flag.red no meaning preservation]
    
    #v(1fr)
    #text(size: 0.8em)[*Blindness:* \
    Hypothesis: _"The CEO was promoted"_ \
    Source: _"The CEO was fired"_ \
    Annotator: 5/5 perfect grammar.]
  ],
  box(fill: COL_YELLOW_LIGHT, inset: 12pt, radius: 4pt, width: 100%, height: 85%)[
    #text(size: 1.1em, weight: "bold")[Target + Reference] \
    #text(size: 0.85em, style: "italic")[Skill: Monolingual]
    #v(0.8em)
    Meaning overlap. \
    #strong[#emoji.flag.red reference bias]
    
    #v(1fr)
    #text(size: 0.8em)[*Bias:*\ Reference: _"I am extremely exhausted."_\ Hypothesis: _"I'm super tired."_\ Annotator: 4/5 for not matching exact phrase.]
  ],
  box(fill: COL_GREEN_LIGHT, inset: 12pt, radius: 4pt, width: 100%, height: 85%)[
    #text(size: 1.1em, weight: "bold")[Target + Source] \
    #text(size: 0.85em, style: "italic")[Skill: Bilingual, more difficult]
    #v(0.8em)
    True adequacy and cross-lingual alignment. 

    #v(1fr)
  ]
)
]

#overview-slide(5)

#slide[
= guidelines

- tells annotators: what to annotate, how to decide, and how to handle edge cases
- *Too vague guidelines* #sym.arrow annotators fill gaps with their own assumptions
- *Too verbose guidelines* #sym.arrow annotators stop reading halfway #underline[(they really will)]
#pause
- Golden rule: have someone *other than the author* dry-run them before going live
  - #comment[they will catch ambiguities the author is blind to]

#place(bottom+center, image("img/wmt_guidelines.png", height: 250pt))
#place(bottom+right, dx: -43pt, dy: 15pt)[#comment[example from WMT 2026]]
]


#slide[
= tutorials

- A short hands-on walkthrough *before* the real task begins
- Guides annotators through worked out examples
#pause
- Serves double duty:
  - trains annotators
  - filters out those who did not understand the task or are not fully interested
#pause
- Time of annotator going through the tutorial is time annotator is not annotating
 - Keep it short: few examples is usually enough (depending on the scenario)
]

#slide[
= tutorials

#set align(bottom)
#image("img/wmt_tutorial_1.png")
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]


#slide[
= tutorials

#set align(bottom+center)
#image("img/wmt_tutorial_2.png", height: 350pt)
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]

#slide[
= tutorials

#set align(bottom+center)
#image("img/wmt_tutorial_3.png", height: 350pt)
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]

#slide[
= tutorials

#set align(bottom+center)
#image("img/wmt_tutorial_4.png", height: 350pt)
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]

#slide[
= tutorials

#set align(bottom+center)
#image("img/wmt_tutorial_5.png", height: 370pt)
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]

#slide[
= tutorials
#v(-100pt)

#set align(bottom+center)
#image("img/wmt_tutorial_6.png", height: 400pt)
#place(bottom+center, dy: 15pt)[#comment[example from WMT 2026]]
]

#slide[
  = attention checks

  - Crowdworkers optimise for *throughput*, not quality
  #pause
  - Three strategies:
    - *Post-hoc filtering*: plant items with a known correct answer
    - *Pre-screen filtering*: only annotators who pass a screening can participate
    - *Loud attention check*: whenever annotator fails an attention check, show a warning
  #pause
  - Attention checks should be *realistic* and not trivially detectable

  #only("4")[
    #block(fill: COL_YELLOW_LIGHT, inset: (x: 8pt, y: 5pt), radius: 4pt, width: 100%)[
      *Example:* _determine if a posting is real or fake_. \
      Just a 5-minute walk from Mall of the Emirates, DoubleTree by Hilton Dubai offers modern accommodations. Dubai International Airport is 30 minutes away by car.
      Enjoy breathtaking views across the #[Hudson River] to #[New Jersey] and #[Liberty Island] from select suites.
    ]
  ]
  #let major = box.with(fill: COL_RED_LIGHT, outset: 2pt, radius: 2pt)
  #only("5-")[
    #block(fill: COL_YELLOW_LIGHT, inset: 10pt, radius: 4pt, width: 100%)[
      *Example:* _determine if a posting is real or fake_. \
      Just a 5-minute walk from Mall of the Emirates, DoubleTree by Hilton Dubai offers modern accommodations. Dubai International Airport is 30 minutes away by car.
      Enjoy breathtaking views across the #major[Hudson River] to #major[New Jersey] and #major[Liberty Island] from select suites.
    ]
  ]
]

#overview-slide(6)

#slide[
= annotation example / translation

#set align(center+horizon)

#image("img/pearmut_translation.png", height: 84%)
]

#slide[
= annotation example / speech quality
#set align(center+horizon)
#image("img/pearmut_speech.png")
]

#title-slide[
  #v(1fr)
  = #text(size: 270pt)[break]

  #v(1fr)
  up next: setup your own human evaluation
]

#overview-slide(6)

#slide[
  = our own human evaluation

  #align(center+horizon)[
    #set align(left)

    *Example task: machine translation*
    #v(0.5em)

    #grid(
      columns: (1.1fr, 1fr, 1.1fr),
      gutter: 1em,
      rect(fill: COL_GRAY_LIGHT, inset: 1em, radius: 0.4em, width: 100%)[
        *Input modality*
        #v(0.3em)
        - text $arrow$ text
        - text + image $arrow$ text
        - speech $arrow$ text
      ],
      rect(fill: COL_GRAY_LIGHT, inset: 1em, radius: 0.4em, width: 100%)[
        *Annotation types*
        #v(0.3em)
        - Sliders (scoring)
        - Span annotation
        - Free text
      ],
      rect(fill: COL_GRAY_LIGHT, inset: 1em, radius: 0.4em, width: 100%)[
        *Study design*
        #v(0.3em)
        - Guidelines
        - One annotator?
        - Multiple Annotators?

      ],
    )
  ]
]




#slide[
  = annotation platforms
  #let mybox = box.with(inset: 10pt, width: 400pt)
  #show image: box.with(width: 300pt)

  #v(-50pt)
  #mybox(fill: COL_GRAY_LIGHT)[
      Appraise @federmann-2018-appraise
      - Older (\<2026) WMT shared tasks
      - Difficult to deploy and modify
    ]
  #image("img/platform_appraise.png")

  #pause
  #v(-60pt)
  #mybox(fill: COL_RED_LIGHT)[
    Label Studio @label-studio
    - General-purpose annotation
    - Easy configuration, harder logistics
  ]
  #image("img/platform_labelstudio.png")

  #pause
  #v(-60pt)
  #mybox(fill: COL_PURPLE_LIGHT)[
    Potato @pei-etal-2022-potato
    - General-purpose
    - Easy configuration, harder logistics
  ]
  #image("img/platform_potato.png")
  
  #pause
  #v(-100pt)
  #show: place.with(bottom)
  #mybox(fill: COL_BLUE_LIGHT)[
    Factgenie @kasner2024factgenie
    - Span annotation (fact verification)
    - Human + LLM integration
  ]
  #image("img/platform_factgenie.png")
]

#slide[
  = annotation platforms / Pearmut @zouhar2026pearmut

  #show raw: block.with(fill: COL_GRAY_LIGHT, inset: 5pt, radius: 0.4em)
  
  #let mybox = box.with(inset: 10pt, width: 350pt)
  #show image: box.with(width: 400pt)

  #box()[
  #mybox(fill: COL_GREEN_LIGHT, baseline: -60pt)[
    #set align(left)
    - MT-focused but customizable
    - Easy to deploy & reproduce
    - Multimodal support
    - Handles logistics
  ]

  #v(-50pt)
  #box(width: 350pt)[
    ```
    pip install pearmut
    
    # Download example campaign
    git clone https://github.com/zouharvi/humeval-tutorial.git
    cd humeval-tutorial/our_own_humeval/campaigns
    
    # Load and start
    pearmut add 0a_da.json
    pearmut run
    ```
  ]
]
  #image("img/platform_pearmut.png", width: 100%)
]


#slide[
= our own human evaluation

#show raw: block.with(fill: COL_GRAY_LIGHT, inset: 5pt, radius: 0.4em)
#set align(left)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 0.5em,
  rect(fill: COL_BLUE_LIGHT, inset: 0.6em, radius: 0.4em, width: 100%, height: 5em)[
    *0. Basic* \
    #text(size: 0.8em)[starting point]
  ],
  rect(fill: COL_GREEN_LIGHT, inset: 0.6em, radius: 0.4em, width: 100%, height: 5em)[
    *1–4. Advanced* \
    #text(size: 0.8em)[sliders · spans · extra]
  ],
  rect(fill: COL_YELLOW_LIGHT, inset: 0.6em, radius: 0.4em, width: 100%, height: 5em)[
    *5. Multimodal* \
    #text(size: 0.8em)[image + audio]
  ],
  rect(fill: COL_PURPLE_LIGHT, inset: 0.6em, radius: 0.4em, width: 100%, height: 5em)[
    *6. Scaling* \
    #text(size: 0.8em)[distribute across annotators]
  ],
)

#v(0.6em)
#text(size: 0.85em)[
  #grid(
    columns: (auto, 1fr),
    gutter: 0.5em,
    `campaigns/0a_da.json`, [basic DA protocol],
    `campaigns/1_sliders.json`, [DA protocol + custom sliders],
    `campaigns/2_spans.json`, [ESA: error span annotation + score],
    `campaigns/3_custom_spans.json.json`, [ESA: custom spans],
    `campaigns/4_freetext.json`, [ESA + free-text comment box],
    `campaigns/5_multimodal.json`, [image and audio as input],
    `campaigns/6a_one_annotator.json`, [task-based: one annotator gets all items],
    `campaigns/6b_four_annotators.json`, [task-based: items split across 4 annotators],
    `campaigns/6c_single_stream.json`, [single-stream: automatic distribution],
  )
]
]

#slide[
= our own human evaluation
#place(top+left, dy: 2em, image("img/pearmut_screenshot_0.png", width: 70%))
#place(bottom+ right, image("img/pearmut_screenshot_1.png", width: 60%))
]


#slide[
= campaign 0 / template
#v(1fr)
#block(width: 90%)[
#grid(columns: (1fr, 1fr), gutter: 1em,
  all-line[```json
  {
    "campaign_id": "...",
    "info": { ... },
    "data": [[ ... ]]
  }
  ```],
  [
    *campaign_id*: unique identifier

    *info*: campaign configuration

    *data*: items to annotate
  ],
)
]
#v(1fr)
]



#slide[
= campaign 0 / campaign_id
#v(1fr)
#block(width: 90%)[
  #grid(columns: (1fr, 1fr), gutter: 1em)[
#all-line[```json
{
"campaign_id": "my_campaign",
"info": { ... },
"data": [[ ... ]]
}
```]][
`campaign_id_` is unique identifier for your campaign. Used in the dashboard URL and *must be unique across all loaded campaigns.*
]
]
#v(1fr)
]

#slide[
= campaign 0 / info
#v(1fr)
#block(width: 90%)[
  #grid(columns: (1fr, 1fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
```],
        highlight-line[```json
"info": {
  "assignment": "task-based",
  "protocol": "DA"
},
```],
        bellow-line[```json
"data": [[ ... ]]
}
"instructions": "...",
  "sliders": [{"name": "Fluency",
    "min": 0, "max": 100, "step": 1}]
```],
      )
    ],
    [
      - *assignment*: `task-based`, `single-stream`, `dynamic`
      - *protocol*: `DA`, `ESA`, `cESA`,`MQM`
      - *instructions*: shown on every item
      - *sliders*: custom score axes
    ],
  )
]
#v(1fr)
]

#slide[
= campaign 0 / data
#v(1fr)
#block(width: 90%)[
  #grid(columns: (3fr, 1fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": {
  "assignment": "task-based",
  "protocol": "DA",
  "instructions": "...",
  "sliders": [{"name": "Fluency",
    "min": 0, "max": 100, "step": 1}]
},
```],
        highlight-line[```json
"data": [[
  [{"item_id": "item_1", "src": "SRC",
    "tgt": {"ModelA": "...", "ModelB": "..."}}],
  [{"item_id": "item_2", "src": "SRC",
    "tgt": {"ModelA": "...", "ModelB": "..."}}]
]]
```],
        bellow-line[```json
}
```],
      )
    ],
    [
      - outer list: one entry *per user*
      - middle list: *documents*
      - inner list: *segments*

      Each segment needs `tgt`. Add `src` for source, `item_id` for tracking.
    ],
  )
]
#v(1fr)
]


#slide[
= campaign 0 / template
#v(1fr)
#block(width: 90%)[
  #grid(
    columns: (3fr, 1fr),
    gutter: 1em,
    all-line[```json
    {
      "campaign_id": "my_campaign",
      "info": {
        "assignment": "task-based",
        "protocol": "DA"
      },
      "data": [[
        [{"item_id": "item_1", 
          "src": "SRC",
          "tgt": {"ModelA": "...", "ModelB": "..."}}],
        [{"item_id": "item_2", 
          "src": "SRC",
          "tgt": {"ModelA": "...",  "ModelB": "..."}}]
      ]]
    }
    ```],
    [
      Fill in `campaign_id`, `instructions`, and your `src` / `tgt` texts.
      #v(1em)
      #all-line[```
      pearmut add campaigns/0.json
      pearmut run
      ```]
    ],
  )
]
#v(1fr)
]

#slide[
= campaign 0 / template

#set align(center+horizon)
#image("img/tut_0a_da.png", height: 80%)
]





#slide[
= campaign 1 / sliders

#v(1fr)
#block(width: 90%)[
  #grid(
    columns: (2fr, 1fr),
    column-gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": {
  "assignment": "task-based",
  "protocol": "DA",
  "instructions": "...",
```],
        highlight-line[```json
  "sliders": [{"name": "Fluency",
    "min": 0, "max": 100, "step": 1}]
```],
        bellow-line[```json
},
"data": [[
  [{"item_id": "item_1", "src": "SRC",
    "tgt": {"ModelA": "...", "ModelB": "..."}}],
  [{"item_id": "item_2", "src": "SRC",
    "tgt": {"ModelA": "...", "ModelB": "..."}}]
]]
}
```],
      )
    ],
    [
      Each slider needs:
      - *name*: label shown to annotator
      - *min/max*: score range
      - *step*: increment size
    ],
  )
]
#v(1fr)
]


#slide[
= campaign 1 / sliders

#v(1fr)
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  [
    #stack(spacing: 0pt,
      above-line[```json
{
"campaign_id": "my_campaign",
"info": {
  "assignment": "task-based",
  "protocol": "DA",
  "instructions": "...",
```],
      highlight-line[```json
"sliders": [
  {"name": "Fluency",
   "min": 0, "max": 100, "step": 1},
  {"name": "Adequacy",
   "min": 0, "max": 100, "step": 1}
]
```],
      bellow-line[```json
},
"data": [[ ... ]]
}
```],
    )
  ],
  [
    Rate each translation on *Fluency* and *Adequacy* independently.
    #v(1em)
    ```
    pearmut add campaigns/1_sliders.json
    pearmut run
    ```
  ],
)
#v(1fr)
]


#slide[
= campaign 1 / sliders
#image("img/tut1_slide.png")
]




#slide[
= campaign 2 / error spans
#v(1fr)
#grid(columns: (2fr, 1fr), gutter: 1em,
  [
    #stack(spacing: 0pt,
      above-line[```json
{
"campaign_id": "my_campaign",
"info": {
  "assignment": "task-based",
```],
      highlight-line[```json
  "protocol": "DA",
```],
      bellow-line[```json
  "instructions": "...",
  "sliders": [ ... ]
  },
"data": [[ ... ]]
}
```],
    )
  ],
  [
    Currently using DA (score only).

    *$arrow$ change protocol to ESA to add error span annotation.*
  ],
)
#v(1fr)
]

#slide[
= campaign 2 / error spans
#v(1fr)
#grid(columns: (2fr, 1fr), gutter: 1em,
  [
    #stack(spacing: 0pt,
      above-line[```json
{
"campaign_id": "my_campaign",
"info": {
  "assignment": "task-based",
```],
      highlight-line[```json
  "protocol": "ESA",
```],
      bellow-line[```json
  "instructions": "...",
  "sliders": [ ... ]
  },
"data": [[ ... ]]
}
```],
    )
  ],
  [
    *Click* start and end of an error to mark a span. *Hover* to set severity (minor / major).
    #v(1em)
    ```
    pearmut add campaigns/2a_esa.json
    pearmut run
    ```
  ],
)
#v(1fr)
]

#slide[
= campaign 2 / error spans (ESA)
#image("img/tut2_spans.png")
]



#slide[
= campaign 2 / more protocols (CESA)

#set align(center+horizon)
#image("img/tut_0c_cesa.png", height: 80%)
]


#slide[
= campaign 2 / more protocols (MQM)

#set align(center+horizon)
#image("img/tut_0d_mqm.png", height: 80%)
]




#slide[
= campaign 3 / custom error spans
#v(1fr)

    #stack(spacing: 0pt,
      above-line[```json
{
"campaign_id": "my_campaign",
  "info": {
    "assignment": "task-based",
    "protocol": "MQM",
  ```],
highlight-line[```json
    "mqm_categories": {
      "General": ["Accuracy", "Fluency"],
      "Audio-specific": ["Inaudible", "Background noise", ".."],
      "Style": ["Awkward", "Embarassing"],
      "Unknown": []
    },
    "mqm_severities": ["Neutral", "Minor", "Major", "Critical"]
```],
      bellow-line[```json
},
"data": [[ ... ]]
}
```],
)
#v(1fr)
]

#slide[
= campaign 3 / custom error spans

#set align(center)
#image("img/tut3_custom_spans.png", height: 80%)
]


#slide[
= campaign 4 / free text
#v(1fr)
#grid(columns: (2fr, 1fr), gutter: 1em,
  [
    #stack(spacing: 0pt,
      above-line[```json
{
  "campaign_id": "my_campaign",
  "info": {
    "assignment": "task-based",
    "protocol": "ESA",
    "instructions": "...",
    "sliders": [ ... ],
  ```],
        highlight-line[```json
      "textfield": "visible"
  ```],
        bellow-line[```json
  },
  "data": [[ ... ]]
}
```],
    )
  ],
  [
    Adds a comment box. Options: `"hidden"`, `"visible"`, `"prefilled"` (pre-filled with the model output).
    #v(1em)
    ```
    pearmut add campaigns/4_freetext.json
    pearmut run
    ```
  ],
)
#v(1fr)
]

#slide[
= campaign 4 / free text

#image("img/tut4_freetext.png")
]



#slide[
= campaign 5 / multimodal
#v(1fr)
#block(width: 90%)[
  #grid(columns: (3fr, 1fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": { ... },
"data": [[
  [{
```],
        highlight-line[```json
    "src": "<img src='/assets/media/photo.jpg'
             width='400'/>",
```],
        bellow-line[
```json
    "tgt": {"ModelA": "...", "ModelB": "..."}
  }],
  [{"src": "<audio controls
      src='/assets/media/clip.wav'></audio>",
    "tgt": {"ModelA": "...", "ModelB": "..."}}]
]]
}
```],
      )
    ],
    [
      Put any HTML in `src` or `tgt` / image, audio, video.

      Put files in `data/assets/media/` / pearmut serves them automatically.
      #v(1em)
      ```
      pearmut add campaigns/
      5_multimodal.json
      pearmut run
      ```
    ],
  )
]
#v(1fr)
]

#slide[
= campaign 5 / multimodal
#align(center)[#image("img/tut5_multimodal.png", width: 85%)]
]

#slide[
= campaign 6a / one annotator
#v(1fr)
#block(width: 90%)[
  #grid(columns: (3fr, 1.5fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": { "assignment": "task-based", ... },
```],
        highlight-line[```json
"data": [
  [ [item 1], [item 2],
    [item 3], [item 4] ]
]
```],
        bellow-line[```json
}
```],
      )
    ],
    [
      One entry in `data` $arrow$ one annotator URL, gets all items.
      #v(1em)
      ```
      pearmut add campaigns/
      6a_one_annotator.json
      pearmut run
      ```
    ],
  )
]
#v(1fr)
]

#slide[
= campaign 6b / manual split
#v(1fr)
#block(width: 90%)[
  #grid(columns: (3fr, 1.5fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": { "assignment": "task-based", ... },
```],
        highlight-line[```json
"data": [
  [ [item 1] ],
  [ [item 2] ],
  [ [item 3] ],
  [ [item 4] ]
]
```],
        bellow-line[```json
}
```],
      )
    ],
    [
      Four entries in `data` $arrow$ four annotator URLs, each gets one item.
      #v(1em)
      ```
      pearmut add campaigns/
      6b_four_annotators.json
      pearmut run
      ```
    ],
  )
]
#v(1fr)
]

#slide[
= campaign 6c / single stream
#v(1fr)
#block(width: 90%)[
  #grid(columns: (3fr, 1.5fr), gutter: 1em,
    [
      #stack(spacing: 0pt,
        above-line[```json
{
"campaign_id": "my_campaign",
"info": {
```],
        highlight-line[```json
  "assignment": "single-stream",
```
],
all-line[
```json
  "users": 4,
  "docs_per_user": 2,
  ...
},
```
],
highlight-line[
```json
"data": [
  [item 1], [item 2],
  [item 3], [item 4]
]
```],
        bellow-line[```json
}
```],
      )
    ],
    [
      Items drawn randomly from a shared pool. Each item annotated once, then skipped for others.
      #v(1em)
      ```
      pearmut add campaigns/
      6c_single_stream.json
      pearmut run
      ```
    ],
  )
]
#v(1fr)
]

#slide[
  = campaign / item assignment
  #align(center)[#image("img/tut6_assignment.png", width: 70%)]
]


#slide[
= pearmut / useful commands

#align(center+horizon)[
  #set align(left)
  #v(0.5em)
```
pearmut add campaigns/0a_da.json              # load a campaign
pearmut add campaigns/0a_da.json -o           # reload after changes
pearmut run                                   # start the server
pearmut purge                                 # delete all campaign data
pearmut purge tutorial_sliders                # delete one campaign
```

#v(0.5em)
*$arrow$ campaign_id in the JSON must be unique across campaigns*
]
]


#slide[
= pearmut / technical

#let mybox = box.with(inset: 5pt, fill: COL_GRAY_LIGHT)

#stack(dir: ltr,
spacing: 2pt,
mybox[your server #emoji.computer],
v(5pt)+sym.arrow,
mybox[links to annotators #emoji.person #emoji.person #emoji.person],
v(5pt)+sym.arrow,
mybox[annotations stored on your server #emoji.computer]
)

How to make server accessible to the world? #pause Options:
- #strike[Have annotators come to your computer one by one.]
- Run `pearmut` on public-facing server. \
#h(1em) Can specify port and URL when running:\
#h(1em) `pearmut run --url https://myserver.myuni.ch --port 8005` #pause
- Run locally with port-forwarding service: \
#h(1em) `ngrok http 8005 --url=pearmut.ngrok.dev` OR \
#h(1em) `ssh -R 80:localhost:8080 localhost.run` #footnote[ngrok and localhost.run are just examples of services that makes your local port accessible to the Internet. Other cloudfared, localtunnel.app, LocalXpose, etc.] \
#h(1em) `pearmut run --port 8005 --url https://pearmut.ngrok.dev`
]


#slide[
= campaign / try it out!

#align(center+horizon)[
#set align(left)

*Run your own campaign and annotate a few samples!*
#v(1em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  rect(fill: COL_BLUE_LIGHT, inset: 1em, radius: 0.4em, width: 100%)[
    *1. Create* `campaign.json`
    #v(0.3em)
    - set your `campaign_id`
    - add your own `src` / `tgt` texts
  ],
  rect(fill: COL_GREEN_LIGHT, inset: 1em, radius: 0.4em, width: 100%)[
    *2. Run*
    #v(0.3em)
    ```
    pearmut add campaign.json
    pearmut run
    ```
  ],
)
]
]

#overview-slide(7)

#slide[
= analysis / statistical testing

- Human evaluations are finite samples drawn from an underlying population of possible judgments.

#align(center)[
#v(1em)
#cetz.canvas({
  import cetz.draw: *
  
  // Underlying Population
  circle((0,0), radius: 1.8, stroke: (dash: "dashed", paint: luma(150)))
  content((0, 2.5), [*Population* \ #comment[(Unobservable)]])
  for (x, y) in ((-0.6, 0.3), (0.4, -0.7), (-1.0, -0.5), (0.8, 0.6), (0.2, 1.0), (-0.3, -1.1), (-1.2, 0.2), (1.1, -0.1)) {
    circle((x, y), radius: 0.05, fill: luma(100), stroke: none)
  }

  // Finite Sample (spaced further out)
  circle((10, 0), radius: 1.0, stroke: black, fill: luma(245)) // Shifted right vastly
  content((10, 1.7), [*Sample* \ #comment[(Observed)]])
  for (x, y) in ((9.7, 0.1), (10.2, -0.3), (10.0, 0.4)) { // Adjust sample points too
    circle((x, y), radius: 0.05, fill: black, stroke: none)
  }

  // Sampling Process (elongated and shifted)
  line((1.9, 0), (8.0, 0), mark: (end: ">", fill: black), stroke: 1pt) // Adjust start/end points
  content((4.95, 0.3), text(size: 0.8em)[Draw $N$]) // Center label on new line
})
#v(1em)
]

#v(1em)
#problem-box[
How do we know if *our model > baseline model* on population-level or we just got lucky?
]
]

#slide[
= analysis / significance vs. effect size

Statistical significance ($p < 0.05$) only proves the difference is not zero. It does not prove the difference is meaningful.
#v(-1em)

#align(center)[
#v(1em)
#scale(200%, reflow: true, cetz.canvas({
  import cetz.draw: *

  let dist(mu, c) = {
    let pts = range(-15, 16).map(x => {
      let dx = x / 10.0
      (mu + dx, 2.0 * calc.exp(-5.5 * dx * dx))
    })
    
    line(
      ..pts,
      shape: "spline",
      stroke: c + 1.5pt,
      fill: c.lighten(70%)
    )
  }

  let dist_narrow(mu, c) = {
    let pts = range(-15, 16).map(x => {
      let dx = x / 10.0
      (mu + dx, 2.0 * calc.exp(-50 * dx * dx))
    })
    
    line(
      ..pts,
      shape: "spline",
      stroke: c + 1.5pt,
      fill: c.lighten(70%)
    )
  }

  // Subplot A: Pathological N
  group(name: "hacking", {
    dist_narrow(-0.05, blue)
    dist_narrow(0.35, red)
    line((-2, 0), (2.2, 0), stroke: black)
    content((0, -0.6), text(size: 0.5em)[Tiny effect ($d approx 0.01$) \ Huge $N arrow.double p < 0.05$])
  })

  // Subplot B: Proper Effect
  group(name: "robust", {
    translate(x: 6)
    dist(0, blue)
    dist(1.5, red)
    line((-2, 0), (3.8, 0), stroke: black)
    content((0.9, -0.6), text(size: 0.5em)[Large effect ($d > 1.0$) \ Normal $N arrow.double p < 0.05$])
  })
}))
]
#v(-0.5em)

#problem-box[
- With $N"="100,000$, Model A scoring 3.401 and Model B scoring 3.400 yields $p"<"0.05$. 
- Mathematically Model A $>$ Model B, but the difference is irrelevant to users.
- *Rule:* Always report an effect size
]
]

#slide[
= analysis / dependent vs. independent

#grid(columns: (1fr, 1fr), gutter: 0.5em,
box(fill: COL_BLUE_LIGHT, inset: 12pt, width: 100%, radius: 4pt)[
  *Dependent (Paired)* \
  #v(0.5em)
  Model A and Model B generate outputs for the _exact same_ input.
  
  #v(1em)
  *Example:* Evaluating translation. Annotator sees Source X, scores Model A's translation, then scores Model B's translation. \
  *Variance:* Low. Item difficulty is perfectly controlled.
],
box(fill: COL_YELLOW_LIGHT, inset: 12pt, width: 100%, radius: 4pt)[
  *Independent (Unpaired)* \
  #v(0.5em)
  Model A and Model B generate outputs for _different_ inputs or users.
  
  #v(1em)
  *Example:* A/B testing in production. User 1 talks to Model A. User 2 talks to Model B. Prompts differ wildly. \
  *Variance:* High. Item difficulty confounds scores. \
  *#emoji.checkmark.box Fewer assumptions* \
  *#emoji.flag.red Weaker:* Requires much larger $N$ to detect the same effect.
]
)
]

#slide[
= analysis / choosing the test

Do not blindly run a t-test. Match the test to the data distribution and assumptions.

#align(horizon+center)[
#table(
  columns: 3,
  inset: 7pt,
  align: horizon+left,
  toprule(),
  [*Data Type*], [*Dependent*], [*Independent*],
  midrule(),
  box[*Continuous & Normal* \ _e.g., latency, aggregated DA_]+h(10pt)+box(image("img/microplot_beta.svg", height: 1.5em)), [Paired t-test], [Welch's t-test],
  box[*Ordinal / Skewed* \ _e.g., Likert 1-5, rankings_]+h(30pt)+box(image("img/microplot_categorical.svg", height: 1.5em)), [Wilcoxon signed-rank], [Mann-Whitney U],
  box[*Categorical* \ _e.g., Pass/Fail, Win/Tie/Loss_]+h(10pt)+box(image("img/microplot_categorical.svg", height: 1.5em)), [McNemar's test], [Chi-squared],
  bottomrule(),
)
]
]



#slide[
= analysis / reporting data

Report precision, variance, and the exact statistical setup.

#v(1em)
#grid(columns: 3, gutter: 1em,
box(fill: COL_GRAY_LIGHT, inset: 12pt, width: 100%, radius: 4pt)[
  *Naïve Reporting* \
  #v(0.5em)
  Baseline: 59.5119% \
  Ours: 64.4213% \
  
  #v(1.5em)
  #emoji.flag.red Absurd precision. \
  #emoji.flag.red No statistical testing. \
  #emoji.flag.red No variance.
]+pause,
box(fill: COL_GRAY_LIGHT, inset: 12pt, width: 100%, radius: 4pt)[
  *Vague reporting* \
  #v(0.5em)
  Baseline: 59.5% $plus.minus$ 1.0% \
  Ours: 64.4% $plus.minus$ 3.3% \
  
  #v(1.5em)
  #emoji.flag.red What is the $plus.minus$? Variance? Standard error? \
  #emoji.flag.red What testing?
]+pause,
box(fill: COL_GREEN_LIGHT, inset: 12pt, width: 100%, radius: 4pt)[
  *Proper Reporting* \
  #v(0.5em)
  Baseline: 59.5% $plus.minus$ 1.0% \
  Ours: 64.4% $plus.minus$ 3.3% \
  Caption: #comment[_"Scores show 95% CI computed via paired bootstrap resampling."_]
  
  #v(1.5em)
  #emoji.checkmark.box Sensible precision. \
  #emoji.checkmark.box Explaining caption
]
)
]


#overview-slide(8)

#slide[
= humeval malpractices / pre-registration

- *p-hacking:* Testing multiple metrics or data subsets until finding $p < 0.05$.
- *HARKing:* Hypothesizing After Results are Known obscures true statistical power.

#bad-box[Running human evaluation. System A doesn't beat B on overall quality. You check subsets. System A beats B on short sentences. You write the paper claiming System A is "optimized for concise generation."]
#good-box[Pre-register the study protocol. Commit to the sample size, primary metric, and specific statistical tests _before_ collecting human annotations. Report all null results alongside positive ones.]
]

#slide[
= humeval malpractices / statistical testing

*ordinal vs. interval data:* Likert scales (1-5) are ordinal. The distance between 3 and 4 is not strictly equal to the distance between 4 and 5.
#bad-box[Averaging Likert scores (e.g., 3.4 vs. 3.6) and applying a parametric Student's $t$-test. This assumes normality and interval spacing.]
#good-box[Report medians and distributions. Use non-parametric tests like Mann-Whitney U, Wilcoxon signed-rank, or ordinal regression models.]

#pause
- *multiple comparisons:* Comparing 5 models against each other yields 10 pairwise tests. Uncorrected, the probability of at least one false positive compounds fast.
- *Fix:* Apply Bonferroni or Benjamini-Hochberg corrections.
]

#slide[
= humeval malpractices / reporting

#v(1em)
*reproducibility crisis:* Human evaluation is notoriously difficult to replicate. Missing metadata makes it impossible.

#bad-box[_"We randomly sampled 100 generated sentences. Three human annotators evaluated them for fluency and adequacy. Our model outperformed the baseline."_]
#good-box[
Minimum reporting requirements:
- *Demographics:* L1/L2 speakers? Experts or crowdworkers?
- *Guidelines:* Exact text of the instructions provided to annotators.
- *Interface:* Screenshot of the UI (e.g., were models presented side-by-side?).
- *Agreement:* Cohen's $kappa$, Fleiss' $kappa$, or Krippendorff's $alpha$.
]
]

#slide[
= humeval malpractices / reliability

- Do independent annotators make consistent judgments under identical guidelines?
- Corrects raw observed agreement $P_o$ for random chance agreement $P_e$:
- $kappa, alpha = (P_o - P_e) / (1 - P_e) in [-1, 1]$
- Upper bound on model/metric evaluation.

#place(bottom+left)[
  #show: comment
  nominal = categories without order, ordinal = rankinng, metric = scalar
]
#table-box(fill: white)[
#table(
columns: (auto, auto, auto, auto),
column-gutter: 1fr,
toprule(),
[Metric], [Annotators], [Data scale], [Key property],
midrule(),
[Cohen's $kappa$], [Exactly 2], [Nominal], [Pairwise; sensitive to prevalence skew],
[Fleiss' $kappa$], [Fixed $> 2$], [Nominal], [Multi-rater extension],
[Krippendorff's $alpha$], [Any $>= 2$], [Nominal, ordinal, metric], [Handles missing ratings & distances],
bottomrule(),
)
]

#pause

#grid(columns: (1.3fr, 1.4fr), gutter: 0.5em,
box(fill: COL_GREEN_LIGHT, inset: 5pt, radius: 4pt, width: 100%)[
*Rule of thumb ($alpha, kappa$)* #text(size: 0.85em)[
- $[0.80, 1.00]$: High agreement
- $[0.67, 0.80)$: Subjective task
- $[0.00, 0.67)$: Unreliable
- $[-1.00, 0.00]$: Oh wow, how?
]
],
box(fill: COL_YELLOW_LIGHT, inset: 5pt, radius: 4pt, width: 100%)[
*Continuous ratings (e.g., DA 0-100)* #text(size: 0.85em)[
- Use Krippendorff's $alpha$ with interval distance
- Or report pairwise MAE (unit: score points)
- #emoji.warning Pearson $r$ normalizes away subjective means!
]
]
)
]

#slide[
= humeval malpractices / ethics

#v(0.5em)
*compensation & exploitation:* Crowdworkers are frequently paid below minimum wage for hard tasks.

#bad-box[_"We collected 5,000 annotations via Amazon Mechanical Turk. Total annotation budget was \$100."_]
#good-box[Compute average time-per-task during pilot. Set piece-rates such that the effective hourly wage meets or exceeds not just the minimum but also fair wage. Explicitly report this calculation.]

#pause
- *informed consent:* Annotators must know how their data will be used.
- *fix:* Present a consent form before the task begins. State clearly if the data will be open-sourced, used for commercial training, or deleted.
- *pay fairly:* Use resources such as #link("https://www.livingwage.org.uk/")[The UK Living Wage Foundation] to estimate a fair wage for a geographic region.
]

#slide[
= humeval malpractices / ethics

*psychological harm:* Evaluating safety, toxicity, or bias models exposes humans to hostile content.

#bad-box[Serving unfiltered violent LLM outputs to crowdworkers without prior warning. Rejecting work (withholding pay) if the worker aborts the task halfway.]
#bad-box[Avoiding problematic outputs altogether.]
#good-box[Implement content warnings. Allow workers to opt-out of specific items without penalty. For highly toxic datasets, hire professional annotators with access to psychological support.]
]

#slide[
= humeval malpractices / ethics

*informed consent:* annotators must agree to how their data will be used.

#bad-box[Silently logging keystrokes or recording demographic data and releasing it open-source without permission.]
#good-box[Require a click-through consent form. Detail data retention, open-sourcing plans, and guarantee the right to withdraw.]

*data leakage & privacy:* Datasets often inadvertently dox annotators or expose private text.
#bad-box[Publishing raw datasets containing worker IDs, IP addresses, or unredacted PII from model inputs.]
#good-box[Strip all identifying metadata. Use cryptographic hashing if tracking annotator overlap is strictly necessary.]
]

#slide[
= humeval malpractices / ethics

ethics commission / IRB: 
- Academic institutions *require* approval before human data collection begins.
- E.g., #link("https://ethz.ch/en/research/ethics-and-animal-welfare/research-ethics.html")[ETH Zurich Ethics Commission]
- They *help* you not get into trouble and do better science
- Waivers are narrow: strictly zero personal data collection, entirely benign designs, or expert-only evaluations.
]

#slide[
= humeval / standardization & data sheets

#show link: underline

- #link("https://aclanthology.org/2025.gem-1.6.pdf")[HEDS 3.0: The Human Evaluation\ Data Sheet Version 3.0] @belz-thomson-2025-heds
- #link("https://evalevalai.com/EvalFactsheets/")[Eval Factsheets]
- #link("https://aclrollingreview.org/responsibleNLPresearch/")[ACL responsible NLP checklist]
- #link("https://arxiv.org/pdf/2606.02255")[Who Annotates in NLP?] @kunilovskaya2026annotatesnlplargescaleassessment

#pause
#place(top+right, dy: 2em)[
#show: box.with(fill: COL_GREEN_LIGHT, inset: 10pt)
#set align(left)
- Reproducibility & comparability
- Rigor & Transparency
]

#pause
#v(1fr)
#align(center+horizon, image("img/xkcd_standards.png", width: 55%))
]

#overview-slide(9)

#slide[
= open problems / ecological validity

*proxy tasks vs. real utility:* We evaluate what is easy to measure, not necessarily what matters

#v(1em)
#align(center)[
#table-box(fill: white)[
  #table(
    columns: 2,
    inset: 7pt,
    align: left+horizon,
    toprule(),
    [*Target Goal*], [*Common Proxy (Benchmark)*],
    midrule(),
    [Translation Utility], [Segment-level adequacy],
    [Conversational Quality], [Single-turn pairwise preference],
    [Factual Reliability], [Error span counting],
    bottomrule()
  )
]
]

#v(1em)
#problem-box([Models optimized for pairwise preference benchmarks frequently learn to output longer, more sycophantic text—decreasing actual utility while "winning" the human evaluation.])
]


#slide[
= open problems / multidimensionality

#problem-box[Management wants a single metric to launch a model. But models capabilities are multidimensional.]

=== averaging approach
- evaluate on 10 dimensions (fluency, accuracy, safety, ...) and average the scores #pause
- *problem:* averages mask flaws
- *problem:* we lack mathematically sound ways to aggregate human preferences without hiding catastrophic failure modes

#align(center)[
#table-box(fill: white)[
#table(
  columns: 5,
  toprule(),
  [System], [Coding], [Math], [Safety], [Average],
  midrule(),
  [Model A], [95%], [90%], [*5%*], [*63%*],
  [Model B], [65%], [60%], [64%], [*63%*],
  bottomrule()
)
]
]
#set align(center)
#comment[Deploying Model A results in a disaster, despite identical average performance.]
]

#slide[
= open problems / matchmaking

#problem-box[Evaluating every model against every other model is financially impossible. For 50 models, that is 1,225 pairs. How do we rank them efficiently?]

#v(-0.9em)
=== tournament approach (model probability of outcome)
- Use Elo or TrueSkill. Pair models with similar win rates.
- Assumes transitivity: if $P(A > B) > 0.5$ and $P(B > C) > 0.5$, then $P(A > C) > 0.5$. #pause
- *problem:* Evaluation outcomes are stochastic.
- *problem:* Non-transitive preferences

#v(1em)

#align(center)[
#table-box(fill: white)[
  #table(
    columns: 4,
    toprule(),
    [], [A vs B], [B vs C], [C vs A],
    midrule(),
    [Terminology], [A], [B], [C],
    [Syntax], [A], [B], [A],
    [Idioms], [B], [C], [C],
    midrule(),
    [Majority Win], [A], [B], [C],
    bottomrule()
  )
]
]
#set align(center)
#comment[A beats B, B beats C, but C beats A. A scalar Elo rating cannot model this. Multi-dimensional adaptations exist.]
]

#slide[
= open problems / test set compression

#problem-box[Your production testset has 100k items. Your human evaluation budget is 500. Which 500 items evaluate the model best?]

#pause 

=== psychometric approach
- Item Response Theory (IRT). Discard queries that are too easy (all models pass) or too hard (all models fail).
- Retain only queries that actively discriminate between models.

#grid(columns: 3, gutter: 1em,
box(fill: COL_RED_LIGHT, inset: 10pt)[*Too Easy* _"Translate Hello"_ \ Yields 0 info.],
box(fill: COL_GREEN_LIGHT, inset: 10pt)[*Optimal?* _"Draft an NDA"_ \ Discriminates well.],
box(fill: COL_RED_LIGHT, inset: 10pt)[*Too Hard* _"Solve P=NP"_ \ Yields 0 info.]
)

#pause 

=== why it breaks in practice
- *Distribution shift:* If you only test edge cases, you stop measuring real-world
- *Blind spots:* discard "easy" items and you miss regressions on basic tasks. 

]

#slide[
= open problems / triage

#problem-box[Do not pay humans to evaluate garbage. How do we stop annotating a bad model as early as possible?]

=== routing approach
- focus human annotators to top-performing or highest-uncertainty outputs
- *problem:* less "objective" measure
- *problem:* ad-hoc pipeline setup, cumbersome to setup

#pause 

=== automatic metric pre-filtering
- select items where metrics predict failure or are uncertain
- *example:* output is in a wrong language
- *problem:* metric uncertainty is unreliable
- *problem:* metrics can be trivially hijacked (happens at WMT)
]


#slide[
= open problems / saturation

#problem-box[
Static testsets are too easy.
$arrow.double$ No failure modes $arrow.double$ Can't improve.
]

#v(2em)
#align(center, scale(x: 200%, image("img/microplot_beta.svg", width: 200pt), reflow: true))
#v(0.5em)
#place(dx: 570pt, [_$arrow.t$Dog bit the neighbour. \ \ #text(COL_RED_DARK)[too easy] _])
#place(dx: 320pt, box(width: 250pt)[_View the latest news and$arrow.t$ breaking news today for... \ #text(COL_GREEN_DARK)[just right] _])
#place(dx: 50pt, box(width: 250pt)[_I reviewed a paper #h(50pt) $arrow.t$\ about sycophancy for ICML.... \ #text(COL_RED_DARK)[too hard / specific] _])

#v(1fr)
#set align(center)
#comment[distribution of difficulty (hard $arrow.l.r$ easy)]
]


#slide[
= open problems / saturation

#problem-box[
Testsets are generally too easy.
$arrow.double$ No failure modes $arrow.double$ Can't improve.
]

#let mybox = box.with(fill: COL_GRAY_LIGHT_LIGHT, inset: 10pt, width: 100%)

#v(1fr)
#pause
#mybox[*Search for difficult examples* @xu2026searchinginternetchallengingbenchmarks@proietti-etal-2025-estimating Get a large dataset (e.g. the whole Internet) and take top-1% most difficult examples.\
*Problems*: Not enough difficult examples, "Difficult" examples turn out to be garbage, like _"The chamber chamber chamber chamber was 0123456789"_]
#v(1fr)
#pause
#mybox[*Generating difficult examples* @zouhar-etal-2026-generating@kalikman-etal-2026-augmenting
Synthetically generated difficult examples.\ *Problems*: Mode collapse (repetition, heavy code switching, specific words), unrealistic inputs, like _"will will buffalo buffalo buffalo will"_]

#v(1fr)
#pause
#mybox[
#box(image("img/last_translation_benchmark.svg", height: 3.4em), width: 1fr)
#box(width: 10fr)[
*Last Translation Benchmark*: 
Humans contribute with an input that state-of-the-art modern machine translation models get provably wrong(& be coauthor #h(0.3em)
#underline(offset: 2pt)[#link("https://last-translation-benchmark.vilda.net")[https://last-translation-benchmark.vilda.net]])
]
]
]

#slide[
= thank you!

#let myrect = rect.with(fill: COL_BLUE_LIGHT, inset: 1.2em, radius: 4pt, width: 100%)

#v(1fr)
#grid(
columns: (1fr, 1fr),
gutter: 1em,
myrect(fill: COL_BLUE_LIGHT)[
  #text(size: 1.5em, weight: "bold", fill: COL_BLUE_DARK)[1. define] 
  Protocol and guidelines. Distinguish diagnosis from benchmarking.
],
myrect(fill: COL_GREEN_LIGHT)[
  #text(size: 1.5em, weight: "bold", fill: COL_GREEN_DARK.darken(20%))[2. measure] 
  Experimental design. Annotator reliability. Reproducible setups.
],
myrect(fill: COL_YELLOW_LIGHT)[
  #text(size: 1.5em, weight: "bold", fill: COL_YELLOW_DARK.darken(10%))[3. analyze] 
  Appropriate statistical testing. Cautious data aggregation.
],
myrect(fill: COL_RED_LIGHT)[
  #text(size: 1.5em, weight: "bold", fill: COL_RED_DARK)[4. practice]
  Fair compensation. Privacy preservation. Pre-registration.
]
)

#v(1fr)
]
#slide[
= bibliography
#{
set text(size: 11pt)
bibliography("bibliography.bib", title: [], style: "association-for-computing-machinery")
}

#v(1fr)
== tutorial based on @belz-etal-2024-inlg @zouhar-2026-eth @10.1162xcoli_a_00508 @Schuff_Vanderlyn_Adel_Vu_2023 @balashov_translation_2026-1 \ these materials #link("https://github.com/zouharvi/humeval-tutorial")[github.com/zouharvi/humeval-tutorial]  @zouhar2026humeval 

#v(1em)

#set par(justify: true)

Thank you Koel Dutta Chowdhury, Dominik Macháček, Jakub Macina, Nico Daheim and Patrick Pinzhen Chen for tutorial feedback.

Patrícia Schmidtová was supported by the European Research Council (Grant agreement No. 101039303 NG-NLG) & Charles University Projects GA UK 252986 and SVV 260 698.
]