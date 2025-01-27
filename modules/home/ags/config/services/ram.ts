import opts from "options"

const divide = ([total, free]: string[]) => Number.parseInt(free) / Number.parseInt(total)
export const ram = Variable(0, {
	poll: [opts.system.pollInterval.value, "free", out => divide(out.split("\n")
		.find(line => line.includes("Mem:"))
		?.split(/\s+/)
		.splice(1, 2) || ["1", "1"])],
})
