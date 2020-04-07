const environment = require("./environment")
if (process.env.NODE_ENV !== 'test') {
  environment.plugins.get("Manifest").opts.writeToFileEmit = true
}
const config = environment.toWebpackConfig()
config.devtool = "inline-source-map"
module.exports = config
