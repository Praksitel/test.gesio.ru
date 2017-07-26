#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';
use Mojolicious::Lite;
use Mojolicious::Plugin::Config;

use Redis;

# Documentation browser under "/perldoc"
#plugin 'PODRenderer';

my $redis = Mojo::Redis2->new;
my $config = plugin Config => {file => './myapp.conf'};

my $appvalue = 0;

my $res = $redis->set(appvalue => $appvalue);

get '/' => sub {
  my $c = shift;
  $c->stash(appmode => $config->{appmode});
  $c->render(template => 'index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
@@ layouts/default.html.ep
<html>
<head></head>
<body>
<h1>Test app</h1>
<div>Mode: <span id="appmode"><%= $appmode %></span></div>
<div>Value: <span id="appvalue"></span></div>
</body>
<html>
