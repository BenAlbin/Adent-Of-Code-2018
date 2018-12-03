import { readFileSync } from "fs";
import { part1 as day1part1, part2 as day1part2 } from "./solutions/day01";

const day1args: ReadonlyArray<string> = readFileSync(
  "./src/resources/day01.txt",
  "utf8"
).split("\n");

console.log("Day 1 Part 1 Results : " + day1part1(day1args));
console.log("Day 1 Part 2 Results : " + day1part2(day1args));

import { part1 as day2part1, part2 as day2part2 } from "./solutions/day02";

const day2args: ReadonlyArray<string> = readFileSync(
  "./src/resources/day02.txt",
  "utf8"
).split("\n");

console.log("Day 2 Part 1 Results : " + day2part1(day2args));
console.log("Day 2 Part 2 Results : " + day2part2(day2args));

import { part1 as day3part1, part2 as day3part2 } from "./solutions/day03";

const day3args: ReadonlyArray<string> = readFileSync(
  "./src/resources/day03.txt",
  "utf8"
).split("\n");

console.log("Day 3 Part 1 Results : " + day3part1(day3args));
console.log("Day 3 Part 2 Results : " + day3part2(day3args));
