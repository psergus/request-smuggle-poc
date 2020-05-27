FROM ruby:2.4.1

WORKDIR /app/src
COPY Gemfile* /app/src/
RUN bundle config path /bundle \
    && bundle install

EXPOSE 8080

ENTRYPOINT ["./run.sh"]
