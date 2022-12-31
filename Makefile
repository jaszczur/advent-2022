LISP ?= ros run --
LISP_FLAGS ?= --no-userinit --non-interactive

build:
	$(LISP) $(LISP_FLAGS) \
		--eval '(require "asdf")' \
		--load advent2022.asd \
		--eval '(asdf:make :advent2022)' \
		--eval '(asdf:test-system :advent2022)' \
		--eval '(uiop:quit)' || (printf "\n%s\n%s\n" "Compilation failed, see the above stacktrace." && exit 1)

clean:
	rm -f common/*.fasl
	rm -f 0?/*.fasl
