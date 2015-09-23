FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

# Install base package
RUN apt-get update
RUN apt-get install -y wget git build-essential

# Install Erlang
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y erlang

# Install Elixir
RUN apt-get install elixir

ADD . /app/github-trending

WORKDIR /app/github-trending

RUN mix do local.rebar, local.hex --force
RUN mix do deps.get, compile

CMD ["mix", "run", "/app/github-trending/lib/list_trending.exs"]
