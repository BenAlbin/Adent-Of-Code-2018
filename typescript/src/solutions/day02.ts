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

console.log(part1(args));
