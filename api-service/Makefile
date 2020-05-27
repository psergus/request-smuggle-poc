DOCKER_IMAGE ?= test/api-service
DOCKER_CONTAINER ?= api-service
# The command below will extract the branch name and replace slashes for underscores so that
# it can be used as a valid docker image tag.
VOLUME ?=-v $(PWD):/app/src

image:
	$(HIDE)docker build -f Dockerfile -t $(DOCKER_IMAGE) $(PWD)

run:
	$(HIDE)docker run --rm \
  --name $(DOCKER_CONTAINER) \
  -p 8080:8080/tcp \
  $(VOLUME) \
  $(DOCKER_IMAGE)
