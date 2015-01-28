Package.describe({
  name: 'ccorcos:ford-fulkerson',
  summary: 'A simple implementation of the Ford-Fulkerson max-flow min-cut algorithm.',
  version: '1.0.0',
  git: 'https://github.com/ccorcos/meteor-ford-fulkerson'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1');

  api.use([
    'stevezhu:lodash@1.0.2',
    'digilord:sugarjs@1.4.1',
    'coffeescript',
  ]);

  api.addFiles([
    'lib/fordfulkerson.coffee',
  ], ['client', 'server']);

  api.export('FordFulkerson', ['server', 'client']);

});

Package.on_test(function (api) {
  api.use(["ccorcos:ford-fulkerson", "tinytest", "test-helpers", "coffeescript"]);
  api.add_files("lib/test.coffee", ["client", "server"]);
});