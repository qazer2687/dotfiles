import GLib20 from "gi://GLib?version=2.0";
import opts from "options";

const clock = Variable(
	GLib20.DateTime.new_now_local(),
	{ poll: [1000, () => GLib20.DateTime.new_now_local()] }
);

const month = Utils.derive([clock], (c) => [
	"JA",
	"FE",
	"MR",
	"AP",
	"MY",
	"JN",
	"JY",
	"AU",
	"SE",
	"OC",
	"NV",
	"DC"
][c.get_month() - 1]);

const day = Utils.derive([clock], (c) => [
	"MO",
	"TU",
	"WE",
	"TH",
	"FR",
	"SA",
	"SU"
][c.get_day_of_week() - 1]);

const date = Utils.derive([clock], (c) => c.get_day_of_month());

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
						label: date.toString().padStart(2, "0"),
						justification: "center"
					}),
					Widget.Label({
						label: d,
						marginTop: opts.space.bind(),
						marginBottom: opts.space.bind(),
						justification: "center"
					})
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

