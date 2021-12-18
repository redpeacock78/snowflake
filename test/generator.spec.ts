const util = require("util");
const now = require("jest-mock-now");
const snowflake = require("../src/snowflake");

const generator = snowflake.generator(512);

describe("Correctly Generates IDs", (): void => {
  test("Ids are correctly sortable chronologically", (): void => {
    const list: bigint[] = [];
    for (let i = 0; i < 1000; i++) {
      const value: string = generator.next().value.toString();
      list.push(BigInt(value));
    }
    expect(list).toEqual([...list].sort());
  });
  test("Ids can generate more than 4096 without failing and are still k-sortable", (): void => {
    const list: bigint[] = [];
    for (let i = 0; i < 5000; i++) {
      const value: string = generator.next().value.toString();
      list.push(BigInt.asUintN(64, BigInt(value) >> 22n));
    }
    util.inspect.defaultOptions.maxArrayLength = null;
    expect(list).toEqual([...list].sort());
  });
  test("Ids are always unique", (): void => {
    const list: bigint[] = [];
    for (let i = 0; i < 50000; i++) {
      const value: bigint = generator.next().value;
      list.push(value);
    }
    expect(new Set(list).size === list.length).toBeTruthy();
  });
  test("Ids throw an error if they generate >4096 in 1 millisecond", (): void => {
    now(new Date("2017-06-22"));
    const list: bigint[] = [];
    for (let i = 0; i < 4096; i++) {
      const value: string = generator.next().value.toString();
      list.push(BigInt.asUintN(64, BigInt(value) >> 22n));
    }
    expect(generator.next().value).toEqual(Error("Failed to generate snowflake id."));
  });
});
