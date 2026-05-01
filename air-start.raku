#!/usr/bin/env raku
use Slangify;

sub MAIN( :$host, :$port, :$scss, :$watch ) {
    $Slangify::site.start:
          :$host, :$port, :$scss, :$watch;
}