import { readFileSync } from "fs";

const args: ReadonlyArray<String> = readFileSync(
  "./src/resources/day01.txt",
  "utf8"
).split(/\r?\n/);

function part1(args: ReadonlyArray<String>): number {
  return args.reduce((acc, val) => acc + +val, 0);
}

function part2(args: ReadonlyArray<String>): number {
  let seen = new Set([0]);
  let freq: number = 0;
  while (true) {
    for (let i: number = 0; i < args.length; i++) {
      freq += +args[i];
      if (seen.has(freq)) {
        return freq;
      }
      seen.add(freq);
    }
  }
  return 0;
}

console.log("Part 1 Results: " + part1(args));
console.log("Part 2 Results: " + part2(args));
