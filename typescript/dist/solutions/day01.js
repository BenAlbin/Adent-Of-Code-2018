"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function part1(args) {
    return args.reduce(function (acc, val) { return acc + +val; }, 0);
}
exports.part1 = part1;
function part2(args) {
    var seen = new Set([0]);
    var freq = 0;
    while (true) {
        for (var i = 0; i < args.length; i++) {
            freq += +args[i];
            if (seen.has(freq)) {
                return freq;
            }
            seen.add(freq);
        }
    }
    return 0;
}
exports.part2 = part2;
