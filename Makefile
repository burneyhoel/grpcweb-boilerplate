generate:
	protoc -I. ./proto/web.proto \
		--gopherjs_out=plugins=grpc:$$GOPATH/src \
		--go_out=plugins=grpc:$$GOPATH/src
	go generate ./frontend/

clean:
	rm -f ./proto/client/* ./proto/server/* ./cert.pem ./key.pem \
		./frontend/html/frontend.js ./frontend/html/frontend.js.map

install:
	go get ./...

generate_cert:
	go run "$$(go env GOROOT)/src/crypto/tls/generate_cert.go" \
		--host=localhost,127.0.0.1 \
		--ecdsa-curve=P256 \
		--ca=true

serve:
	go run main.go
