# Sourcing the remaining parts (2026-11-26)

Research for the parts still missing after the first AliExpress order (mics, ESP32-S3, OLED, magnets,
dowel pins, nuts, M8 and 3/8"-16 bolts, bubble level). Shops checked: Galaxus, Bastelgarage, Conrad
(for data sheets) and AliExpress (CH storefront, prices in CHF). Prices are as quoted on 2026-11-26.

## Ordered

| Part | Shop | Listing | Price CHF | Why this one |
|---|---|---|---|---|
| Laser module | Galaxus | [Tru Components TC-9206124](https://www.galaxus.ch/de/s1/product/tru-components-modulo-laser-punto-rosso-095-mw-diode-21609471): red dot, class 2, 0.95 mW, Ø10 mm, 3 V, 40 mA | 7.20 | The only class 2 (< 1 mW) module found in CH. Bastelgarage stocks only 5 mW class 3R modules. Runs from the ESP32's 3V3 pin, so no AAA holder. Conrad gives "Ø10 mm × 16 cm"; the 16 cm is probably the length with the leads (not checked). |
| Cork granulate, 2 packs | Galaxus | [Mica Decorations Korkgranulat 5–10 mm, 600 ml](https://www.galaxus.ch/de/s14/product/mica-decorations-dekoration-korkgranulate-braun-5-10mm-600ml-naturmaterialien-77834261) | 2 × 12.00 | No 2–4 mm grade found in CH or on AliExpress. The fill port went from Ø14 to Ø30 (v3.3) to take 5–10 mm grain. |
| 3/8"-16 → 1/4"-20 reducer bushing, 4 pcs | AliExpress | item 1005012245910963, "4PCS" | 2.13 | The tripod screw measured 7 mm, i.e. 1/4"-20. The head keeps its 3/8"-16 nut because the sofa hook bolt and the optional stem use 3/8". The CHF 0.93 search price was a first-order deal; 2.13 is the real price. |
| Dupont jumpers, 40 cm M-F | AliExpress | item 1005009071621102, "40cm M-F" | 1.90 | The 20 cm jumpers on hand do not reach from the slab into the caps. |
| Double-sided foam tape, 15 mm × 10 m × 1 mm | AliExpress | item 1005003980172009 | 1.81 | Holds the ESP32. |
| Adhesive putty, 50 g | AliExpress | item 1005008099585945, "1pc 50g" | 2.96 | Seals the mic ring and the fill plug and holds the OLED cover (the README's "acoustic putty"). |
| EVA foam tape, 10 mm × 2 mm, 3 × 5 m | AliExpress | item 1005012986692324, "3Pcs/5m/2mm/10mm" | 2.72 | Wrapped round the USB plug where it passes the slot. |
| Electrical tape, 16 mm × 10 m | AliExpress | item 1005012184447338 | 2.11 | Insulation on the wiring. |
| USB-A → USB-C cable, 2 m, grey | AliExpress | Vumpach, item 1005004239746517 | 2.68 | Runs from the power bank down the stand. The user already has the power bank. |

AliExpress: 7 lines, CHF 16.31 with free shipping (Choice, free from CHF 9 of Choice items).
Galaxus: CHF 31.20 plus shipping (below the CHF 50 free-shipping threshold).

When read on 2026-11-26, six of the seven AliExpress lines were in the account's order list. The
EVA tape was not, although the cart was empty after checkout. Check it in the order list.

## Not needed

- **2×AAA battery holder** for the laser: the 3 V module runs from 3V3.
- **Power bank**: on hand.
- **Threaded rod** for the optional stem: removed from the cart. The stem is optional.

## Still open

- Fixing the mic carriers from inside: CA glue or silicone. Neither is ordered. Either is a local-shop item.
- Bench-test the laser at 3.3 V before fitting it. The listing does not say whether the module has its own driver.
