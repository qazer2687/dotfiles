import GLib20 from "gi://GLib?version=2.0";
import Gio from "types/@girs/gio-2.0/gio-2.0";

export const im = Variable("", {
	poll: [
		2000,
		() => {
			const current = Gio.DBus.session.call_sync(
				"org.fcitx.Fcitx5",
				"/controller",
				"org.fcitx.Fcitx.Controller1",
				"CurrentInputMethod",
				null,
				null,
				Gio.DBusCallFlags.NONE,
				-1,
				null,
			).get_child_value(0).get_string()[0];

			const available: ([
				string,
				string,
				string,
				string,
				string,
				string,
				boolean
			])[] = Gio.DBus.session.call_sync(
				"org.fcitx.Fcitx5",
				"/controller",
				"org.fcitx.Fcitx.Controller1",
				"AvailableInputMethods",
				null,
				null,
				Gio.DBusCallFlags.NONE,
				-1,
				null
			).get_child_value(0).recursiveUnpack();

			return ((available.find(x => x[0] === current) || [, , , ""])[4] || "").slice(0, 2);
		}
	]
});
