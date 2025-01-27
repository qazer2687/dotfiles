import opts from "options";
import { cpu } from "services/cpu";
import { im } from "services/fcitx5";
import { ram } from "services/ram";
import { Align } from "types/@girs/gtk-3.0/gtk-3.0.cjs";
import { barAlignedMargin } from "widgets/bar";


const network = await Service.import("network");

//const NetworkIndicator = () => Widget.Box({
//	//vexpand: opts.bar.vertical.bind().as(v => !v),
//	//hexpand: opts.bar.vertical.bind(),
//	//halign: Align.CENTER,
//	//valign: Align.CENTER,
//	//on_clicked: () => App.toggleWindow("quicksettings"),
//	child: Widget.Icon({
//		halign: Align.CENTER,
//		valign: Align.CENTER,
//		css: "border: none"
//	})
//}).hook(network, self => {
//	const icon = network[network.primary || "wifi"]?.icon_name;
//	self.child.icon = icon || "";
//	self.visible = !!icon;
//});

const NetworkIndicator = () => Widget.Icon().hook(network, self => {
	const icon = network[network.primary || "wifi"]?.icon_name;
	self.icon = icon || "";
	self.visible = !!icon;
});

const KeyboardIndicator = () => Widget.Label({
	label: im.bind(),
});

const CPUIndicator = () => Widget.CircularProgress({
	css: `
		font-size: 2px;
		min-width: 16px;
		min-height: 16px;
	`,
	value: cpu.bind(),
	startAt: 0.4,
	endAt: 0.1,
	rounded: true,
	//child: Widget.Icon({
	//	size: 8,
	//	icon: "computer-symbolic"
	//})
	child: Widget.Label({
		label: " ",
		css: opts.font.size.bind().as(f => `font-size: ${f - 2}px`),
		marginStart: 2,
		marginTop: 0,
	})
});

const MemoryIndicator = () => Widget.CircularProgress({
	css: `
		font-size: 2px;
		min-width: 16px;
		min-height: 16px;
	`,
	value: ram.bind(),
	startAt: 0.4,
	endAt: 0.1,
	rounded: true,
	child: Widget.Label({
		label: " ",
		css: opts.font.size.bind().as(f => `font-size: ${f - 5}px`),
		marginStart: 1,
		marginTop: 0,
	})
});

export default () => Widget.Button({
	classNames: ["system-indicators", "bar-panel", "bar-panel-button"],
	//vexpand: opts.bar.vertical.bind().as(v => !v),
	//hexpand: opts.bar.vertical.bind(),
	//halign: Align.CENTER,
	//valign: Align.CENTER,
	child: barAlignedMargin(opts.space.bind()).
		as(margin => Widget.Box({
			vertical: opts.bar.vertical.bind(),
			//spacing: opts.space.bind().as(s => s * 2.5),
			spacing: opts.space.bind().as(s => s * 1.5),
			children: [
				MemoryIndicator(),
				CPUIndicator(),
				NetworkIndicator(),
				// TODO: Make a bluetooth indicator when I have a machine with bluetooth
				// BluetoothIndicator(),
				// TODO: AudioIndicator(),
				// TODO: MicrophoneIndicator(),
				KeyboardIndicator(),
			],
			...margin
		})),
});
