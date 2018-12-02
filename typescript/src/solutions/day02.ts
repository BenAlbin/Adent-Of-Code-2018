import { readFileSync } from "fs";

const args: ReadonlyArray<String> = readFileSync(
  "./src/resources/day02.txt",
  "utf8"
).split("\n");

function part1(args: ReadonlyArray<String>): number {
  let counts = args.reduce(
    (acc, val) => {
      let { two: two_for_line, three: three_for_line } = count_for_line(val);
      return {
        twos: acc.twos + two_for_line,
        threes: acc.threes + three_for_line
      };
    },
    { twos: 0, threes: 0 }
  );
  return counts.twos * counts.threes;
}

function count_for_line(line: String): { two: number; three: number } {
  const lineList: ReadonlyArray<String> = line.split("");
  const twosAndThrees: ReadonlyArray<String> = to_duplicates(lineList);
  const threesOnly: ReadonlyArray<String> = to_duplicates(twosAndThrees);
  const threesRaw: number = threesOnly.length;
  const twosRaw: number = to_unique(twosAndThrees).length - threesRaw;
  return { two: twosRaw > 0 ? 1 : 0, three: threesRaw > 0 ? 1 : 0 };
}

function to_duplicates<T>(array: ReadonlyArray<T>): Array<T> {
  return array.filter(
    (value: T, index: number, self: ReadonlyArray<T>) =>
      self.indexOf(value) != index
  );
}

function to_unique<T>(array: ReadonlyArray<T>): Array<T> {
  return array.filter(
    (value: T, index: number, self: ReadonlyArray<T>) =>
      self.indexOf(value) === index
  );
}

function part2(args: ReadonlyArray<String>): string {
  const id_length: number = args[0].length;
  const args_length: number = args.length;
  for (let i: number = 0; i < id_length; i++) {
    let seen = new Set<string>();
    for (let n: number = 0; n < args_length; n++) {
      let removeOneString = args[n].substring(0, i) + args[n].substring(i + 1);
      if (seen.has(removeOneString)) {
        return removeOneString;
      }
      seen.add(removeOneString);
    }
  }
  return "";
}

console.log("Part 1 Results: " + part1(args));
console.log("Part 2 Results: " + part2(args));
