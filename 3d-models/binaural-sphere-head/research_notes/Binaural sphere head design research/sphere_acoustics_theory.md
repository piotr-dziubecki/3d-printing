# Rigid-sphere head model: what it implies for sphere size and ear placement

Researched 2026-11-23 (machine clock). Fixture under study: 175 mm PLA sphere (a = 87.5 mm), flush MEMS mics at ±90° on the horizontal great circle, loudspeakers at ±30°, 2–4 m, 20 Hz–20 kHz.

Notes on method and evidence quality:
- Primary text actually read in full: Duda & Martens' 1997 IEEE WASPAA conference version of the range-dependence work (scanned PDF, OCR'd), and the CIPIC database paper (Algazi, Duda, Thompson, Avendano 2001, WASPAA) for its anthropometry table. The 1998 JASA journal paper, Aaronson & Hartmann 2014 (PMC), Algazi et al. 2001 JAES and the 2002 snowman paper could not be fetched (bot checks / paywall / HTML stubs). Their claims below come from abstracts or search-result excerpts and are marked as such.
- All "Computed" numbers come from my own implementation of the exact Rayleigh plane-wave series for a rigid sphere (script: `scratchpad/calc/sphere.py`, `itd.py`; numpy/scipy; c = 343 m/s, a = 87.5 mm unless stated). The script reproduces two published anchors: ka = 1 at 624 Hz for a = 8.75 cm (Duda & Martens give 624 Hz), and a low-frequency ITD equal to 3a/c·sinθ (computed 385.6 µs at 100 Hz vs 382.7 µs formula). Computed values are inferences from theory, not measurements.
- Plane-wave modelling is justified at 2–4 m: normalized range ρ = r/a = 22.9 (2 m) to 45.7 (4 m), well above the ρ < 5 threshold where Duda & Martens find range effects start (see Q1).

Formulas used throughout:
- Rayleigh series, plane wave on a rigid sphere (pressure at the surface / free-field pressure at the centre), incidence angle θ between source direction and the observation point:
  H(ka, θ) = (1/(ka)²) Σₙ iⁿ⁺¹ (2n+1) Pₙ(cos θ) / h′ₙ(ka), with h′ₙ the derivative of the spherical Hankel function of the first kind (e^{−iωt} convention). Duda & Martens use the point-source generalisation from Rabinowitz et al., normalized by ρ = r/a and μ = ωa/c.
- Woodworth–Schlosberg delay relative to the centre, for an ear at incidence angle θ: Δt = −(a/c)cos θ for θ ≤ 90°; Δt = (a/c)(θ − π/2) for θ > 90°. For antipodal ears (±90°) and source azimuth φ: ITD = (a/c)(φ + sin φ).
- Kuhn low-frequency limit: ITD_LF = (3a/c) sin φ; high-frequency limit ≈ (2a/c) sin φ (Woodworth is the exact HF ray solution).
- For ears at ±e (not 90°), low-frequency limit (inference from the dipole term of the series): ITD_LF = (3a/c)·sin e·sin φ.

## 1. Rayleigh rigid-sphere scattering and Duda & Martens (range dependence, bright spot, validity)

### Takeaway
For a source at 2–4 m the sphere behaves as in the plane-wave case: ipsilateral pressure rises ~6 dB at high frequency, the response is roughly flat at 100° incidence, and a "bright spot" appears only at the contralateral pole (incidence 150–180°). With sources at ±30° and ears at ±90°, the contralateral ear sits at 120° incidence, outside the bright-spot zone, so the bright spot does not affect the main measurement; it matters for lateral and rear reflections.

### Cited Findings
- The 1998 JASA paper: Duda & Martens, "Range dependence of the response of a spherical head model," JASA 104(5):3048–3058, Nov 1998, DOI 10.1121/1.423886. Its abstract reports close agreement between experiment and theory, and that the time delay is well approximated by the Woodworth–Schlosberg ray formula. — [Scilit record](https://scilit.com/publications/b09f1327d78ec097d7f59a0495472dc8)
- The HRTF is defined as the ratio of the phasor pressure on the sphere surface to the free-field pressure at the sphere centre; ρ = r/a, μ = ωa/c, θ = angle of incidence. — [Duda & Martens 1997, WASPAA (eScholarship)](https://escholarship.org/uc/item/48m5k072)
- At low frequency the pressure on the sphere equals the free-field pressure. At normal incidence (θ = 0°) the pressure rises with frequency, about 6 dB at high frequencies. μ = 1 corresponds to 624 Hz for the "traditional average head radius" of 8.75 cm. The magnitude response is roughly flat at θ = 100° and falls in a complicated way for larger θ. Near the back of the sphere the response has large ripples and rises to a "bright spot" at the contralateral point. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- In the time domain the bright spot is the meeting point of two creeping waves running around either side. Incidence angles between about 150° and 170° show two distinct pulses, which explains strong frequency-domain ripples there. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- Range dependence: the low-frequency ILD stays below 3 dB at ρ = 100 (for μ < 1) and changes significantly only when ρ < 5. The low-frequency ILD can exceed 10 dB at ρ = 2 and 20 dB at ρ = 1.25. Theory and experiment agree that the HRTF starts depending on range at ρ < 5. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- The sphere HRTF appears to be minimum-phase (numerical evidence, no proof), so apart from a pure delay the HRIR can be rebuilt from the magnitude response. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- Experimental check: an ER-7C probe mic in a hole drilled in a 10.9 cm radius, 3.6 kg bowling ball (μ = 1 at 500 Hz), on a 1.3 cm diameter vertical rod, 1 m above the anechoic-chamber floor, measured at ρ = 1.25–20. Results were "remarkably similar" to theory. Significant discrepancies appeared only at ρ < 2, where the loudspeaker stopped acting as a point source. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- Bringing the source closer increases the ITD by at most 25.7% (0.0908 normalized units, 146 µs for an 8.75 cm radius), for ears at ±100°. ITD is therefore not a strong range cue. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- The Woodworth–Schlosberg generalisation matched 15%-rise-time arrival times within 2.4%. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)

### Inferences
- ρ = 22.9–45.7 at 2–4 m, so the fixture is in the far-field regime and range has no practical effect on its ITD/ILD. Range effects return only for near-field objects (e.g. the operator's body, a laptop at under 0.44 m, which is ρ < 5).
- Incidence angles for a source at 30°: ears at ±90° see 60° (ipsilateral) and 120° (contralateral); ears at ±100° see 70° and 130°. Both stay below the 150–180° bright-spot/ripple zone, so the direct-sound response at each mic is smooth. Side-wall reflections arriving from about ±90° put the far mic at 180°, on the bright spot. The contralateral mic will then show strong comb-like ripples above about 1 kHz. Those are real sphere physics, not a fixture defect, and a human head has a weaker, smeared version (see Q3 gaps).
- The Duda & Martens bowling-ball rig (sphere on a 1.3 cm rod) is the closest published precedent for a sphere on a thin support. It matched theory well, which suggests a thin tripod stem does not spoil the sphere response.

### Gaps
- Could not open the 1998 JASA full text. The figures above come from the 1997 conference version by the same authors, which covers the same theory and an earlier version of the experiment.
- No published validity upper frequency for a "sphere as human head" was found. Above roughly 3–4 kHz the pinna dominates the human HRTF (see Q5), so the sphere stays physically exact but stops being a faithful human proxy there.

## 2. Woodworth ITD and Kuhn's frequency dependence; values for a = 87.5 mm

### Takeaway
For a = 87.5 mm and a source at 30°, the exact sphere gives an ITD of about 386 µs below 300 Hz (3a/c·sin φ) and about 267 µs above 3 kHz (≈ Woodworth 261 µs). The transition runs from about 500 Hz to 1.5 kHz, around ka = 1 at 624 Hz. The maximum ITD at 90° is 656 µs (Woodworth, HF) or 765 µs (LF limit).

### Cited Findings
- The phase delay of the sphere is frequency-dependent and is 50% greater at low frequencies than at high frequencies (citing Kuhn 1977, JASA 62:157). — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- Aaronson & Hartmann, "Testing, correcting, and extending the Woodworth model for interaural time difference," JASA 135(2):817–823, 2014, DOI 10.1121/1.4861243. They compare the Woodworth predictions for antipodal ears and plane waves with the exact model as a function of frequency. They extend Woodworth to arbitrary ear angles and finite distances, which gives different formulas in six regions of ear angle and source distance. The 90°-ear form is front-back symmetric and has a cone of confusion. — [search excerpts of the paper; full text at PMC3985894, not fetched](https://pmc.ncbi.nlm.nih.gov/articles/PMC3985894/)
- The high-frequency limit of the spherical head model is the creeping-wave solution known as the Woodworth model. — [same search excerpt, Aaronson & Hartmann 2014](https://ouci.dntb.gov.ua/works/4NZzzoe4)

### Computed (exact Rayleigh series, plane wave, a = 87.5 mm, c = 343 m/s, source at 30°, ears at ±90°)

| f (Hz) | ILD (dB) | Interaural phase delay (µs) |
|---|---|---|
| 100 | 0.0 | 386 |
| 300 | 0.3 | 401 |
| 500 | 1.5 | 399 |
| 700 | 3.3 | 371 |
| 1000 | 4.9 | 320 |
| 1500 | 4.6 | 290 |
| 2000 | 4.4 | 289 |
| 3000 | 6.1 | 280 |
| 4000 | 5.9 | 279 |
| 6000 | 7.1 | 274 |
| 8000 | 7.9 | 272 |
| 12000 | 9.0 | 269 |
| 16000 | 9.8 | 267 |
| 20000 | 10.5 | 267 |

Closed-form references (computed):
- 3a/c·sin 30° = 382.7 µs; 2a/c·sin 30° = 255.1 µs; Woodworth (a/c)(φ + sin φ) at 30° = 261.1 µs.
- At 90°: Woodworth 655.8 µs, LF limit 3a/c = 765.3 µs.
- Radius sensitivity of Woodworth ITD at 30° (ears ±90°): a = 80.0 mm → 238.7 µs; 83.5 → 249.2; 85.0 → 253.7; 87.5 → 261.1; 90.0 → 268.6 µs. ITD scales linearly with a: 1 mm of radius ≈ 3.0 µs at 30° and 7.5 µs at 90°.

### Inferences
- A single "ITD" number from the fixture depends on the estimator. Broadband cross-correlation is dominated by wherever the signal energy is. Low-passed (< 1 kHz) correlation reports ~380–400 µs. Onset or high-passed group delay reports ~260–270 µs. The analysis pipeline should report ITD per band, or state which band it uses, before comparing with human ITD data.
- Group delay is irregular between 500 Hz and 1.5 kHz (computed 180–420 µs), so avoid quoting ITD from that band.

### Gaps
- Aaronson & Hartmann's own error figures for the Woodworth model (by frequency and ear angle) could not be read. Kuhn 1977's original measured transition frequencies were also not read; the "50% greater" ratio comes via Duda & Martens.

## 3. Optimal sphere radius vs human heads: is 175 mm right?

### Takeaway
175 mm (a = 87.5 mm) is the "traditional average head radius" and sits within about 2 mm of the anthropometric optimum. Plugging CIPIC mean head dimensions into the Algazi et al. 2001 regression gives a ≈ 89 mm (178 mm diameter). One KEMAR fit gives a ≈ 83.5 mm. Changing the diameter by a few mm changes ITD by ~1–2%, which is smaller than the spread between people (CIPIC head width varies ±6.6% at 1 SD). No case was found for changing the diameter.

### Cited Findings
- 8.75 cm is the "traditional average head radius." — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- Algazi, Avendano & Duda, "Estimation of a Spherical-Head Model from Anthropometry," JAES 49(6):472–479, June 2001. They derive an optimal spherical-head model from the high-frequency ITD of 25 subjects, then fit it to individuals with simple empirical predictive equations. — [AES e-Library abstract](https://www.aes.org/e-lib/browse.cfm?elib=10188)
- The regression is r_opt = 0.51·w½ + 0.019·h½ + 0.18·d½ + 32 mm, where w½, h½ and d½ are half head width, half height and half depth. Head width dominates and height matters least. Bomhardt & Fels later found depth to be the least important. — [Gamper et al., Microsoft Research (secondary report of Algazi 2001)](https://microsoft.com/en-us/research/wp-content/uploads/2016/02/Anthropometric-parameterisation-Gamper.pdf)
- CIPIC anthropometry (mean ± SD, cm, 40+ subjects): head width 14.49 ± 0.95, head height 21.46 ± 1.24, head depth 19.96 ± 1.29, pinna offset down 3.03 ± 0.66, pinna offset back 0.46 ± 0.59, neck height 6.26 ± 1.69, torso top width 31.50 ± 3.19, shoulder width 45.90 ± 3.78, head circumference 57.33 ± 2.47. The authors say these broadly agree with published adult values. — [Algazi, Duda, Thompson, Avendano, "The CIPIC HRTF Database," WASPAA 2001](https://www.ece.ucdavis.edu/cipic/wp-content/uploads/sites/12/2015/04/cipic_WASSAP_2001_143.pdf)
- In CIPIC, the maximum ITD is roughly normally distributed and strongly correlated with head size. Head width is the best single predictor; head width plus head depth is the best pair. — [CIPIC database paper](https://www.ece.ucdavis.edu/cipic/wp-content/uploads/sites/12/2015/04/cipic_WASSAP_2001_143.pdf) (the mean/SD values for ITD_max are in a font that did not extract)
- A spherical-head fit to KEMAR with offset ears gave radius 8.35 cm and ears at 89.62° azimuth, −4.87° elevation. — [search-result summary of a study using the Ziegelwanger–Majdak TOA model; underlying paper not identified or read](https://phaidra.kug.ac.at/open/o:34867)

### Computed / Inferences
- Algazi formula with CIPIC means (w½ = 72.45, h½ = 107.3, d½ = 99.8 mm): 0.51·72.45 + 0.019·107.3 + 0.18·99.8 + 32 = 36.9 + 2.0 + 18.0 + 32 = 88.9 mm, i.e. 178 mm diameter. This applies the formula to population means, so it is an inference, not a value the paper reports.
- Moving from 175 mm to 178 mm raises ITD by 1.6% (≈ 4 µs at 30°). Moving to a KEMAR-like 167 mm lowers it by 4.6% (≈ 12 µs at 30°). Both are smaller than the inter-subject spread: a ±1 SD head width (±6.6%) corresponds to roughly ±4–5% in the dominant term. For a diagnostic of left/right symmetry and image shifts, what matters is ITD differences between left and right speakers, which are independent of radius to first order. Keep 175 mm.
- The physical sphere on a printer is easier to make accurately than this level of anthropometric precision requires.

### Gaps
- The Algazi 2001 mean optimal radius across the 25 subjects, and its comparison with 8.75 cm, could not be read directly. I believe the paper reports an optimum close to 8.7 cm, but this is unverified.
- ANSUR head-breadth statistics were not retrieved; CIPIC is the only anthropometric source used here.

## 4. Ear placement: ±90° vs ±100° and lowered ears

### Takeaway
Moving the mics from ±90° to ±100° (Blauert's/Duda's "ears 10° back") changes the computed ITD at a 30° source by under 5% (LF −1.5%, HF −4%). It lowers the HF ILD by 1–2.6 dB, because the ipsilateral mic loses part of its 6 dB pressure gain. Human ears are mainly lower than the centre (CIPIC: 30 mm down, only 5 mm back), not far behind it. Neither offset is needed for a fixture whose job is left/right comparison. If anything is changed, a −10° to −20° elevation offset is closer to the anthropometry than a +10° azimuth offset.

### Cited Findings
- Following Blauert, Duda & Martens placed the ears "back an additional 10°", i.e. at ±100°, for their ILD/ITD computations. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- CIPIC mean pinna offset: 3.03 cm down and 0.46 cm back (SD 0.59 cm, so the back offset is not significantly different from zero across subjects). — [CIPIC database paper](https://www.ece.ucdavis.edu/cipic/wp-content/uploads/sites/12/2015/04/cipic_WASSAP_2001_143.pdf). The reference point for these offsets is defined in the paper's figure, which did not extract; treat "relative to the head centre" as my interpretation.
- In the Ziegelwanger–Majdak geometric TOA model, the head radius, ear positions on the sphere and the position of the head in the measurement setup are free parameters fitted to HRTF data. — [DAGA 2012 abstract and diploma-thesis description via search results](https://pub.dega-akustik.de/DAGA_2012/data/articles/000237.pdf)
- A KEMAR fit with that model put the ears at 89.62° azimuth and −4.87° elevation (r = 8.35 cm). — [secondary search summary, paper not read](https://phaidra.kug.ac.at/open/o:34867)
- With 90° ears the Woodworth model is front-back symmetric (cone of confusion). Aaronson & Hartmann extended it to arbitrary ear angles. — [Aaronson & Hartmann 2014, excerpt](https://ouci.dntb.gov.ua/works/4NZzzoe4)

### Computed (exact series, a = 87.5 mm, source at 30°)

| Quantity | Ears ±90° | Ears ±100° |
|---|---|---|
| ITD, 100 Hz (phase) | 386 µs | 380 µs |
| ITD, 20 kHz (phase) | 267 µs | 256 µs |
| Woodworth ITD | 261.1 µs | 265.3 µs |
| Mean ILD 1–2 kHz | 4.6 dB | 3.9 dB |
| Mean ILD 2–4 kHz | 5.6 dB | 4.9 dB |
| Mean ILD 4–8 kHz | 7.1 dB | 5.8 dB |
| Mean ILD 8–16 kHz | 8.9 dB | 6.9 dB |
| ILD at 20 kHz | 10.5 dB | 7.8 dB |
| Woodworth ITD at 90° source | 655.8 µs | 696.5 µs |

- LF check: (3a/c)·sin 100°·sin 30° = 376.9 µs, consistent with 380 µs computed.
- The Woodworth ray formula and the exact series disagree in direction for ±100° at a 30° source (Woodworth +4 µs, exact HF −11 µs). Woodworth's θ > 90° branch overestimates the path when the far ear is near 130°. Treat the ±100° Woodworth number as unreliable at the 10 µs level. Inference.
- Lowered ears (my geometry, Woodworth): an ear at 90° azimuth and −20° elevation (≈ 30 mm below the equator on a 87.5 mm sphere) sees a horizontal 30° source at 62.0° / 118.0° incidence. That gives Woodworth ITD 244.7 µs (−6.3% vs 261.1) and LF ITD 359.6 µs (−6%). Lowering the ears acts like shrinking the radius by ~6% for horizontal sources.

### Inferences
- For a fixture whose output is compared to human perception: published ITD/ILD thresholds were not retrieved, so it is uncertain whether a ~10 µs ITD shift or a 1–2 dB HF ILD shift is perceptible. Both offsets are smaller than inter-subject variation in head size. They also cancel in the left/right difference measures that diagnose imaging (speaker asymmetry, phantom-centre shift).
- ±100° has one functional benefit: it breaks front/back symmetry, so the fixture can tell a front reflection from a rear one by ILD. A loudspeaker-imaging diagnostic at a fixed seat facing the speakers rarely needs that.
- If the design must match "a human" more closely, the most defensible single change is a down offset (about −10° to −20° elevation, from CIPIC's 30 mm). Note that this reduces ITD for horizontal sources, which partly offsets moving to a larger 178 mm sphere. Both changes together leave ITD roughly where 175 mm with 90° ears already is. Inference from the computations above.

### Gaps
- Algazi et al.'s own offset-ear sphere parameters (often quoted as ~±100° azimuth and a few degrees down) could not be verified from a primary text.
- Ziegelwanger & Majdak 2014 JASA ("Modeling the direction-continuous time-of-arrival in head-related transfer functions") was not read. Its fitted human ear-offset statistics are therefore missing.

## 5. Torso and shoulders (snowman model): would a sphere on a thin tripod miss important cues?

### Takeaway
Torso effects lie mainly between ~0.7 and 3.5 kHz and act as weak elevation cues (shoulder bounce) for sources above ear level. For loudspeakers near ear height at ±30° they add a small, mostly symmetric left/right colouration and little ITD or ILD change. A torso proxy is not needed for an imaging diagnostic, but its absence should be stated as a limit. No magnitude or delay numbers for the snowman torso effect could be verified.

### Cited Findings
- The snowman model is a spherical head above a spherical (or ellipsoidal) torso. It has no closed form; the HRTF was computed by multipole re-expansion and BEM. It approximates the HRTF of a pinna-less KEMAR well. — [Algazi, Duda et al., "Approximating the head-related transfer function using simple geometric models of the head and torso," JASA 112, 2002 (abstract via eScholarship/search)](https://escholarship.org/uc/item/979578gv)
- An efficient approximation replaces the exact snowman HRTF with two time delays and two first-order IIR filters (Duda, Algazi & Thompson, AES 2002 convention). — [AES e-Library 11294](https://aes2.org/publications/elibrary-page/?id=11294)
- Early KEMAR work found that the pinna had no influence below 3.5 kHz, while the torso introduced "clues of a secondary nature" between 0.7 and 3.5 kHz. — [UC Davis IDAV / Algazi et al., eScholarship](https://escholarship.org/uc/item/7rf421w9)
- The "shoulder bounce" (specular reflection from the upper torso when the source is above) is a weak but significant elevation cue for sources away from the median plane. The delay is longest for overhead sources and drops to zero at the torso-shadow cone, inside which the torso shadows instead of reflecting. With sources low-passed to 3 kHz, localization with a spherical head plus an ellipsoidal torso matched localization with measured HRTFs. — [Algazi et al., eScholarship](https://escholarship.org/uc/item/7rf421w9)
- Semi-ellipsoidal or truncated-KEMAR torsos give better low-frequency lateral elevation localization than a spherical torso. — [Forum Acusticum 2023 paper](https://dael.euracoustics.org/confs/fa2023/data/articles/000226.pdf)

### Inferences
- Geometry estimate (not from a source): with CIPIC neck height 62.6 mm and a 87.5 mm head radius, shoulders lie about 150–200 mm below the ears. For a source at ear height the specular shoulder path adds roughly 2·h·sin(elevation) ≈ 0 ms, and the source is near the torso-shadow boundary. So for ear-height speakers the shoulder reflection gives only a weak, low-frequency colouration, not a separable echo. For tweeters above ear height, or a standing operator, it becomes a 0.3–0.6 ms comb-filter echo in the 1–3 kHz region. That last figure is my geometric estimate and is unverified.
- The tripod must stay thin and acoustically small. The Duda & Martens 1.3 cm rod precedent (Q1) shows a thin support leaves the sphere response near theory. A broad tripod head or a table directly under the sphere would create a reflection the human listener does not have.
- Torso effects at ±30° are nearly mirror-symmetric left/right, so they mostly cancel in ITD/ILD difference measures. They would matter for absolute comparison against a HATS.

### Gaps
- Snowman torso effect magnitudes (dB), shoulder-reflection delays (ms) and torso/head radii from Algazi et al. 2002 were not obtained; the full text was not accessible. Brown & Duda 1998 (IEEE TSAP structural model) was not read.

## 6. ILD magnitude vs frequency for a sphere with a source at ±30°

### Takeaway
Computed for a = 87.5 mm and ears at ±90°: ILD is < 0.3 dB below 300 Hz, 1.5 dB at 500 Hz, ~4.5–5 dB from 1 to 2 kHz, 6 dB at 3–4 kHz, 8 dB at 8 kHz and 10.5 dB at 20 kHz. That is monotonic apart from a small dip near 1.5–2 kHz. Real heads have larger, more irregular HF ILDs because of the pinna, and published comparisons say sphere ILDs are underestimated.

### Cited Findings
- The ipsilateral HF pressure gain is ~+6 dB at normal incidence; the response is roughly flat near 100° incidence. — [Duda & Martens 1997](https://escholarship.org/uc/item/48m5k072)
- ILDs from a spherical head were typically underestimated compared with head measurement systems in earlier studies. A stereo microphone pair gave higher ITDs than human listeners and very small ILDs with no frequency dependence. — [Acta Acustica 2026, aacus250090 (search excerpt; full text returned 403)](https://acta-acustica.edpsciences.org/articles/aacus/pdf/2026/01/aacus250090.pdf)
- Spagnol & Avanzini fitted a sphere radius to ILD data by multiple regression, and it gave lower ILD spectral distortion for lateral sources than other radius estimators. — [Spagnol & Avanzini, ICAD 2015](https://avanzini.di.unimi.it/downloads/publications/spagnol_icad15.pdf) (from search summary)

### Computed
- Full table in Q2 (ears ±90°) and band means in Q4 (ears ±90° vs ±100°).
- Per-ear levels at 20 kHz, source at 30°: ipsilateral +5.6 dB, contralateral −4.9 dB re free field (ears ±90°).

### Inferences
- The sphere's ILD is a smooth, well-defined function, which makes it a better diagnostic baseline than a HATS: deviations measured in a room are then due to the room/speakers, not pinna notches. It is not a quantitative stand-in for human ILD above ~4 kHz.
- For phantom-centre diagnostics, the useful quantities are the L/R ILD and ITD differences, in which the sphere's absolute calibration cancels.

### Gaps
- No published side-by-side ILD table (sphere vs KEMAR vs humans at 30°) was obtained.

## 7. IACC: sphere vs real head/KEMAR, diffuse field and rooms

### Takeaway
In an ideal diffuse field, the computed coherence between antipodal points on an 87.5 mm rigid sphere drops faster with frequency than for two free-field mics 175 mm apart (zero crossing ~600 Hz vs ~980 Hz). The sphere therefore yields lower low-frequency IACC than a spaced pair, in the same direction as a real head. No paper comparing sphere-mic IACC with dummy-head IACC was found.

### Formula
Diffuse-field coherence between two surface points separated by angle ψ on a rigid sphere (isotropic field; inference from the modal series above):
γ(ka, ψ) = Σₙ (2n+1)·|h′ₙ(ka)|⁻²·Pₙ(cos ψ) / Σₙ (2n+1)·|h′ₙ(ka)|⁻². Free-field pair: γ = sin(kd)/(kd).

### Computed (a = 87.5 mm)

| f (Hz) | Sphere, ψ = 180° (ears ±90°) | Sphere, ψ = 160° (ears ±100°) | Free pair, d = 175 mm |
|---|---|---|---|
| 100 | 0.961 | 0.962 | 0.983 |
| 200 | 0.844 | 0.848 | 0.933 |
| 300 | 0.653 | 0.663 | 0.853 |
| 400 | 0.417 | 0.433 | 0.748 |
| 500 | 0.183 | 0.204 | 0.624 |
| 600 | −0.004 | 0.019 | 0.488 |
| 800 | −0.176 | −0.159 | 0.213 |
| 1000 | −0.124 | −0.125 | −0.020 |
| 1500 | 0.086 | 0.071 | −0.207 |
| 2000+ | ≈ 0 | ≈ 0 | ≈ 0 |

### Cited Findings
- Binaural coherence in rooms is measured with the normalized interaural cross-correlation function. An envelope/waveform coherence relation γE = π/4 + (1 − π/4)·γW² held both in simulation and in KEMAR measurements in two rooms. — [Hartmann et al., PMC2906201](https://pmc.ncbi.nlm.nih.gov/articles/PMC2906201) (from search summary)
- The frequency dependence of the ITD alone produces binaural incoherence (an interaural cross-correlation peak below 1). — [search excerpt, PMC4575315](https://pmc.ncbi.nlm.nih.gov/articles/PMC4575315)
- The spherical head model "has serious deficiencies" that show up in detailed comparison with measured interaural differences, while its low- and high-frequency ITD limits roughly agree with KEMAR. — [search excerpt, PMC4575315](https://pmc.ncbi.nlm.nih.gov/articles/PMC4575315)

### Inferences
- Moving the mics to ±100° changes diffuse coherence by ≤ 0.02, which is negligible for IACC.
- In a real room, broadband IACC (ISO 3382-style, max of the normalized cross-correlation within ±1 ms) is dominated by the band below ~600 Hz, where the sphere is a good acoustic analogue of a head (no pinna effects there). Sphere IACC should therefore track dummy-head IACC more closely than a spaced pair does. This is unverified by any found comparison.

### Gaps
- No study comparing IACC measured with a sphere against KEMAR/HATS or human-ear recordings was found. Lindevald & Benade (JASA 1986, "Two-ear correlation in the statistical sound fields of rooms") is the likely primary reference on human two-ear correlation in rooms vs sphere theory. It was not read, and I cannot confirm what it reports.

## 8. Prior work on sphere-based ITD/ILD measurement of stereo phantom images

### Takeaway
No published work was found that uses a rigid-sphere microphone specifically to diagnose loudspeaker stereo imaging via ITD/ILD/IACC. A 2026 Acta Acustica paper compares measurement systems (including spherical-head and stereo-mic setups) against human listeners for interaural cues, which is the closest match found.

### Cited Findings
- That 2026 Acta Acustica paper reports that spherical-head ILDs were underestimated vs head measurement systems in earlier studies, and a stereo microphone gave higher ITDs than humans and frequency-independent, very small ILDs. — [Acta Acustica 2026, aacus250090 (search excerpt only)](https://acta-acustica.edpsciences.org/articles/aacus/pdf/2026/01/aacus250090.pdf)
- A 3D-printed dummy head matched KEMAR's ITD within 62.5 µs at 90°. — [arXiv 2505.04548, "Accelerating Audio Research with Robotic Dummy Heads" (search excerpt)](https://arxiv.org/pdf/2505.04548)

### Inferences
- The sphere-fixture method is novel enough that the fixture's own validation (anechoic or near-field speaker sweep at known angles vs the Rayleigh series) is the main way to establish its accuracy. The Duda & Martens bowling-ball experiment is a direct template.

### Gaps
- The 2026 Acta Acustica paper's full text (403) and its quantitative tables were not read. The literature on binaural models of stereophonic phantom sources (e.g. summing-localization ITD analyses) was not searched within this scope.

## Summary of design implications (all inferences from the findings above)

1. Diameter: keep 175 mm. The anthropometric optimum from Algazi's regression with CIPIC means is ~178 mm (+1.6% ITD); KEMAR fits ~167 mm (−4.6%). Both are within inter-subject spread, and L/R difference measures do not depend on radius.
2. Ear azimuth: ±90° vs ±100° changes ITD at 30° by < 5% and HF ILD by 1–2.6 dB, and changes diffuse coherence by ≤ 0.02. Not worth the asymmetry in printing and analysis unless front/back discrimination of reflections is wanted.
3. Ear elevation: human ears are ~30 mm below the centre (CIPIC), not behind it. If any offset is adopted, a downward one is better supported; it reduces horizontal-source ITD by ~6%.
4. Support: use a thin stem (precedent: a 1.3 cm rod gave measurements matching theory); keep tripod hardware and tables away from the sphere's underside.
5. Analysis: report ITD per band (LF ≈ 3a/c·sin φ ≈ 383 µs vs HF ≈ 261–267 µs at 30°) and avoid the 0.5–1.5 kHz transition band for single-number ITD.
