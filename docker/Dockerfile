FROM ruby:slim

WORKDIR app

COPY . .

RUN bundle

ENTRYPOINT ["bundle", "exec", "rake", "rspec_report:html"]