main = (machineId)->* (
  seq = ``0n``
  shiftLeftTime = ``22n``
  machine = (BigInt machineId) .<<. ``12n``
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
      id = BigInt.asUintN 64, shiftedTime .|. machine .|. seq
      lastTime = time
      yield id.toString!
    catch e
      yield new Error 'Failed to generate snowflake id.'
)

export generator = (machine_id) -> main machine_id