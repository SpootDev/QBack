import asyncio
import json

import aio_pika

from common import common_config_ini
from common import common_logging_elasticsearch_httpx
from common import common_network


# grabs the messages and processes
async def on_message(message: aio_pika.IncomingMessage):
    async with message.process(ignore_processed=True):
        try:
            json_message = json.loads(message.body)
            print(json_message)
        except json.decoder.JSONDecodeError as e:
            print('json error:', message.body)
            await message.reject()
            return
        await message.ack()
        await asyncio.sleep(1)


async def main(loop):
    # open the database
    option_config_json, db_connection = common_config_ini.com_config_read()

    # start up rabbitmq
    connection = await aio_pika.connect_robust("amqp://guest:guest@stack_rabbitmq:5672/%2F",
                                               loop=loop)
    # Creating a channel
    channel = await connection.channel()
    await channel.set_qos(prefetch_count=1)
    # Declaring exchange
    exchange = await channel.declare_exchange(name='backup_job_queue_ex',
                                              type=aio_pika.ExchangeType.DIRECT,
                                              durable=True)
    # Declaring queue
    queue = await channel.declare_queue(name='backup_job_queue',
                                        durable=True)
    # Binding queue
    await queue.bind(exchange=exchange, routing_key='backup_job_queue_ex')
    # Start listening
    await queue.consume(on_message)


if __name__ == "__main__":
    # start logging
    common_logging_elasticsearch_httpx.com_es_httpx_post(message_type='info',
                                                         message_text='START',
                                                         index_name='main_backup_job')
    # fire off wait for it script to allow connection
    common_network.mk_network_service_available('stack_rabbitmq', '5672')
    # start up the loop
    loop = asyncio.get_event_loop()
    connection = loop.run_until_complete(main(loop))

    try:
        loop.run_forever()
    finally:
        loop.run_until_complete(connection.close())
