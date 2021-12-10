const main = require("../dist/snowflake.js");

type Iterator = {
  next: () => { value: string; done: boolean };
};

export const snowflake = (machine_id: number): Iterator => {
  return main.generator(machine_id);
};
