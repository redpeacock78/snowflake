module.exports = {
  testEnvironment: "node",
  transform: {
    "^.+\\.ls$": "livescript-jest",
    "^.+\\.(j|t)sx?$": "@swc/jest",
  },
  testRegex: "/test/.*\\.tsx?$",
  moduleFileExtensions: ["js", "jsx", "json", "ls", "ts", "tsx"],
};
