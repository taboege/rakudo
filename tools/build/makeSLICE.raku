#!/usr/bin/env raku

# This script generates the logic for doing adverbed slices, usually part of
# the core settings as "src/core/SLICE.pm6".  When run, it will generate the
# source code on STDOUT.

use v6;

say qq:to/HEADER/;
#===============================================================================
#
# This file has been generated by $*PROGRAM-NAME
# on {DateTime.new(now)}.
#
# Please do *NOT* make changes to this file, as they will be lost
# whenever this file is generated again.
#
#===============================================================================
HEADER

for 1, 0 -> $array {  # 1 = [], 0 = {}

# Fill in these settings.  The ( is included here to prevent the interpolating
# logic to get confused by seeing [](...) .

    my @TYPE   = $array ?? <LIST(>       !! <HASH(>;
    my @AT     = $array ?? <AT-POS(>     !! <AT-KEY(>;
    my @DELETE = $array ?? <DELETE-POS(> !! <DELETE-KEY(>;
    my @EXISTS = $array ?? <EXISTS-POS(> !! <EXISTS-KEY(>;

# Below here is the actual source code template that is generated.  By only
# interpolating arrays (:a), we can put the right strings in the right place
# by using the zen slice ([]).  Any other occurrences of @ will *not* be
# interpolated because they lack the zen slice.

    say Q:a:to/SOURCE/;
# internal 1 element @TYPE[].chop.lc() access with adverbs
sub SLICE_ONE_@TYPE[]\SELF,$one,$key,$value,%adv) {
    my Mu $d := nqp::clone(nqp::getattr(%adv,Map,'$!storage'));
    nqp::bindkey($d,nqp::unbox_s($key),nqp::decont($value));

    sub HANDLED($key) {
        nqp::if(
          nqp::existskey($d,nqp::unbox_s($key)),
          nqp::stmts(
            (my $value := nqp::atkey($d,$key)),
            nqp::deletekey($d,$key),
            $value
          ),
          Nil
        )
    }

    my @nogo;
    my \result = do {

        if HANDLED('delete') {            # :delete:*
            if nqp::elems($d) == 0 {          # :delete
                SELF.@DELETE[]$one);
            }
            elsif nqp::existskey($d,'exists') { # :delete:exists(0|1):*
                my $exists   := HANDLED('exists');
                my $wasthere := SELF.@EXISTS[]$one);
                SELF.@DELETE[]$one);
                if nqp::elems($d) == 0 {          # :delete:exists(0|1)
                    !( $wasthere ?^ $exists )
                }
                elsif nqp::existskey($d,'kv') {   # :delete:exists(0|1):kv(0|1)
                    my $kv := HANDLED('kv');
                    if nqp::elems($d) == 0 {
                        !$kv || $wasthere
                          ?? ( $one, !( $wasthere ?^ $exists ) )
                          !! ();
                    }
                    else {
                        @nogo = <delete exists kv>;
                    }
                }
                elsif nqp::existskey($d,'p') {    # :delete:exists(0|1):p(0|1)
                    my $p := HANDLED('p');
                    if nqp::elems($d) == 0 {
                        !$p || $wasthere
                          ?? Pair.new($one, !($wasthere ?^ $exists) )
                          !! ();
                    }
                    else {
                        @nogo = <delete exists p>;
                    }
                }
                else {
                    @nogo = <delete exists>;
                }
            }
            elsif nqp::existskey($d,'kv') {    # :delete:kv(0|1)
                my $kv := HANDLED('kv');
                if nqp::elems($d) == 0 {
                    !$kv || SELF.@EXISTS[]$one)
                      ?? ( $one, SELF.@DELETE[]$one) )
                      !! ();
                }
                else {
                    @nogo = <delete kv>;
                }
            }
            elsif nqp::existskey($d,'p') {     # :delete:p(0|1)
                my $p := HANDLED('p');
                if nqp::elems($d) == 0 {
                    !$p || SELF.@EXISTS[]$one)
                      ?? Pair.new($one, SELF.@DELETE[]$one))
                      !! ();
                }
                else {
                    @nogo = <delete p>;
                }
            }
            elsif nqp::existskey($d,'k') {     # :delete:k(0|1)
                my $k := HANDLED('k');
                if nqp::elems($d) == 0 {
                    !$k || SELF.@EXISTS[]$one)
                      ?? do { SELF.@DELETE[]$one); $one }
                      !! ();
                }
                else {
                    @nogo = <delete k>;
                }
            }
            elsif nqp::existskey($d,'v') {     # :delete:v(0|1)
                my $v := HANDLED('v');
                if nqp::elems($d) == 0 {
                    !$v || SELF.@EXISTS[]$one)
                      ?? SELF.@DELETE[]$one)
                      !! ();
                }
                else {
                    @nogo = <delete v>;
                }
            }
            else {
                @nogo = <delete>;
            }
        }
        elsif nqp::existskey($d,'exists') {  # :!delete?:exists(0|1):*
            my $exists  := HANDLED('exists');
            my $wasthere = SELF.@EXISTS[]$one);
            if nqp::elems($d) == 0 {           # :!delete?:exists(0|1)
                !( $wasthere ?^ $exists )
            }
            elsif nqp::existskey($d,'kv') {    # :!delete?:exists(0|1):kv(0|1)
                my $kv := HANDLED('kv');
                if nqp::elems($d) == 0 {
                    !$kv || $wasthere
                      ?? ( $one, !( $wasthere ?^ $exists ) )
                      !! ();
                }
                else {
                    @nogo = <exists kv>;
                }
            }
            elsif nqp::existskey($d,'p') {     # :!delete?:exists(0|1):p(0|1)
                my $p := HANDLED('p');
                if nqp::elems($d) == 0 {
                    !$p || $wasthere
                      ?? Pair.new($one, !( $wasthere ?^ $exists ))
                      !! ();
                }
                else {
                    @nogo = <exists p>;
                }
            }
            else {
                @nogo = <exists>;
            }
        }
        elsif nqp::existskey($d,'kv') {      # :!delete?:kv(0|1):*
            my $kv := HANDLED('kv');
            if nqp::elems($d) == 0 {           # :!delete?:kv(0|1)
                !$kv || SELF.@EXISTS[]$one)
                  ?? ($one, SELF.@AT[]$one))
                  !! ();
            }
            else {
                @nogo = <kv>;
            }
        }
        elsif nqp::existskey($d,'p') {       # :!delete?:p(0|1):*
            my $p := HANDLED('p');
            if nqp::elems($d) == 0 {           # :!delete?:p(0|1)
                !$p || SELF.@EXISTS[]$one)
                  ?? Pair.new($one, SELF.@AT[]$one))
                  !! ();
            }
            else {
                @nogo = <p>;
            }
        }
        elsif nqp::existskey($d,'k') {       # :!delete?:k(0|1):*
            my $k := HANDLED('k');
            if nqp::elems($d) == 0 {           # :!delete?:k(0|1)
                !$k || SELF.@EXISTS[]$one)
                  ?? $one
                  !! ();
            }
            else {
                @nogo = <k>;
            }
        }
        elsif nqp::existskey($d,'v') {       # :!delete?:v(0|1):*
            my $v := HANDLED('v');             # :!delete?:v(0|1)
            if nqp::elems($d) == 0 {
                !$v || SELF.@EXISTS[]$one)
                  ?? SELF.@AT[]$one)
                  !! ();
            }
            else {
                @nogo = <v>;
            }
        }
        elsif nqp::elems($d) == 0 {           # :!delete
            SELF.@AT[]$one);
        }
    }

    @nogo || nqp::elems($d)
      ?? SLICE_HUH( SELF, @nogo, $d, %adv )
      !! result;
} #SLICE_ONE_@TYPE[].chop()

# internal >1 element @TYPE[].chop.lc() access with adverbs
sub SLICE_MORE_@TYPE[]\SELF,$more,$key,$value,%adv) {
    my Mu $d := nqp::clone(nqp::getattr(%adv,Map,'$!storage'));
    nqp::bindkey($d,nqp::unbox_s($key),nqp::decont($value));

    sub HANDLED($key) {
        nqp::if(
          nqp::existskey($d,nqp::unbox_s($key)),
          nqp::stmts(
            (my $value := nqp::atkey($d,$key)),
            nqp::deletekey($d,$key),
            $value
          ),
          Nil
        )
    }

    my @nogo;
    my \result = do {

        if HANDLED('delete') {            # :delete:*
            if nqp::elems($d) == 0 {          # :delete
                $more.cache.flatmap( { SELF.@DELETE[]$_) } ).eager.list;
            }
            elsif nqp::existskey($d,'exists') { # :delete:exists(0|1):*
                my $exists := HANDLED('exists');
                my $wasthere; # no need to initialize every iteration of map
                if nqp::elems($d) == 0 {          # :delete:exists(0|1)
                    $more.cache.flatmap( {
                        SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                        !( $wasthere ?^ $exists );
                    } ).eager.list;
                }
                elsif nqp::existskey($d,'kv') { # :delete:exists(0|1):kv(0|1):*
                    my $kv := HANDLED('kv');
                    if nqp::elems($d) == 0 {      # :delete:exists(0|1):kv(0|1)
                        $more.cache.flatmap( {
                            SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                            next unless !$kv || $wasthere;
                            ($_, !( $wasthere ?^ $exists ));
                        } ).flat.eager.list;
                    }
                    else {
                        @nogo = <delete exists kv>;
                    }
                }
                elsif nqp::existskey($d,'p') {  # :delete:exists(0|1):p(0|1):*
                    my $p := HANDLED('p');
                    if nqp::elems($d) == 0 {      # :delete:exists(0|1):p(0|1)
                        $more.cache.flatmap( {
                            SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                            next unless !$p || $wasthere;
                            Pair.new($_,!($wasthere ?^ $exists));
                        } ).eager.list;
                    }
                    else {
                        @nogo = <delete exists p>;
                    }
                }
                else {
                    @nogo = <delete exists>;
                }
            }
            elsif nqp::existskey($d,'kv') {     # :delete:kv(0|1):*
                my $kv := HANDLED('kv');
                if nqp::elems($d) == 0 {          # :delete:kv(0|1)
                    $kv
                      ?? $more.cache.flatmap( {
                             next unless SELF.@EXISTS[]$_);
                             ( $_, SELF.@DELETE[]$_) );
                         } ).flat.eager.list
                      !! $more.cache.flatmap( {
                             ( $_, SELF.@DELETE[]$_) )
                         } ).flat.eager.list;
                }
                else {
                    @nogo = <delete kv>;
                }
            }
            elsif nqp::existskey($d,'p') {      # :delete:p(0|1):*
                my $p := HANDLED('p');
                if nqp::elems($d) == 0 {          # :delete:p(0|1)
                    $p
                      ?? $more.cache.flatmap( {
                             next unless SELF.@EXISTS[]$_);
                             Pair.new($_, SELF.@DELETE[]$_));
                         } ).eager.list
                      !! $more.cache.flatmap( {
                             Pair.new($_, SELF.@DELETE[]$_))
                         } ).eager.list;
                }
                else {
                    @nogo = <delete p>;
                }
            }
            elsif nqp::existskey($d,'k') {     # :delete:k(0|1):*
                my $k := HANDLED('k');
                if nqp::elems($d) == 0 {          # :delete:k(0|1)
                    $k
                      ?? $more.cache.flatmap( {
                             nqp::if(
                               SELF.@EXISTS[]$_),
                               nqp::stmts(
                                 SELF.@DELETE[]$_),
                                 $_
                               ),
                               next
                             )
                         } ).eager.list
                      !! $more.cache.flatmap( {
                             SELF.@DELETE[]$_); $_
                         } ).eager.list;
                }
                else {
                    @nogo = <delete k>;
                }
            }
            elsif nqp::existskey($d,'v') {      # :delete:v(0|1):*
                my $v := HANDLED('v');
                if nqp::elems($d) == 0 {          # :delete:v(0|1)
                    $v
                      ?? $more.cache.flatmap( {
                             next unless SELF.@EXISTS[]$_);
                             SELF.@DELETE[]$_);
                     } ).eager.list
                      !! $more.cache.flatmap( {
                             SELF.@DELETE[]$_)
                     } ).eager.list;
                }
                else {
                    @nogo = <delete v>;
                }
            }
            else {
                @nogo = <delete>;
            }
        }
        elsif nqp::existskey($d,'exists') { # :!delete?:exists(0|1):*
            my $exists := HANDLED('exists');
            if nqp::elems($d) == 0 {          # :!delete?:exists(0|1)
                $more.cache.flatmap({ !( SELF.@EXISTS[]$_) ?^ $exists ) }).eager.list;
            }
            elsif nqp::existskey($d,'kv') {   # :!delete?:exists(0|1):kv(0|1):*
                my $kv := HANDLED('kv');
                if nqp::elems($d) == 0 {        # :!delete?:exists(0|1):kv(0|1)
                    $kv
                      ?? $more.cache.flatmap( {
                             next unless SELF.@EXISTS[]$_);
                             ( $_, $exists );
                         } ).flat.eager.list
                      !! $more.cache.flatmap( {
                             ( $_, !( SELF.@EXISTS[]$_) ?^ $exists ) )
                         } ).flat.eager.list;
                }
                else {
                    @nogo = <exists kv>;
                }
            }
            elsif nqp::existskey($d,'p') {  # :!delete?:exists(0|1):p(0|1):*
                my $p := HANDLED('p');
                if nqp::elems($d) == 0 {      # :!delete?:exists(0|1):p(0|1)
                    $p
                      ?? $more.cache.flatmap( {
                             next unless SELF.@EXISTS[]$_);
                             Pair.new( $_, $exists );
                         } ).eager.list
                      !! $more.cache.flatmap( {
                             Pair.new( $_, !( SELF.@EXISTS[]$_) ?^ $exists ) )
                         } ).eager.list;
                }
                else {
                    @nogo = <exists p>;
                }
            }
            else {
                @nogo = <exists>;
            }
        }
        elsif nqp::existskey($d,'kv') {     # :!delete?:kv(0|1):*
            my $kv := HANDLED('kv');
            if nqp::elems($d) == 0 {          # :!delete?:kv(0|1)
                $kv
                  ?? $more.cache.flatmap( {
                         next unless SELF.@EXISTS[]$_);
                         $_, SELF.@AT[]$_);
                     } ).flat.eager.list
                  !! $more.cache.flatmap( {
                         $_, SELF.@AT[]$_)
                     } ).flat.eager.list;
            }
            else {
                @nogo = <kv>;
            }
        }
        elsif nqp::existskey($d,'p') {      # :!delete?:p(0|1):*
            my $p := HANDLED('p');
            if nqp::elems($d) == 0 {          # :!delete?:p(0|1)
                $p
                  ?? $more.cache.flatmap( {
                         next unless SELF.@EXISTS[]$_);
                         Pair.new($_, SELF.@AT[]$_));
                     } ).eager.list
                  !! $more.cache.flatmap( {
                         Pair.new( $_, SELF.@AT[]$_) )
                     } ).eager.list;
            }
            else {
                @nogo = <p>
            }
        }
        elsif nqp::existskey($d,'k') {      # :!delete?:k(0|1):*
            my $k := HANDLED('k');
            if nqp::elems($d) == 0 {          # :!delete?:k(0|1)
                $k
                  ?? $more.cache.flatmap( {
                         next unless SELF.@EXISTS[]$_);
                         $_;
                     } ).eager.list
                  !! $more.cache.flat.eager.list;
            }
            else {
                @nogo = <k>;
            }
        }
        elsif nqp::existskey($d,'v') {      # :!delete?:v(0|1):*
            my $v := HANDLED('v');
            if nqp::elems($d) == 0 {          # :!delete?:v(0|1)
                $v
                  ??  $more.cache.flatmap( {
                          next unless SELF.@EXISTS[]$_);
                          SELF.@AT[]$_);
                      } ).eager.list
                  !!  $more.cache.flatmap( {
                          SELF.@AT[]$_)
                      } ).eager.list;
            }
            else {
                @nogo = <v>;
            }
        }
        elsif nqp::elems($d) == 0 {         # :!delete
            $more.cache.flatmap( { SELF.@AT[]$_) } ).eager.list;
        }
    }

    @nogo || nqp::elems($d)
      ?? SLICE_HUH( SELF, @nogo, $d, %adv )
      !! result;
} #SLICE_MORE_@TYPE[].chop()

SOURCE
}

say "# vim: set ft=perl6 nomodifiable :";
