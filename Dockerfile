FROM ruby:alpine

COPY *.rb /

ENTRYPOINT ["/main.rb"]
