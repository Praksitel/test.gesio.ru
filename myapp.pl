#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
#plugin 'PODRenderer';

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h1>Welcome to the Mojolicious real-time web framework!</h1>
To learn more, you can browse through the documentation
<%= link_to 'here' => '/perldoc' %>.

@@ layouts/default.html.ep
<html>
<head></head>
<body>
<h1>Test app</h1>
<div>Mode: <span id="appmode"></span></div>
<div>Value: <span id="appvalue"></span></div>
</body>
<html>
