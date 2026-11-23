# Binaural measurement practice and standards (ITD / ILD / IACC) and what they require of the sphere-head fixture

Research date: 2026-11-23 (clock read on the machine). Fixture assumed: 175 mm PLA sphere (a = 87.5 mm), two flush Infineon IM73D122 PDM MEMS mics at ±90°, stereo PDM on one ESP32-S3 clock, 1/4"-20 tripod, living-room listening seat, purpose: diagnosing stereo imaging.

Reading status of sources: documents marked **[read]** were opened and their text read in full or in the relevant section (PDFs were extracted locally with pdftotext/tesseract). Sources marked **[search excerpt only]** were seen only as search-result summaries; their full text was not read (paywalled or blocked), so treat those claims as pointers, not verified content.

---

## 1. ISO 3382-1 and IACC: dummy head, ear height, orientation, windows, bands, accuracy, head-to-head differences

### Takeaway
ISO 3382 defines IACC as the maximum of the normalised interaural cross-correlation over a ±1 ms lag, with early (0–80 ms) and late (80 ms to ~1 s) windows, and puts receivers at 1.2 m (seated ear height). It does not say which octave bands to average. The common choice is IACC_E3 (mean of 500 Hz, 1 kHz and 2 kHz). The one quantified orientation study found that IACC tolerates about ±10° of head misalignment. That is far looser than ITD needs (see section 5). I found no study that directly compares IACC values across KEMAR, B&K, HEAD and Neumann heads.

### Cited Findings
- ISO 3382:1997 §4.3 (text read): "In rooms for speech and music the height of the microphones above the floor should be 1,2 m corresponding to the ear height of average listeners in typical chairs." Microphone positions shall be at least half a wavelength apart ("around 2 m"). The distance to the nearest reflecting surface, including the floor, shall be at least a quarter wavelength ("normally around 1 m"). — [ISO 3382:1997 sample, iTeh](https://cdn.standards.iteh.ai/samples/2354/da1625f2a0c9494ab0ac112528ff5850/ISO-3382-1997.pdf) **[read, OCR]**
- ISO 3382:1997 Annex B (informative) "introduces binaural measurements and the head and torso simulators (dummy heads) required to make the measurements in auditoria". The annex text itself is not in the free sample. — [ISO 3382:1997 sample](https://cdn.standards.iteh.ai/samples/2354/da1625f2a0c9494ab0ac112528ff5850/ISO-3382-1997.pdf) **[read, OCR]**
- A study following ISO 3382-1:2009 placed its HEAD acoustics HSU III head-and-torso simulator "at the approximate height of the head of a seated person, ~1.20 m from the floor". — [Girón et al., Archives of Acoustics 37(4) 2012](https://journals.pan.pl/Content/101627/PDF/14_paper.pdf) **[read]**
- Definition used under ISO 3382-1:2009: IACC(t1,t2) = max IACF(t1,t2) for −1 ms < τ < +1 ms. IACC_E uses t1 = 0 and t2 = 80 ms. IACC_L runs from 80 ms "to infinity". — [Girón et al. 2012](https://journals.pan.pl/Content/101627/PDF/14_paper.pdf) **[read]**
- Bradley's hall measurements used the internal microphones of a B&K HATS, a ±1 ms maximum time shift, "early" = first 80 ms and "late" = 80 ms to 1 s after the direct sound. — [Bradley, NRCC-37817 / JASA 96(6) 1994](https://www.akutek.info/Mitt%20Bibliotek/BRADLEY_Comparison%20of%20concert%20hall%20measurements%20of%20spatial%20impression_nrcc37817.pdf) **[read]**
- Frequency bands: "ISO 3382-1:2009(E) does not specify" how to average IACC over octave bands. Following Hidaka et al. (1995) and Okano et al. (1998), 500 Hz, 1 kHz and 2 kHz are "the octave bands of equal and principal importance" for ASW, which gives IACC_E3. — [Girón et al. 2012](https://journals.pan.pl/Content/101627/PDF/14_paper.pdf) **[read]**
- Other band choices in use: all octaves from 125 Hz to 4 kHz, or pairs of neighbouring bands for IACC_E,Low / IACC_E,Mid / IACC_E,High (per ISO 3382), or IACC_E3. — [Witew, Dietrich, Vorländer, ICA 2010](https://acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ICA2010/papers/p91.pdf) **[read]**
- JND, conflicting sources:
  - "ISO 3382 quotes the IACC difference limen to be 0.05." Kim et al. collected IACC JNDs "from 0.04 to 0.7" depending on absolute IACC and the excitation signal. — [Witew et al., DAGA 2010](https://pub.dega-akustik.de/DAGA_2010/data/articles/000468.pdf) **[read]**
  - Girón et al. attribute the 0.05 JND in ISO 3382-1:2009 to the lateral fraction JLF. They say that for IACC "according to Cox et al. (1993) a just-noticeable difference of 0.075 is assumed". — [Girón et al. 2012](https://journals.pan.pl/Content/101627/PDF/14_paper.pdf) **[read]**
  - Bradley cites Cox et al.: JND 0.048 for LF_early and 0.075 for 1−IACC_early. — [Bradley, ISRA 2010](https://www.acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ISRA2010/Papers/O3a.pdf) **[read]**
  - Without the standard text I cannot settle whether ISO 3382-1 itself gives 0.05 for IACC.
- Orientation sensitivity (FABIAN HATS in three shoebox rooms of 3300–5180 m³ and T30 1.14–1.83 s, seated at twice the critical distance, ±70° in 1° steps): with an azimuth placement accuracy of σ = 10°, the IACC_E error is 0.002 at low frequencies and 0.07 at high frequencies. The uncertainty is +0.005/−0.013 (low) and +0.059/−0.175 (high). The authors read "a maximum tolerable placement error of about 10°" against a 0.05 JND and conclude "a tolerance of about ±10° seems acceptable". — [Witew, Lindau et al., DAGA 2010](https://pub.dega-akustik.de/DAGA_2010/data/articles/000468.pdf) **[read]**
- Companion study (ITA head on a turntable, ±45° in 1° steps, 15,000 m³ hall, 2 sources × 6 receivers, ~6 s exponential sweeps, 24-bit/44.1 kHz). Mean IACC_E across 12 combinations: 0.94 (125 Hz), 0.83 (250 Hz), 0.53 (500 Hz), 0.48 (1 kHz), 0.52 (2 kHz), 0.55 (4 kHz). The 0° reference orientation was defined by ITD = 0 s. — [Witew et al., ICA 2010](https://acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ICA2010/papers/p91.pdf) **[read]**
- The acoustic ear spacing of a dummy head is larger than its physical spacing: B&K HATS ears are ~0.15 m apart physically, but the IACC/LF relation matched a ~0.30 m omni-pair separation. — [Bradley 1994](https://www.akutek.info/Mitt%20Bibliotek/BRADLEY_Comparison%20of%20concert%20hall%20measurements%20of%20spatial%20impression_nrcc37817.pdf) **[read]**
- Where the direct sound dominates, the two ear signals are more similar and IACC_E is high. IACC_E falls as the receiver moves away from the source. — [Bradley 1994](https://www.akutek.info/Mitt%20Bibliotek/BRADLEY_Comparison%20of%20concert%20hall%20measurements%20of%20spatial%20impression_nrcc37817.pdf) **[read]**
- Across 15 halls, 1−IACC_E and LF_E are significantly correlated in hall averages from 125 to 1000 Hz but not at 2 and 4 kHz. Bradley suspects an adjacent seat "could produce measureable changes in IACCearly values but not in LFearly values". — [Bradley, ISRA 2010](https://www.acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ISRA2010/Papers/O3a.pdf) **[read]**
- de Vries, Hulsebos and Baan (JASA 110(2), 2001, 947–954) found that LF and IACC "show large fluctuations with small variations in microphone position" from wave-field interference, which the ear appears insensitive to. — [AES e-Library 9191](https://www.aes.org/e-lib/browse.cfm?elib=9191) **[search excerpt only]**
- Head-to-head differences: a DIN-committee study found that "mainly because of geometrically different shells" different dummy heads give different sound images. — [Møller et al. AES J. 1999 (AAU)](https://vbn.aau.dk/ws/files/227876184/1999_M_ller_et_al_AES_Journal.pdf) **[search excerpt only]**
- Buchholz et al. (Acta Acustica 2026, 10, 69) found that ITD/ILD differences between a GRAS 45CA test fixture and a HEAD HMS II.3 head "largely depend on incident angle and frequency". A 3D-printed KEMAR-based shell reduced the differences. They note that ITDs matter up to ~1.5 kHz and ILDs from ~2.5 kHz. — [Acta Acustica aacus250090](https://acta-acustica.edpsciences.org/articles/aacus/abs/2026/01/aacus250090/aacus250090.html) **[search excerpt only]**

### Inferences
- *Inference:* For the fixture, "ISO-like" means ear axis at 1.2 m above the floor, a horizontal ear axis, facing the source (or here, the midpoint between the speakers), and a ±1 ms lag search. A 175 mm sphere has a maximum ITD of ~0.66–0.77 ms (section 5), which fits inside the ±1 ms window.
- *Inference:* Bradley found an acoustic ear spacing of about twice the physical spacing on a HATS with a torso. A bare sphere will decorrelate the ears differently from a HATS, mostly at high frequencies, so its absolute IACC will not match published hall values made with HATS. IACC from the sphere is useful for comparisons on the same fixture (before/after treatment, seat to seat, speaker to speaker), not as an absolute ISO figure.
- *Inference:* Witew et al. show IACC changes little with orientation at 125–250 Hz and a lot at 2–4 kHz. The ±10° tolerance applies to IACC only. ITD needs about 1° (section 5).
- *Inference:* Given the de Vries result, a single fixed position gives a noisy IACC. Average 3–5 positions a few cm apart around the head position, or several small yaw offsets.

### Gaps
- I could not read the normative ISO 3382-1:2009 annex text, which would say which dummy heads are allowed, the orientation rule and whether the annex is informative. Secondary sources agree only on "HATS required, 1.2 m, facing the source".
- I found no published study comparing IACC across KEMAR, B&K 4128/4100, HEAD HMS and Neumann KU100 in the same hall.
- I found no Okano or Beranek inter-head IACC comparison table. Beranek's books are not open access.

---

## 2. Dummy-head standards (ANSI S3.36, IEC TR 60959, ITU-T P.58, IEC 60318-7): geometry, torso, tolerances

### Takeaway
All three classic standards specify a full head *and torso* with pinnae and occluded-ear simulators. A plain sphere conforms to none of them. ANSI S3.36 and IEC TR 60959 share the KEMAR-derived dimensions and the same free-field HRTF targets at 0/90/180/270°. ITU-T P.58 was written loosely enough to cover both the B&K 4128 and the HEAD HMS II.3. The fixture should be documented as a "spherical-head binaural probe", not a HATS.

### Cited Findings
- ANSI S3.36-1985 (R1996) gives head, torso and pinna dimensions. "The essential dimensions are those of the Kemar manikin" and the standard "appears to be based on the pre-existing Kemar". IEC TR 60959 gives dimensions "identical to those in ANSI S3.36". — [ISVR Consulting report 6824 R01, 2003](https://generic.wordpress.soton.ac.uk/isvr-new/wp-content/uploads/sites/422/2022/07/6824-R01.pdf) **[read]**
- ITU-T P.58 head and torso dimensions are "very similar to, but not the same as" IEC TR 60959 and ANSI S3.36. Its inner tolerance appears to be the HEAD HMS II.3 shape and its outer tolerance the B&K HATS. P.58 requires a HATS height of at least 600 mm; the HMS II.3/II.4 "only model the head and shoulders" and probably fall short of this. — [ISVR 6824 R01](https://generic.wordpress.soton.ac.uk/isvr-new/wp-content/uploads/sites/422/2022/07/6824-R01.pdf) **[read]**
- ANSI S3.36 and IEC TR 60959 give free-field HRTFs (eardrum SPL re free-field SPL at head centre, head removed) for 0° elevation at 0°, 90°, 180° and 270° azimuth. The targets are the same; ANSI states tolerances to 0.1 dB and IEC rounds them to 0.5 dB. P.58 uses the same 0° target with asymmetric tolerances so that heads from different manufacturers fit. — [ISVR 6824 R01](https://generic.wordpress.soton.ac.uk/isvr-new/wp-content/uploads/sites/422/2022/07/6824-R01.pdf) **[read]**
- The B&K 4128 claims conformance to ANSI S3.36, IEC TR 60959 and ITU-T P.58. A "sharp dip to –6 dB" at 8 kHz puts its response outside the P.58 tolerance. — [ISVR 6824 R01](https://generic.wordpress.soton.ac.uk/isvr-new/wp-content/uploads/sites/422/2022/07/6824-R01.pdf) **[read]**
- Heads without ear canals, with microphones blocking the canal entrance (e.g. HEAD HMS III, Neumann-type recording heads), are "most frequently used for making dummy head stereo recordings". — [ISVR 6824 R01](https://generic.wordpress.soton.ac.uk/isvr-new/wp-content/uploads/sites/422/2022/07/6824-R01.pdf) **[read]**
- IEC 60318-7:2022 specifies a head and torso simulator for measuring sound sources close to the ear, over 100 Hz–16 kHz. — [IEC 60318-7 preview, VDE](https://www.vde-verlag.de/iec-normen/preview-pdf/info_iec60318-7{ed1.0}b.pdf) **[search excerpt only]**

### Inferences
- *Inference:* A flush mic on a sphere is a "blocked-entrance" receiver without pinna or canal. That suits ITD (dominated by head size and ear position) and broadband ILD. It does not reproduce the 2–10 kHz pinna/concha ILD and spectral detail.
- *Inference:* The standards include a torso because shoulder and chest reflections add an early arrival (~0.5–1 ms, from the head–shoulder geometry; not sourced here). A sphere on a thin stand lacks it, which keeps the direct-sound window clean. That helps when diagnosing the loudspeakers, but sphere readings will not match HATS readings in the 1–3 kHz region.
- *Inference:* Ears at exactly ±90° on a sphere create a strong contralateral "bright spot" for fully lateral sources (Duda & Martens; see section 6). For stereo speakers at ±30° this is a secondary concern.

### Gaps
- I did not obtain the numeric head dimensions (head breadth, ear-axis offsets, torso) from ANSI S3.36, IEC TR 60959 or P.58. The ISVR report shows them only in figures. KEMAR's head breadth (~152 mm is the commonly quoted figure) is unverified here.
- I did not retrieve the numeric free-field HRTF tolerance tables.

---

## 3. Inter-channel matching, calibration and clocking

### Takeaway
The IM73D122 datasheet guarantees ±1 dB sensitivity per unit, so two units can differ by up to 2 dB. It gives only *typical* phase and group delay, with no spread between units. To hit ILD ≈ 0.5 dB and ITD ≈ 10 µs, the fixture must support a mic-swap or roll-180° calibration and per-unit correction filters. A shared PDM clock removes inter-channel drift. Two datasheet numbers differ from the project brief: SNR is 73 dB(A) at 3.072 MHz (69 dB(A) only in the 768 kHz low-power mode), and AOP is 122 dB SPL, not 130 dB.

### Cited Findings
- IM73D122V01 datasheet (rev. dated 2022-08-12), test conditions VDD 1.8 V, fCLK 3.072 MHz, 25 °C: **[read]** — [Infineon IM73D122 datasheet](https://www.infineon.com/assets/row/public/documents/24/49/infineon-im73d122-datasheet-en.pdf)
  - Sensitivity −27 / −26 / −25 dBFS (min/typ/max) at 1 kHz, 94 dB SPL. Each unit is calibrated with an Infineon algorithm, "resulting in low sensitivity tolerances (± 1dB)".
  - LFRO 20 Hz (−3 dB re 1 kHz). HF flatness +3 dB at 19 kHz. Resonance peak 37 kHz.
  - SNR, A-weighted: 69 dB at fclock 768 kHz (20 Hz–8 kHz bandwidth); 71 dB at 1.536 MHz; 72 dB at 2.4 MHz; 73 dB at 3.072 MHz; 72 dB at 4.8 MHz (20 Hz–20 kHz).
  - AOP (10 % THD) 122 dB SPL. THD 0.5 % at 94 dB SPL, 1.0 % at 120 dB SPL. Dynamic range 101 dB.
  - Group delay (typical): 60 µs at 250 Hz, 12 µs at 600 Hz, 7 µs at 1 kHz, 3.5 µs at 4 kHz.
  - Phase response (typical): 20° at 75 Hz, 0.5° at 1 kHz, −2° at 4 kHz. No min/max and no matching specification.
  - Startup: 20 ms to ±0.5 dB sensitivity accuracy.
  - Stereo PDM: with two mics on one bus, "data is transmitted alternately according to the L/R pin status", and both share one clock and power mode. "The performance is unchanged relative to a single microphone per bus." L/R = GND drives data on the falling edge; L/R = VDD on the rising edge.
  - Package 4 × 3 × 1.2 mm, omnidirectional, IP57.
- Infineon's product page reportedly claims sensitivity (±1 dB) and phase (±2° @ 1 kHz) matching. This came only from a search summary and I did not confirm it on the page; the datasheet has no phase-matching figure. — [Infineon IM73D122 product page](https://www.infineon.com/part/IM73D122) **[search excerpt only, unverified]**
- A dummy-head study calibrated two capsules with nominal sensitivity "20mV/Pa ±1 dB". It found a 2 dB difference between two calibration procedures, of which 1.7 dB was an insertion loss reported by the manufacturer. — [Toledo & Møller, AES Convention 2009](https://vbn.aau.dk/ws/files/227876843/2009_Toledo_and_M_ller_AES_Convention.pdf) **[read, partially]**

### Inferences
- *Inference (arithmetic):* An ITD error of Δt is a phase error of 360·f·Δt. For 10 µs that is 0.36° at 100 Hz, 1.8° at 500 Hz, 3.6° at 1 kHz. The datasheet's typical 0.5° at 1 kHz is an absolute deviation, not a unit-to-unit spread, so it does not prove 10 µs matching.
- *Inference (first-order high-pass model):* Low-frequency phase depends on the LFRO corner. At 75 Hz with a 20 Hz corner, phase moves by ≈ 0.7° per Hz of corner shift. A 2 Hz LFRO spread between units would give ≈ 1.4° ≈ 50 µs of apparent ITD at 75 Hz; at 500 Hz the same spread gives ≈ 0.23° ≈ 1.3 µs. So low-frequency ITD (< 300 Hz) is only trustworthy after per-unit phase calibration. Above ~500 Hz the mismatch probably stays under ~10 µs, but that is unverified without unit-pair data.
- *Inference:* ±1 dB per unit means up to 2 dB raw gain mismatch, four times the 0.5 dB ILD target. Gain must be calibrated per frequency band, not just at 1 kHz.
- *Calibration procedures (inference, built from standard practice and the geometry):*
  1. **Roll-180° swap.** Rotate the sphere 180° about its front–back axis, so front stays front and the mics trade sides. Measure the same source both ways. With channel mismatch m and acoustic ITD τ: run A = τ + m, run B = −τ + m, so τ = (A − B)/2 and m = (A + B)/2. The same works for ILD in dB. This needs a mount with two detented positions 180° apart about the front–back axis, so it is a fixture requirement.
  2. **Co-located reference.** Hold both mic PCBs side by side (or both ports facing one small source at a few cm on axis) and record. The transfer-function ratio gives the mismatch filter directly. A detachable mic carrier makes this possible.
  3. **Absolute level** (needed only for SPL, not for ITD/ILD): a 94 dB/1 kHz calibrator needs a coupler that fits the flush port. The 4 × 3 mm package and flush mount make this awkward; a printed adapter ring would work.
  4. Yaw offset is **not** removed by the swap; see section 5.
- *Inference:* With a shared PDM clock both channels are sampled from one oscillator, so inter-channel delay is fixed. The opposite clock edges offset the channels by half a PDM period (≈ 163 ns at 3.072 MHz), which is a constant and negligible next to 10 µs. Using identical decimation filters on both channels keeps it constant.
- *Inference:* Loudspeaker playback runs on a different clock from capture. This time-stretches both channels equally, so it moves absolute arrival time but not ITD or ILD.
- *Inference:* Running at 3.072 MHz (73 dB(A) SNR) rather than 768 kHz costs current but gains 4 dB SNR and the full 20 kHz bandwidth. 768 kHz limits bandwidth to 8 kHz, which cuts off the ILD band above it.
- *Inference:* The 122 dB SPL AOP is ample for living-room sweeps at ~85–95 dB SPL at the seat.

### Gaps
- There is no published unit-to-unit phase or group-delay spread for the IM73D122. It must be measured on the actual pair.
- I did not verify the Infineon product-page ±2° phase-matching claim.
- No source gives the temperature drift of IM73D122 sensitivity.

---

## 4. Stand, tripod, chair and floor reflections

### Takeaway
I found no study that quantifies how much a stand or tripod changes binaural cues. Practice is to keep supports small and absorptive and to time-gate the direct sound before the first setup reflection. The 1/4"-20 tripod head and the chair backrest matter less as scatterers than for *when* their reflections arrive, because that sets the longest clean window for ITD/ILD of the direct sound.

### Cited Findings
- HRTF practice: measurements are done in anechoic rooms to minimise reflections. One B&K HATS setup laid sound-absorbing material on the floor "to minimize the effect of reflection on the support". — [arXiv 2203.03166](https://arxiv.org/pdf/2203.03166) **[search excerpt only]**
- Toledo & Møller (Neumann KU100) used a rectangular window long enough for all impulse responses to die out, which "could not exclude the first reflections from the setup". They then built shorter (256-sample) FIR filters "avoiding some reflections from the setup", and showed visible setup-reflection effects in the longer filters. — [Toledo & Møller, AES 2009](https://vbn.aau.dk/ws/files/227876843/2009_Toledo_and_M_ller_AES_Convention.pdf) **[read, partially]**
- ISO 3382:1997 asks for at least a quarter wavelength (~1 m) from any reflecting surface, floor included. — [ISO 3382:1997 sample](https://cdn.standards.iteh.ai/samples/2354/da1625f2a0c9494ab0ac112528ff5850/ISO-3382-1997.pdf) **[read]**

### Inferences
- *Inference (geometry; c = 343 m/s):* A reflector d behind or below the mic adds roughly 2d/c of delay for a frontal source:
  - Tripod head ~10 cm below the ear axis: a few hundred µs. It is small (≈ 4–6 cm), so it scatters mainly above ~3–6 kHz, where its size approaches the wavelength.
  - Chair backrest 10–20 cm behind the sphere: ≈ 0.6–1.2 ms, a comb with notches spaced ~0.8–1.7 kHz, inside the IACC_E window. It is roughly symmetric for both ears, so it mostly affects IACC and spectral cues rather than ITD.
  - Floor, speakers at ~3 m, tweeter ~1 m, ears at 1.2 m: image path ≈ √(3² + 2.2²) ≈ 3.72 m against 3.01 m direct, so ≈ 2.1 ms. This is a room property, not a fixture one.
- *Inference:* For direct-sound ITD/ILD, gate before the first setup reflection. A 0.5–1 ms clean window limits frequency resolution to roughly 1–2 kHz. Lower-frequency ITD therefore has to come from a longer window that includes the room, which suits phantom-image diagnosis because the room is part of what the listener hears.
- *Design requirements derived:*
  1. Mount the sphere on a thin rod (≤ 12–16 mm) rising ≥ 15–20 cm above the tripod head, so the tripod-head reflection arrives > 1 ms after the direct sound. Wrap the rod and tripod head in felt or foam.
  2. Make the sphere's own lower mount small, with no flange near the ear axis.
  3. Make two measurement modes possible: (a) chair removed, ISO-style, for "system only"; (b) chair in place, sphere at the real head position, for "as heard". Record which mode was used.
  4. Keep the ear axis 1.2 m above the floor, or at the listener's measured ear height, as an adjustable tripod column parameter.

### Gaps
- I found no quantitative study of stand or rod diameter against HRTF/ITD error.
- I found no published guidance on sphere-to-backrest distance for in-situ binaural measurements.

---

## 5. Orientation and alignment accuracy

### Takeaway
On a 175 mm sphere, 1° of yaw shifts ITD by about 9 µs (high-frequency/Woodworth) to 13 µs (low-frequency). A 10 µs ITD target therefore needs yaw within about ±1°, an order of magnitude tighter than the ±10° that suffices for IACC. Lateral position matters even more: 1 cm of sideways offset from the centreline changes the arrival-time difference between left and right speakers by ≈ 29 µs (for ±30° speakers). The fixture needs a laser or sight line and a centring reference.

### Cited Findings
- Woodworth's rigid-sphere formula ITD(θ) = (a/c)(θ + sin θ) is a frequency-independent ray model that matches the high-frequency limit of exact diffraction. The low-frequency limit is (3a/c) sin θ. Kuhn's data imply a larger effective radius of 9.3 cm at low frequency. — [Hartmann/MSU notes on Woodworth](https://web.pa.msu.edu/acoustics/woodworth.pdf) **[search excerpt only]**
- IACC orientation tolerance is about ±10° (σ = 10° gives an error of 0.002–0.07). — [Witew et al., DAGA 2010](https://pub.dega-akustik.de/DAGA_2010/data/articles/000468.pdf) **[read]**
- Witew et al. defined the reference (0°) orientation as the orientation with ITD = 0 s. — [Witew et al., ICA 2010](https://acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ICA2010/papers/p91.pdf) **[read]**

### Inferences
- *Inference (arithmetic, a = 0.0875 m, c = 343 m/s):*
  - Maximum ITD at 90°: (a/c)(π/2 + 1) ≈ 656 µs (HF). 3a/c ≈ 765 µs (LF).
  - Slope at the midline: 2a/c ≈ 510 µs/rad ≈ 8.9 µs/° (HF). 3a/c ≈ 765 µs/rad ≈ 13.4 µs/° (LF).
  - A single speaker at 30°: ITD ≈ 261 µs (HF, Woodworth).
- *Inference:* A yaw error of δ biases ITD by ~9–13 µs per degree. The roll-180° swap (section 3) does not remove it, because the yaw stays the same. Options:
  - Mechanical/optical aim. A laser on the sphere's front meridian aimed at the speaker midpoint at 3 m: 1° ≈ 52 mm at 3 m, so a laser dot within ±26 mm of the midpoint gives ±0.5°.
  - Acoustic aim. Rotate until ITD = 0 for a single on-axis reference source, as Witew et al. did. This assumes the reference source sits exactly on the centreline.
  - Measure each speaker alone. With a centred seat, ITD_L + ITD_R ≈ 2·k·δ, so the sum shows yaw offset combined with seat asymmetry.
- *Inference:* Lateral seat offset x changes the inter-speaker path difference by ≈ 2x·sin(30°) = x, so 1 cm ≈ 29 µs. That is a real imaging effect, not a fixture error. To separate it from yaw, the fixture needs a centring reference such as a plumb or downward laser to a floor mark, or tape-measure points to both tweeters. The tweeter distances should match to ≤ 3 mm for < 10 µs.
- *Inference:* Elevation error matters little for ITD. Lateral angle scales with cos(elevation), so 5° of pitch changes a 30° source's ITD by ≈ 0.4 % (≈ 1 µs). The ear axis must still be level, because roll tilts one ear up. A bubble level on the sphere or mount is enough.
- *Inference:* Ear height relative to the tweeter mainly affects vertical lobing of multi-way speakers and the floor-bounce timing, not ITD. Set the ear axis to the listener's ear height (ISO default 1.2 m) and record the tweeter height.

### Gaps
- I found no published practice note giving a yaw tolerance for binaural ITD measurements specifically. The ±1° figure above is my derivation.

---

## 6. Measurement and analysis methods (sweep or MLS, ITD estimators, ILD, phantom-image diagnostics)

### Takeaway
Use exponential sine sweeps (Farina ESS). They separate harmonic distortion and tolerate time variance and clock mismatch better than MLS, and they are what the IACC studies above used. Estimate ITD with several estimators on the same data. The comparative literature finds onset-threshold and IACC-max/centroid estimators (after ~3 kHz low-pass) reasonable, and phase/group-delay estimators less reliable. Report ILD per third-octave or octave band. For phantom-image diagnosis, compare L-only, R-only and L+R (mono) responses at the seat.

### Cited Findings
- ESS gives the linear IR plus separate harmonic-distortion IRs in one measurement. MLS shows distortion as spurious peaks and relies on averaging, which increases "vulnerability to time variance". The log sweep, "avoiding any kind of averages", becomes "substantially immune to clock mismatch and time variance". — [Farina presentations / NordicSound 2007](https://angelofarina.it/Public/papers/238-NordicSound2007.pdf) **[search excerpt only]**
- An IOA paper notes that ESS is "arguably superior" to MLS but both remain in common use. — [Nikolić & Bjor, IOA proceedings](https://www.ioa.org.uk/system/files/proceedings/i_nikolic_o-h_bjor_building_and_room_acoustics_measurements_with_sine-sweep_technique.pdf) **[search excerpt only]**
- The IACC orientation studies used ~6 s exponential sweeps (interleaved for two sources). — [Witew et al., ICA 2010](https://acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ICA2010/papers/p91.pdf) **[read]**
- Katz & Noisternig (JASA 2014, DOI 10.1121/1.4875714) compared ITD methods on KEMAR HRTFs **[search excerpt only; HAL page blocked automated access, full text not read]** — [HAL 01107079](https://hal.archives-ouvertes.fr/hal-01107079):
  - ITD methods fall into three families (onset threshold, cross-correlation, phase/group delay), and different methods give "highly variable" ITDs for the same data.
  - The contralateral HRIR's double peak is a main source of variation.
  - A 3 kHz low-pass on the HRIRs reduced variability for some methods but changed the ITD spatial function.
  - Threshold methods and IACC max/centroid on similarly filtered HRIRs or envelopes gave reasonable results. Integrated relative group delay and auditory-model phase methods performed worse.
- Some ITD estimators are much more affected by additive noise than others. — [Steidle & Baumgartner, DAGA 2019](https://pub.dega-akustik.de/DAGA_2019/data/articles/000454.pdf) **[search excerpt only]**
- On a spherical head model, a fully lateral source produces an acoustic "bright spot" at the far ear, which puts a peak into level against azimuth. The spherical model also "has serious deficiencies" next to measured human interaural differences. Duda & Martens used ears at ±100° in one figure. — [Duda & Martens / UC Davis IDAV](https://escholarship.org/content/qt48m5k072/qt48m5k072.pdf?t=ptt2xl) **[search excerpt only]**
- ITDs are perceptually usable up to ~1.5 kHz; ILDs dominate above ~2.5 kHz. — [Buchholz et al., Acta Acustica 2026](https://acta-acustica.edpsciences.org/articles/aacus/abs/2026/01/aacus250090/aacus250090.html) **[search excerpt only]**

### Inferences
- *Inference, recommended analysis for phantom-image diagnostics:*
  1. Record three sweeps at the seat: L only, R only, L+R (mono, identical signal). Two more with polarity inverted on one side (L−R) help to separate in-phase and out-of-phase room contributions.
  2. Apply per-band channel-mismatch correction from the roll-180° calibration.
  3. ITD:
     - Direct sound: onset threshold (e.g. −20 dB re peak) and IACC lag (argmax of the cross-correlation in ±1 ms) on a 1–1.5 kHz low-passed, gated (≤ 1 ms) direct sound.
     - Phantom images: cross-correlation lag per octave band, 125 Hz–1 kHz, in a 0–80 ms window. A centred mono phantom should give ≈ 0 µs at every band; a frequency-dependent ITD shows a lateral image shift. Report agreement between estimators as the uncertainty.
  4. ILD: band levels (third-octave) L − R, gated direct sound for > 2 kHz, and 0–80 ms and steady-state for the room. For a centred mono phantom it should be ≈ 0 dB per band.
  5. IACC_E / IACC_L per octave and IACC_E3, using the same windows as ISO (REW's panel does this).
  6. Symmetry check: ITD_L(single speaker) should be ≈ −ITD_R; differences show seat or yaw offset or speaker/room asymmetry.
- *Inference:* With ears at ±90° the fixture's ITD-to-angle curve differs from human heads (ears slightly behind ±90°, plus pinna). Report ITD in µs and ILD in dB as measured, and convert to "image angle" only through the sphere's own calibration curve, measured once by rotating the fixture against a single speaker in 5° steps.

### Gaps
- I did not read the Katz & Noisternig full text, so I have no numeric bias per estimator (µs).
- I found no source on phantom-image (two-speaker summing) ITD/ILD diagnosis with a dummy head in domestic rooms. The procedure above is constructed, not cited.

---

## 7. Tools for binaural room / stereo-imaging analysis

### Takeaway
REW has an IACC panel (early/late/full, per-octave, zero-phase filters) that works on any pair of measurements, which makes it the most practical off-the-shelf tool for this fixture. MATLAB toolboxes (ITA-Toolbox, AARAE) cover research-grade binaural analysis. I found no tool built for low-cost spherical heads.

### Cited Findings
- REW's IACC panel "is used to calculate the early, late and full IACC values for a pair of binaural measurements". Zero time is "the earlier of the two measurement IR start times". The panel does not realign measurements (use "Cross corr. align"). Filters are one-octave, zero-phase bandpass of selectable order. The early window ends at 80 ms. The late window ends at the later of 500 ms or where the Schroeder integral reaches the noise floor. — [REW help: Inter-Aural Cross Correlation](https://www.roomeqwizard.com/betahelp/help/html/iacc.html) **[read]**
- The help page does not mention ITD or ILD output, or a lag output. — [REW help](https://www.roomeqwizard.com/betahelp/help/html/iacc.html) **[read]**
- The ITA-Toolbox (MATLAB, RWTH Aachen) handled signal processing, turntable control and IACC evaluation in the Witew et al. study. — [Witew et al., ICA 2010](https://acoustics.asn.au/conference_proceedings/ICA2010/cdrom-ICA2010/papers/p91.pdf) **[read]**
- AARAE (Audio and Acoustical Response Analysis Environment) is a MATLAB environment that requires several MathWorks toolboxes. — [AARAE fork on GitHub](https://github.com/runngezhang/aarae) **[search excerpt only]**

### Inferences
- *Inference:* REW cannot read a two-channel ESP32 recording as a live input unless the ESP32 shows up as a USB audio device. Otherwise the workflow is: record the sweep on the ESP32, import the two channels as WAV, and deconvolve in REW or a Python script against the known sweep. The two channels must share a time reference, or REW's IACC zero-time rule ("earlier of the two IR start times") must be respected; importing both channels from one recording preserves this.
- *Inference:* ITD and ILD are not in REW's IACC panel. A small Python script (scipy: deconvolve, band filters, cross-correlation lag, onset threshold) is needed for those, and it fits the repository's "build for reuse" rule.

### Gaps
- I did not confirm whether AARAE has an IACC/ITD analyser, or whether Acourate or EASERA provide IACC.
- I found no open-source project that analyses stereo imaging with a low-cost binaural fixture.

---

### Derived fixture requirements (summary of inferences above; each traces to the sections cited)
1. Ear axis horizontal and adjustable to 1.2 m (ISO) or the listener's ear height; bubble level on the mount (sections 1, 5).
2. Yaw aim within ±1°: a front-meridian laser or sight slot aimed at the speaker midpoint (≈ ±26 mm at 3 m for ±0.5°) (section 5).
3. Centring reference to the seat centreline within ~3 mm: a downward laser or plumb point, or tweeter-distance measurement points (section 5).
4. Roll-180° indexed mount about the front–back axis, so the mics can be swapped without changing yaw (section 3).
5. Removable mic carriers for a co-located mismatch measurement, plus a printable calibrator adapter for absolute SPL (section 3).
6. Thin rod (≤ 12–16 mm, ≥ 15–20 cm) between sphere and tripod head, wrapped in absorber, with nothing large near the ear axis (section 4).
7. PDM clock 3.072 MHz (73 dB(A), 20 kHz band); identical decimation on both channels; start recording ≥ 20 ms after clock start (section 3).
8. Per-band calibration files stored with each measurement; ITD reported from at least two estimators (section 6).
