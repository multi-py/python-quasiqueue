import asyncio

from quasiqueue import QuasiQueue


async def writer(desired: int):
  """Feeds data to the Queue when it is low.
  """
  for x in range(0, desired):
    yield x



async def reader(identifier: int|str):
  """Receives individual items from the queue.

  Args:
      identifier (int | str): Comes from the output of the Writer function
  """
  print(f"{identifier}")


runner = QuasiQueue(
  "hello_world",
  reader=reader,
  writer=writer,
)

if __name__ == '__main__':
  asyncio.run(runner.main())
