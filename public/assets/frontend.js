"use strict";
/* jshint ignore:start */

/* jshint ignore:end */

define('frontend/adapters/application', ['exports', 'ember-data'], function (exports, _emberData) {
  var ApplicationAdapter;

  ApplicationAdapter = _emberData['default'].RESTAdapter.extend();

  exports['default'] = ApplicationAdapter;
});
define('frontend/app', ['exports', 'ember', 'ember/resolver', 'ember/load-initializers', 'frontend/config/environment'], function (exports, _ember, _emberResolver, _emberLoadInitializers, _frontendConfigEnvironment) {
  var App;

  _ember['default'].MODEL_FACTORY_INJECTIONS = true;

  App = _ember['default'].Application.extend({
    modulePrefix: _frontendConfigEnvironment['default'].modulePrefix,
    podModulePrefix: _frontendConfigEnvironment['default'].podModulePrefix,
    Resolver: _emberResolver['default']
  });

  (0, _emberLoadInitializers['default'])(App, _frontendConfigEnvironment['default'].modulePrefix);

  exports['default'] = App;
});
define('frontend/components/app-version', ['exports', 'ember-cli-app-version/components/app-version', 'frontend/config/environment'], function (exports, _emberCliAppVersionComponentsAppVersion, _frontendConfigEnvironment) {

  var name = _frontendConfigEnvironment['default'].APP.name;
  var version = _frontendConfigEnvironment['default'].APP.version;

  exports['default'] = _emberCliAppVersionComponentsAppVersion['default'].extend({
    version: version,
    name: name
  });
});
define('frontend/controllers/array', ['exports', 'ember'], function (exports, _ember) {
  exports['default'] = _ember['default'].Controller;
});
define('frontend/controllers/login', ['exports', 'ember', 'frontend/helpers/constants'], function (exports, _ember, _frontendHelpersConstants) {
  var controller;

  controller = _ember['default'].Controller.extend({
    actions: {
      login: function login() {
        var email, password, that;
        email = this.get('email');
        password = this.get('password');
        that = this;
        return $.ajax({
          url: _frontendHelpersConstants['default'].SIGN_IN_URL,
          type: 'POST',
          data: {
            username: email,
            password: password
          },
          success: function success() {
            alert('User Logged in Successfully');
            return that.transitionToRoute('home');
          },
          error: function error(_error) {
            return alert(_error.message);
          }
        });
      }
    }
  });

  exports['default'] = controller;
});
define('frontend/controllers/object', ['exports', 'ember'], function (exports, _ember) {
  exports['default'] = _ember['default'].Controller;
});
define('frontend/helpers/constants', ['exports'], function (exports) {
  var constants;

  constants = {
    HOST: '',
    APP_NAME: 'My App'
  };

  constants.LOGOUT_URL = constants.HOST + '/sign_out';

  constants.LOGGED_IN_USER_URL = constants.HOST + '/users/logged_in';

  constants.SIGN_IN_URL = constants.HOST + "/users/sign_in";

  constants.SIGN_UP_URL = constants.HOST + "/users/sign_up";

  constants.FORGOT_PASSWORD_URL = constants.HOST + '/users/forgot_password';

  constants.RESET_PASSWORD_URL = constants.HOST + '/auth/password';

  constants.CHANGE_PASSWORD_URL = constants.HOST + '/users/change_password';

  exports['default'] = constants;
});
define('frontend/helpers/http', ['exports'], function (exports) {
  var Http;

  Http = {
    ajax: function ajax(url, type, hash, context) {
      if (type.toLowerCase() !== 'get' && hash.data !== null) {
        hash.data = JSON.stringify(hash.data);
      }
      hash.url = url;
      hash.type = type;
      hash.dataType = 'json';
      hash.contentType = 'application/json; charset=utf-8';
      hash.context = context || this;
      return $.ajax(hash);
    }
  };

  exports['default'] = Http;
});
define('frontend/helpers/session', ['exports', 'ember', 'frontend/helpers/constants'], function (exports, _ember, _frontendHelpersConstants) {
  var Session;

  Session = _ember['default'].Object.extend({
    isAuthenticated: false,
    currentUser: null,
    appName: _frontendHelpersConstants['default'].APP_NAME,
    initialize: function initialize(user) {
      var that, userPromise;
      if (user.id) {
        that = this;
        userPromise = this.store.findRecord('user', user.id).then(function (user) {
          return that.set('currentUser', userPromise);
        });
        return userPromise;
      }
    }
  });

  exports['default'] = Session;
});
define('frontend/initializers/app-version', ['exports', 'ember-cli-app-version/initializer-factory', 'frontend/config/environment'], function (exports, _emberCliAppVersionInitializerFactory, _frontendConfigEnvironment) {
  exports['default'] = {
    name: 'App Version',
    initialize: (0, _emberCliAppVersionInitializerFactory['default'])(_frontendConfigEnvironment['default'].APP.name, _frontendConfigEnvironment['default'].APP.version)
  };
});
define('frontend/initializers/export-application-global', ['exports', 'ember', 'frontend/config/environment'], function (exports, _ember, _frontendConfigEnvironment) {
  exports.initialize = initialize;

  function initialize() {
    var application = arguments[1] || arguments[0];
    if (_frontendConfigEnvironment['default'].exportApplicationGlobal !== false) {
      var value = _frontendConfigEnvironment['default'].exportApplicationGlobal;
      var globalName;

      if (typeof value === 'string') {
        globalName = value;
      } else {
        globalName = _ember['default'].String.classify(_frontendConfigEnvironment['default'].modulePrefix);
      }

      if (!window[globalName]) {
        window[globalName] = application;

        application.reopen({
          willDestroy: function willDestroy() {
            this._super.apply(this, arguments);
            delete window[globalName];
          }
        });
      }
    }
  }

  exports['default'] = {
    name: 'export-application-global',

    initialize: initialize
  };
});
define('frontend/initializers/session', ['exports', 'ember', 'frontend/helpers/session'], function (exports, _ember, _frontendHelpersSession) {
  var SessionInitializer;

  SessionInitializer = {
    name: 'injectSession',
    initialize: function initialize(registry, app) {
      app.register('service:session', _frontendHelpersSession['default']);
      app.inject('controller', 'session', 'service:session');
      app.inject('route', 'session', 'service:session');
      return app.inject('service:session', 'store', 'service:store');
    }
  };

  exports['default'] = SessionInitializer;
});
define('frontend/models/user', ['exports', 'ember-data'], function (exports, _emberData) {
  var model;

  model = _emberData['default'].Model.extend({
    firstname: _emberData['default'].attr('string'),
    lastname: _emberData['default'].attr('string'),
    email: _emberData['default'].attr('string')
  });

  exports['default'] = model;
});
define('frontend/router', ['exports', 'ember', 'frontend/config/environment'], function (exports, _ember, _frontendConfigEnvironment) {
  var Router;

  Router = _ember['default'].Router.extend({
    location: _frontendConfigEnvironment['default'].locationType
  });

  Router.map(function () {
    this.route('login', {
      path: '/'
    });
    return this.route('home');
  });

  exports['default'] = Router;
});
define('frontend/routes/application', ['exports', 'ember', 'frontend/helpers/constants'], function (exports, _ember, _frontendHelpersConstants) {
  var route;

  route = _ember['default'].Route.extend({
    beforeModel: function beforeModel() {
      return this.getCurrentUser();
    },
    getCurrentUser: function getCurrentUser() {
      var that;
      that = this;
      return $.ajax({
        url: _frontendHelpersConstants['default'].LOGGED_IN_USER_URL,
        type: 'GET'
      }).then(function (data) {
        if (data.message === 'Nobody logged In') {
          return that.transitionTo('login');
        } else {
          return that.get('session').initialize(data);
        }
      });
    }
  });

  exports['default'] = route;
});
define('frontend/routes/login', ['exports', 'ember'], function (exports, _ember) {
  var route;

  route = _ember['default'].Route.extend({});

  exports['default'] = route;
});
define('frontend/serializers/application', ['exports', 'ember-data'], function (exports, _emberData) {
  var ApplicationSerializer;

  ApplicationSerializer = _emberData['default'].RESTSerializer.extend();

  exports['default'] = ApplicationSerializer;
});
define("frontend/templates/application", ["exports"], function (exports) {
  exports["default"] = Ember.HTMLBars.template((function () {
    return {
      meta: {
        "revision": "Ember@1.13.11",
        "loc": {
          "source": null,
          "start": {
            "line": 1,
            "column": 0
          },
          "end": {
            "line": 2,
            "column": 0
          }
        },
        "moduleName": "frontend/templates/application.hbs"
      },
      arity: 0,
      cachedFragment: null,
      hasRendered: false,
      buildFragment: function buildFragment(dom) {
        var el0 = dom.createDocumentFragment();
        var el1 = dom.createComment("");
        dom.appendChild(el0, el1);
        var el1 = dom.createTextNode("\n");
        dom.appendChild(el0, el1);
        return el0;
      },
      buildRenderNodes: function buildRenderNodes(dom, fragment, contextualElement) {
        var morphs = new Array(1);
        morphs[0] = dom.createMorphAt(fragment, 0, 0, contextualElement);
        dom.insertBoundary(fragment, 0);
        return morphs;
      },
      statements: [["content", "outlet", ["loc", [null, [1, 0], [1, 10]]]]],
      locals: [],
      templates: []
    };
  })());
});
define("frontend/templates/home", ["exports"], function (exports) {
  exports["default"] = Ember.HTMLBars.template((function () {
    return {
      meta: {
        "revision": "Ember@1.13.11",
        "loc": {
          "source": null,
          "start": {
            "line": 1,
            "column": 0
          },
          "end": {
            "line": 2,
            "column": 0
          }
        },
        "moduleName": "frontend/templates/home.hbs"
      },
      arity: 0,
      cachedFragment: null,
      hasRendered: false,
      buildFragment: function buildFragment(dom) {
        var el0 = dom.createDocumentFragment();
        var el1 = dom.createTextNode("Hi \n");
        dom.appendChild(el0, el1);
        return el0;
      },
      buildRenderNodes: function buildRenderNodes() {
        return [];
      },
      statements: [],
      locals: [],
      templates: []
    };
  })());
});
define("frontend/templates/login", ["exports"], function (exports) {
  exports["default"] = Ember.HTMLBars.template((function () {
    return {
      meta: {
        "revision": "Ember@1.13.11",
        "loc": {
          "source": null,
          "start": {
            "line": 1,
            "column": 0
          },
          "end": {
            "line": 6,
            "column": 0
          }
        },
        "moduleName": "frontend/templates/login.hbs"
      },
      arity: 0,
      cachedFragment: null,
      hasRendered: false,
      buildFragment: function buildFragment(dom) {
        var el0 = dom.createDocumentFragment();
        var el1 = dom.createElement("div");
        var el2 = dom.createTextNode("\n  ");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("div");
        var el3 = dom.createTextNode("Email: ");
        dom.appendChild(el2, el3);
        var el3 = dom.createComment("");
        dom.appendChild(el2, el3);
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n  ");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("div");
        var el3 = dom.createTextNode("Password: ");
        dom.appendChild(el2, el3);
        var el3 = dom.createComment("");
        dom.appendChild(el2, el3);
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n  ");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("button");
        var el3 = dom.createTextNode("Log In");
        dom.appendChild(el2, el3);
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n");
        dom.appendChild(el1, el2);
        dom.appendChild(el0, el1);
        var el1 = dom.createTextNode("\n");
        dom.appendChild(el0, el1);
        return el0;
      },
      buildRenderNodes: function buildRenderNodes(dom, fragment, contextualElement) {
        var element0 = dom.childAt(fragment, [0]);
        var element1 = dom.childAt(element0, [5]);
        var morphs = new Array(3);
        morphs[0] = dom.createMorphAt(dom.childAt(element0, [1]), 1, 1);
        morphs[1] = dom.createMorphAt(dom.childAt(element0, [3]), 1, 1);
        morphs[2] = dom.createElementMorph(element1);
        return morphs;
      },
      statements: [["inline", "input", [], ["type", "text", "value", ["subexpr", "@mut", [["get", "email", ["loc", [null, [2, 40], [2, 45]]]]], [], []]], ["loc", [null, [2, 14], [2, 47]]]], ["inline", "input", [], ["type", "password", "value", ["subexpr", "@mut", [["get", "password", ["loc", [null, [3, 47], [3, 55]]]]], [], []]], ["loc", [null, [3, 17], [3, 57]]]], ["element", "action", ["login"], [], ["loc", [null, [4, 10], [4, 28]]]]],
      locals: [],
      templates: []
    };
  })());
});
/* jshint ignore:start */

/* jshint ignore:end */

/* jshint ignore:start */

define('frontend/config/environment', ['ember'], function(Ember) {
  var prefix = 'frontend';
/* jshint ignore:start */

try {
  var metaName = prefix + '/config/environment';
  var rawConfig = Ember['default'].$('meta[name="' + metaName + '"]').attr('content');
  var config = JSON.parse(unescape(rawConfig));

  return { 'default': config };
}
catch(err) {
  throw new Error('Could not read config from meta tag with name "' + metaName + '".');
}

/* jshint ignore:end */

});

if (!runningTests) {
  require("frontend/app")["default"].create({"name":"frontend","version":"0.0.0+cfa55e40"});
}

/* jshint ignore:end */
//# sourceMappingURL=frontend.map