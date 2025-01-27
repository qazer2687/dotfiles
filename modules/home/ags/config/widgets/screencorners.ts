import opts from "options";

export default (monitor: number) => Widget.Window({
	monitor,
	name: `corner${monitor}`,
	class_name: "screen-corner",
	anchor: ["top", "bottom", "left", "right"],
	clickThrough: true,
	child: Widget.Box({
		class_name: "shadow",
		child: Widget.Box({
			class_name: "border",
			expand: true,
			child: Widget.Box({
				class_name: "corner",
				expand: true
			})
		})
	}),
	setup: self => self.hook(opts.bar.mode, _ => {
		self.visible = (opts.bar.mode.value === "fixed");
	})
});
