FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /ingresse_test
WORKDIR /ingresse_test
COPY Gemfile /ingresse_test/Gemfile
COPY Gemfile.lock /ingresse_test/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /ingresse_test
RUN touch /tmp/caching-dev.txt

# Add a script to be executed every time the container starts#.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
