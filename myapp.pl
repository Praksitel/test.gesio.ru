#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';
use Mojolicious::Lite;
use Mojolicious::Plugin::Config;

use Redis;

# Documentation browser under "/perldoc"
#plugin 'PODRenderer';

my $redis = Redis->new;
my $config = plugin Config => {file => './myapp.conf'};

my $appvalue = 0;
my $res = $redis->set('appvalue' => $appvalue);

get '/' => sub {
  my $c = shift;
  $c->stash(res => $res);
  $c->stash(appmode => $config->{appmode});
  $c->stash(appvalue => $redis->get('appvalue'));
  $c->render(template => 'index');
};

post 'set/:appvalue' => {
  my $c = shift;
  $appvalue = $c->param('appvalue');
  $res = $redis->set('appvalue' => $appvalue);
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
@@ layouts/default.html.ep
<html>
<head>
  <script data-require="jquery@3.1.1" data-semver="3.1.1" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script type="text/javascript">
    $( document ).ready(function() {
      refreshPage();
      function refreshPage() {
          var appvalue = new Date().getTime();
          $.ajax({
              type:   "POST",
              url:    'test.gesio.ru:8080/set/' + appvalue
              });

          setTimeout(refreshPage, 1000);
      };
    });
  </script>
</head>
<body>
<h1>Test app</h1>
<div>Redis res: <span id="res"><%= $res %></span></div>
<div>Mode: <span id="appmode"><%= $appmode %></span></div>
<div>Value: <span id="appvalue"><%= $appvalue %></span></div>
</body>
<html>
