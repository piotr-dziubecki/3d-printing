// === DESCRIPTION ===
// Binaural sphere head: a 175 mm spherical "dummy head" measurement fixture for room acoustics.
// Two Infineon IM73D122 PDM MEMS microphones (each on its round carrier PCB) sit flush in the
// sphere surface at the ear points, diametrically opposite on the horizontal great circle
// (±90° from the front). One ESP32-S3 DevKitC-1 clone inside records both mics as stereo PDM
// (shared CLK/DATA, L/R select pin to GND on one mic and VDD on the other) so the two ears
// share a clock. Used at a listening seat to measure ITD, ILD and IACC for stereo imaging.
// v3: portable — an 18650 cell in a holder plus a 1-cell charge/boost module (USB-C charge port and
// a toggle switch on the back-bottom) power it; a printed hook hangs it over a sofa backrest.
// Cap chambers are filled with cork granulate (sand is optional, on the stem only).
//
// Physical context: stands on a 200 mm printed stem (3/8"-16 rod into a nut at the bottom; the
// stem takes a 1/4"-20 tripod screw), indoors, static. Loads: its own weight (~0.7 kg empty,
// ~1.0 kg with cork in the chambers, ~2.4 kg with sand) on the stem pad and nut, and hand forces when opening. An SSD1306 0.96" OLED looks out through a window
// on the back; a USB-C cable to an external power bank plugs in through a slot on the back.
//
// Design decisions:
//   - Split into THREE parts along the ear axis (X): right cap, centre slab, left cap. The two
//     seams are planes at x = ±slab_half (20 mm) — 67.5 mm from each ear. One central (sagittal)
//     split would be 87.5 mm away but puts the electronics, tripod nut and display on the seam;
//     the 40 mm slab is the narrowest that holds them (jumper room is asserted). A plain hemisphere split on the
//     vertical plane through the ears would put the seam across both ears; the sagittal
//     hemisphere split puts electronics, mount and display on the seam. The slab carries all of
//     them, so each cap is a simple closed fill chamber with an ear on top.
//   - Each cap prints seam face down, ear up: the mic pocket is then a vertical bore (round,
//     exact), the outer dome has no overhang, and the closed fill chamber's ceiling is held to
//     <= ceiling_overhang (55°) from vertical by a 45° flare that rises from the wire conduit to
//     the shell. That flare also makes the ear region a thick solid in CAD; print it dense
//     (>= 40% infill modifier on the cap tops) so it is stiff in the part too. The chamber is sealed: printed floor (the seam plate), shell, conduit tube, flare.
//   - The slab prints flat on its left face. Everything inside it (board cradle, OLED channel,
//     tripod boss, joint tabs) is a prism along X, i.e. vertical walls in print: support-free.
//   - Joints: 3 mm steel dowel pins locate, 10×3 mm neodymium magnets clamp. No screw or seam
//     crosses the ear regions; the outer surface has only the two seams, the OLED window and
//     USB slot (back), the 0.5 mm front notch, the top flat + aiming groove and the bottom flat.
//   - v2 (from the research report in reports/): aiming needs ±1° yaw (9-13 µs ITD per degree),
//     so a top flat + V groove keys a removable sight bar (pen laser + bubble level); a 3/8"-16
//     nut and a thin 200 mm stem keep the tripod-head reflection late; a flush cover closes the
//     OLED window while measuring. 175 mm and ±90° ears were kept (the research supports both).
//   - Walls 4.5 mm = 10 extrusion lines; caps and slab have 4.5 mm shells, the ear region is solid.
//
// Terminology → code:
//   "sphere / head"           → head_d, wall_lines → wall, head_revolve()
//   "caps / ears side"        → cap_local(), cap_right_print(), cap_left_print(), slab_half
//   "fill chamber"            → chamber_2d(), ceiling_overhang, plate_t; "fill port/plug" → fill_*
//   "wire conduit"            → conduit_id, conduit_wall
//   "mic pocket / carrier"    → mic_pcb_d, mic_pcb_t, mic_port_offset, mic_ledge, mic_pocket()
//   "slab / middle ring"      → slab_head(), slab_print()
//   "board cradle"            → board_*, board_angle, board_cradle()
//   "OLED window / channel"   → oled_*, oled_angle, oled_holder(), oled_window()
//   "USB slot"                → usb_*
//   "tripod nut"              → tnut_*, tripod_boss(), tripod_cut(); "bottom flat" → flat_d
//   "joint tabs / magnets / pins" → tab_*, mag_*, pin_*
//   "front notch"             → notch_*
//   "aiming groove / sight bar" → sight_flat_d, groove_d, sight_*, laser_v_d, vial_*, sight_bar_*()
//   "stand stem"              → stem_*, tpod_*, rod_protrude, rod_len, stem()
//   "OLED cover"              → cover_fit, cover_gap, oled_cover_*()
//   "battery / 18650 holder"  → bat_*, bat_cradle(), bat_cut(); "charge module" → pm_*; "switch" → sw_*
//   "sofa hook"               → backrest_t, head_fwd, head_up, hook_*, arm_*, hinge_*, hook_saddle_*(), hook_arm_*()
//
// Common modifications:
//   Measured mic carrier     → mic_pcb_d, mic_pcb_t, mic_port_offset, mic_ledge (asserted: ledge
//                              leaves >= 10 mm bore for header housings)
//   Measured ESP32 board     → board_len, board_w, board_comp_h; board_angle moves it around the back
//   Measured OLED module     → oled_w, oled_h, oled_stack, oled_win_*
//   Different head size      → head_d (keep caps within 256 mm bed: asserted)
//   Thicker/thinner seams    → slab_half (>= 18 mm: the jumper room under the board is asserted)
//   Other head thread        → tnut_af/tnut_t/tbolt_d (3/8"-16 default; asserted >= 3 mm boss wall)
//   Your bubble level        → vial_d, vial_h; longer stem → stem_h (rod_len is echoed)
//   Your sofa                → backrest_t (<= ~230 to fit the bed), head_up (ear axis vs backrest top)
//   Other battery / module   → bat_len/w/h, pm_len/w/comp_h (asserted clear of tabs, conduits, ESP32)
//   Steeper chamber ceiling  → ceiling_overhang (55° default; above ~60° the PLA ceiling sags)
//
// Overall dimensions: sphere Ø175; caps 170.3 × 170.3 × 67.5 mm (print), slab 170.3 × 170.3 × 40 mm
//   (print), hook saddle 208 × 152 × 30 mm — each fits the Bambu P2S (and X1C) 256 × 256 × 256 mm bed.
// Coordinate system (head / assembly): origin = sphere centre, X = ear axis (+X right ear),
//   Y = front (+Y, the nose), Z = up. In print, each cap's ear axis is +Z (seam face on Z=0) and
//   the slab's X becomes Z (left face on Z=0).
// NOTE: printed parts are modelled in print orientation (cap_right, cap_left, slab, fill_plug).
// Final review: 2026-11-22, claude-fable-5-2 (after a claude-sonnet-5-5 review); findings fixed.
//   v2 and v3 changes reviewed 2026-11-23 on claude-sonnet-5-5.

// === PRINT SETTINGS ===
// Material: PLA (stiff — less shell vibration than PETG, best dimensional accuracy, indoor use).
//   PETG also works: raise hole_comp/fit values per the PETG material notes.
// Layer Height: 0.2 mm (0.16 mm on the caps for a smoother dome is optional).
// Walls/Perimeters: 4 (1.8 mm). Top/bottom shell layers: 5.
// Infill: 15% gyroid; add a 40% modifier on the top 25 mm of each cap (the solid around the ear)
//   and print the slab at 25% (tripod boss).
// Supports: None. Caps: dome outside has no overhang; the sealed chamber ceiling is <= 55° and
//   invisible. Slab: every internal feature is a vertical prism; window/USB tops are bridges
//   (OLED window 21 mm, USB slot 24 mm). The gate's overhang report on the caps is that interior chamber ceiling.
// Orientation: as modelled. Caps seam face down (ear up), slab left face down, plug flange down,
//   sight bar top face down, stem upright (base down), OLED cover inner face down,
//   hook saddle and arm lying flat (profile on the bed).
// Notes: PLA 200-220 °C (Bambu PLA Basic preset 220) / bed 60 °C. Brim not needed (full-disc footprint on caps). The caps are
//   hollow sealed chambers: do not enable "remove small gaps" or anything that fills cavities.

// === PARAMETERS ===
/* [Printer] */
nozzle_diameter = 0.4;
layer_height    = 0.2;
bed_xy          = 256;   // Bambu P2S (same as X1C / P1S)
bed_z           = 256;

/* [Head] */
head_d       = 175;      // outer sphere diameter
wall_lines   = 10;       // shell = 10 × 0.45 = 4.5 mm
slab_half    = 20;       // seam planes at x = ±slab_half
plate_t      = 3.2;      // cap seam plate (fill chamber floor), 16 layers
ceiling_overhang = 55;   // max chamber ceiling angle from vertical (deg)
flat_d       = 30;       // flat at the bottom so it sits on a tripod plate

/* [Wire conduit] */
conduit_id   = 16;       // ear-to-bay wire tube, takes two 3-pin Dupont housings
conduit_wall = 2.7;      // 6 lines

/* [Microphone carrier — PLACEHOLDERS, measure!] */
mic_pcb_d       = 15.0;  // PLACEHOLDER carrier PCB diameter
mic_pcb_t       = 1.6;   // PLACEHOLDER carrier PCB thickness
mic_port_offset = 0.0;   // PLACEHOLDER acoustic port distance from PCB centre (pocket shifts so
                         //   the PORT sits on the ear axis)
mic_ledge       = 1.0;   // seat ring under the PCB rim (must miss the header housings)
mic_fit         = 0.15;  // diametral slip allowance on the carrier

/* [ESP32-S3 DevKitC-1 clone — PLACEHOLDERS, measure!] */
board_len    = 69.0;     // PLACEHOLDER (official DevKitC-1 is 62.74; N16R8 clones ~69)
board_w      = 26.0;     // PLACEHOLDER (official 25.4)
board_t      = 1.6;
board_comp_h = 3.5;      // tallest part on top (module shield / USB-C)
board_tol    = 0.4;      // per side, around the outline
board_web_t  = 4.05;     // web under the board, 9 lines
board_angle  = 195;      // direction of the USB end in the Y-Z plane: 0 front, 90 up, 180 back
board_jumper_room = 22;  // header plastic 2.5 + Dupont housing 14 + bend, under the PCB
usb_open_w   = 24;       // slot across the board end (covers both USB-C on dual-port clones)
usb_open_h   = 9;        // slot height along X
usb_h        = 3.2;      // USB-C receptacle height (centre = PCB top + usb_h/2)

/* [SSD1306 0.96" OLED — PLACEHOLDERS, measure!] */
oled_w       = 27.3;     // PLACEHOLDER module width (display long axis), along X
oled_h       = 27.8;     // PLACEHOLDER module height (header edge on top)
oled_stack   = 3.0;      // PLACEHOLDER glass + tape + PCB thickness
oled_win_w   = 24;       // window along X (active area ~21.7)
oled_win_h   = 17;       // window height (active area ~10.9; tall so an unmeasured offset still shows it all)
oled_win_flare = 4.0;    // tangential widening per side at the surface (keeps the top bridge <= 21 mm)
oled_win_off = 0.0;      // PLACEHOLDER active-area centre offset from the module centre, + = away from the header
oled_angle   = 155;      // module centre direction in the Y-Z plane (back, 25° up)
oled_face_r  = 82.5;     // radius of the flat the glass presses against
oled_tol     = 0.3;
oled_lip     = 2.0;      // lip behind the bottom edge of the OLED PCB

/* [Joint] */
tab_angles   = [10, 70, 120, 240, 300];
tab_r_in     = 58;       // tab inner face radius
tab_w        = 16;
mag_d        = 10;       // magnet disc diameter
mag_t        = 3;        // magnet disc thickness
mag_r        = 73;       // magnet centre radius
pin_d        = 3;        // steel dowel diameter
pin_len      = 12;
pin_r        = 63;       // dowel centre radius

/* [Fill port] */
fill_d       = 14;
fill_r       = 45;
fill_angle   = 90;

/* [Tripod] */
tnut_af      = 14.29;    // 3/8"-16 hex nut across flats (9/16"), the measurement-head standard
tnut_t       = 8.33;     // nut thickness (21/64")
tbolt_d      = 9.525;    // 3/8"; 1/4"-20 tripods use a 3/8"->1/4" brass reducer bushing in the nut
tnut_floor   = 2.0;      // plastic under the nut (the bushing or stem rod passes through it)
tbolt_extra  = 8.0;      // bore above the nut for long tripod screws
tboss_w      = 24;       // boss width (Y)
tboss_h      = 26;       // boss height (Z) above the flat

/* [Front notch] */
notch_len    = 16;       // along X
notch_depth  = 0.5;      // 90° V, 1 mm wide: a faint mark, least disturbance in the forward field (was 1.5)

/* [Pry notches] */
pry_angle    = 225;      // bottom-back, on both seams
pry_w        = 10;
pry_depth    = 2.0;
pry_h        = 2.0;      // along X into the slab

/* [Sight (top): aiming groove and sight bar] */
sight_flat_d = 30;       // flat on top of the slab that the sight bar sits on
groove_d     = 1.0;      // 90° V groove along Y on the flat (width 2 × groove_d), keys the bar
sight_len    = 70;       // bar along Y
sight_w      = 54;       // bar along X
sight_t      = 6;        // bar thickness
laser_v_d    = 4.0;      // 90° V cradle along Y on top of the bar (pen lasers up to ~Ø14)
vial_d       = 15.0;     // PLACEHOLDER bullseye bubble level diameter
vial_h       = 7.0;      // PLACEHOLDER bullseye level height
vial_x       = 17.0;     // vial pocket centre, clear of the largest laser
laser_d_max  = 14;       // largest pen laser the cradle takes (rests on the cradle edges above ~Ø11)

/* [Stand stem] */
stem_h       = 200;      // stem length, NOT the rod length (see rod_cut); tripod plate to head flat; >= 150 pushes the tripod-head reflection past ~1 ms
stem_d       = 16;       // thin shaft
stem_pad_d   = 24;       // top pad under the head's bottom flat (flat_d = 30)
stem_pad_h   = 3;
stem_base_d  = 34;
stem_base_h  = 26;       // holds the 1/4"-20 tripod nut and the 3/8"-16 rod nut
tpod_af      = 11.11;    // 1/4"-20 nut for the tripod screw (7/16")
tpod_t       = 5.56;
tpod_d       = 6.35;
rod_protrude = 13.5;     // design target: 3/8"-16 rod above the pad, through the head nut
rod_cut      = 203;      // rod length listed in the README (rounded up from the echoed rod_len)

/* [OLED cover] */
cover_fit    = 0.15;     // clearance on the window walls
cover_gap    = 0.5;      // air above the OLED glass
cover_flare_gap = 0.05;  // deliberate clearance on the flares, so the cover can be lifted out
cover_pry_w  = 4;        // fingernail notch at the cover's +X edge
cover_pry_d  = 0.8;

/* [Battery — PLACEHOLDERS, measure!] */
// one 18650 cell in a single-cell holder, lying as a chord in the front-lower slab, slid in from the
// right seam face and held by the right cap plate (like the OLED)
bat_len      = 78;       // PLACEHOLDER holder length (tangential)
bat_w        = 21;       // PLACEHOLDER holder width (radial)
bat_h        = 21;       // PLACEHOLDER holder height (along X)
bat_tol      = 0.4;
bat_angle    = 335;      // chord centre direction (front, 25° down): corners fall between the tabs at 300 and 10
bat_r_in     = 16;       // inner (radial) face of the holder; keeps the conduit mouths free
// charge + 5 V boost module (USB-C in, 5 V out to the ESP32 5V pin), PCB lying flat (thickness along X)
pm_len       = 25;       // PLACEHOLDER module length (radial, USB-C at the outer end)
pm_w         = 21;       // PLACEHOLDER module width (tangential)
pm_t         = 1.6;      // PCB thickness
pm_comp_h    = 4.0;      // PLACEHOLDER tallest part on top (USB-C receptacle ~3.2)
pm_usb_w     = 9.0;      // USB-C receptacle width (tangential)
pm_usb_h     = 3.2;      // receptacle height (centre = PCB top + pm_usb_h/2)
pm_angle     = 223;      // back-bottom, between the ESP32 jumpers and the tab at 240
pm_x0        = -6.0;     // PCB underside along X (port well inside the slab, far from the pry notches)
pm_tol       = 0.3;
sw_d         = 6.2;      // panel toggle switch thread (M6 mini toggle); hole along the radius
sw_angle     = 223;
sw_x         = 7.0;      // switch position along X (beside the charge port)
sw_spot_d    = 12;       // flat spot-face for the switch nut

/* [Sofa hook] */
// use frame: Y forward (toward the speakers), Z up, origin = front-top edge of the backrest
backrest_t   = 160;      // MEASURE: backrest thickness at the top, cushion pressed lightly
hook_t       = 12;       // beam thickness in the hook's plane (in-plane loads, along the layers)
hook_w       = 50;       // hook width across (print height); wide for roll stability on a soft cushion
hook_back    = 60;       // back leg length down the rear of the backrest
plate_h      = 140;      // front plate length down the front of the backrest
head_fwd     = 130;      // sphere centre in front of the backrest front face (room for ±8° of hinge pitch)
head_up      = 0;        // MEASURE: sphere centre (ear axis) above the backrest top; negative = below
arm_t        = 22;       // arm thickness across (print height); the bolt-head hex needs ~15
arm_h        = 22;       // arm depth in its plane
hinge_d      = 8;        // M8 bolt + wing nut: pitch hinge between plate and arm
hinge_up     = 18;       // hinge centre above the plate's bottom end
hinge_y      = 27;       // hinge centre in front of the backrest face (arm clears the plate)
hinge_pitch  = 8;        // pitch adjustment the sphere must clear (deg)
mbolt_head_af = 14.29;   // 3/8"-16 hex bolt head across flats (9/16")
mbolt_head_t = 6.5;      // pocket depth for the bolt head (head is 5.95-6.2 mm)
mbolt_len    = 38.1;     // 3/8"-16 x 1-1/2" hex bolt (shank length)
jam_t        = 8.33;     // 3/8"-16 jam / thumb nut between the arm pad and the head's flat

/* [Render] */
part = "all"; // ["all", "explode", "section", "view_stand", "cap_right", "cap_left", "slab", "fill_plug", "sight_bar", "stem", "oled_cover", "clash_sight", "clash_cover", "clash_laser", "clash_power", "clash_power_board", "hook_saddle", "hook_arm", "view_sofa", "clash_cap_slab_r", "clash_cap_slab_l", "clash_board", "clash_oled", "check_chamber"]

// === DERIVED CONSTANTS ===
extrusion_width = nozzle_diameter * 1.125;   // 0.45
fin_t     = extrusion_width * 6;             // 2.7 mm fingers / channel walls
wall      = extrusion_width * wall_lines;    // 4.5
fudge     = 0.01;
tolerance = 0.2;                             // PLA sliding fit
hole_comp = 0.30;                            // X1C 0.4 hole compensation (skill default)
ef_chamfer = 0.3;
$fn       = $preview ? 32 : 64;
fn_big    = $preview ? 72 : 192;

R   = head_d / 2;
r_i = R - wall;
s   = slab_half;
rho_seam_out = sqrt(R*R - s*s);              // outer radius at the seam plane
rho_seam_in  = sqrt(r_i*r_i - s*s);
cap_h = R - s;

// cap chamber flare: meets the inner sphere where its ceiling reaches ceiling_overhang
r_to = conduit_id/2 + conduit_wall;
z_m  = r_i * sin(ceiling_overhang);
rho_m = r_i * cos(ceiling_overhang);
z_f  = z_m - (rho_m - r_to);                 // flare starts on the conduit at local z = z_f

// mic pocket (cap local frame, ear axis = +z)
mic_cb_d  = mic_pcb_d + hole_comp + mic_fit;
mic_hb_d  = mic_pcb_d - 2*mic_ledge;         // header bore under the seat ring
mic_face_z = sqrt(R*R - pow(mic_cb_d/2 + abs(mic_port_offset), 2));   // PCB face at the rim height
mic_seat_z = mic_face_z - mic_pcb_t;

// holes
mag_hole   = mag_d + hole_comp;              // glued
mag_depth  = mag_t + 0.5;                   // bridged pocket roofs sag; glue sets the magnet just below flush
pin_hole_press = pin_d + hole_comp - 0.08;   // slab side
pin_hole_slide = pin_d + hole_comp + 0.15;   // cap side
pin_depth  = pin_len/2 + 1;
boss_h     = max(pin_depth, mag_depth) + 2;  // cap plate bosses, above the seam face
fill_hole  = fill_d + hole_comp;

// board (slab), polar frame of board_angle: local y radial, local z tangential
rho_in_at = function(x) sqrt(r_i*r_i - x*x);
board_x0   = s - 2 - usb_open_h/2 - usb_h/2 - board_t;   // PCB underside; keeps the USB slot inside the slab
board_top  = board_x0 + board_t + board_comp_h;
board_pw   = board_w + 2*board_tol;
board_pl   = board_len + 2*board_tol;
board_end  = sqrt(pow(rho_in_at(board_top), 2) - pow(board_pw/2, 2)) - 0.5;   // USB end radius
board_in   = board_end - board_pl;
usb_x      = board_x0 + board_t + usb_h/2;

// OLED (slab), polar frame of oled_angle
oled_x0    = s - 0.5 - oled_w - oled_tol;     // bottom (−X) end of the module; top end held by the cap plate
oled_pw    = oled_h + 2*oled_tol;
oled_back  = oled_face_r - oled_stack - oled_tol;   // PCB back radius
oled_min_wall = sqrt(R*R - pow(s, 2) - pow(oled_pw/2, 2)) - oled_face_r;   // thinnest shell over the flat

// tripod
z_flat   = -sqrt(R*R - pow(flat_d/2, 2));
tnut_z0  = z_flat + tnut_floor;
tnut_ac  = (tnut_af + hole_comp + 0.1) / cos(30);
tbolt_hole = tbolt_d + hole_comp + 0.30;

// sight (top flat at z_top; groove along Y)
z_top     = sqrt(R*R - pow(sight_flat_d/2, 2));
groove_len = sight_flat_d - 2;
rib_d     = groove_d - 0.1;   
// laser centre height: on the V flanks if it fits inside the cradle, else on the cradle edges
laser_z   = laser_d_max/2/sqrt(2) <= laser_v_d ? sight_t - laser_v_d + laser_d_max/2*sqrt(2)
                                               : sight_t + sqrt(pow(laser_d_max/2, 2) - pow(laser_v_d, 2));   // ~±0.25° yaw play over the rib length

// stem (print = use orientation, Z up, base on the bed)
tpod_ac   = (tpod_af + hole_comp + 0.1) / cos(30);
rod_ac    = (tnut_af + hole_comp + 0.1) / cos(30);
tpod_z0   = tnut_floor;
rod_nut_z0 = tpod_z0 + tpod_t + tolerance + 3;
rod_hole  = tbolt_d + hole_comp + 0.30;
tpod_hole = tpod_d + hole_comp + 0.30;
rod_len   = stem_h - rod_nut_z0 + rod_protrude;

// OLED cover: window walls shrunk by cover_fit, seated deeper by cover_seat on the flares
oled_win_c = oled_x0 + oled_tol + oled_w/2;
win_dr     = R + 1 - oled_face_r;
cover_seat = (cover_fit - cover_flare_gap) * win_dr / oled_win_flare;
cover_edge_t = sqrt(R*R - pow(abs(oled_win_c) + oled_win_w/2, 2)
                    - pow(abs(oled_win_off) + oled_win_h/2 + oled_win_flare*(R - oled_face_r)/win_dr, 2))
               - (oled_face_r + cover_gap);

// battery (polar frame of bat_angle: local y radial, z tangential)
bat_pl   = bat_len + 2*bat_tol;
bat_pw   = bat_w + 2*bat_tol;
bat_x0   = s - 0.5 - bat_h - bat_tol;            // held by the right cap plate at x = s
bat_corner_r = sqrt(pow(bat_r_in + bat_pw + fin_t, 2) + pow(bat_pl/2 + fin_t, 2));
bat_corner_da = atan2(bat_pl/2 + fin_t, bat_r_in + bat_pw + fin_t);   // corner angle from bat_angle
tab_half_a = atan2(tab_w/2, tab_r_in) + 1;
function ang_dist(a, b) = abs(((a - b) % 360 + 540) % 360 - 180);
bat_tab_clear = min([for (a = tab_angles, sg = [-1, 1]) ang_dist(bat_angle + sg*bat_corner_da, a)]) - tab_half_a;
// power module (polar frame of pm_angle)
pm_pl    = pm_len + 2*pm_tol;
pm_pw    = pm_w + 2*pm_tol;
pm_top   = pm_x0 + pm_t + pm_comp_h;
pm_end   = sqrt(pow(rho_in_at(pm_top), 2) - pow(pm_pw/2, 2)) - 0.5;   // USB end radius
pm_in    = pm_end - pm_pl;
pm_usb_x = pm_x0 + pm_t + pm_usb_h/2;
// sofa hook (use frame)
mount_z  = head_up + z_flat - jam_t;            // arm pad top: head flat rests on the jam nut
hinge_z  = -plate_h + hinge_up;
lug_w    = hook_w/2 - arm_t/2 - 0.5;            // hinge lug on the -X side; the arm (and the load) sits on the centreline
mbolt_tip = mount_z - arm_h + mbolt_head_t + mbolt_len;   // bolt tip height (use frame)
function rot2(p, a) = [p[0]*cos(a) - p[1]*sin(a), p[0]*sin(a) + p[1]*cos(a)];
pitched_c = [hinge_y, hinge_z] + rot2([head_fwd - hinge_y, head_up - hinge_z], hinge_pitch);   // arm pitched back
hook_clear = norm(pitched_c - [hook_t, hook_t]) - R;
hinge_hole = hinge_d + hole_comp + 0.30;
mbolt_hole = tbolt_d + hole_comp + 0.30;
saddle_len = backrest_t + 2*hook_t;

// === CONTRACTS ===
assert(abs(wall - 4.5) < 1e-6, "shell must be 4.5 mm (10 lines)");
assert(2*rho_seam_out <= bed_xy - 10, "cap footprint exceeds the bed");
assert(cap_h <= bed_z && 2*s <= bed_z, "part too tall");
assert(z_f > s + boss_h + 2, "flare starts below the plate bosses: chamber would vanish");
assert(ceiling_overhang <= 60, "chamber ceiling over 60° sags in PLA");
assert(mic_hb_d >= 10, "header bore under the carrier < 10 mm: two 3-pin housings won't pass");
assert(mic_hb_d < mic_cb_d, "seat ring has no width");
assert(abs(mic_port_offset) <= mic_pcb_d/2 - 1, "port outside the carrier");
assert(abs(mic_port_offset) + mic_hb_d/2 <= conduit_id/2 + 1.5, "offset header bore no longer meets the conduit");
assert(R - mic_face_z < 0.5, "carrier sits more than 0.5 mm below the pole: front cavity");
assert(mic_seat_z - 4 > z_m, "mic pocket reaches into the chamber region");
assert(conduit_id/2 + 1 < mic_hb_d/2 + 10, "conduit geometry");
assert(board_x0 + s >= board_jumper_room, "no room for jumpers under the ESP32");
assert(board_top <= s - 0.5, "ESP32 top hits the cap plate");
assert(usb_x + usb_open_h/2 <= s - 2, "USB slot breaks through the seam face");
assert(board_in > conduit_id/2 - 2, "ESP32 far end over the conduit mouth");
assert(R - board_end <= 8.5, "USB-C receptacle too deep for a standard plug (6.6 mm insertion)");
assert(oled_x0 > -s + 3, "OLED doesn't fit the slab width");
assert(oled_min_wall >= 1.2, "shell over the OLED flat too thin");
assert(oled_x0 + oled_tol + oled_w/2 + oled_win_w/2 <= s - 2, "OLED window too close to the seam");
assert(mag_r + mag_hole/2 < rho_seam_in - 1, "magnet pocket breaks the band");
assert(pin_r - pin_hole_slide/2 > tab_r_in + 1.5, "pin breaks the tab inner face");
assert(fill_r + fill_hole/2 < tab_r_in - 3 && fill_r - fill_hole/2 > r_to + 3, "fill port position");
assert(tnut_z0 + tnut_t + tbolt_extra < z_flat + tboss_h - 3, "tripod bore leaves the boss");
assert(tnut_af + hole_comp + 6 <= tboss_w, "nut leaves < 3 mm boss wall each side");
assert(rod_protrude <= tnut_floor + tnut_t + tbolt_extra - 1 && rod_protrude >= tnut_floor + tnut_t + tolerance + 1.5,
       "stem rod must engage the head nut without bottoming");
assert(rod_cut - (stem_h - rod_nut_z0) >= tnut_floor + tnut_t + tolerance + 1.5 &&
       rod_cut - (stem_h - rod_nut_z0) <= tnut_floor + tnut_t + tbolt_extra - 1, "rod_cut does not engage the head nut properly");
assert(groove_d <= 1.0, "sight groove deeper than 1 mm");
assert(R - z_top + groove_d <= wall - 2, "top flat + groove leave < 2 mm shell");
assert(vial_x + vial_d/2 + 0.2 + 1.8 <= sight_w/2 && vial_x - vial_d/2 - 0.2 >= laser_d_max/2 + 1, "vial pocket hits the laser or the bar edge");
assert(stem_pad_d <= flat_d - 2, "stem pad larger than the head's bottom flat");
assert(stem_d - rod_hole >= 2*4*extrusion_width, "stem wall < 4 lines");
assert(rod_ac + 6 <= stem_base_d && tpod_ac + 6 <= stem_base_d, "nut slot leaves thin base walls");
assert(rod_nut_z0 + tnut_t + tolerance + 3 <= stem_base_h, "rod nut leaves the base");
assert(cover_edge_t >= 1.2, "OLED cover too thin at its corner");
assert(bat_x0 > -s + 2, "battery holder taller than the slab");
assert(bat_corner_r < tab_r_in - 1 || bat_tab_clear > 0, "battery cradle reaches the joint tabs");
assert(bat_corner_r < mag_r - mag_hole/2 - 2, "battery cradle too far out");
assert(bat_r_in - fin_t > r_to + 2, "battery cradle over a conduit mouth");
assert(R - pm_end <= 6.5, "charge-port receptacle too deep for a USB-C plug");
assert(pm_in > 20, "power module reaches the bay centre");
assert(pm_x0 - 1 > -s + 2 && pm_top < s - 3, "power module outside the slab width");
assert(abs(sw_x) + sw_spot_d/2 < s - 2, "switch spot-face reaches a seam");
assert(saddle_len <= bed_xy - 10 && plate_h + hook_t <= bed_xy - 10, "hook saddle exceeds the bed");
assert(mount_z > hinge_z + arm_h, "arm pad below the hinge: raise head_up or lengthen plate_h");
assert(head_fwd - R > hook_t + 5, "sphere touches the hook plate");
assert(hook_clear >= 2, "sphere hits the saddle when the arm is pitched back by hinge_pitch");
assert(lug_w >= 10, "hinge lug thinner than 10 mm");
assert(hinge_y - (arm_h + 4)/2 >= hook_t + 1, "arm hinge end hits the plate");
assert(mbolt_tip >= head_up + z_flat + tnut_floor + tnut_t && mbolt_tip <= head_up + z_flat + tnut_floor + tnut_t + tbolt_extra - 1,
       "head-mount bolt length: must pass the head nut without bottoming");

echo(seam_outer_d = 2*rho_seam_out, cap_h = cap_h, flare_start_z = z_f, flare_meet = [rho_m, z_m]);
echo(mic_face_below_pole = R - mic_face_z, mic_counterbore = mic_cb_d, header_bore = mic_hb_d);
echo(board_x0 = board_x0, board_top = board_top, board_end_r = board_end, board_in_r = board_in,
     usb_depth_from_surface = R - board_end, jumper_room = board_x0 + s);
echo(rod_len = rod_len, rod_cut_protrudes = rod_cut - (stem_h - rod_nut_z0), cover_seat = cover_seat, cover_edge_t = cover_edge_t, top_flat_depth = R - z_top);
echo(hook_clear_pitched = hook_clear, lug_w = lug_w, mbolt_tip_above_flat = mbolt_tip - head_up - z_flat, bat_x0 = bat_x0, bat_corner_r = bat_corner_r, bat_tab_clear_deg = bat_tab_clear, pm_end_r = pm_end, pm_usb_depth = R - pm_end, saddle_len = saddle_len, mount_z = mount_z);
echo(oled_x_range = [oled_x0, oled_x0 + oled_w + 2*oled_tol], oled_min_wall = oled_min_wall);

// === HELPERS ===
// revolve a 2D (rho, x) profile about the head X axis
module head_revolve() rotate([0, 90, 0]) rotate_extrude($fn = fn_big) children();

// polar frame in the Y-Z plane: local y = radial outward along angle a, local z = tangential
module polar(a) rotate([a, 0, 0]) children();

// cap-local position of a head (y,z) polar point: local u = -z, v = y
function cap_uv(r, a) = [-r*sin(a), r*cos(a)];

// teardrop prism along Z with its point toward +X (holes running along head Z, printed with X up)
module teardrop_z(d, h) linear_extrude(height = h) union() { circle(d = d); rotate(-45) square(d/2); }
// teardrop prism along +Y with its point toward +X (radial holes in a polar frame of the slab)
module teardrop_y(d, h) rotate([-90, 0, 0]) linear_extrude(height = h) union() { circle(d = d); rotate(-45) square(d/2); }

// === CAP (local frame: ear axis +z, sphere centre at origin, cap is z >= s) ===
module cap_outer_2d() difference() {
    intersection() { circle(r = R, $fn = fn_big); translate([0, s]) square([R + 1, R]); }
    // elephant-foot chamfer on the outer rim (print bottom)
    translate([rho_seam_out, s]) polygon([[-ef_chamfer, -fudge], [2, -fudge], [2, 2 + ef_chamfer]]);
}
module chamber_2d() intersection() {
    circle(r = r_i, $fn = fn_big);
    translate([r_to, s + plate_t]) square([R, R]);
    polygon([[r_to, -1], [r_to, z_f], [r_to + 2*R, z_f + 2*R], [r_to + 2*R, -1]]);
}
module cap_bosses() for (a = tab_angles) {
    hull() {
        translate(concat(cap_uv(mag_r, a), [s])) cylinder(d = mag_hole + 6, h = boss_h);
        translate(concat(cap_uv(pin_r, a), [s])) cylinder(d = pin_hole_slide + 6, h = boss_h);
    }
}
module mic_pocket() {
    off = [mic_port_offset, 0];   // shift so the port (not the PCB centre) is on the axis
    translate(concat(-off, [mic_seat_z])) cylinder(d = mic_cb_d, h = R - mic_seat_z + 1);
    // header bore, 45° transition to the conduit (self-supporting, narrows going up)
    translate(concat(-off, [0])) {
        hb_len = 3;
        translate([0, 0, mic_seat_z - hb_len]) cylinder(d = mic_hb_d, h = hb_len + fudge);
        if (conduit_id > mic_hb_d) hull() {
            translate([0, 0, mic_seat_z - hb_len - (conduit_id - mic_hb_d)/2]) cylinder(d = conduit_id, h = fudge);
            translate([0, 0, mic_seat_z - hb_len]) cylinder(d = mic_hb_d, h = fudge);
        }
    }
    hb_bottom = mic_seat_z - 3 - max(0, (conduit_id - mic_hb_d)/2);
    translate([0, 0, s - 1]) cylinder(d = conduit_id, h = hb_bottom - s + 1 + fudge);
}
module cap_local() difference() {
    rotate_extrude($fn = fn_big) cap_outer_2d();
    difference() {
        rotate_extrude($fn = fn_big) chamber_2d();
        cap_bosses();
    }
    mic_pocket();
    for (a = tab_angles) {
        translate(concat(cap_uv(mag_r, a), [s - fudge])) cylinder(d = mag_hole, h = mag_depth + fudge);
        translate(concat(cap_uv(mag_r, a), [s - fudge])) cylinder(d1 = mag_hole + 2*ef_chamfer, d2 = mag_hole, h = ef_chamfer + fudge);
        translate(concat(cap_uv(pin_r, a), [s - fudge])) cylinder(d = pin_hole_slide, h = pin_depth + fudge);
        translate(concat(cap_uv(pin_r, a), [s - fudge])) cylinder(d1 = pin_hole_slide + 1, d2 = pin_hole_slide, h = 0.5 + fudge);
    }
    translate(concat(cap_uv(fill_r, fill_angle), [s - 1])) cylinder(d = fill_hole, h = plate_t + 2);
    translate(concat(cap_uv(fill_r, fill_angle), [s - fudge])) cylinder(d1 = fill_hole + 2*ef_chamfer, d2 = fill_hole, h = ef_chamfer + fudge);
}
module cap_right_head() rotate([0, 90, 0]) cap_local();
module cap_left_head()  mirror([1, 0, 0]) cap_right_head();
module cap_right_print() translate([0, 0, -s]) cap_local();
module cap_left_print()  mirror([1, 0, 0]) cap_right_print();

// === SLAB (head frame) ===
module slab_outer_2d() difference() {
    intersection() { circle(r = R, $fn = fn_big); translate([0, -s]) square([R + 1, 2*s]); }
    translate([rho_seam_out, -s]) polygon([[-ef_chamfer, -fudge], [2, -fudge], [2, 2 + ef_chamfer]]);
}
module slab_env() head_revolve() slab_outer_2d();
module band() head_revolve() difference() { slab_outer_2d(); circle(r = r_i, $fn = fn_big); }

module prism(y0, y1, z0, z1, x0 = -s - 1, x1 = s + 1)   // box in a polar frame
    translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);

module tabs() for (a = tab_angles) polar(a) prism(tab_r_in, R, -tab_w/2, tab_w/2);

module board_cradle() polar(board_angle) {
    hw = board_pw/2;
    // web under the board centreline: board rests on its top (x = board_x0)
    prism(board_in - 4, R, -board_web_t/2, board_web_t/2, -s - 1, board_x0);
    // far-end stop (beyond the board end) rising from the web, 45° chamfer under its wings
    hull() {
        prism(board_in - 4, board_in, -board_web_t/2, board_web_t/2, -s - 1, board_top);
        prism(board_in - 4, board_in, -hw - fin_t, hw + fin_t, board_x0 - 3, board_top);
    }
    // low bar at the bed tying the far fingers to the web (beyond the board end, clear of the pins)
    prism(board_in - 4, board_in, -hw - fin_t, hw + fin_t, -s - 1, -s + 3);
    // side fingers just outside the long edges, at both ends (clear of the header housings)
    for (sz = [-1, 1]) {
        prism(board_in - 4, board_in + 6, sz > 0 ? hw : -hw - fin_t, sz > 0 ? hw + fin_t : -hw,
              -s - 1, board_top);
        prism(board_end - 6, R, sz > 0 ? hw : -hw - fin_t, sz > 0 ? hw + fin_t : -hw);
    }
}
module board_cut() polar(board_angle) {
    // board outline above the web (clears fingers/stop by board_tol)
    prism(board_in, board_end + 0.5, -board_pw/2, board_pw/2, board_x0, s + 1);
    // USB slot through the band
    prism(board_end - 0.5, R + 1, -usb_open_w/2, usb_open_w/2, usb_x - usb_open_h/2, usb_x + usb_open_h/2);
}

module oled_holder() polar(oled_angle) {
    hp = oled_pw/2;
    // side walls of the channel
    for (sz = [-1, 1]) prism(oled_back - oled_lip, R, sz > 0 ? hp : -hp - fin_t, sz > 0 ? hp + fin_t : -hp);
    // lip behind the bottom edge (local +z = away from the header)
    prism(oled_back - oled_lip, oled_back, hp - 2, hp + fin_t);
    // floor stop under the module
    prism(oled_back - oled_lip, R, -hp - fin_t, hp + fin_t, -s - 1, oled_x0);
}
module oled_cut() polar(oled_angle) {
    hp = oled_pw/2;
    // module pocket (cut into the band so the glass sits close to the surface)
    prism(oled_back, oled_face_r, -hp, hp, oled_x0, s + 1);
    // back side open to the bay above the lip
    prism(oled_back - oled_lip - 1, oled_back + fudge, -hp, hp - 2, oled_x0, s + 1);
    // window, flared 45° tangentially on the outside
    wc = oled_x0 + oled_tol + oled_w/2;
    k  = oled_win_flare;
    hull() {
        prism(oled_face_r - fudge, oled_face_r, oled_win_off - oled_win_h/2, oled_win_off + oled_win_h/2,
              wc - oled_win_w/2, wc + oled_win_w/2);
        prism(R + 1 - fudge, R + 1, oled_win_off - oled_win_h/2 - k, oled_win_off + oled_win_h/2 + k,
              wc - oled_win_w/2, wc + oled_win_w/2);
    }
}

module bat_cradle() polar(bat_angle) {
    y0 = bat_r_in; y1 = bat_r_in + bat_pw; hz = bat_pl/2; xt = bat_x0 + bat_h;
    prism(y0 - fin_t, y0, -hz - fin_t, hz + fin_t, -s - 1, xt);          // inner wall
    prism(y1, y1 + fin_t, -hz - fin_t, hz + fin_t, -s - 1, xt);          // outer wall
    for (sz = [-1, 1]) prism(y0, y1, sz > 0 ? hz : -hz - fin_t, sz > 0 ? hz + fin_t : -hz, -s - 1, xt);   // end walls
    for (zc = [-hz + 6, 0, hz - 6]) prism(y0, y1, zc - 3, zc + 3, -s - 1, bat_x0);   // floor ribs
    for (zc = [-20, 20]) prism(y1, R, zc - fin_t, zc + fin_t, -s - 1, xt);            // struts to the band
}
module bat_cut() polar(bat_angle) {
    prism(bat_r_in, bat_r_in + bat_pw, -bat_pl/2, bat_pl/2, bat_x0, s + 1);
    // lead exits at the floor of both end walls
    prism(bat_r_in + bat_pw/2 - 2, bat_r_in + bat_pw/2 + 2, -bat_pl/2 - fin_t - 1, bat_pl/2 + fin_t + 1, bat_x0 - 0.5, bat_x0 + 4);
}

module pm_cradle() polar(pm_angle) {
    hw = pm_pw/2;
    prism(pm_in - 3, R, -hw - fin_t, hw + fin_t, -s - 1, pm_x0);           // web under the module
    prism(pm_in - 3, pm_in, -hw - fin_t, hw + fin_t, -s - 1, pm_top);      // inner stop
    for (sz = [-1, 1]) prism(pm_in - 3, R, sz > 0 ? hw : -hw - fin_t, sz > 0 ? hw + fin_t : -hw, -s - 1, pm_top);
}
module pm_cut() polar(pm_angle) {
    prism(pm_in, pm_end + 0.5, -pm_pw/2, pm_pw/2, pm_x0, pm_top + 0.5);
    prism(pm_end - 0.5, R + 1, -pm_usb_w/2 - 0.75, pm_usb_w/2 + 0.75, pm_usb_x - pm_usb_h/2 - 1, pm_usb_x + pm_usb_h/2 + 1);
    // switch hole through the band (teardrop: radial hole, printed with X up) and its spot-face
    translate([sw_x, R - wall - 1, 0]) teardrop_y(sw_d + hole_comp, wall + 2);
    translate([sw_x, R - 1.5, 0]) rotate([-90, 0, 0]) cylinder(d = sw_spot_d, h = 3);
}

module tripod_boss() translate([-s - 1, -tboss_w/2, z_flat - 1]) cube([2*s + 2, tboss_w, tboss_h + 1]);
module tripod_cut() {
    // nut slot, dropped in from the +X face (flats facing ±Y)
    hull() for (x = [0, s + 1]) translate([x, 0, tnut_z0]) cylinder(d = tnut_ac, h = tnut_t + tolerance, $fn = 6);
    translate([0, 0, z_flat - 1]) teardrop_z(tbolt_hole, tnut_z0 + tnut_t + tbolt_extra - z_flat + 1);
}

module slab_head() difference() {
    union() {
        band();
        intersection() {
            slab_env();
            union() { tabs(); board_cradle(); oled_holder(); tripod_boss(); bat_cradle(); pm_cradle(); }
        }
    }
    translate([-s - 1, -R - 1, z_flat - 10]) cube([2*s + 2, 2*R + 2, 10]);   // bottom flat
    board_cut();
    oled_cut();
    bat_cut();
    pm_cut();
    tripod_cut();
    for (a = tab_angles, sx = [-1, 1]) polar(a) {
        x0 = sx > 0 ? s - mag_depth : -s - fudge;
        translate([x0, mag_r, 0]) rotate([0, 90, 0]) cylinder(d = mag_hole, h = mag_depth + fudge);
        if (sx < 0) translate([x0, mag_r, 0]) rotate([0, 90, 0]) cylinder(d1 = mag_hole + 2*ef_chamfer, d2 = mag_hole, h = ef_chamfer + fudge);
        px0 = sx > 0 ? s - pin_depth : -s - fudge;
        translate([px0, pin_r, 0]) rotate([0, 90, 0]) cylinder(d = pin_hole_press, h = pin_depth + fudge);
        translate([sx < 0 ? -s - fudge : s - 0.5, pin_r, 0]) rotate([0, 90, 0])
            cylinder(d1 = sx < 0 ? pin_hole_press + 1 : pin_hole_press, d2 = sx < 0 ? pin_hole_press : pin_hole_press + 1, h = 0.5 + fudge);
    }
    // pry notches: shallow recesses in the slab rim at both seams, bottom-back (far from the ears)
    for (sx = [-1, 1]) polar(pry_angle)
        prism(rho_seam_out - pry_depth, R + 1, -pry_w/2, pry_w/2, sx > 0 ? s - pry_h : -s - 1, sx > 0 ? s + 1 : -s + pry_h);
    // top flat + 90° V groove along Y: seat and yaw key for the sight bar (median plane, 90° from both ears)
    translate([-s - 1, -R - 1, z_top]) cube([2*s + 2, 2*R + 2, 10]);
    translate([0, -groove_len/2, z_top]) rotate([-90, 0, 0])
        linear_extrude(height = groove_len) polygon([[-groove_d - 1, -1], [groove_d + 1, -1], [0, groove_d]]);
    // front notch: small V groove at the front centre, along X
    translate([-notch_len/2, R - notch_depth, 0]) rotate([0, 90, 0])
        linear_extrude(height = notch_len) polygon([[-notch_depth - 1, 1 + notch_depth], [notch_depth + 1, 1 + notch_depth], [0, 0]]);
}
module slab_print() translate([0, 0, s]) rotate([0, -90, 0]) slab_head();

// === SIGHT BAR (G1) ===
// use frame: bottom face on z = 0, rib down, laser cradle and vial pocket on top
module sight_bar_local() difference() {
    union() {
        translate([-sight_w/2, -sight_len/2, 0]) cube([sight_w, sight_len, sight_t]);
        translate([0, -(groove_len - 4)/2, fudge]) rotate([-90, 0, 0])   // V rib into the head groove
            linear_extrude(height = groove_len - 4) polygon([[-rib_d, 0], [rib_d, 0], [0, rib_d]]);
    }
    translate([0, -sight_len/2 - 1, sight_t]) rotate([-90, 0, 0])      // 90° laser cradle, open both ends
        linear_extrude(height = sight_len + 2) polygon([[-laser_v_d - 1, -1], [laser_v_d + 1, -1], [0, laser_v_d]]);
    translate([vial_x, 0, sight_t - vial_h*0.6]) cylinder(d = vial_d + 0.4, h = vial_h);
    translate([vial_x, 0, sight_t - ef_chamfer]) cylinder(d1 = vial_d + 0.4, d2 = vial_d + 0.4 + 2*ef_chamfer + fudge, h = ef_chamfer + fudge);
}
module sight_bar_head() translate([0, 0, z_top]) sight_bar_local();
module sight_bar_print() translate([0, 0, sight_t]) rotate([180, 0, 0]) sight_bar_local();   // top face on the bed

// === STAND STEM (G2) ===
// print = use orientation. A 3/8"-16 rod (rod_len) runs through it into the head nut; a 1/4"-20 nut
// in the base takes the tripod screw. Both nuts drop into side slots from +X.
module stem() difference() {
    union() {
        translate([0, 0, ef_chamfer]) cylinder(d = stem_base_d, h = stem_base_h - ef_chamfer);
        cylinder(d1 = stem_base_d - 2*ef_chamfer, d2 = stem_base_d, h = ef_chamfer + fudge);
        translate([0, 0, stem_base_h - fudge]) cylinder(d1 = stem_base_d, d2 = stem_d, h = (stem_base_d - stem_d)/2);
        cylinder(d = stem_d, h = stem_h - stem_pad_h - (stem_pad_d - stem_d)/2 + fudge);
        translate([0, 0, stem_h - stem_pad_h - (stem_pad_d - stem_d)/2])
            cylinder(d1 = stem_d, d2 = stem_pad_d, h = (stem_pad_d - stem_d)/2 + fudge);
        translate([0, 0, stem_h - stem_pad_h]) cylinder(d = stem_pad_d, h = stem_pad_h);
    }
    translate([0, 0, -fudge]) cylinder(d = tpod_hole, h = rod_nut_z0);
    translate([0, 0, -fudge]) cylinder(d1 = tpod_hole + 2*ef_chamfer, d2 = tpod_hole, h = ef_chamfer + fudge);
    translate([0, 0, rod_nut_z0]) cylinder(d = rod_hole, h = stem_h);
    hull() for (x = [0, stem_base_d]) translate([x, 0, tpod_z0]) cylinder(d = tpod_ac, h = tpod_t + tolerance, $fn = 6);
    hull() for (x = [0, stem_base_d]) translate([x, 0, rod_nut_z0]) cylinder(d = rod_ac, h = tnut_t + tolerance, $fn = 6);
}

// === OLED COVER (G4) ===
module oled_cover_local(shrink) {   // polar frame of oled_angle, seated
    hw = oled_win_h/2 - shrink; k = oled_win_flare; c = oled_win_c; xw = oled_win_w/2 - shrink;
    intersection() {
        translate([0, -cover_seat, 0]) hull() {
            prism(oled_face_r - fudge, oled_face_r, oled_win_off - hw, oled_win_off + hw, c - xw, c + xw);
            prism(R + 1 - fudge, R + 1, oled_win_off - hw - k, oled_win_off + hw + k, c - xw, c + xw);
        }
        sphere(r = R, $fn = fn_big);
        prism(oled_face_r + cover_gap, R + 1, -R, R, -R, R);
    }
}
module oled_cover_part(shrink) difference() {   // seated cover with the fingernail notch at +X
    oled_cover_local(shrink);
    prism(R - cover_pry_d, R + 2, oled_win_off - cover_pry_w/2, oled_win_off + cover_pry_w/2,
          oled_win_c + oled_win_w/2 - shrink - cover_pry_d, oled_win_c + oled_win_w/2 + 1);
}
module oled_cover_head() polar(oled_angle) oled_cover_part(cover_fit);
module oled_cover_print() translate([0, 0, -(oled_face_r + cover_gap)]) rotate([90, 0, 0]) oled_cover_part(cover_fit);

// === FILL PLUG ===
module fill_plug() {
    stem = fill_d - 0.1;   // slip into the (compensated) Ø14 hole; silicone seals it
    cylinder(d = fill_d + 6, h = 1.6);
    translate([0, 0, 1.6 - fudge]) cylinder(d = stem, h = plate_t - 0.7);
    translate([0, 0, 1.6 + plate_t - 0.7 - 3*fudge]) cylinder(d1 = stem, d2 = stem - 1, h = 0.5);   // lead-in
}

// === DUMMIES (for clash checks and the assembly view) ===
module board_dummy() polar(board_angle) {
    y0 = board_in + board_tol; y1 = board_end - board_tol + 0.3;   // receptacle sticks out 0.3
    prism(y0, y1, -board_w/2, board_w/2, board_x0 + fudge, board_x0 + board_t);   // PCB
    prism(y0, y1 - 0.3, -board_w/2 + 2, board_w/2 - 2, board_x0 + board_t, board_top - fudge);   // parts
    for (sz = [-1, 1]) prism(y0 + 1, y1 - 3, sz*board_w/2 - (sz > 0 ? 2.54 : 0),
                             sz*board_w/2 + (sz < 0 ? 2.54 : 0), board_x0 - board_jumper_room, board_x0);   // jumpers
}
module oled_dummy() polar(oled_angle) {
    hp = oled_h/2;
    prism(oled_face_r - oled_stack - fudge, oled_face_r - fudge, -hp, hp, oled_x0 + oled_tol, oled_x0 + oled_tol + oled_w);
    prism(oled_back - 16, oled_back, -hp + 0.3, -hp + 3.0, oled_x0 + oled_tol + 6, oled_x0 + oled_tol + oled_w - 6);   // header + Dupont
}

module bat_dummy() polar(bat_angle)
    prism(bat_r_in + bat_tol, bat_r_in + bat_tol + bat_w, -bat_len/2, bat_len/2, bat_x0 + fudge, bat_x0 + bat_h);
module pm_dummy() polar(pm_angle) {
    y0 = pm_in + pm_tol; y1 = pm_end - pm_tol + 0.3;
    prism(y0, y1, -pm_w/2, pm_w/2, pm_x0 + fudge, pm_x0 + pm_t);
    prism(y0, y1 - 0.3, -pm_w/2 + 2, pm_w/2 - 2, pm_x0 + pm_t, pm_top - fudge);
}

// === SOFA HOOK ===
// Profiles are drawn in the hook plane: 2D x = use Y (forward), 2D y = use Z (up). Both parts print
// lying flat (profile on the bed, extruded up), so the hanging load bends them along the layers.
// saddle: a ∩ over the backrest top: back leg, bridge, front plate, and a hinge lug at the plate foot
module hook_saddle_profile() difference() {
    union() {
        translate([-backrest_t - hook_t, 0]) square([saddle_len, hook_t]);                   // bridge
        translate([-backrest_t - hook_t, -hook_back]) square([hook_t, hook_back + hook_t]);    // back leg
        translate([0, -plate_h]) square([hook_t, plate_h + hook_t]);                         // front plate
        polygon([[fudge, -8], [fudge, fudge], [-8, fudge]]);                                // inner corner gussets
        translate([-backrest_t, 0]) polygon([[-fudge, -8], [-fudge, fudge], [8, fudge]]);
    }
}
module hook_lug_profile() difference() {   // hinge lug at the plate foot, only lug_w thick
    translate([hook_t - fudge, hinge_z - hinge_up]) square([hinge_y + 12 - hook_t, 2*hinge_up]);
    translate([hinge_y, hinge_z]) circle(d = hinge_hole);
}
// arm: from the hinge (beside the plate, on +X) forward and up to a pad under the sphere
module hook_arm_profile() difference() {
    union() {
        hull() {
            translate([hinge_y, hinge_z]) circle(d = arm_h + 4);
            translate([head_fwd - 17, mount_z - arm_h]) square([1, arm_h]);
        }
        translate([head_fwd - 17, mount_z - arm_h]) square([34, arm_h]);                   // pad
    }
    translate([hinge_y, hinge_z]) circle(d = hinge_hole);
}
module hook_saddle_print() {
    linear_extrude(height = hook_w) hook_saddle_profile();
    linear_extrude(height = lug_w) hook_lug_profile();
}
module hook_arm_print() difference() {
    linear_extrude(height = arm_t) hook_arm_profile();
    // 3/8"-16 bolt up through the pad (horizontal in print: teardrop, point up), head in a hex pocket
    translate([head_fwd, mount_z - arm_h - 1, arm_t/2]) rotate([0, -90, 0]) teardrop_y(mbolt_hole, arm_h + 2);
    translate([head_fwd, mount_z - arm_h - 1, arm_t/2]) rotate([-90, 0, 0])   // flats top and bottom: 8 mm bridge
        cylinder(d = (mbolt_head_af + hole_comp + 0.1)/cos(30), h = mbolt_head_t + 1, $fn = 6);
}
module hook_saddle_use() translate([-hook_w/2, 0, 0]) rotate([90, 0, 90]) hook_saddle_print();
module hook_arm_use()    translate([-hook_w/2 + lug_w + 0.5, 0, 0]) rotate([90, 0, 90]) hook_arm_print();
arm_axis_x = -hook_w/2 + lug_w + 0.5 + arm_t/2;   // use-frame X of the bolt and sphere: ~0, the saddle centreline

// === ASSEMBLY / RENDER ===
module assembly(gap = 0) {
    color("lightsteelblue") translate([gap, 0, 0]) cap_right_head();
    color("lightsteelblue") translate([-gap, 0, 0]) cap_left_head();
    color("wheat") slab_head();
    color("green") board_dummy();
    color("red") bat_dummy();
    color("purple") pm_dummy();
    color("black") oled_dummy();
    color("tan") oled_cover_head();
    color("orange") translate([0, 0, gap/2]) sight_bar_head();
}

if (part == "all")      assembly();
if (part == "explode")  assembly(60);
if (part == "section")  difference() { assembly(); translate([-R-1, -R-1, 0]) cube([2*R+2, 2*R+2, R+1]); }
if (part == "view_stand") { assembly(); translate([0, 0, z_flat - stem_h]) stem();
                           color("silver") translate([0, 0, z_flat - stem_h + rod_nut_z0]) cylinder(d = tbolt_d, h = rod_len); }
if (part == "view_sofa") {
    color("sienna") translate([-200, -backrest_t, -300]) cube([400, backrest_t, 300]);
    color("lightgray") hook_saddle_use(); color("gray") hook_arm_use();
    translate([arm_axis_x, head_fwd, head_up]) assembly();
}
if (part == "hook_saddle") hook_saddle_print();
if (part == "hook_arm")    hook_arm_print();
if (part == "clash_power") intersection() { slab_head(); union() { bat_dummy(); pm_dummy(); } }
if (part == "clash_power_board") intersection() { union() { bat_dummy(); pm_dummy(); } board_dummy(); }
if (part == "cap_right") cap_right_print();
if (part == "cap_left")  cap_left_print();
if (part == "slab")      slab_print();
if (part == "fill_plug") fill_plug();
if (part == "sight_bar") sight_bar_print();
if (part == "stem")      stem();
if (part == "oled_cover") oled_cover_print();
if (part == "clash_sight") intersection() { slab_head(); translate([0, 0, fudge]) sight_bar_head(); }
if (part == "clash_cover") intersection() { slab_head(); polar(oled_angle) translate([0, fudge, 0]) oled_cover_part(cover_fit); }
if (part == "clash_laser") intersection() {   // largest laser resting in the cradle vs the bubble level
    translate([vial_x, 0, sight_t - vial_h*0.6]) cylinder(d = vial_d, h = vial_h);
    translate([0, -sight_len/2, laser_z]) rotate([-90, 0, 0]) cylinder(d = laser_d_max, h = sight_len);
}
if (part == "clash_cap_slab_r") intersection() { translate([fudge, 0, 0]) cap_right_head(); slab_head(); }
if (part == "clash_cap_slab_l") intersection() { translate([-fudge, 0, 0]) cap_left_head(); slab_head(); }
if (part == "clash_board") intersection() { slab_head(); board_dummy(); }
if (part == "clash_oled")  intersection() { slab_head(); oled_dummy(); }
if (part == "check_chamber") rotate_extrude($fn = 48) chamber_2d();
