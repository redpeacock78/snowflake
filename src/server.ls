require! fastify
require 'dotenv' .config!
require! './snowflake': snowflake

app = fastify!

machine_id = process.env.MACHINE_ID |> parseInt
machine = machine_id || (Math.random! * 1024 |> Math.floor)
generator = machine |> snowflake.generator

app.get '/id', (req, res) ->> (
  id = generator.next!.value
  return if typeof id == 'string'
    then { status: 'OK', id: id }
    else id
)

start = ->> (
  try
    port = process.env.PORT || 3000
    await port |> app.listen
    'Server Ready at http://localhost:' + port |> console.log
  catch e
    app.log.error e
    process.exit 1
)

start!
