# Human Evaluation Tutorial

Tutorial materials for the human evaluation tutorial at EAMT 2026 / KONVENS 2026 / MT Marathon 2026.
Look at the [compiled slides](humeval_tutorial_animated.pdf) or the [handout version without animations](humeval_tutorial_handout.pdf).
<!-- TODO: add compiled final version -->

## Our own human evaluation campaign

You can run your own human evaluation campaign with [Pearmut](https://github.com/zouharvi/pearmut).

```bash
cd our_own_humeval
pip install pearmut
```

### Campaign 0 based on template

`tut_0.json` is a starting point. Fill in your own source texts and translations, then run:

```bash
pearmut add tut_0.json
pearmut run
```

Open the dashboard link printed in the terminal to manage the campaign and access annotator URLs.

### Campaign 1 based on custom sliders

`tut_1_sliders.json`: text-based evaluation with two custom sliders (Fluency and Adequacy).

```bash
pearmut add tut_1_sliders.json
pearmut run
```

### Campaign 2 with error spans

`tut_2_spans.json`: annotators highlight error spans in the translation and set severity (minor/major), then rate overall quality.

```bash
pearmut add tut_2_spans.json
pearmut run
```

### Campaign 3 with custom error spans

`tut_2_spans.json`: annotators highlight error spans in the translation and set custom taxonomy

```bash
pearmut add tut_3_custom_spans.json
pearmut run
```

### Campaign 4 with free-form text

`tut_4_freetext.json`: same as Step 2, plus a free-text comment box.

```bash
pearmut add tut_4_freetext.json
pearmut run
```

### Campaign 5 goes multimodal

`tut_5_multimodal.json`: image and audio inputs. Media files are in `assets/` and served based on the configuration in the JSON.

```bash
pearmut add tut_5_multimodal.json
pearmut run
```

### Campaign 6 scales up

Three configs with the same 4 items, showing different distribution strategies:

- **6a: one annotator gets everything** (`tut_6a_one_annotator.json`): task-based with 1 user.
- **6b: items split across annotators** (`tut_6b_four_annotators.json`): task-based with 4 users, each gets 1 item.
- **6c: automatic distribution** (`tut_6c_single_stream.json`): single-stream with 4 users and `docs_per_user: 2`. Items are drawn randomly from a shared pool: each item is annotated once, then skipped for everyone else.

```bash
pearmut add tut_6a_one_annotator.json
pearmut add tut_6b_four_annotators.json
pearmut add tut_6c_single_stream.json
pearmut run
```

### Notes

- Run all `pearmut` commands from `our_own_humeval/` folder
- To overwrite a campaign after changes: `pearmut add tut_X.json -o`
- To reset all data: `pearmut purge`


## Compiling Slides Locally

Slides are written in Typst and can be compiled locally:
```bash
cd slides
# TODO: add slides
# note: requires "IBM Plex" font installed locally
typst compile main_slides.typ
```

## Misc.

If you find this tutorial useful or want to cite it, please use:
```bibtex
@misc{zouhar2026humeval,
  author = {Zouhar, Vilém and Züfle, Maike and Schmidtová, Patrícia},
  title = {Human Evaluation of Multilingual Tasks},
  year = {2026},
  url = {https://github.com/zouharvi/humeval-tutorial},
  note = {Tutorial at EAMT 2026, KONVENS 2026, and MT Marathon 2026}
}
```