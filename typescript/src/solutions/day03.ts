interface Claim {
  id: number;
  xPos: number;
  yPos: number;
  width: number;
  height: number;
}

export function part1(args: ReadonlyArray<string>): number {
  const parsedClaims: Array<Claim> = args.map(parseClaim);
  return 0;
}

export function part2(args: ReadonlyArray<string>): number {
  return 0;
}

function parseClaim(claim: string): Claim {
  const split = claim.split(/[^0-9]/).filter(Boolean);
  const [id, xPos, yPos, width, height]: string[] = split;
  return {
    id: +id,
    xPos: +xPos,
    yPos: +yPos,
    width: +width,
    height: +height
  };
}
