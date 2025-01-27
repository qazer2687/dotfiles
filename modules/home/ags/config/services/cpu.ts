import opts from "options"

const divide = ([total, free]: string[]) => Number.parseInt(free) / Number.parseInt(total)

export const cpu = Variable(0, {
	poll: [opts.system.pollInterval.value, "top -b -n 1", out => divide(["100", out.split("\n")
		.find(line => line.includes("Cpu(s)"))
		?.split(/\s+/)[1]
		.replace(",", ".") || "0"])],
})
