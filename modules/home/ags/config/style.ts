import { Opt } from "lib/option";
import { tmp_dir } from "lib/session";
import { bash, dependencies } from "lib/util";
import opts from "options";

const $ = (name: string, value: string | Opt<any>) => `$${name}: ${value};`

const variables = () => [
	$("font-name", opts.font.family),
	$("font-size", opts.font.size),

	$("space", opts.space),
	$("radius", opts.radius),

	$("bar-bg", opts.bar.style.bg),
	$("bar-fg", opts.bar.style.fg),
	$("bar-border", opts.bar.style.border),
	$("bar-accent", opts.bar.style.accent),

	// Floating/Solid
	$("bar-window-bg", opts.bar.mode.value === "floating" ? "transparent" : opts.bar.style.bg),
	$("bar-window-rounding", (opts.bar.mode.value !== "fixed").toString()),
	$("bar-position", opts.bar.position),
	$("bar-vert", opts.bar.vertical),
];

async function resetCss() {
	if (!dependencies("sass", "fd"))
		return

	try {
		const vars = `${tmp_dir}/variables.scss`
		const scss = `${tmp_dir}/main.scss`
		const css = `${tmp_dir}/main.css`

		const fd = await bash(`fd ".scss" ${App.configDir}`)
		const files = fd.split(/\s+/)
		const imports = [vars, ...files].map(f => `@import '${f}';`)

		await Utils.writeFile(variables().join("\n"), vars)
		await Utils.writeFile(imports.join("\n"), scss)
		await bash`sass ${scss} ${css}`

		App.applyCss(css, true)
	} catch (error) {
		error instanceof Error
			? logError(error)
			: console.error(error)
	}
}

await resetCss();

opts.config.connect("changed", () => resetCss());
