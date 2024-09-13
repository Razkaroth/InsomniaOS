;; -*- TIMINGS -*-
(defvar
  tap-time 150
  tap-timeout 200
)

(defalias
  caps (tap-hold 200 250 esc (layer-while-held fn))
)

(defsrc
  esc  grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab   q    w    e    r    t    y    u    i    o    p    [    ]    \    del
  caps  a    s    d    f    g    h    j    k    l    ;    '    ret       pgup
  lsft  z    x    c    v    b    n    m    ,    .    /    rsft      ▲    pgdn
  lctl  lmet lalt           spc            ralt rmet rctl      ◀    ▼    ▶
)

(deflayer base
  esc  grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab   q    w    e    r    t    y    u    i    o    p    [    ]    \    del
  esc   a    s    d    f    g    h    j    k    l    ;    '    ret       home
  lsft  z    x    c    v    b    n    m    ,    .    /    rsft      ▲    end
  lctl  lmet lalt           spc            ralt rmet rctl      ◀    ▼    ▶
)

(deflayer blank
   _    _    _    _    _    _    _    _    _    _    _    _    _    _    _
   _    _    _    _    _    _    _    _    _    _    _    _    _    _    _
   _    _    _    _    _    _    _    _    _    _    _    _    _    _    _
   _    _    _              _              _    _    _    _    _    _    _
 )











;; old mappings
;; (deflayer fn
;;   caps @grv  f1     f2      f3      f4      f5      f6    f7       f8     f9   f10  f11  f12  ins
;;   tab   q    w      end     lrld    @tmx    y       u     @i       o      pp   @op  @cp  \    del
;;    _    a    s      bspc    home    g       ◀       ▼     ▲        ▶      @n   '    ret       pgup
;;   lsft  z    x      C-S-c   C-S-v   prev    next    mute  voldwn   volu   /    rsft           pgdn
;;   lctl  lmet lalt            ret            ralt    rmet  rctl
;; )
