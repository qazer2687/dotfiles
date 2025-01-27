import GLib20 from "gi://GLib?version=2.0";
import opts from "options";
import { barAlignedMargin } from "widgets/bar";

const clock = Variable(
	GLib20.DateTime.new_now_local(),
	{ poll: [1000, () => GLib20.DateTime.new_now_local()] }
);

const hour = Utils.derive([clock], c => c.format("%H")!);
const minute = Utils.derive([clock], c => c.format("%M")!);

export default () => Widget.Button({
	classNames: ["bar-panel", "bar-panel-button", "time"],
	child: Widget.Box({
		vertical: opts.bar.vertical.bind(),
		children: barAlignedMargin(opts.space.bind()).as(margin => [
			Widget.Label({
				label: hour.bind(),
				justification: "center",
				...margin
			}),
			Widget.Label({
				visible: opts.bar.vertical.bind().as(v => !v),
				label: ":",
				justification: "center",
			}),
			Widget.Label({
				label: minute.bind(),
				justification: "center",
				...margin
			}),
		]),
	}),
});
