FROM ruby:alpine

COPY main.rb /

ENTRYPOINT ["/main.rb"]
