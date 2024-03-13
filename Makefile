.PHONY: test

export TF_PATH

test:
	cd tests && go test -v -timeout 60m -run TestApplyNoError/$(TF_PATH) ./pdns_test.go

#test_extended:
	#cd tests && env go test -v -timeout 60m -run TestStorage ./pdns_extended_test.go
