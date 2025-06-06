# Changelog

* [Unreleased](#unreleased)
* [0.7](#0.7)
* [0.6](#0.6)
* [0.5](#0.5)


## Unreleased
### Added

* Support for the linux-drm-syncobj-v1 protocol ([wlroots!4715][wlroots!4715], [#685][685])
* Allow the use of non-system wlroots library ([#646][646])

[wlroots!4715]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/4715
[685]: https://codeberg.org/dwl/dwl/pulls/685
[646]: https://codeberg.org/dwl/dwl/pulls/646


### Changed
### Deprecated
### Removed
### Fixed

* Crash when a client is created while all outputs are disabled.

### Security
### Contributors


## 0.7

This version is just 0.6 with wlroots 0.18 compatibility.

### Added

* Add support for the alpha-modifier-v1 protocol ([wlroots!4616][wlroots!4616]).
* dwl now will survive GPU resets ([#601][601]).

[wlroots!4616]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/4616
[601]: https://codeberg.org/dwl/dwl/issues/601


### Contributors

Guido Cella


## 0.6

### Added

* Add `rootcolor` to change the default background color ([#544][544]).
* Implement the wlr-virtual-pointer-unstable-v1 protocol ([#574][574]).
* Implement the pointer-constraints and relative-pointer protocols ([#317][317])
* Implement the wlr-output-power-management protocol ([#599][599])

[544]: https://codeberg.org/dwl/dwl/pulls/544
[574]: https://codeberg.org/dwl/dwl/pulls/574
[317]: https://codeberg.org/dwl/dwl/issues/317
[599]: https://codeberg.org/dwl/dwl/issues/559


### Changed

* Keyboards are now managed through keyboard groups ([#549][549]).
* Only the first matched keybinding is executed.
* Allow toggling the layout before selecting a different one ([#570][570]).
* Fullscreen clients are now rendered above wlr_layer_surfaces in the top layer
  ([#609][609]).
* The default menu was changed from `bemenu-run` to `wmenu-run` ([#553][553]).
* The option `sloppyfocus` now replicates the dwm behavior ([#599][599]).
* Allow configure position of monitors with negative values. (-1, -1) is
  used to auto-configure them ([#635][635]).
* dwl now kills the entire process group of `startup_cmd`
* The O_NONBLOCK flag is set for stdout.

[549]: https://codeberg.org/dwl/dwl/pulls/549
[570]: https://codeberg.org/dwl/dwl/pulls/570
[609]: https://codeberg.org/dwl/dwl/pulls/609
[553]: https://codeberg.org/dwl/dwl/issues/553
[599]: https://codeberg.org/dwl/dwl/pulls/599
[635]: https://codeberg.org/dwl/dwl/pulls/635


### Removed

* The SLOC limit is now removed ([#497][497]).

[497]: https://codeberg.org/dwl/dwl/pulls/497


### Fixed

* Clients not having the correct border color when mapping.
* Compliance with the xdg-decoration-unstable-v1 ([#546][546]).
* dwl no longer sends negative values in xdg_toplevel.configure events.
* Crashes with disabled monitors ([#472][472]).

[546]: https://codeberg.org/dwl/dwl/pulls/546
[472]: https://codeberg.org/dwl/dwl/issues/472


### Contributors

Ben Jargowsky
Benjamin Chausse
David Donahue
Devin J. Pohly
Dima Krasner
Emil Miler
Forrest Bushstone
Guido Cella
Peter Hofmann
Rutherther
Squibid
choc
fictitiousexistence
korei999
sewn
thanatos


## 0.5

### Added

* Allow configure x and y position of outputs ([#301][301])
* Implement repeatable keybindings ([#368][368])
* Print app id in printstatus() output ([#381][381])
* Display client count in monocle symbol ([#387][387])
* Export XCURSOR_SIZE to fix apps using an older version of Qt ([#425][425])
* Support for wp-fractional-scale-v1 (through wlr_scene: [wlroots!3511][wlroots!3511])
* dwl now sends `wl_surface.preferred_buffer_scale` (through wlr_scene: [wlroots!4269][wlroots!4269])
* Add support for xdg-shell v6 ([#465][465])
* Add support for wp-cursor-shape-v1 ([#444][444])
* Add desktop file ([#484][484])
* Add macro to easily configure colors ([#466][466])
* Color of urgent clients are now red ([#494][494])
* New flag `-d` and option `log_level` to change the wlroots debug level
* Add CHANGELOG.md ([#501][501])

[301]: https://github.com/djpohly/dwl/pull/301
[368]: https://github.com/djpohly/dwl/pull/368
[381]: https://github.com/djpohly/dwl/pull/381
[387]: https://github.com/djpohly/dwl/issues/387
[425]: https://github.com/djpohly/dwl/pull/425
[wlroots!4269]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/4269
[wlroots!3511]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/3511
[465]: https://github.com/djpohly/dwl/pull/465
[444]: https://github.com/djpohly/dwl/pull/444
[484]: https://github.com/djpohly/dwl/pull/484
[466]: https://github.com/djpohly/dwl/issues/466
[494]: https://github.com/djpohly/dwl/pull/494
[501]: https://github.com/djpohly/dwl/pull/501


### Changed

* Replace `tags` with `TAGCOUNT` in config.def.h ([#403][403])
* Pop ups are now destroyed when focusing another client ([#408][408])
* dwl does not longer respect size hints, instead clip windows if they are
  larger than they should be ([#455][455])
* The version of wlr-layer-shell-unstable-v1 was lowered to 3 (from 4)
* Use the same border color as dwm ([#494][494])

[403]: https://github.com/djpohly/dwl/pull/403
[408]: https://github.com/djpohly/dwl/pull/409
[455]: https://github.com/djpohly/dwl/pull/455
[494]: https://github.com/djpohly/dwl/pull/494


### Removed

* Remove unused `rootcolor` option ([#401][401])
* Remove support for wlr-input-inhibitor-unstable-v1 ([#430][430])
* Remove support for KDE idle protocol ([#431][431])

[401]: https://github.com/djpohly/dwl/pull/401
[430]: https://github.com/djpohly/dwl/pull/430
[431]: https://github.com/djpohly/dwl/pull/431


### Fixed

* Fix crash when creating a layer surface with all outputs disabled
  ([#421][421])
* Fix other clients being shown as focused if the focused client have pop ups
  open ([#408][408])
* Resize fullscreen clients when updating monitor mode
* dwl no longer crash at exit like sometimes did
* Fullscreen background appearing above clients ([#487][487])
* Fix a segfault when user provides invalid xkb_rules ([#518][518])

[421]: https://github.com/djpohly/dwl/pull/421
[408]: https://github.com/djpohly/dwl/issues/408
[487]: https://github.com/djpohly/dwl/issues/487
[518]: https://github.com/djpohly/dwl/pull/518


### Contributors

* A Frederick Christensen
* Angelo Antony
* Ben Collerson
* Devin J. Pohly
* Forrest Bushstone
* gan-of-culture
* godalming123
* Job79
* link2xt
* Micah Gorrell
* Nikita Ivanov
* Palanix
* pino-desktop
* Weiseguy
* Yves Zoundi
