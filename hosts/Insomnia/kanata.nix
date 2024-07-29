{ ... }: {

  services.kanata = {
    enable = true;
    keyboards = {
      main = {
        config = ''
          (defvar
            tap-time 150
            tap-timeout 200
          )
          (defalias
            caps (tap-hold 100 100 esc (layer-while-held fn))
            n   (macro S-grv n)
            grv (macro S-grv spc)
            i   (macro '     i)
            tmx (tap-dance-eager 10000 ( 
                  (macro A-s d)
                  (macro t m u x spc k i l l - s e r v e r ret) 
                  (macro . / t m u x S-r e ▶ ret)
                  (macro t m u x ret)
                  (macro A-s C-r)
                ))
          )

          (defsrc
            esc  grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab   q    w    e    r    t    y    u    i    o    p    [    ]    \    del
            caps  a    s    d    f    g    h    j    k    l    ;    '    ret       pgup
            lsft  z    x    c    v    b    n    m    ,    .    /    rsft           pgdn
            lctl  lmet lalt           spc            ralt rmet rctl
          )

          (deflayer base
            esc  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab   q    w    e    r    t    y    u    i    o    p    [    ]    \    del
            @caps a    s    d    f    g    h    j    k    l    ;    '    ret       home
            lsft  z    x    c    v    b    n    m    ,    .    /    rsft           end
            lctl  lmet lalt           spc            ralt rmet rctl
          )

          (deflayer fn
            caps @grv  f1     f2     f3      f4      f5      f6    f7       f8     f9   f10  f11  f12  ins
            tab   q    w      e      lrld    @tmx    y       u     @i       o      pp   [    ]    \    del
             _    a    s      d      f       g       ◀       ▼     ▲        ▶      @n   '    ret       pgup
            lsft  z    x    C-S-c  C-S-v    prev     next    mute  voldwn   volu   /    rsft           pgdn
            lctl  lmet lalt           ret            ralt    rmet  rctl
          )
        '';
        extraDefCfg = "process-unmapped-keys yes";
      };
    };
  };
}
