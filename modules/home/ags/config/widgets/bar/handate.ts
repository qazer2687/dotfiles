import GLib20 from "gi://GLib?version=2.0";
import opts from "options";
import { WrapMode } from "types/@girs/pango-1.0/pango-1.0.cjs";

const clock = Variable(
	GLib20.DateTime.new_now_local(),
	{ poll: [1000, () => GLib20.DateTime.new_now_local()] }
);

const hz = [
	"",
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
	"十\n一",
	"十\n二"
];

const month = Utils.derive([clock], (c) => hz[c.get_month()]);

const day = Utils.derive([clock], (c) => [
	"MO",
	"TU",
	"WE",
	"TH",
	"FR",
	"SA",
	"SU"
][c.get_day_of_week() - 1]);

const date = Utils.derive(
	[clock],
	(c) => `${[
		"",
		"十\n",
		"二\n十\n",
		"三\n十\n"
	][Math.floor(c.get_day_of_month() / 10)]}${hz[c.get_day_of_month() % 10]}`
);

const longdate = Utils.derive([clock], (c) => c.format("%A %e %B"));

export default () => Widget.Button({
	classNames: ["bar-panel", "bar-panel-button", "time"],
	child: Widget.Box({
		vertical: opts.bar.vertical.bind(),
		children: Utils.merge([month.bind(), day.bind(), date.bind(), longdate.bind(), opts.bar.vertical.bind()], (m, d, date, l, vert) =>
			vert
				? [
					Widget.Label({
						label: m,
						marginTop: opts.space.bind(),
						marginBottom: opts.space.bind(),
						justification: "center"
					}),
					Widget.Label({
						label: "月",
						className: "hd-faint",
						justification: "center"
					}),
					Widget.Label({
						label: date,
						marginTop: opts.space.bind(),
						marginBottom: opts.space.bind(),
						justification: "center"
					}),
					Widget.Label({
						label: "号",
						className: "hd-faint",
						justification: "center",
						marginBottom: opts.space.bind(),
					}),
				]
				: [
					Widget.Label({
						label: l,
						margin: opts.space.bind(),
						marginTop: opts.space.bind(),
						marginBottom: opts.space.bind(),
						justification: "center"
					})
				]),
	}),
});

