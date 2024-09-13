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
            caps (tap-hold 200 250 esc (layer-while-held fn))
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
            esc a    s    d    f    g    h    j    k    l    ;    '    ret       home
            lsft  z    x    c    v    b    n    m    ,    .    /    rsft           end
            lctl  lmet lalt           spc            ralt rmet rctl
          )

          (deflayermap

          )

        '';
        extraDefCfg = "process-unmapped-keys yes";
      };
    };
  };
}
