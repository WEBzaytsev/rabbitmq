# Dockerfile
FROM rabbitmq:4-management

# Устанавливаем curl для загрузки плагина
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Загружаем и устанавливаем плагин rabbitmq-delayed-message-exchange
ARG PLUGIN_VERSION=4.1.0
RUN curl -L https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v${PLUGIN_VERSION}/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez \
    -o /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez

# Включаем плагин
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# Экспонируем стандартные порты RabbitMQ
EXPOSE 5672 15672

# Создаем директории для данных
RUN mkdir -p /var/lib/rabbitmq

# Устанавливаем владельца директорий
RUN chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

# Настраиваем рабочую директорию
WORKDIR /var/lib/rabbitmq

# Запускаем RabbitMQ
CMD ["rabbitmq-server"]
