import * as fs from "fs";

const lines: string[] = fs
  .readFileSync("/dev/stdin", "utf8").trim().split("\n");
