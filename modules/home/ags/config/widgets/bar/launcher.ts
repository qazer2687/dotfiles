import opts from "options";
import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

export default () => Widget.Button({
	classNames: ["bar-panel", "bar-panel-button"],
	//child: Widget.Icon({
	//	icon: "system-search-symbolic"
	//}),
	child: Widget.Label({
		label: " ",
		css: opts.font.size.bind().as(f => `font-size: ${f * 1.2}px`),
		halign: Gtk.Align.CENTER,
		marginStart: 3,
	})
});
