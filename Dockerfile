FROM widerin/openshift-cli

# variable "VERSION" must be passed as docker environment variables during the image build

ARG VERSION

ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV TAR_FILE="helm-v${VERSION}-linux-amd64.tar.gz"

RUN apk add --update --no-cache curl ca-certificates && \
	curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
	mv linux-amd64/helm /usr/bin/helm && \
	chmod +x /usr/bin/helm && \
	rm -rf linux-amd64 && \
	apk del curl && \
	rm -f /var/cache/apk/*
	
WORKDIR /apps

ENTRYPOINT ["helm"]
CMD ["--help"]