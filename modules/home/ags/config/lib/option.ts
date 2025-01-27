//! This file contains a highly stripped down and slightly optimized version of
//! https://github.com/Aylur/dotfiles/blob/a7cfbdc80d79e063894e7b4f7dbeae241894eabd/ags/lib/option.ts

import { Variable } from "resource:///com/github/Aylur/ags/variable.js"

class Config extends Service {
	static { Service.register(this); }

	content: { [key: string]: any } = {};

	constructor(public file: string) {
		super();

		this.load();

		Utils.monitorFile(file, () => {
			this.load();
			this.emit("changed");
		});

		console.log(`monitoring config ${file}`)
	}

	load() {
		this.content = JSON.parse(Utils.readFile(this.file) || "{}");
		console.log(`loaded ${this.file}:`, this.content);
	}

	get(id: string): any {
		return id.split(".")
			.slice(0, -1)
			.reduce((o, part) => o[part] || {}, this.content)[
			id.split(".").slice(-1)[0]
		];
	}

	set(id: string, value: any) {
		let content = this.content;
		for (const part of id.split(".").slice(0, -1)) {
			if (content[part])
				content = content[part];
			else {
				content[part] = {};
				content = content[part]
			}
		}
		content[id.split(".").slice(-1)[0]] = value;

		Utils.writeFileSync(JSON.stringify(this.content, null, 2), this.file);
	}
}

export class Opt<T = unknown> extends Variable<T> {
	static { Service.register(this) }

	constructor(public initial: T, public persistent: boolean) {
		super(initial);
	}

	id = ""

	toString() { return `${this.value}` }
	toJSON() { return `opt:${this.value}` }

	init(config: Config, id: string) {
		this.id = id;
		this.value = config.get(id) ?? this.value;
		console.log("initialized", id, "as", this.value);

		config.connect("changed", config => {
			this.value = config.get(id) ?? this.initial;
		});
	}

	reset() {
		if (this.persistent)
			return;

		this.value = this.initial;
	}
}

type OptProps = {
	persistent?: boolean;
};

export const opt = <T>(initial: T, opts?: OptProps) => new Opt(
	initial,
	opts?.persistent || false
);

function buildOptions(object: object, config: Config, path = ""): Opt[] {
	return Object.keys(object).flatMap(key => {
		const option = object[key];
		const id = path ? `${path}.${key}` : key;

		if (option instanceof Opt) {
			option.init(config, id);
			return option;
		}

		if (typeof option === "object")
			return buildOptions(option, config, id);

		return [];
	});
}

export function mkOptions<Q extends object>(configFile: string, object: Q) {
	const config = new Config(configFile);
	const options = buildOptions(object, config);

	return Object.assign(object, {
		config,
		array: () => options,
	});
}
