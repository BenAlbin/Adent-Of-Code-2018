export function part1(args: ReadonlyArray<string>): number {
  let counts = args.reduce(
    (acc, val) => {
      let { two: twoForLine, three: threeForLine } = count_for_line(val);
      return {
        twos: acc.twos + twoForLine,
        threes: acc.threes + threeForLine
      };
    },
    { twos: 0, threes: 0 }
  );
  return counts.twos * counts.threes;
}

function count_for_line(line: string): { two: number; three: number } {
  const lineList: ReadonlyArray<string> = line.split("");
  const twosAndThrees: ReadonlyArray<string> = toDuplicates(lineList);
  const threesOnly: ReadonlyArray<string> = toDuplicates(twosAndThrees);
  const threesRaw: number = threesOnly.length;
  const twosRaw: number = toUnique(twosAndThrees).length - threesRaw;
  return { two: twosRaw > 0 ? 1 : 0, three: threesRaw > 0 ? 1 : 0 };
}

function toDuplicates<T>(array: ReadonlyArray<T>): Array<T> {
  return array.filter(
    (value: T, index: number, self: ReadonlyArray<T>) =>
      self.indexOf(value) != index
  );
}

function toUnique<T>(array: ReadonlyArray<T>): Array<T> {
  return array.filter(
    (value: T, index: number, self: ReadonlyArray<T>) =>
      self.indexOf(value) === index
  );
}

export function part2(args: ReadonlyArray<string>): string {
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
