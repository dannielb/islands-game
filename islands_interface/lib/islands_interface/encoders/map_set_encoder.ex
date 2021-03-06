defmodule IslansdInterface.Encoders.MapSetEncoder do
  alias Jason.Encoder

  defimpl Encoder, for: MapSet do
    def encode(data, options) do
      data
      |> MapSet.to_list()
      |> Encoder.List.encode(options)
    end
  end
end
