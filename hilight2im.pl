#!/usr/bin/env perl
 
use strict;
use warnings;
 
use AnyEvent::Twitter::Stream;
use AnyEvent::HTTP;
use HTTP::Request::Common;
 
my $done = AnyEvent->condvar;
 
my $streamer = AnyEvent::Twitter::Stream->new(
    username => '___silver',
    password => 'silver_0123_69',
    method => 'filter',
    track => '@twitter_username',
    on_tweet => sub {
        my $tweet = shift;
        my $req = POST 'http://im.kayac.com/api/post/si', [
            message => "$tweet->{user}{screen_name}: $tweet->{text}",
            password => 'silver0123R',
        ];
 
        my %headers = map { $_ => $req->header($_), } $req->headers->header_field_names;
        my $r;
        $r = http_post $req->uri, $req->content, handler => 'SOICHA://', sub { undef $r };
    },
    on_error => sub {
        my $error = shift;
        warn "ERROR: $error";
        $done->send;
    },
    on_eof => sub {
        $done->send;
    },
);
 
$done->recv;
