start-db: docker-compose.yml
	@echo "--> Starting db container" && \
	eval $(egrep -v '^#' .env | xargs) docker-compose up -d db

wait-for-db: start-db
	@eval $$(egrep -v '^#' "$(CURDIR)/.env" | xargs) "$(CURDIR)/scripts/wait-for-db.sh"

setup-db: wait-for-db
	@eval $$(egrep -v '^#' "$(CURDIR)/.env" | xargs) "$(CURDIR)/scripts/setup-db.sh"

run-example: setup-db
	@echo "--> Publishing flyway-example Scala app as a Docker image" && \
	sbt docker:publishLocal && \
	eval $$(egrep -v '^#' .env | xargs) docker-compose up -d && \
	stty sane

connect-to-db: wait-for-db
	@eval $$(egrep -v '^#' .env | xargs) "$(CURDIR)/scripts/connect-to-db.sh"

clean:
	@docker-compose down --rmi local -v && \
	sbt clean && \
	stty sane

.PHONY: start-db wait-for-db setup-db run-example connect-to-db cleanf
