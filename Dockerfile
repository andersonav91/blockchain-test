# v1

FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs # include the required packages
RUN mkdir /blockchain-test

WORKDIR /blockchain-test
COPY Gemfile /blockchain-test/Gemfile
COPY Gemfile.lock /blockchain-test/Gemfile.lock
RUN bundle install
COPY . /blockchain-test

ENV BITCOIN_RPC_URL=http://localhost:18332
ENV BITCOIN_RPC_PASS=password
ENV BITCOIN_RPC_USER=bitcoin
ENV ETHEREUM_RPC_URL=http://localhost:8545
ENV NEO_RPC_URL=http://localhost:8545

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

# commands

# docker build -t blockchain-test .

# docker run -d -p 3000:3000 --name blockchain-test-container blockchain-test