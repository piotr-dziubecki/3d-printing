# Commercial and DIY sphere microphones, sphere heads and dummy heads: physical design choices

Research date: 2026-11-23. Scope: products relevant to a 175 mm PLA sphere with two flush MEMS mics at ±90°, used at a listening seat for ITD/ILD/IACC.

Fetch notes: several manufacturer PDFs (B&K 5128 family, HEAD HMS V, GRAS 45BB-6, mh acoustics em64, IEC TS 60318-7:2011 preview, ISO 3382-1:2009 preview, Theile JAES 1991, Duda et al. 1999) were downloaded and their text extracted with `pdftotext`, so the figures quoted from them were read from the full document text, not from search snippets. 3Dio's own site returned HTTP 429 twice; its figures come from retailers.

## Q1. Physical design of each product (size, shape, mic placement, capsule, material, mass, mounting, torso, use)

### Takeaway
Two families exist. Spheres built for loudspeaker stereo (Neumann KFM 100, Schoeps KFM 6 at 200 mm, Schoeps KFM 360 at 180 mm) mount pressure capsules flush in the surface, with no pinnae. Measurement dummy heads (KU 100, HMS V, B&K 5128, KEMAR) follow ITU-T P.58 / IEC 60318-7 / ANSI S3.36 geometry, have pinnae and usually ear canals with an ear simulator, and weigh 3.5–11.5 kg. The 84 mm Eigenmike sphere is sized for spherical-harmonic beamforming, not for head simulation.

### Comparison table

| Product | Size | Shape | Mic placement | Mount type | Capsule | Mass | Mounting | Torso | Intended use | Sources |
|---|---|---|---|---|---|---|---|---|---|---|
| **Schoeps KFM 6 / KFM 6U** (Theile, IRT; discontinued) | 200 mm sphere | Sphere | Two capsules on the surface, "more than 180° apart" per recordinghacks (exact angle not given); Theile describes the mics as "placed on the sides of a sphere" | Flush ("mounted flush on the surface of a sphere 20 cm in diameter", per Schoeps product history, via search result) | Pressure (omni) transducers derived from MK 2XS (Schoeps); "modified Colette capsules, 13 mm diaphragm in 20 mm housing" (recordinghacks) | Conflicting: 1.1 kg (B&H) vs 500 g (recordinghacks; B&H gives 500 g for the suspension) | Wire hanger HKFM, ball-joint stand mount KG; an LED between the capsules aids aiming | No | Loudspeaker-stereo main microphone, 90° recording angle | [B&H](https://www.bhphotovideo.com/c/product/743597-REG/Schoeps_KFM_6_KFM6_Stereo_Sphere_Microphone.html); [recordinghacks](https://recordinghacks.com/microphones/Schoeps/KFM-6); [Schoeps product history](https://schoeps.de/en/about-schoeps/product-history.html); [Theile JAES 1991](https://hauptmikrofon.de/theile/1991-2_Naturelness-of-stereo_JAES-1991.PDF); [micpedia](https://micpedia.com/?p=6063) |
| **Schoeps KFM 360** (discontinued) | 180 mm sphere | Sphere plus two CCM 8L figure-8 mics mounted beside the pressure transducers | Pressure transducers "built into the sphere" | Built-in (flush not stated on the manual page read) | 2 pressure + 2 fig-8 (CCM 8L); DSP 4 KFM 360 processor for 5.1 | not found | not found | No | 5.1 surround; pickup angle about 120° | [KFM 360 manual p.3](https://www.manualsdir.com/manuals/593725/schoeps-kfm-360.html?page=3); [micpedia](https://micpedia.com/?p=6062) |
| **Neumann KFM 100** (historical) | Diameter not stated on Neumann page | Sphere | Two omni capsules | "Flush mounted in a sphere" | Omni | not found | not found | No | Dummy-head-like stereo "optimized for loudspeaker playback"; Neumann says it "never caught on" | [Neumann KFM 100](https://www.neumann.com/en-us/products/historical/kfm-100) |
| **Neumann KU 100** | Head 280 H × 180 W × 220 D mm | Head, no torso | Capsules "built into artificial ears"; canal vs. pinna depth not specified | In the ears | Two omni pressure condenser capsules; 20 mV/Pa; 16 dB(A) self-noise; 135/145 dB max SPL | ≈3.5 kg (≈9.5 kg in case) | 5/8"-27 female thread top or bottom, adapters for 1/2" and 3/8" | No | Binaural recording, diffuse-field equalized; also industrial noise documentation | [Neumann KU 100](https://www.neumann.com/en/products/microphones/ku-100/) |
| **HEAD acoustics HMS V** (code 1502) | 450 W × 400 H × 180 D mm (head and shoulders) | Head and shoulders; optional "HEAD Torso Box" | Not described in datasheet | not found | Internal measurement chain, "Dual ADC" HD auto range 130 dB SPL | 5.5 kg | 3/8" UNC (tripod), 2 × M6, camlock, seat mount HSM V | Shoulders built in; full torso with Torso Box | Sound-quality / NVH measurement; equalizations ID, FF, DF, LIN | [HMS V datasheet](https://documents.thermofisher.com/TFS-Assets/ANZ/Datasheets/head-acoustics-hms-v-artificial-head-1502.pdf) |
| **B&K / HBK 5128-B** (tabletop HF HATS) | Head height 290 mm; neck Ø 112 mm | Head on support foot | Pinna (ITU-T P.57) + anatomically shaped ear canal + occluded ear simulator at eardrum | In ear canal at eardrum position | Prepolarized ear-simulator mic; 13.0 mV/Pa at 250 Hz; 27.5 dB(A) noise | 6.8 kg | Support foot 3/8"-16 UNC, 15 mm thread depth | No | Headphone R&D | [HBK 5128 product data](https://www.bksv.com/-/media/literature/Product-Data/bp2573.ashx) |
| **B&K / HBK 5128-C / -D** (HF HATS) | Total 695 mm; torso 460 H × 410 W × 183 D mm | Head + torso; head vertical or tilted 17° forward | As 5128-B; pinna Shore-OO 35 | Ear canal, eardrum mic | as above | 9 kg | not found | Yes | Headphones, handsets, headsets, hearing aids; mouth simulator to P.58 | [HBK 5128 product data](https://www.bksv.com/-/media/literature/Product-Data/bp2573.ashx); [HBK P.58/P.57 approval news](https://www.bksv.com/news/hats-5128-standardisation) |
| **B&K 4128-C / -D** (older HATS, first released 1986) | not found | Head + torso | Ear simulators 4158-C (right), 4159-C (left) | Occluded ear simulator | not found | not found | not found | Yes | Telephonometry, binaural | [HBK 4128-C page](https://www.hbkworld.com/en/products/integrated-systems/electroacoustics/head-and-torso-simulators-hats/head-and-torso-simulator-4128-c); [HBK "green man" article](https://www.bksv.com/knowledge/blog/sound/the-green-man-the-next-chapter) |
| **GRAS KEMAR 45BB / 45BC** | Same dimensions as 1972 Knowles KEMAR (numbers not in the datasheet text) | Head + torso | Pinna KB0065/66 (large, 55 Shore OO) + ear-canal extension + IEC 60318-4 ear simulator (RA0045) | Ear simulator at eardrum | IEC 60318-4 occluded ear simulator, 1/2" mic; 45BB-5 sensitivity 12.5 mV/Pa | 45BB-6: 11.45 kg | not found | Yes | Hearing aids, headsets, audiology; 45BC adds a mouth simulator | [GRAS 45BB-6 datasheet](https://cdn.shopify.com/s/files/1/0755/9344/9805/files/GRAS_45BB-6.pdf); [GRAS 45BC-10](https://cdn.shopify.com/s/files/1/0755/9344/9805/files/GRAS_45BC-10.pdf); [GRAS 45BB-5](https://cdn.shopify.com/s/files/1/0755/9344/9805/files/GRAS_45BB-5.pdf) |
| **Jecklin disc / OSS** (Haun) | Original: 300 mm disc, 165 mm mic spacing; Jecklin's revision: 350 mm disc, 360 mm spacing | Absorptive disc about 20 mm thick, foam or fleece faced | Two omnis either side of the disc | Spaced off the baffle | Omnis (user-supplied) | not found | Stand | No | Stereo recording | [Wikipedia: Jecklin disk](https://en.wikipedia.org/wiki/Jecklin_disk); [Sengpiel PDF](https://www.SengpielAudio.com/JecklinDisk.pdf); [Thomann Haun OSS](https://www.thomannmusic.com/haun_oss_jecklinscheibe.htm) |
| **Schneider disc** | 300 mm disc + 120 mm foam-covered sphere at centre | Disc + sphere | Mics about 165 mm apart, angled out 20° | Spaced | n/a | not found | Stand | No | Stereo recording | [Sound On Sound glossary](https://www.soundonsound.com/glossary/schneider-disc) |
| **Sennheiser MKE 2002** (1970s) | n/a | Mics on a stethoscope-style headset worn by a person; dummy head supplied for unworn use | At the wearer's ears | Ear-worn | not found | not found | not found | No | Binaural recording | [MKE 2002 manual](https://www.manualowl.com/m/Sennheiser/MKE-2002/Manual/358082?page=5); [Tape Op #47](https://new.tapeop.com/tutorials/47/dummy-head-mic) |
| **3Dio Free Space XLR** | 190 × 110 × 110 mm | Bar with two silicone ears, no head | Capsules inside the prosthetic ear canals | Ear canal | Primo EM172 electret (the Pro II used DPA 4060 at the canal opening) | 755 g | Mic-stand adapter | No | Binaural recording | [Adorama](https://www.adorama.com/3dio-free-space-xlr-binaural-microphone/p/3dfsxlr); [Perfect Circuit](https://www.perfectcircuit.com/3dio-fs-free-space-xlr.html) |
| **mh acoustics Eigenmike em32** | 84 mm sphere | Rigid sphere | 32 capsules | Embedded in a rigid baffle | 14 mm electret | not found | not found | No | Higher-order Ambisonics; superseded by em64 | [em32 release notes](https://mhacoustics.com/sites/default/files/EigenmikeReleaseNotesV15.pdf); [DPA dictionary](https://www.dpamicrophones.com/dictionary/e/eigen-mike); [eigenmike.com em32](https://eigenmike.com/eigenmike-em32) |
| **mh acoustics Eigenmike em64** | 84 mm sphere; 280 mm overall height with shaft | Rigid sphere, all electronics inside | 64 capsules | Mounted on the rigid baffle | Omni electret; HOA aliasing > 12 kHz; up to 6th order | 0.75 kg | Shock mount with 3/8" and 5/8" threads; PoE/Dante | No | Spatial / HOA recording and beamforming | [em64 datasheet](https://eigenmike.com/sites/default/files/documentation-2023-12/em64%20Eigenmike%20Datasheet.pdf) |
| **CCRMA (Stanford) 32-channel open-source sphere** (DIY) | 200 mm sphere (100 mm radius) | 3D-printed sphere in two separable hemispheres | Dodecahedron vertices and face centres | Capsules on preamp boards, press-fit into the baffle | Not stated | not found | 20 mm cylindrical stand doubles as cable conduit | No | Spatial room impulse responses | [CCRMA MaxLab](https://ccrma.stanford.edu/wp/maxlab/?p=91) |
| **NIH 3D Print Exchange spherical MEMS array** (DIY) | Min. radius 50 mm | Modular sphere, 19 channels on an icosahedron layout | — | — | MEMS | not found | not found | No | Spatial array | [NIH 3D entry, via search result](https://3d.nih.gov/entries/3DPX-009017/2) |
| **Robotic 3D-printed dummy head** (arXiv 2505.04548, open source) | not found | 3D-printed head on a robot | Two mics in ear canals (per search summary) | Ear canal | not found | not found | Robot | — | Automated binaural experiments; ITD reported within 62.5 µs of KEMAR at 90° and 67.9 µs RMS across orientations (search summary, full paper not read) | [arXiv 2505.04548](https://arxiv.org/abs/2505.04548) |

### Cited Findings (design-rationale detail not captured in the table)
- Theile's sphere microphone uses "two boundary-layer microphones placed on the sides of a sphere" and produces signals "composed of natural interaural" differences. Dummy-head pinna cues for front/back would "cause coloration problems" over loudspeakers, so the sphere omits pinnae. — [Theile, JAES 39(10) 1991](https://hauptmikrofon.de/theile/1991-2_Naturelness-of-stereo_JAES-1991.PDF)
- The KFM 6U response is linear for frontal (0°) incidence, the summed L+R energy is frequency independent for lateral sources, and the response is linear for the diffuse field. The pressure capsules "sharply reduce sensitivity to air motion" and extend to the lower limit of hearing. — [Theile 1991](https://hauptmikrofon.de/theile/1991-2_Naturelness-of-stereo_JAES-1991.PDF)
- The original reference is G. Theile, "Das Kugelflächenmikrofon", Proc. 14th Tonmeistertagung, pp. 277–293 (1986). — [Theile 1991, ref. 10](https://hauptmikrofon.de/theile/1991-2_Naturelness-of-stereo_JAES-1991.PDF)
- Dates conflict: recordinghacks gives 1990 for development and release, while Theile's paper is from 1986. — [recordinghacks](https://recordinghacks.com/microphones/Schoeps/KFM-6); [Theile 1991](https://hauptmikrofon.de/theile/1991-2_Naturelness-of-stereo_JAES-1991.PDF)
- The KFM 360 sphere is smaller than the KFM 6's "in order to increase the stereo pickup angle" (micpedia, via search result). — [micpedia KFM 360](https://micpedia.com/?p=6062)
- In the KFM 360's "B: SURR" mode, the processor applies diffuse-field equalization to the pressure transducers. — [KFM 360 manual](https://www.manualsdir.com/manuals/593725/schoeps-kfm-360.html?page=3)
- The 5128 occluded ear simulator "simulates the inner part of the ear, from the ear drum inwards". The pinna is removable silicone rubber with a quick-release button. Left–right ear tracking is better than ±1 dB to 5 kHz and ±3 dB to 20 kHz. — [HBK 5128 product data](https://www.bksv.com/-/media/literature/Product-Data/bp2573.ashx)
- A real head's ears are "not positioned across a diameter, but are displaced behind and below the center of the head". Duda et al. model this with an ellipsoid with offset ears to reproduce how ITD varies with elevation. A centred-ear sphere gives cones of confusion symmetric about the interaural axis (Woodworth formula). — [Duda, Avendano & Algazi 1999](https://escholarship.org/content/qt8jk3n8tc/qt8jk3n8tc.pdf?t=ptt2x7)

### Inferences
- No measurement-grade product puts flush mics on a bare sphere for ITD/ILD/IACC at a listening seat. The flush-sphere precedent is the Theile/Schoeps/Neumann recording family; measurement instruments are anthropometric HATS. The design here is a hybrid: KFM-style geometry used for measurement.
- Every capsule in a flush sphere is a pressure (omni) transducer. The IM73D122 MEMS is also a pressure-type omni, so it matches the concept. (Inferred: the IM73D122 datasheet was not checked in this note.)
- The 3D-printed precedents (CCRMA 200 mm, NIH array) use two hemispheres and press-fit capsule boards, with a slim stand that doubles as the cable route. This matches the PLA two-shell plan.

### Gaps
- **Schalltechnik / "Schalltec":** no product found. The name may refer to Schalltechnik Dr.-Ing. Klaus Genuit (HEAD acoustics' founder) or be a misremembering; not verified.
- **Microtech Gefell sphere / KFM-type:** no source found.
- **AKG Kugelflächenmikrofon:** no source found.
- **Core Sound binaural:** the product URL returned 404; no specifications collected.
- **Neumann KFM 100 diameter:** not on the Neumann page (commonly said to be 20 cm, unverified).
- **KFM 6 exact capsule angle:** "more than 180° apart" (recordinghacks) is ambiguous. Theile's Fig. 3 is a scanned image and was not legible.
- **HEAD acoustics HMS microphone position** (ear canal entrance vs. eardrum) and **KEMAR head breadth in mm:** not in the datasheet text read.
- **B&K 4128 weight and microphone size:** not found.
- **ESP32/MEMS binaural sphere projects:** no GitHub, Hackaday or diyAudio project matching "ESP32 + MEMS + sphere head" was found. Nearest are ESP32 two-MEMS direction-finding repos ([EkinUgurr/sound-localization-esp32](https://github.com/EkinUgurr/sound-localization-esp32), [matrn/AcousticDetection](https://github.com/matrn/AcousticDetection)) and an ESP32-S2 binaural recorder firmware ([ICantMakeThings/StereoRecorder](https://awesome.ecosyste.ms/projects/github.com%2Ficantmakethings%2Fstereorecorder)), none with a sphere.
- **Room-acoustics "dummy sphere" for ISO 3382 IACC:** no dedicated product found. ISO 3382-1 Annex B refers to head-and-torso simulators (see Q3).

## Q2. Prices where public

### Takeaway
Most current list prices are not published. The public figures are historic Schoeps prices and the 3Dio Free Space XLR at about USD 649.

### Cited Findings
- Schoeps KFM 6: MSRP USD 8,212 (recordinghacks; date not given). — [recordinghacks](https://recordinghacks.com/microphones/Schoeps/KFM-6)
- Schoeps KFM 360: USD 5,550, plus DSP-4 processor USD 6,305 (Mix review, Feb 2007). — [Mix, via search result](https://www.mixonline.com/?p=93765)
- 3Dio Free Space XLR: USD 649 (Perfect Circuit and 3Dio store); GBP 648 (Studiospares). — [Perfect Circuit](https://www.perfectcircuit.com/3dio-fs-free-space-xlr.html); [Studiospares](https://www.studiospares.com/3dio-free-space-xlr-binaural-microphone-329290.htm)
- Neumann KU 100: Neumann's page lists no price and links to retailers. Bax Music marks it discontinued. — [Neumann](https://www.neumann.com/en/products/microphones/ku-100/); [Bax](https://www.bax-shop.co.uk/small-diaphragm-condenser-microphones/neumann-ku-100-dummy-head-microphone)

### Inferences
- HATS (HBK 5128, GRAS KEMAR, HEAD HMS) are sold on quotation. Prices are commonly understood to run to five figures in USD/EUR, but none was found in a primary source.

### Gaps
- No public price found for KU 100 (2026), HMS V, 5128, KEMAR 45BB/45BC, Eigenmike em64 or the Jecklin OSS disc. (The Thomann pages exist but the price was not read.)

## Q3. Standards compliance and what the standards dictate geometrically

### Takeaway
ITU-T P.58, IEC 60318-7 (formerly IEC TR 60959) and ANSI S3.36 all specify an anthropometric head *and torso* manikin with pinnae and ear simulators, built to median adult dimensions. A sphere cannot comply with any of them. ISO 3382-1 contributes only a microphone height of 1.2 m and an informative annex on binaural measurement with dummy heads.

### Cited Findings
- **HBK 5128-B:** head geometry complies with ITU-T P.58, IEC 60318-7 and ANSI S3.36. **5128-C/-D:** head and torso geometry complies. HBK notes that IEC 60318-7 was formerly IEC 60959. — [HBK 5128 product data](https://www.bksv.com/-/media/literature/Product-Data/bp2573.ashx)
- ITU-T approved HBK 5128 and ear simulator 4620 as standardized solutions for P.58 (HATS) and P.57 (ear simulator). — [HBK news](https://www.bksv.com/news/hats-5128-standardisation)
- **GRAS KEMAR:** meets ANSI S3.36/ASA58-2012 and IEC 60318-7:2011. The ear simulator complies with IEC 60318-4 and ITU-T P.57 Type 3.3, based on P.58. — [GRAS 45BB-6 datasheet](https://cdn.shopify.com/s/files/1/0755/9344/9805/files/GRAS_45BB-6.pdf)
- **HEAD HMS V:** head dimensions are "designed according to ITU P.58, table 1 and comparable to ANSI 3.36, table 1". Without the HEAD Torso Box, some Table 1 dimensions do not apply. Monaural frequency responses comply with P.58 Table 4. — [HMS V datasheet](https://documents.thermofisher.com/TFS-Assets/ANZ/Datasheets/head-acoustics-hms-v-artificial-head-1502.pdf)
- **IEC TS 60318-7:2011 scope:**
  - Hearing-aid measurement from 100 Hz to 10 kHz, using a head on a torso to the waist, with simulated pinnae and cylindrical cavities with acoustic impedance terminations.
  - Microphones sit at "positions corresponding to those of the eardrums in a median human adult", designed for diffraction "similar to that encountered around the median human head and torso".
  - The standard tabulates dimensions: Table 1 head and torso; head cross-sections ±2.5 mm; torso ±4 mm; pinna ±1.5 mm.
  - It is a revision of IEC/TR 60959 (1990).
  - It defines the manikin's reference point as the point bisecting the line between the centres of the ear-canal openings. Azimuth is 0° facing the source and +90° with the right ear facing the source.
  - Its NOTE 3 says designs used beyond the standard's scope should document their variations.
  — [IEC TS 60318-7:2011 preview](https://cdn.standards.iteh.ai/samples/17312/24b8f93023b7409ca72e26ddd126e437/IEC-TS-60318-7-2011.pdf)
- **ITU-T P.58:** Section 4 specifies the physical dimensions of torso, head and pinna. The current edition is 2023-03. — [ITU-T P.58 TOC](https://www.itu.int/dms_pubrec/itu-t/rec/p/T-REC-P.58-201305-S!!TOC-HTM-E.htm); [P.58 2023 summary](https://www.itu.int/dms_pubrec/itu-t/rec/p/T-REC-P.58-202303-I!!SUM-HTM-E.htm)
- **ISO 3382-1:2009:** "the height of the microphones above the floor should be 1,2 m, corresponding to the ear height of average listeners in typical chairs". Microphones must be at least a quarter wavelength from the nearest reflecting surface. Annex B (informative) "introduces binaural measurements and the head and torso simulators (dummy heads) required to make binaural measurements". IACC is derived there. — [ISO 3382-1:2009 preview](https://cdn.standards.iteh.ai/samples/40979/b0e9f87f3d9f4df6b18f767e3439bfb6/ISO-3382-1-2009.pdf)

### Inferences
- For this project, the useful part of the standards is the coordinate convention: reference point midway between the ears, azimuth 0° front, +90° right ear (IEC 60318-7). The ISO 3382-1 seat height of 1.2 m is a sensible default for the ear axis when the tripod is set up.
- IACC from a sphere will not equal IACC from an ISO 3382-1 Annex B dummy head, because there is no pinna or torso. Results should be reported as sphere-referenced, not ISO-comparable. (Inferred.)

### Gaps
- Numeric values from P.58 Table 1 / IEC 60318-7 Table 1 (head breadth, ear-canal entrance position relative to head centre) are paywalled and absent from the previews. They were not verified, and no numbers are given here.
- The text of ISO 3382-1 Annex B (dummy-head requirements) is not in the preview.
- The ANSI S3.36 text was not accessed.

## Q4. Patterns: diameter clustering, mic offsets from ±90°, and why

### Takeaway
Head-simulating spheres cluster at 180–200 mm. That brackets the dummy-head widths (KU 100 180 mm wide) and sits just above 175 mm. Measurement arrays (Eigenmike, 84 mm) are sized by beamforming, not anatomy. No flush-sphere product documents an offset from ±90° in a source read here. Real ears sit behind and below the head centre, and HATS reproduce that through anthropometric geometry.

### Cited Findings
- Sphere diameters: KFM 6 200 mm; KFM 360 180 mm; CCRMA DIY 200 mm; Eigenmike 84 mm. — [B&H](https://www.bhphotovideo.com/c/product/743597-REG/Schoeps_KFM_6_KFM6_Stereo_Sphere_Microphone.html); [KFM 360 manual](https://www.manualsdir.com/manuals/593725/schoeps-kfm-360.html?page=3); [CCRMA](https://ccrma.stanford.edu/wp/maxlab/?p=91); [em64 datasheet](https://eigenmike.com/sites/default/files/documentation-2023-12/em64%20Eigenmike%20Datasheet.pdf)
- Head widths: KU 100 is 180 mm wide and 220 mm deep. — [Neumann](https://www.neumann.com/en/products/microphones/ku-100/)
- Schoeps made the KFM 360 sphere smaller (180 vs. 200 mm) to widen the stereo pickup angle (about 120° vs. 90°). Sphere size is a tuning parameter for the ITD/ILD-versus-angle mapping. — [micpedia KFM 360](https://micpedia.com/?p=6062); [KFM 360 manual](https://www.manualsdir.com/manuals/593725/schoeps-kfm-360.html?page=3); [B&H KFM 6](https://www.bhphotovideo.com/c/product/743597-REG/Schoeps_KFM_6_KFM6_Stereo_Sphere_Microphone.html)
- Ears on real heads are displaced behind and below the head centre. A sphere with diametrically opposite ears misses the elevation dependence of ITD. — [Duda et al. 1999](https://escholarship.org/content/qt8jk3n8tc/qt8jk3n8tc.pdf?t=ptt2x7)
- Algazi, Avendano and Duda fitted an "optimal" sphere radius to high-frequency ITDs of 25 subjects, with an anthropometric prediction equation (abstract via search result; the radius value was not read). — [AES e-library 10188](https://secure.aes.org/forum/pubs/journal/?elib=10188)
- The KFM 6 capsules are described as "more than 180° apart" (recordinghacks). If that means measured around the back, it would imply a rearward offset; the source is ambiguous. — [recordinghacks](https://recordinghacks.com/microphones/Schoeps/KFM-6)
- Mass: flush spheres and arrays weigh 0.5–1.1 kg; dummy heads 3.5 kg (KU 100); HATS 5.5–11.45 kg. — sources in the Q1 table.
- Mount threads: 3/8"-16 UNC (HBK 5128-B, HMS V), 5/8"-27 (KU 100), 3/8" and 5/8" (em64). None of the sources read lists a 1/4"-20 thread on a measurement head. — sources in the Q1 table.

### Inferences
- 175 mm is about 3% below the KU 100's 180 mm width and 12.5% below the KFM 6's 200 mm. ITD for a sphere scales linearly with radius (Woodworth formula, as cited by Duda et al.), so a 175 mm sphere gives about 12.5% less ITD than a KFM 6. Whether 175 mm suits the population target depends on the optimal-radius figure from Algazi et al., which was not verified here.
- For seat-level stereo-imaging diagnosis, ±90° on a diameter (KFM convention) keeps the interaural axis symmetric front–back and makes ITD a clean function of azimuth. A rearward or downward offset would mimic human ears better but bring in elevation-dependent ITD. The precedent favours ±90° for a loudspeaker-referred tool. (Inferred.)
- Commercial measurement heads use 3/8"-16 or 5/8"-27 mounts. A 1/4"-20 mount fits a 1–2 kg sphere and camera tripods, but a 3/8"-16 insert, or a 1/4"→3/8" bushing, would fit professional mic stands. (Inferred.)
- The sand-filled caps raise the mass toward the em64/KFM range (0.75–1.1 kg). No source read discusses damping fill. (Inferred.)

### Gaps
- No primary source gives the exact angular position of capsules on the KFM 6, KFM 100 or KFM 360.
- The Algazi et al. optimal head radius was not read from the primary source (commonly cited as about 87 mm, i.e. a sphere diameter of about 175 mm). This is unverified and could not be confirmed this session.
- No documentation was found on the surface finish or material of the KFM spheres.
