#!/usr/bin/env raku
use Slangify;

sub MAIN( :$host, :$port, :$scss=1, :$watch ) {
    $Slangify::site.serve:
          :$host, :$port, :$scss, :$watch;
}