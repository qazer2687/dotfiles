import opts from "options";
import LauncherBar from "widgets/bar/launcher";
import Workspaces from "widgets/bar/workspaces";
import Date from "widgets/bar/date";
import HanDate from "widgets/bar/handate";
import Time from "widgets/bar/time";
import SysTray from "widgets/bar/systray";
import System from "widgets/bar/system";
import BatteryBar from "widgets/bar/battery";
import { Binding } from "types/service";

const { layout, position, vertical, mode } = opts.bar;
const { start, center, end } = layout;

const widgets = {
	launcher: LauncherBar,
	workspaces: Workspaces,
	date: Date,
	handate: HanDate,
	time: Time,
	systray: SysTray,
	system: System,
	battery: BatteryBar,
	expander: () => Widget.Box({ expand: true }),
};

export type BarWidget = keyof typeof widgets;

export function barAlignedMargin(margin: number | Binding<any, any, number>) {
	return vertical.bind().as(v => v ? {
		marginTop: margin,
		marginBottom: margin,
	} : {
		marginStart: typeof margin === "number" ? margin * 2 : margin.as(m => m * 2),
		marginEnd: typeof margin === "number" ? margin * 2 : margin.as(m => m * 2),
	});
}

export default (monitor: number) => Widget.Window({
	monitor,
	class_name: "bar",
	name: `bar${monitor}`,
	exclusivity: "exclusive",
	anchor: Utils.merge(
		[position.bind(), vertical.bind()],
		(pos, vert) =>
			pos === "start"
				? (vert
					? ["left", "top", "bottom"]
					: ["top", "left", "right"])
				: (vert
					? ["right", "top", "bottom"]
					: ["bottom", "left", "right"])
	),
	margins: Utils.merge(
		[position.bind(), mode.bind(), vertical.bind()],
		(pos, mode, vert) =>
			mode === "fixed" ? [0, 0, 0, 0] :
				pos === "start"
					? (vert
						? [10, 0, 10, 10]
						: [10, 10, 0, 10])
					: (vert
						? [10, 10, 10, 0]
						: [0, 10, 10, 10])
	),
	child: Widget.CenterBox({
		css: "min-width: 2px; min-height: 2px;",
		vertical: opts.bar.vertical.bind(),
		margin: Utils.merge(
			[opts.bar.mode.bind(), opts.space.bind()],
			(m, s) => m === "floating" ? 0 : s * 2
		),
		startWidget: Widget.Box({
			spacing: opts.space.bind().as(x => 2.5 * x),
			hexpand: opts.bar.vertical.bind().as(v => !v),
			vexpand: opts.bar.vertical.bind(),
			vertical: opts.bar.vertical.bind(),
			children: start.bind().as(s => s.map(w => widgets[w](monitor)))
		}),
		centerWidget: Widget.Box({
			spacing: opts.space.bind().as(x => 2.5 * x),
			hexpand: opts.bar.vertical.bind().as(v => !v),
			vexpand: opts.bar.vertical.bind(),
			vertical: opts.bar.vertical.bind(),
			children: center.bind().as(s => s.map(w => widgets[w](monitor)))
		}),
		endWidget: Widget.Box({
			spacing: opts.space.bind().as(x => 2.5 * x),
			hexpand: opts.bar.vertical.bind().as(v => !v),
			vexpand: opts.bar.vertical.bind(),
			vertical: opts.bar.vertical.bind(),
			children: end.bind().as(s => s.map(w => widgets[w](monitor)))
		}),
	}),
});
