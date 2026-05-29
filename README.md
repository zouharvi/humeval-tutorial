# Human Evaluation Tutorial

Tutorial materials for running your own human evaluation campaign with [Pearmut](https://github.com/zouharvi/pearmut).

## Our own human evaluation campaign

```bash
cd our_own_humeval
pip install pearmut
```

### Step 0: Your own campaign (template)

`tut_0.json` is a starting point. Fill in your own source texts and translations, then run:

```bash
pearmut add tut_0.json
pearmut run
```

Open the dashboard link printed in the terminal to manage the campaign and access annotator URLs.

### Step 1: Sliders

`tut_1_sliders.json`: text-based evaluation with two custom sliders (Fluency and Adequacy).

```bash
pearmut add tut_1_sliders.json
pearmut run
```

### Step 2: Error spans

`tut_2_spans.json`: annotators highlight error spans in the translation and set severity (minor/major), then rate overall quality.

```bash
pearmut add tut_2_spans.json
pearmut run
```

### Step 3: Free text

`tut_3_freetext.json`: same as Step 2, plus a free-text comment box.

```bash
pearmut add tut_3_freetext.json
pearmut run
```

### Step 4: Multimodal

`tut_4_multimodal.json`: image and audio inputs. Media files are in `assets/` and served based on the configuration in the JSON.

```bash
pearmut add tut_4_multimodal.json
pearmut run
```

### Step 5: Scaling up

Three configs with the same 4 items, showing different distribution strategies:

**5a: one annotator gets everything** (`tut_5a_one_annotator.json`): task-based with 1 user.

**5b: items split across annotators** (`tut_5b_four_annotators.json`): task-based with 4 users, each gets 1 item.

**5c: automatic distribution** (`tut_5c_single_stream.json`): single-stream with 4 users and `docs_per_user: 2`. Items are drawn randomly from a shared pool: each item is annotated once, then skipped for everyone else.

```bash
pearmut add tut_5a_one_annotator.json
pearmut add tut_5b_four_annotators.json
pearmut add tut_5c_single_stream.json
pearmut run
```

### Notes

- Run all `pearmut` commands from `our_own_humeval/` folder
- To reload a campaign after changes: `pearmut add tut_X.json -o`
- To reset all data: `pearmut purge`

