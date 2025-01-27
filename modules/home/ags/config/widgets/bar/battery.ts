const battery = await Service.import("battery");

// TODO: Implement this when I actually have a laptop to test it with
export default () => Widget.Box({
	setup: self => self.hook(battery, self => {
		self.visible = !!battery.available;
	})
});
