"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var fs_1 = require("fs");
var day01_1 = require("./solutions/day01");
var day1args = fs_1.readFileSync("./src/resources/day01.txt", "utf8").split("\n");
console.log("Day 1 Part 1 Results : " + day01_1.part1(day1args));
console.log("Day 1 Part 2 Results : " + day01_1.part2(day1args));
