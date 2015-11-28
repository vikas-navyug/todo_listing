/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults){
  var app = new EmberApp(defaults, {
      outputPaths: {
        app: {
          html: 'index.html',
          css: {
            'app': '/assets/app.css'
          },
          js: '/assets/app.js'
        },
        vendor: {
          css: '/assets/vendor.css',
          js: '/assets/vendor.js'
        }
      },
      sassOptions: {
        includePaths: [
          'bower_components/bootstrap-sass/assets/stylesheets'
        ]
      }
    }
  );
  return app.toTree();
};
