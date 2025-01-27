import Bar from "widgets/bar";
import ScreenCorners from "widgets/screencorners";
import { allMonitors } from "lib/util";
import "style";

App.config({
	windows: [
		...allMonitors(Bar),
		// ...allMonitors(NotificationPopups),
		...allMonitors(ScreenCorners),
		// ...allMonitors(OSD),
		// Launcher(),
		// PowerMenu(),
		// SettingsDialog(),
		// Verification(),
	],
});
