const esbuild = require("esbuild");
const glob = require("glob");

const inputFiles = glob.sync("app/javascript/*.*");
console.log(inputFiles);
esbuild.buildSync({
  entryPoints: [inputFiles],
  outdir: "app/assets/builds",
  bundle: true,
  sourcemap: true,
});
