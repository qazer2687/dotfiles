import opts from "options";
import { barAlignedMargin } from "widgets/bar";

//const hyprland = await Service.import("hyprland");
const { workspaces } = opts.bar.workspaces;

export default (monitor: number) => {
	return Widget.Button({
		class_names: opts.bar.vertical.bind().as(v => [
			"bar-panel",
			"bar-panel-button",
			v ? "vertical" : "horizontal"
		]),
		child: Widget.Box({
			vertical: opts.bar.vertical.bind(),
			children: Utils.merge(
				[workspaces.bind(), barAlignedMargin(opts.space.bind())],
				(spaces, margin) => spaces.map((ws, i) => Widget.Label({
					className: "workspace",
					attribute: ws,
					vpack: "center",
					label: hyprland.bind("active").as(active =>
						typeof ws === "string"
							? ws
							: active.workspace.id === (i + 1) ? ws[1] : ws[0],
					),
					justification: "center",
					setup: self => self.hook(hyprland, () => {
						const active = hyprland.active.workspace.id === (i + 1);
						self.toggleClassName(
							"active",
							active && (hyprland.getWorkspace(i + 1)?.monitorID === monitor || true)
						);
						const occupied = (hyprland.getWorkspace(i + 1)?.windows || 0) > 0;
						self.toggleClassName("occupied", occupied);
						self.set_visible(occupied || active);
					}),
					...margin
				}))),
		})
	})
};
