FROM ruby:2.4.1

WORKDIR /onelogin/src
COPY Gemfile* /onelogin/src/
RUN bundle config path /bundle \
    && bundle install

EXPOSE 8080

ENTRYPOINT ["./run.sh"]
