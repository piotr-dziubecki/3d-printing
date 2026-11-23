# Physical construction details affecting acoustic accuracy of a 3D-printed sphere head with flush MEMS microphones

Scope: 175 mm PLA sphere (a = 87.5 mm), 4.5 mm walls, sand-filled caps, 40 mm centre slab with an electronics bay vented through a USB slot, IM73D122 bottom-port MEMS on ~15 mm round carriers (1.6 mm PCB forms the port) flush at the ear points, seams 67.5 mm from each ear, 0.2 mm layers.

Source status (written 2026-11-23, clock checked): documents **read in full text** were the InvenSense/TDK AN-1003 mounting note, the Infineon IM73D122V01 datasheet (v1.00, 2022-08-12), and the Lu et al. robotic dummy head paper (arXiv 2505.04548). Infineon AN557 and ST AN4427 (gasket design) **could not be downloaded**: Mouser and ST timed out or returned HTML bot pages on several attempts. Statements attributed to them below come from search-engine summaries only and are marked "[snippet, not verified]". The Acta Acustica 2026 printed-shell paper returned HTTP 403.

Reference numbers used throughout (computed here, c = 343 m/s):
- Wavelength at 20 kHz = 17.15 mm; at 10 kHz = 34.3 mm. AN-1003 gives the same relation ("at 10 kHz, the wavelength is 34 mm").
- ka for a = 87.5 mm: 1.6 at 1 kHz, 32 at 20 kHz.
- Time per mm of path: 2.92 µs/mm. A 1 mm error in mic position changes ITD by up to ~3 µs.

## 1. Mic port geometry (carrier PCB as the port, Helmholtz resonance, how flush is flush)

### Takeaway
A 1.6 mm-long, 0.8–1.0 mm-diameter PCB port in front of a bottom-port MEMS stays clear of the audio band only if the volume between the board and the membrane is about 1 mm³ or less. The IM73D122 itself already rises +3 dB by 19 kHz and peaks at 37 kHz, so any extra port length or front cavity pulls that peak down into the band. A 0.3 mm recess or step in front of the carrier is acoustically small at 20 kHz (λ/57). Its quarter-wave resonance is far above the band (~286 kHz, computed). It matters only if it creates an enclosed cavity in series with the port.

### Cited Findings
- IM73D122V01: "High Frequency Flatness" 19 kHz at +3 dB relative to 1 kHz; "Resonance Frequency Peak" 37 kHz; both "not subject to productive test. Verified by laboratory characterization / design". Other specs: sensitivity −26 dBFS (±1 dB), SNR 73 dB(A) at 3.072 MHz clock, AOP 122 dBSPL, LFRO 20 Hz, package 4 × 3 × 1.2 mm, group delay 7 µs at 1 kHz and 3.5 µs at 4 kHz, phase 0.5° at 1 kHz and −2° at 4 kHz — [Infineon IM73D122V01 datasheet](https://static.chipdip.ru/lib/911/DOC028911535.pdf)
- The datasheet says the PCB port hole diameter "should be larger than the acoustic port hole diameter of the MEMS microphone". It recommends a PCB sound port of radius 0.4 mm (diameter 0.8 mm). It also says not to blow air into or vacuum the port, and to tape the port during sawing and assembly — [Infineon IM73D122V01 datasheet](https://static.chipdip.ru/lib/911/DOC028911535.pdf)
- AN-1003: response "is not affected by the PCB hole size, as long as the hole is not smaller than 0.25 mm" in diameter. 0.5–1 mm is typical. Exact alignment does not matter "as long as the holes are not partially or completely blocked" — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)
- AN-1003: a Helmholtz resonator forms when "a wide gasket is used between the microphone PCB and the device case". It causes "a high-frequency response peak". To avoid it, keep the gasket as small as possible or put the board directly against the case. If a longer path is unavoidable, its effective diameter should be close to or smaller than the case opening, and several small holes may replace one vent. A good seal on both sides of the gasket is important. Gasket stiffness has negligible influence (rubber, silicone, neoprene and closed-cell foam all work) — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)
- AN-1003 gives a closed-form estimate (D = vent diameter mm, V = cavity volume mm³, L = vent length mm, c ≈ 340 m/s). It warns that results "can differ from the actual measurement results due to nonrigid gasket walls, leakages, and other imperfections" and should be used only to locate the resonance roughly — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)
- [snippet, not verified] Infineon AN557 advises a short, wide, uniform acoustic channel without cavities or constrictions, so the Helmholtz resonance moves up and its peak is lower. It also says the bare component's port and front volume already form a resonator, and integration usually lowers it — [Infineon AN557 (Mouser copy)](https://www.mouser.com/pdfDocs/Infineon-AN557_MEMS_microphone_mechanical_and_acoustical_implementation-AN-v01_01-EN.pdf)
- [snippet, not verified] ST AN4427: the cavity formed by cover, gasket and PCB shapes the frequency response. A port too small for its chamber restricts airflow — [ST AN4427](https://www.st.com/resource/en/application_note/dm00103201-gasket-design-for-optimal-acoustic-performance-in-mems-microphones-stmicroelectronics.pdf)

### Inferences
- **Computed Helmholtz estimates** use f = (c/2π)·√(S/(V·L_eff)), with L_eff = L + 0.85·D (flanged end corrections) and L = 1.6 mm port. This is a standard lumped model, not taken from AN-1003's printed form. V is the air volume between the carrier hole and the membrane: the solder-gap ring plus the package's internal front volume. That volume is not in the datasheet (see Gaps).

  | Port D | V = 0.5 mm³ | V = 1 mm³ | V = 2 mm³ | V = 5 mm³ |
  |---|---|---|---|---|
  | 0.8 mm | 36 kHz | 26 kHz | 18 kHz | 11.5 kHz |
  | 1.0 mm | 44 kHz | 31 kHz | 22 kHz | 14 kHz |
  | 1.5 mm | 60 kHz | 43 kHz | 30 kHz | 19 kHz |

  These numbers are indicative only. Their spread shows that **an unintended cavity of a few mm³ behind the carrier hole puts the peak inside 10–20 kHz**. Examples: a solder-mask relief ring, an underfilled pad gap, or a recess milled for the mic.
- The datasheet's 37 kHz peak was measured on Infineon's own characterization board, whose port length is not stated (inference). A 1.6 mm FR-4 port with the recommended 0.8 mm hole is probably close to that setup. Thinner carriers (0.8 mm or 1.0 mm FR-4) shorten the neck and raise the resonance. A larger hole (1.0–1.2 mm, still above the package port) does the same.
- Treated as a closed tube, the port alone has a quarter-wave resonance at ~45–47 kHz (computed: L_eff ≈ 1.8–1.9 mm). This is out of band.
- **"How flush is flush"**: a 0.3 mm recess is λ/57 at 20 kHz. Its own depth resonance (c/4d) is ~286 kHz. A shallow, wide, open recess in front of the carrier is therefore not a resonator. Its acoustic effect is a small local diffraction (see section 2). It becomes harmful only when it narrows to a neck in front of a wider pocket: for example, a printed shell hole smaller than the carrier face, with an air gap between the shell and the PCB. That forms the AN-1003 "wide gasket" Helmholtz case. Practical rule (inference): make the PCB face the outer surface, or put the shell surface flush or within about 0.2 mm of the PCB face, with no air pocket between shell and carrier. Seal the carrier perimeter (thin silicone bead or adhesive) so no leak path bypasses the port.
- A leak path from the inside of the sphere to the back of the port would form an unintended acoustic shunt. Bottom-port MEMS have the back volume sealed in the package, so the main leak risk is the front path along the carrier edge (inference). AN-1003's "good seal" advice covers this.

### Gaps
- IM73D122 package front-volume and package port diameter are not given in the datasheet text extracted. The Helmholtz table therefore cannot be pinned to one number. Measure it, or ask Infineon.
- Port length of the PCB Infineon used for the 37 kHz figure: not stated in the datasheet.
- AN557 numeric examples (channel dimensions vs resonance curves) were not read. The PDF could not be retrieved.

## 2. Microphone and carrier size on the baffle; diffraction from seams, gaps, notches, flats

### Takeaway
At 20 kHz the wavelength is 17 mm, so a 15 mm flush carrier is invisible if it is truly flush. A step or gap ring of a few tenths of a millimetre is λ/50–λ/100 and causes small local diffraction. Features of several millimetres or more (OLED flat, front notch, open seam gaps) cause measurable high-frequency ripple and should sit far from the ears or be filled. No paper was found that quantifies dB error against step height for a sphere. The magnitudes below are inferences from wavelength ratios.

### Cited Findings
- All dimensional references in acoustics scale with wavelength: 34 mm at 10 kHz — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)
- An ICSV paper on the "baffled effect" of a mobile-phone panel reports that the panel around a microphone entrance hole changes the response at higher frequencies. Panel thickness matters mainly above a characteristic frequency [snippet, not verified] — [Liu, IOA](https://www.ioa.org.uk/system/files/publications/YC%20LIU%20STUDY%20ON%20THE%20BAFFLED%20EFFECT%20OF%20MOBILE%20PHONE%20PANEL.pdf)
- A covered cavity in front of a sensor produces quarter-wavelength standing-wave amplification, set by depth, diameter and wall angle [snippet, not verified] — [Politecnico di Torino](https://iris.polito.it/bitstream/11583/2976892/1/10.0009274.pdf)
- A finite baffle's edge diffraction must be known to get an accurate frequency response. Standard methods include Kirchhoff, GTD and Biot–Tolstoy–Medwin [snippet, not verified] — [Applied Sciences 12(3):1420](https://mdpi.com/2076-3417/12/3/1420/html)

### Inferences
- Carrier step 0.3 mm = 0.017 λ at 20 kHz. A backward step that small scatters a negligible fraction of energy. The expected magnitude ripple is well below 1 dB (inference, not measured). A protruding carrier is worse than a recessed one only in that it is more likely to be bumped. Acoustically the two are similar at this scale.
- A gap ring around the carrier, for example 0.2 mm wide and 1–2 mm deep, closed at the bottom, has a quarter-wave depth resonance of c/4d ≈ 43–86 kHz. That is above the band. Filling it (silicone, CA + talc) removes it anyway.
- Seams 67.5 mm from each ear: that distance is ~3.9 λ at 20 kHz and ~0.2 λ at 1 kHz. A hairline seam (< 0.3 mm) is acoustically negligible. A seam with a 1 mm groove or a lip acts as a weak line scatterer. On a sphere, the creeping wave passing the seam toward the shadowed ear carries the contralateral signal, so a lipped seam on that path would mostly perturb contralateral HF levels (inference). Tape or fill the seam for measurement.
- The OLED flat (30 mm, ~1.75 λ at 20 kHz) and the front notch are geometric departures from the sphere at the scale of the wavelength. Their effect on the ear signal depends on angle and is largest for sources whose path to the ear crosses them. This argues for placing them at the back or bottom, or covering them during measurement (inference).
- Position tolerance: every 1 mm of ear-point placement error changes ITD by up to 2.9 µs. The Lu et al. printed head differed from KEMAR by 62.5 µs at 90°, which shows that ITD-level accuracy is dominated by geometry far more than by surface detail.

### Gaps
- No published quantitative measurement was found of the HRTF error from a flush-mount step or gap of a given height on a sphere or head. A BEM run (for example Mesh2HRTF) of the actual STL with and without the features would close this.

## 3. Shell rigidity, shell resonances, sand filling, printed-head literature

### Takeaway
At 4.5 mm PLA wall the shell is acoustically rigid for airborne scattering: surface density ~5.6 kg/m², impedance far above air. Its breathing-mode resonance is estimated at ~4–5 kHz, but it is excited only weakly by sound and is heavily loaded and damped where the caps are sand-filled. The hollow slab bay is the weak point. Published printed heads match KEMAR closely in ILD and ITD. No paper found reports shell vibration as an error source.

### Cited Findings
- A modular, interlocking 3D-printed dummy head measured against a GRAS 45BC KEMAR at 5° resolution: HRTFs "alike at speech-relevant frequencies", ILDs at 90° similar, and ITD difference "62.5 µs at 90°" with RMSE 67.9 µs over 0–180°. Microphones were Countryman B3 lavaliers in faux ear canals. The paper gives no wall/infill details — [Lu et al., arXiv 2505.04548](https://arxiv.org/pdf/2505.04548)
- PLA FDM modulus: about 3.5 GPa for on-edge prints (~40% lower for upright) and 3120 MPa on a datasheet at 90% infill. Modulus rises with infill density, and infill pattern has no significant effect. Some studies report far lower values (~0.83 GPa), depending on parameters [search summary] — [PMC6981541](https://pmc.ncbi.nlm.nih.gov/articles/PMC6981541); [PMC7579378](https://pmc.ncbi.nlm.nih.gov/articles/PMC7579378)
- A skull-substitute study modeled a 180 mm sphere shell with constant 7 mm thickness to mimic cranial bone modal behavior (shaker + laser vibrometer) [snippet] — [Frontiers Bioeng. 2024, 10.3389/fbioe.2024.1297730](https://www.frontiersin.org/journals/bioengineering-and-biotechnology/articles/10.3389/fbioe.2024.1297730/full)
- PLA FFF panels with 1.6 mm perimeter shell: infill-dependent absorption and transmission loss (TLn 53.3 dB at 60% infill, 4 mm panels) [snippet; airborne panel tests, not shells] — [PMC12251598](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12251598/)
- Harder et al.: human vs printed-head HRTFs had very similar spectral features; larger deviations were between measurements and FEM simulations [search summary] — [Harder et al. via search](https://eprints.soton.ac.uk/495143/1/aacus220104.pdf)

### Inferences
- **Breathing mode** of a thin sphere, f = (1/2πa)·√(2E/(ρ(1−ν))), with E = 2.0–3.5 GPa, ρ = 1240 kg/m³ and ν = 0.36 (assumed PLA values; E from the sources above): **~4.1–5.4 kHz** for a = 87.5 mm (computed). Lower-order flexural modes of a 4.5 mm/175 mm shell, and of the three separate parts joined by magnets, fall lower, in the hundreds of Hz to low kHz (inference, not computed). Each joined part rattles as its own body unless clamped.
- Coupling to the microphones goes through the carrier mount. If the carrier is glued into the shell wall, shell vibration at the ear is picked up two ways: (a) inertially, through the membrane's tiny vibration sensitivity (section 6), and (b) as sound radiated by the shell surface next to the port. Path (b) dominates (inference). Sound-driven shell velocity is tiny for 5.6 kg/m², so airborne-induced errors are expected to be negligible. Tripod- or handling-driven vibration is the realistic concern.
- **Sand**: dry sand filling a sealed cap adds mass (~0.86 kg per 0.54 L cap at ~1.6 kg/L bulk density, an assumed typical value) and high internal friction damping. It suppresses cap shell modes and internal cavity modes. This is the same reason loudspeaker builders sand-fill panels (inference; no source fetched). Downsides: total mass ~2 kg on a tripod head, and loose sand can rattle or settle and leave an air gap at the top of each cap. Fill completely and compact it, or bind it (sand + resin, or sand + PVA).
- 15% gyroid infill in "solid" regions leaves ~85% air in those regions. That air is enclosed and does not radiate, but it lowers the local stiffness of those regions (inference).

### Gaps
- No paper found that measured shell or structure-borne transmission, or mic-to-mic coupling through a printed head shell. The Acta Acustica 2026 printed-shell study ([aacus250090](https://acta-acustica.edpsciences.org/articles/aacus/pdf/2026/01/aacus250090.pdf)) was blocked (403).
- No published FABIAN or printed-KEMAR construction specs (wall, infill) were retrieved.

## 4. Internal cavity (electronics bay ~0.8 L, USB slot vent ~200 Hz Helmholtz)

### Takeaway
The bay is not in the mic's acoustic path, because each MEMS is sealed at its carrier and faces outward. Its effects are a weak external scatterer/resonator at the back of the sphere near 200 Hz, and a possible path for internal noise. Sealing or damping the bay, or plugging the USB slot during measurement, removes both cheaply. Expected impact is small but unquantified.

### Cited Findings
- A Helmholtz resonator is "a wide section forming an inner cavity and a narrow hole, or vent, to the outside". It produces a response peak even when its dimensions are much smaller than the wavelength — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)

### Inferences
- At 200 Hz, ka = 0.32 and λ = 1.7 m. The vent opening is a monopole point source on the sphere surface at the back. When incident sound drives it at resonance, it re-radiates. Because it sits ~90° from each ear, it adds a small, nearly equal-phase component to both ears. That perturbs low-frequency level slightly but hardly changes ILD or ITD (inference, magnitude unquantified). Fibre filling (polyester, felt) in the bay lowers the Q and is free.
- If the carrier perimeter is not sealed and the bay connects to the ear-mic front through internal channels, the bay becomes part of the mic front volume. This is the failure mode to rule out: it would put a resonance and leak right at the port. Ensure each carrier is sealed and no cable channel connects the front of the port to the bay (inference).
- An OLED, regulator coil or MCU in the bay does not make acoustic noise worth considering. A fan or a buzzing magnetic part would (inference).

### Gaps
- No source found on bay-vent effects on sphere-head ear signals. A quick test settles it: measure with the USB slot open and taped.

## 5. Surface finish (0.2 mm terracing, FDM roughness)

### Takeaway
0.2 mm layer steps are λ/86 at 20 kHz and do not matter acoustically for the external field. Near the ear points, terracing changes local geometry by tenths of a millimetre at most. The only practical requirement is that the carrier seat stays flush and sealed. Sanding or a filler-primer coat is cosmetic for sound, and helps mainly with sealing.

### Cited Findings
- Printed shells treated as acoustically rigid at 0.06 mm print precision in a metamaterial-enclosure study [snippet] — [arXiv 1908.08160](https://arxiv.org/pdf/1908.08160)
- Printed heads match KEMAR closely at speech-relevant frequencies, despite FDM surfaces — [Lu et al., arXiv 2505.04548](https://arxiv.org/pdf/2505.04548)

### Inferences
- The roughness Rz of FDM (~0.1–0.2 mm, assumed) is 10⁻² λ at 20 kHz. That is in the Rayleigh smooth regime (k·h ≈ 0.07 for h = 0.2 mm at 20 kHz), so scattering losses are negligible (computed: k = 366 rad/m).
- Porosity is the one surface property that could matter, through absorption. FDM walls with 4.5 mm solid perimeters are effectively non-porous. Under-extruded walls can leak air, which matters for sealing the sand caps and the carrier seats, not for scattering (inference).

### Gaps
- No measured comparison of sanded vs unsanded FDM head HRTFs was found.

## 6. Mechanical coupling: decoupling the MEMS carrier; tripod and handling vibration

### Takeaway
MEMS membranes are ~20 dB less vibration-sensitive than electret capsules (InvenSense: 40 dB SPL-equivalent at 1 m/s²). Direct inertial pickup is therefore small. What reaches the recording is sound radiated by a vibrating shell around the port, so damping the shell (sand, firm clamps between parts) and isolating the tripod mount matter more than isolating the carrier. A soft-mounted carrier that can rock relative to the shell risks breaking flushness and the seal.

### Cited Findings
- Equivalent pressure from axial vibration is p_a = ρ·t·a (membrane density × thickness × acceleration). InvenSense MEMS (p-Si, 0.9 µm): 40 dB SPL at 1 m/s² and 60 dB at 1 g. A typical ECM (Mylar 10 µm): 57 / 77 dB. B&K ½" (metal 4 µm): 65 / 85 dB. "When the vibration produces sound at the microphone location, the microphone pickup of that sound is determined by its acoustic sensitivity" — [InvenSense AN-1003](https://www.cdiweb.com/datasheets/invensense/Mounting-Recommendations.pdf)
- IM73D122 qualification includes a vibration test, 20–2000 Hz per IEC 60068-2-6 (reliability, not sensitivity) — [Infineon IM73D122V01 datasheet](https://static.chipdip.ru/lib/911/DOC028911535.pdf)
- A 3D-printed turntable was designed to damp motor vibrations, and servomotor noise was broadband and intense relative to speech — [Lu et al., arXiv 2505.04548](https://arxiv.org/pdf/2505.04548)

### Inferences
- With 40 dB-equivalent at 1 m/s², tripod vibration from footsteps on a floor (assumed order of 0.01–0.1 m/s²) gives an equivalent of ~0–20 dB SPL by direct pickup. That is below the IM73D122 noise floor: 94 − 73 = 21 dB(A) SPL equivalent, computed from the datasheet SNR. The direct pickup is negligible. Shell radiation into the port and low-frequency rocking of the head on the tripod are the paths to control (inference).
- Mitigation: a sorbothane or rubber washer between the tripod screw insert and the slab, firm clamping between caps and slab (magnets alone may allow rattle at high SPL), and short soft cables so the cable doesn't transmit tug vibration (inference).
- Mic-to-mic crosstalk through the structure: the shell paths between ears are the same at both ears and carry very low energy. At the levels above it is negligible compared with acoustic crosstalk around the sphere (inference).

### Gaps
- No measurements found of tripod-borne noise in a printed head with MEMS mics.

## 7. DIY reports (diyAudio, Hackaday, others)

### Takeaway
The DIY reports found are about ear-shaped binaural heads with electret capsules, not spheres with MEMS. They raise comb filtering and head shading as expected effects, and debate whether printed material differs acoustically. None documents a construction defect specific to printed spheres.

### Cited Findings
- A diyAudio builder warns of "comb filtering and head shading" problems and suggests comparing with and without ears [search summary] — [diyAudio DIY binaural mics thread](https://www.diyaudio.com/community/threads/diy-binaural-mics.301897/page-2)
- A hobbyist who built several designs ranked a plain "dodge-ball" head lowest for realism and an anatomical ear model highest [search summary] — [Hackaday 2020](https://hackaday.com/2020/05/31/homebrew-binaural-microphone-lets-you-listen-like-a-human)
- A commenter argues that printed material lacks head-tissue acoustic characteristics [search summary; opinion] — [Hackaday 2015](https://hackaday.com/2015/06/28/3d-printing-binaural-microphones)

### Inferences
- The "material differs" argument does not apply to a measurement sphere, whose reference is a rigid sphere, not a human head. For a rigid-sphere reference, harder and denser is closer to the model.

### Gaps
- No diyAudio, Gearspace or Hackaday report was found of a printed sphere head with MEMS mics and documented port or seam problems. The forum threads were not opened in full; summaries above come from search results.
