import { mkOptions, opt } from "lib/option";
import { opt_file } from "lib/session";
import { BarWidget } from "widgets/bar";

export const opts = mkOptions(opt_file, {
	font: {
		family: opt("JetBrainsMono Nerd Font"),
		size: opt(11),
	},
	space: opt(4),
	radius: opt(8),
	system: {
		pollInterval: opt(2000),
	},
	bar: {
		position: opt<"start" | "end">("start"),
		vertical: opt(true),
		mode: opt<"floating" | "solid" | "fixed">("floating"),
		style: {
			bg: opt("#0d1117"),
			fg: opt("#ffffff"),
			border: opt("rgba(255, 255, 255, 0.2)"),
			accent: opt("#be95ff"),
		},
		layout: {
			start: opt<Array<BarWidget>>([
				"launcher",
				// "taskbar",
				"date",
				"systray",
				"expander",
			]),
			center: opt<Array<BarWidget>>([
				"workspaces"
			]),
			end: opt<Array<BarWidget>>([
				"expander",
				// "colorpicker",
				"system",
				"time",
				"battery"
			]),
		},
		workspaces: {
			workspaces: opt<(string | [string, string])[]>([
				"一",
				"二",
				"三",
				"四",
				"五",
				"六",
				"七",
				"八",
				"九",
				"十",
			])
		},
	},
});

console.log(JSON.stringify(opts, null, 2));

export default opts;
