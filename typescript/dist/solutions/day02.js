"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function part1(args) {
    var counts = args.reduce(function (acc, val) {
        var _a = count_for_line(val), two_for_line = _a.two, three_for_line = _a.three;
        return {
            twos: acc.twos + two_for_line,
            threes: acc.threes + three_for_line
        };
    }, { twos: 0, threes: 0 });
    return counts.twos * counts.threes;
}
exports.part1 = part1;
function count_for_line(line) {
    var lineList = line.split("");
    var twosAndThrees = to_duplicates(lineList);
    var threesOnly = to_duplicates(twosAndThrees);
    var threesRaw = threesOnly.length;
    var twosRaw = to_unique(twosAndThrees).length - threesRaw;
    return { two: twosRaw > 0 ? 1 : 0, three: threesRaw > 0 ? 1 : 0 };
}
function to_duplicates(array) {
    return array.filter(function (value, index, self) {
        return self.indexOf(value) != index;
    });
}
function to_unique(array) {
    return array.filter(function (value, index, self) {
        return self.indexOf(value) === index;
    });
}
function part2(args) {
    var id_length = args[0].length;
    var args_length = args.length;
    for (var i = 0; i < id_length; i++) {
        var seen = new Set();
        for (var n = 0; n < args_length; n++) {
            var removeOneString = args[n].substring(0, i) + args[n].substring(i + 1);
            if (seen.has(removeOneString)) {
                return removeOneString;
            }
            seen.add(removeOneString);
        }
    }
    return "";
}
exports.part2 = part2;
