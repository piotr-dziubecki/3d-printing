// === DESCRIPTION ===
// Binaural sphere head: a 175 mm spherical "dummy head" measurement fixture for room acoustics.
// Two Infineon IM73D122 PDM MEMS microphones (each on its round carrier PCB) sit flush in the
// sphere surface at the ear points, diametrically opposite on the horizontal great circle
// (±90° from the front). One ESP32-S3 DevKitC-1 clone inside records both mics as stereo PDM
// (shared CLK/DATA, L/R select pin to GND on one mic and VDD on the other) so the two ears
// share a clock. Used at a listening seat to measure ITD, ILD and IACC for stereo imaging.
//
// Physical context: stands on a tripod or mic stand (1/4"-20 nut at the bottom), indoors,
// static. Loads: its own weight (~0.7 kg empty, ~2.4 kg with the sand chambers full) on the
// 1/4"-20 nut, and hand forces when opening. An SSD1306 0.96" OLED looks out through a window
// on the back; a USB-C cable to an external power bank plugs in through a slot on the back.
//
// Design decisions:
//   - Split into THREE parts along the ear axis (X): right cap, centre slab, left cap. The two
//     seams are planes at x = ±slab_half (20 mm) — 67.5 mm from each ear. One central (sagittal)
//     split would be 87.5 mm away but puts the electronics, tripod nut and display on the seam;
//     the 40 mm slab is the narrowest that holds them (jumper room is asserted). A plain hemisphere split on the
//     vertical plane through the ears would put the seam across both ears; the sagittal
//     hemisphere split puts electronics, mount and display on the seam. The slab carries all of
//     them, so each cap is a simple closed sand chamber with an ear on top.
//   - Each cap prints seam face down, ear up: the mic pocket is then a vertical bore (round,
//     exact), the outer dome has no overhang, and the closed sand chamber's ceiling is held to
//     <= ceiling_overhang (55°) from vertical by a 45° flare that rises from the wire conduit to
//     the shell. That flare also makes the ear region a thick solid in CAD; print it dense
//     (>= 40% infill modifier on the cap tops) so it is stiff in the part too. The chamber is sealed: printed floor (the seam plate), shell, conduit tube, flare.
//   - The slab prints flat on its left face. Everything inside it (board cradle, OLED channel,
//     tripod boss, joint tabs) is a prism along X, i.e. vertical walls in print: support-free.
//   - Joints: 3 mm steel dowel pins locate, 10×3 mm neodymium magnets clamp. No screw or seam
//     crosses the ear regions; the outer surface has only the two seams, the OLED window and
//     USB slot (back), the front notch and the bottom flat.
//   - Walls 4.5 mm = 10 extrusion lines; caps and slab have 4.5 mm shells, the ear region is solid.
//
// Terminology → code:
//   "sphere / head"           → head_d, wall_lines → wall, head_revolve()
//   "caps / ears side"        → cap_local(), cap_right_print(), cap_left_print(), slab_half
//   "sand chamber"            → chamber_2d(), ceiling_overhang, plate_t; "fill port/plug" → fill_*
//   "wire conduit"            → conduit_id, conduit_wall
//   "mic pocket / carrier"    → mic_pcb_d, mic_pcb_t, mic_port_offset, mic_ledge, mic_pocket()
//   "slab / middle ring"      → slab_head(), slab_print()
//   "board cradle"            → board_*, board_angle, board_cradle()
//   "OLED window / channel"   → oled_*, oled_angle, oled_holder(), oled_window()
//   "USB slot"                → usb_*
//   "tripod nut"              → tnut_*, tripod_boss(), tripod_cut(); "bottom flat" → flat_d
//   "joint tabs / magnets / pins" → tab_*, mag_*, pin_*
//   "front notch"             → notch_*
//
// Common modifications:
//   Measured mic carrier     → mic_pcb_d, mic_pcb_t, mic_port_offset, mic_ledge (asserted: ledge
//                              leaves >= 10 mm bore for header housings)
//   Measured ESP32 board     → board_len, board_w, board_comp_h; board_angle moves it around the back
//   Measured OLED module     → oled_w, oled_h, oled_stack, oled_win_*
//   Different head size      → head_d (keep caps within 256 mm bed: asserted)
//   Thicker/thinner seams    → slab_half (>= 18 mm: the jumper room under the board is asserted)
//   1/4"-20 heat-set insert  → set tnut_af/tnut_t to the insert's OD/length (or use a nut)
//   Steeper chamber ceiling  → ceiling_overhang (55° default; above ~60° the PLA ceiling sags)
//
// Overall dimensions: sphere Ø175; caps 170.3 × 170.3 × 67.5 mm (print), slab 170.3 × 170.3 × 40 mm
//   (print) — each fits the Bambu X1C 256 × 256 × 256 mm bed.
// Coordinate system (head / assembly): origin = sphere centre, X = ear axis (+X right ear),
//   Y = front (+Y, the nose), Z = up. In print, each cap's ear axis is +Z (seam face on Z=0) and
//   the slab's X becomes Z (left face on Z=0).
// NOTE: printed parts are modelled in print orientation (cap_right, cap_left, slab, fill_plug).
// Final review: 2026-11-22, claude-fable-5-2 (after a claude-sonnet-5-5 review); findings fixed.

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
// Orientation: as modelled. Caps seam face down (ear up), slab left face down, plug flange down.
// Notes: PLA 200-220 °C (Bambu PLA Basic preset 220) / bed 60 °C. Brim not needed (full-disc footprint on caps). The caps are
//   hollow sealed chambers: do not enable "remove small gaps" or anything that fills cavities.

// === PARAMETERS ===
/* [Printer] */
nozzle_diameter = 0.4;
layer_height    = 0.2;
bed_xy          = 256;   // Bambu X1C
bed_z           = 256;

/* [Head] */
head_d       = 175;      // outer sphere diameter
wall_lines   = 10;       // shell = 10 × 0.45 = 4.5 mm
slab_half    = 20;       // seam planes at x = ±slab_half
plate_t      = 3.2;      // cap seam plate (sand chamber floor), 16 layers
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
tnut_af      = 11.11;    // 1/4"-20 hex nut across flats (7/16")
tnut_t       = 5.56;     // nut thickness (7/32")
tbolt_d      = 6.35;     // 1/4"
tnut_floor   = 2.0;      // plastic under the nut (thin: camera screws protrude only ~4.5-6 mm)
tbolt_extra  = 8.0;      // bore above the nut for long tripod screws
tboss_w      = 24;       // boss width (Y)
tboss_h      = 26;       // boss height (Z) above the flat

/* [Front notch] */
notch_len    = 16;       // along X
notch_depth  = 1.5;

/* [Pry notches] */
pry_angle    = 225;      // bottom-back, on both seams
pry_w        = 10;
pry_depth    = 2.0;
pry_h        = 2.0;      // along X into the slab

/* [Render] */
part = "all"; // ["all", "explode", "section", "cap_right", "cap_left", "slab", "fill_plug", "clash_cap_slab_r", "clash_cap_slab_l", "clash_board", "clash_oled", "check_chamber"]

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

echo(seam_outer_d = 2*rho_seam_out, cap_h = cap_h, flare_start_z = z_f, flare_meet = [rho_m, z_m]);
echo(mic_face_below_pole = R - mic_face_z, mic_counterbore = mic_cb_d, header_bore = mic_hb_d);
echo(board_x0 = board_x0, board_top = board_top, board_end_r = board_end, board_in_r = board_in,
     usb_depth_from_surface = R - board_end, jumper_room = board_x0 + s);
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
            union() { tabs(); board_cradle(); oled_holder(); tripod_boss(); }
        }
    }
    translate([-s - 1, -R - 1, z_flat - 10]) cube([2*s + 2, 2*R + 2, 10]);   // bottom flat
    board_cut();
    oled_cut();
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
    // front notch: small V groove at the front centre, along X
    translate([-notch_len/2, R - notch_depth, 0]) rotate([0, 90, 0])
        linear_extrude(height = notch_len) polygon([[-notch_depth*1.2, 2], [0, 0], [notch_depth*1.2, 2]]);
}
module slab_print() translate([0, 0, s]) rotate([0, -90, 0]) slab_head();

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

// === ASSEMBLY / RENDER ===
module assembly(gap = 0) {
    color("lightsteelblue") translate([gap, 0, 0]) cap_right_head();
    color("lightsteelblue") translate([-gap, 0, 0]) cap_left_head();
    color("wheat") slab_head();
    color("green") board_dummy();
    color("black") oled_dummy();
}

if (part == "all")      assembly();
if (part == "explode")  assembly(60);
if (part == "section")  difference() { assembly(); translate([-R-1, -R-1, 0]) cube([2*R+2, 2*R+2, R+1]); }
if (part == "cap_right") cap_right_print();
if (part == "cap_left")  cap_left_print();
if (part == "slab")      slab_print();
if (part == "fill_plug") fill_plug();
if (part == "clash_cap_slab_r") intersection() { translate([fudge, 0, 0]) cap_right_head(); slab_head(); }
if (part == "clash_cap_slab_l") intersection() { translate([-fudge, 0, 0]) cap_left_head(); slab_head(); }
if (part == "clash_board") intersection() { slab_head(); board_dummy(); }
if (part == "clash_oled")  intersection() { slab_head(); oled_dummy(); }
if (part == "check_chamber") rotate_extrude($fn = 48) chamber_2d();
