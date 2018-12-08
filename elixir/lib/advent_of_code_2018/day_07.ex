defmodule AdventOfCode2018.Day07 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn {left, right}, acc ->
      acc
      |> Map.put_new(left, [])
      |> Map.update(right, [left], &Enum.sort([left | &1]))
    end)
    |> do_step([])
    |> List.to_string()
  end

  defp parse_line(line) do
    <<"Step ", left, " must be finished before step ", right, " can begin.">> = line

    {left, right}
  end

  def do_step(map, completed_steps) when map == %{} do
    Enum.reverse(completed_steps)
  end

  def do_step(map, completed_steps) do
    {step_done, []} =
      map
      |> Enum.min_by(fn
        {key, []} -> key
        {_, _} -> :infinity
      end)

    new_map =
      Enum.reduce(map, %{}, fn
        {k, _v}, acc when k == step_done -> Map.delete(acc, k)
        {k, v}, acc -> Map.put_new(acc, k, List.delete(v, step_done))
      end)

    do_step(new_map, [step_done | completed_steps])
  end

  def part2(input, number_of_workers \\ 5, seconds_added \\ 60) do
    workers =
      for n <- 1..number_of_workers,
          do: {n, {0, nil}},
          into: %{}

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn {left, right}, acc ->
      acc
      |> Map.put_new(left, [])
      |> Map.update(right, [left], &Enum.sort([left | &1]))
    end)
    |> do_step_with_workers(workers, 0, seconds_added)
  end

  def do_step_with_workers(instruction_map, workers, total_time, _) when instruction_map == %{} do
    {_, {longest_time_left, _}} =
      Enum.max_by(workers, fn {_k, {time, _}} -> time end, fn -> {nil, 0} end)

    total_time + longest_time_left
  end

  def do_step_with_workers(instruction_map, workers, total_time, seconds_added) do
    work_available? = Enum.any?(instruction_map, fn {_k, v} -> v == [] end)
    worker_free? = Enum.any?(workers, fn {_k, {_time_left, assigned}} -> assigned == nil end)

    if work_available? and worker_free? do
      {instruction_map, workers} = assign_worker_to_step(instruction_map, workers, seconds_added)
      do_step_with_workers(instruction_map, workers, total_time, seconds_added)
    else
      {instruction_map, workers, time_spent} =
        finish_next_completed_task(instruction_map, workers)

      do_step_with_workers(instruction_map, workers, total_time + time_spent, seconds_added)
    end
  end

  def assign_worker_to_step(instruction_map, workers, seconds_added) do
    {worker_to_use, {0, nil}} =
      Enum.find(workers, fn {_k, {_time_left, assigned}} -> assigned == nil end)

    {step_to_assign, []} =
      instruction_map
      |> Enum.min_by(
        fn
          {key, []} -> key
          {_, _} -> :infinity
        end,
        fn -> {64, []} end
      )

    time_for_step = step_to_assign - 64 + seconds_added

    instruction_map = Map.put(instruction_map, step_to_assign, [:assigned])

    workers = Map.put(workers, worker_to_use, {time_for_step, step_to_assign})

    {instruction_map, workers}
  end

  def finish_next_completed_task(instruction_map, workers) do
    # Next tasks to be finished
    {time_done, completed_steps} =
      workers
      |> Enum.reduce({:infinity, []}, fn
        {_key, {_time_left, nil}}, acc ->
          acc

        {_key, {time_left, assigned_step}}, {time, steps} ->
          cond do
            time_left < time -> {time_left, [assigned_step]}
            time_left == time -> {time, [assigned_step | steps]}
            true -> {time, steps}
          end
      end)

    # Move workers along
    workers =
      Enum.into(workers, %{}, fn {k, {time, step}} ->
        if step in completed_steps,
          do: {k, {0, nil}},
          else: {k, {max(0, time - time_done), step}}
      end)

    # Update steps so task is completed
    new_map =
      Enum.reduce(instruction_map, %{}, fn
        {k, v}, acc ->
          if k in completed_steps,
            do: Map.delete(acc, k),
            else: Map.put_new(acc, k, v -- completed_steps)
      end)

    # Return new workers, new map and time that's been spent on this task
    {new_map, workers, time_done}
  end
end
