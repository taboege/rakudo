my class Cancellation {
    has $.cancelled;
    has $!lock;
    has @!async_handles;

    submethod BUILD(:@!async_handles) {
        $!cancelled = False;
        $!lock      = Lock.new;
    }

    method cancel() {
        $!lock.protect({
            unless $!cancelled {
                for @!async_handles {
                    nqp::cancel(nqp::decont($_));
                }
                $!cancelled = True;
            }
        })
    }
}
