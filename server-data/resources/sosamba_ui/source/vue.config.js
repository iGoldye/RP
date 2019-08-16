var path = ''

module.exports = {

  // disable hashes in filenames
  filenameHashing: false,

  /*
  // delete HTML related webpack plugins
  chainWebpack: config => {
    config.plugins.delete('html')
    config.plugins.delete('preload')
    config.plugins.delete('prefetch')
  },
*/

  configureWebpack: {
    mode: 'production',
//    mode: 'development',
//    entry: {
//      index: './src/main.js',
//      ListMenu: './src/components/ListMenu.js',
//    },
    output: {
      publicPath: path,
      chunkFilename: '[name].bundle.js',
    },

/*
    optimization: {
      moduleIds: 'named',
      chunkIds: 'named',
      concatenateModules: false,
      namedChunks: true,
      namedModules: true,
      minimize: false,

      splitChunks: {
        chunks: 'all',
        minSize: 1,
    },
  }, 
*/

  },
  publicPath: path,

//  chainWebpack: config => {
//    if (config.plugins.has('optimize-css')) {
//      config.plugins.delete('optimize-css')
//    }
//  },
}
