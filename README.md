# Human Evaluation Tutorial

<!-- at EAMT 2026 / KONVENS 2026 / MT Marathon 2026 -->
Tutorial materials for the human evaluation tutorial by Vilém Zouhar, Maike Züfle, Patrícia Schmidtová.
Look at the [slides](humeval_tutorial_animated.pdf) or the [slides without animations](humeval_tutorial_handout.pdf).

## Our own human evaluation campaign

You can run your own human evaluation campaign with [Pearmut](https://github.com/zouharvi/pearmut).

```bash
cd our_own_humeval
pip install pearmut
```

### Campaign 0 based on template

`0a_da.json` is a starting point with simple direct assessment campaign.
Fill in your own source texts and translations, then run:

```bash
pearmut add campaigns/0a_da.json
pearmut run
```
Open the dashboard link printed in the terminal to manage the campaign and access annotator URLs.

The `0b_esa.json`, `0c_cesa.json`, and `0d_mqm.json` contain ESA, cESA, and MQM annotation protocol defaults.

### Campaign 1 based on custom sliders

`1_sliders.json`: text-based evaluation with two custom sliders (Fluency and Adequacy).

```bash
pearmut add campaigns/1_sliders.json
pearmut run
```

### Campaign 2 with error spans

`2_spans.json`: annotators highlight error spans in the translation and set severity (minor/major), then rate overall quality.

```bash
pearmut add campaigns/2_spans.json
pearmut run
```

### Campaign 3 with custom error spans

`2_spans.json`: annotators highlight error spans in the translation and set custom taxonomy

```bash
pearmut add campaigns/3_custom_spans.json
pearmut run
```

### Campaign 4 with free-form text

`4_freetext.json`: same as Step 2, plus a free-text comment box.

```bash
pearmut add campaigns/4_freetext.json
pearmut run
```

### Campaign 5 goes multimodal

`5_multimodal.json`: image and audio inputs. Media files are in `assets/` and served based on the configuration in the JSON.

```bash
pearmut add campaigns/5_multimodal.json
pearmut run
```

### Campaign 6 scales up

Three configs with the same 4 items, showing different distribution strategies:

- **6a: one annotator gets everything** (`6a_one_annotator.json`): task-based with 1 user.
- **6b: items split across annotators** (`6b_four_annotators.json`): task-based with 4 users, each gets 1 item.
- **6c: automatic distribution** (`6c_single_stream.json`): single-stream with 4 users and `docs_per_user: 2`. Items are drawn randomly from a shared pool: each item is annotated once, then skipped for everyone else.

```bash
pearmut add campaigns/6a_one_annotator.json
pearmut add campaigns/6b_four_annotators.json
pearmut add campaigns/6c_single_stream.json
pearmut run
```

### Notes

- Run all `pearmut` commands from `our_own_humeval/` folder
- To overwrite a campaign after changes: `pearmut add campaigns/X.json -o`
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

If you find this tutorial (MIT license) useful or want to cite it, please use:

```bibtex
@misc{zouhar2026humeval,
  author = {Zouhar, Vilém and Züfle, Maike and Schmidtová, Patrícia},
  title = {Human Evaluation of Multilingual Tasks},
  year = {2026},
  url = {https://github.com/zouharvi/humeval-tutorial},
  note = {Tutorial at EAMT 2026, KONVENS 2026, and MT Marathon 2026}
}
```