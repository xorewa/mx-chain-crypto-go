test:
	@echo "  >  Running unit tests"
	# The BLS implementation is linked through a native Cgo library. Under Go's
	# race runtime, concurrently starting multiple Cgo-backed package test
	# processes can abort in the native allocator during process teardown.
	# Keep race detection and atomic coverage enabled, but execute package test
	# processes serially.
	go test -p=1 -cover -race -coverprofile=coverage.txt -covermode=atomic -v ./...

benchmark-multisig:
	cd signing/mcl/multisig/ && \
		go test -v -bench=. -count 1 -run=^#
