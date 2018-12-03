export function part1(args: ReadonlyArray<string>): number {
  return args.reduce((acc, val) => acc + +val, 0);
}

export function part2(args: ReadonlyArray<string>): number {
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
