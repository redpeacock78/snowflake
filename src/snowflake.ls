main = (machineId) ->* (
  seq = ``0n``
  shiftLeftTime = ``22n``
  machine = (machineId |> BigInt) .<<. ``12n``
  lastTime = Date.now! |> BigInt
  while true
    try
      seq++
      time = Date.now! |> BigInt
      shiftedTime = time .<<. shiftLeftTime
      if time == lastTime && seq >= ``4096n``
        throw Error 'Exceeded 4096 ids in 1 millisecond.'
      if time != lastTime 
        seq = ``0n``
      id = shiftedTime .|. machine .|. seq |> (x) -> BigInt.asUintN 64, x
      lastTime = time
      yield id.toString!
    catch e
      yield new Error 'Failed to generate snowflake id.'
)

export generator = (machine_id) -> machine_id |> main
