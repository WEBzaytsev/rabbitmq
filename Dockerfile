FROM rabbitmq:4.1.0-management

ARG PLUGIN_VERSION=4.1.0
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && curl -fsSL https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v${PLUGIN_VERSION}/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez \
      -o /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez \
 && rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange \
 && apt-get purge -y --auto-remove curl \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 5672 15672
