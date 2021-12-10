require! fastify
require 'dotenv' .config!
require! './snowflake': snowflake

app = fastify!

machine_id = process.env.MACHINE_ID |> parseInt
machine = machine_id || (Math.random! * 1024 |> Math.floor)
generator = snowflake.generator machine

app.get '/id', (req, res) ->> (
  id = generator.next!.value
  return { status: 'OK', id: id }
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
