import { readFileSync } from "fs";
import { part1 as day1part1, part2 as day1part2 } from "./solutions/day01";

const day1args: ReadonlyArray<String> = readFileSync(
  "./src/resources/day01.txt",
  "utf8"
).split("\n");

console.log("Day 1 Part 1 Results : " + day1part1(day1args));
console.log("Day 1 Part 2 Results : " + day1part2(day1args));
