# MangoWM modular configuration

This bundle contains a cleaned MangoWM configuration with a Noctalia-friendly effects setup.

## Structure

- `config.conf` – loader that sources the modular files under `conf.d/`
- `conf.d/10-effects.conf` – application-window blur, shadows, opacity and rounded corners
- `conf.d/20-animations.conf` – window and layer animation settings
- `conf.d/30-layout.conf` – master-stack, scroller and dwindle layout behaviour
- `conf.d/45-appearance.conf` – gaps, borders, scratchpad sizing and colours
- `conf.d/99-local.conf` – optional machine-specific overrides
- `conf.d/binds/*.conf` – key, mouse and axis bindings

## Noctalia compatibility fix

Layer-shell blur and shadows are disabled in `conf.d/10-effects.conf`:

```conf
blur_layer=0
layer_shadows=0
```

Normal application-window blur and shadows remain enabled. This prevents Noctalia panels from hiding windows behind cached wallpaper blur and prevents unwanted shadow boxes around notifications.

## Install

Back up your current MangoWM configuration, then copy this folder to:

```text
~/.config/mango/
```

Reload MangoWM using your existing reload key binding or restart the session.

## Noctalia dynamic colours

`config.conf` loads `./noctalia.conf` after the static appearance defaults.
Noctalia regenerates that file when its theme changes, so Mango border colours
follow the active Noctalia palette after a Mango config reload.

## Noctalia layer surfaces

Mango compositor blur and shadows are disabled for layer-shell surfaces.
Noctalia handles the visual treatment of its own panels and notifications.
The `dimland_layer` rule also prevents opened panels from hiding application
windows behind an animated or blurred shell dimming surface.

## Known MangoWM limitation

The `float-all-windows` helper intentionally uses Mango's built-in
`toggle_all_floating` command only.

Older experiments tried to scatter windows and then restore the exact previous
tiled layout. This worked with two windows, but became unreliable with three or
more windows because Mango does not currently expose a full layout-tree
snapshot/restore command through IPC.

For now, the supported behaviour is:

- toggle visible windows between tiled and floating
- do not move, scatter, resize, or reorder windows
- accept that complex 3+ window tiled layouts may not restore exact positions
